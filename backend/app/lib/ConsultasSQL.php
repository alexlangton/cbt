<?php

class ConsultasSQL {
    protected $db;
    protected $tabla;
    protected $f3;
    protected $logger;

    public function __construct($tabla) {
        $this->f3 = \Base::instance();
        $this->db = $this->f3->get('DB');
        $this->tabla = $tabla;
        $this->logger = new Logger($this->f3);
    }

    protected function logQuery($sql, $params = []) {
        try {
            // Preparar los parámetros para el log
            $parametrosLog = array_map(function($param) {
                if (is_array($param)) {
                    return json_encode($param);
                }
                return is_string($param) ? $param : (string)$param;
            }, $params);

            // Reemplazar los placeholders con los valores reales
            $queryFinal = preg_replace_callback('/\?/', function() use (&$parametrosLog) {
                return array_shift($parametrosLog) ?? '?';
            }, $sql);

            // Preparar datos para el log
            $datosLog = [
                'tabla' => $this->tabla,
                'query_raw' => $sql,
                'parametros' => $params
            ];

            // Convertir arrays en los parámetros a JSON
            array_walk_recursive($datosLog, function(&$item) {
                if (is_array($item)) {
                    $item = json_encode($item);
                }
            });

            // Escribir en el archivo de log
            $logFile = fopen('logs/sql.log', 'a');
            if ($logFile) {
                fwrite($logFile, '[' . date('Y-m-d H:i:s') . '] SQL: ' . $queryFinal . "\n");
                fwrite($logFile, json_encode($datosLog) . "\n");
                fclose($logFile);
            }

        } catch (\Exception $e) {
            // Si hay un error en el logging, lo registramos pero no interrumpimos la ejecución
            error_log('Error en logQuery: ' . $e->getMessage());
        }
    }

    public function obtenerPorId($id) {
        try {
            // Validar que $id sea un número y no esté vacío
            if (empty($id) || !is_numeric($id) || $id <= 0) {
                $this->logger->error('ID inválido', [
                    'id' => $id,
                    'tipo' => gettype($id),
                    'razon' => empty($id) ? 'vacío' : (!is_numeric($id) ? 'no numérico' : 'menor o igual a cero'),
                    'tabla' => $this->tabla
                ]);

                return [
                    'estado' => 'error',
                    'mensaje' => 'ID inválido',
                    'detalles' => [
                        'id' => $id,
                        'tipo' => gettype($id),
                        'razon' => empty($id) ? 'vacío' : (!is_numeric($id) ? 'no numérico' : 'menor o igual a cero')
                    ]
                ];
            }

            // Convertir a entero para asegurar formato correcto
            $id = (int)$id;
            
            $sql = 'SELECT * FROM ' . $this->tabla . ' WHERE id = ?';
            $this->logQuery($sql, [$id]);
            $resultado = $this->db->exec($sql, [$id]);

            if (!$resultado) {
                return [
                    'estado' => 'error',
                    'mensaje' => 'Registro no encontrado',
                    'detalles' => ['id' => $id]
                ];
            }

            return [
                'estado' => 'exito',
                'datos' => $resultado[0]
            ];

        } catch (\Exception $e) {
            $mensaje = $e->getMessage();
            $this->logger->error('Error al obtener registro', [
                'error' => $mensaje,
                'id' => $id,
                'tabla' => $this->tabla
            ]);

            return [
                'estado' => 'error',
                'mensaje' => 'Error al obtener registro',
                'detalles' => [
                    'error' => $mensaje,
                    'id' => $id
                ]
            ];
        }
    }

    public function obtenerTodos() {
        try {
            $sql = 'SELECT * FROM ' . $this->tabla;
            $this->logQuery($sql);
            $resultado = $this->db->exec($sql);
            
            return $this->respuestaExito($resultado);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    protected function manejarError($e) {
        $mensaje = $e->getMessage();
        $codigo = $e->getCode();
        $errorInfo = [];

        // Capturar errores de duplicados
        if (strpos($mensaje, 'Duplicate entry') !== false) {
            preg_match("/Duplicate entry '(.+)' for key '(.+)'/", $mensaje, $matches);
            if (count($matches) >= 3) {
                $valor = $matches[1];
                $campo = $matches[2];
                
                $errorInfo = [
                    'tipo' => 'duplicado',
                    'campo' => $campo,
                    'valor' => $valor,
                    'mensaje' => "Valor duplicado: {$campo} = {$valor}",
                    'codigo' => 409 // Conflict
                ];
            }
        }
        // Error de restricción de llave foránea
        elseif (strpos($mensaje, 'foreign key constraint fails') !== false) {
            $errorInfo = [
                'tipo' => 'restriccion_foranea',
                'mensaje' => 'Violación de restricción de llave foránea',
                'codigo' => 409
            ];
        }
        // Error de tabla no encontrada
        elseif (strpos($mensaje, "Table") !== false && strpos($mensaje, "doesn't exist") !== false) {
            $errorInfo = [
                'tipo' => 'tabla_no_existe',
                'mensaje' => 'La tabla no existe',
                'codigo' => 500
            ];
        }
        // Error de columna no encontrada
        elseif (strpos($mensaje, "Unknown column") !== false) {
            $errorInfo = [
                'tipo' => 'columna_no_existe',
                'mensaje' => 'Columna no existe en la tabla',
                'codigo' => 400
            ];
        }
        // Otros errores SQL
        else {
            $errorInfo = [
                'tipo' => 'sql',
                'mensaje' => $mensaje,
                'codigo' => $codigo ?: 500
            ];
        }

        // Registrar el error completo en el log
        $this->logger->error('Error en consulta SQL', [
            'mensaje' => $mensaje,
            'codigo' => $codigo,
            'tabla' => $this->tabla,
            'trace' => $e->getTraceAsString()
        ]);

        return $errorInfo;
    }

    protected function respuestaExito($datos = null, $mensaje = null) {
        return [
            'estado' => 'exito',
            'mensaje' => $mensaje,
            'datos' => $datos
        ];
    }

    protected function respuestaError($mensaje, $detalles = null, $codigo = 500) {
        return [
            'estado' => 'error',
            'mensaje' => $mensaje,
            'detalles' => $detalles,
            'codigo' => $codigo
        ];
    }

    public function insertar($datos) {
        try {
            // Validar que haya datos
            if (empty($datos)) {
                return $this->respuestaError('No hay datos para insertar', null, 400);
            }

            // Hashear password si existe y estamos en la tabla usuarios
            if ($this->tabla === 'usuarios' && isset($datos['pass'])) {
                $hasheo = new HasheoPassword();
                $datos['pass'] = $hasheo->hashear($datos['pass']);
            }

            // Preparar la consulta
            $columnas = implode(', ', array_keys($datos));
            $valores = implode(', ', array_fill(0, count($datos), '?'));
            $sql = "INSERT INTO {$this->tabla} ($columnas) VALUES ($valores)";
            
            // Registrar la consulta en el log
            $this->logQuery($sql, array_values($datos));
            
            // Ejecutar la inserción
            $result = $this->db->exec($sql, array_values($datos));
            
            if ($result === false) {
                return $this->respuestaError('Error en la ejecución de la consulta');
            }
            
            // Obtener el ID del nuevo registro
            $nuevoId = $this->db->lastInsertId();
            
            return $this->respuestaExito(
                ['id' => $nuevoId],
                'Registro creado correctamente'
            );
                
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function actualizar($id, $datos) {
        try {
            if (empty($id)) {
                return $this->respuestaError('ID no proporcionado al actualizar', null, 400);
            }

            // Hashear password si existe y estamos en la tabla usuarios
            if ($this->tabla === 'usuarios' && isset($datos['pass'])) {
                $hasheo = new HasheoPassword();
                $datos['pass'] = $hasheo->hashear($datos['pass']);
            }

            $campos = array_map(function($campo) {
                return "$campo = ?";
            }, array_keys($datos));
            
            $sql = "UPDATE {$this->tabla} SET " . implode(', ', $campos) . " WHERE id = ?";
            $valores = array_merge(array_values($datos), [$id]);
            
            $this->logQuery($sql, $valores);
            $result = $this->db->exec($sql, $valores);
            
            if ($result !== false) {
                // Si la actualización fue exitosa, devolver el registro actualizado
                return $this->obtenerPorId($id);
            }
            
            return $this->respuestaError('Error al actualizar el registro');
            
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function eliminar($id) {
        try {
            if (empty($id)) {
                return $this->respuestaError('ID no proporcionado al eliminar', null, 400);
            }

            $sql = 'DELETE FROM ' . $this->tabla . ' WHERE id = ?';
            $this->logQuery($sql, [$id]);
            $result = $this->db->exec($sql, [$id]);
            
            if ($result === false) {
                return $this->respuestaError('Error al eliminar el registro');
            }
            
            return $this->respuestaExito(
                ['id' => $id],
                'Registro eliminado correctamente'
            );
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    // Métodos adicionales para consultas más específicas
    public function buscarPor($campo, $valor) {
        try {
            $sql = 'SELECT * FROM ' . $this->tabla . ' WHERE ' . $campo . ' = ?';
            $this->logQuery($sql, [$valor]);
            $resultado = $this->db->exec($sql, [$valor]);
            
            return $this->respuestaExito($resultado);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function contarRegistros() {
        try {
            $sql = 'SELECT COUNT(*) as total FROM ' . $this->tabla;
            $this->logQuery($sql);
            $resultado = $this->db->exec($sql);
            
            return $this->respuestaExito([
                'total' => $resultado[0]['total']
            ]);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    // Búsqueda con múltiples condiciones
    public function buscarConFiltros($filtros, $orden = null, $limite = null) {
        try {
            $this->logger->info('Iniciando búsqueda con filtros raw: ' . json_encode($filtros));
            
            $sql = 'SELECT * FROM ' . $this->tabla;
            $valores = [];
            
            if (!empty($filtros)) {
                $this->logger->info('Filtros no están vacíos');
                $condiciones = [];
                
                foreach ($filtros as $campo => $valor) {
                    $this->logger->info("Procesando: campo='$campo', valor='$valor'");
                    
                    // Extraer campo y operador usando regex
                    if (preg_match('/^(\w+)\s*([<>]=?|=)\s*(\d+)$/', $campo, $matches)) {
                        $campoReal = $matches[1];
                        $operador = $matches[2];
                        $valorComparacion = $matches[3];
                        $this->logger->info("Campo real: '$campoReal', Operador: '$operador', Valor: '$valorComparacion'");
                        $condiciones[] = "$campoReal $operador $valorComparacion";
                    }
                }
                
                if (!empty($condiciones)) {
                    $this->logger->info('Condiciones: ' . json_encode($condiciones));
                    $sql .= ' WHERE ' . implode(' AND ', $condiciones);
                }
            }
            
            $this->logger->info('SQL final: ' . $sql);
            $this->logQuery($sql, []);
            $resultado = $this->db->exec($sql);
            
            return $this->respuestaExito($resultado);
        } catch (\Exception $e) {
            $this->logger->error('Error en búsqueda con filtros: ' . $e->getMessage());
            throw $e;
        }
    }

    // Búsqueda por texto en múltiples campos
    public function buscarTexto($campos, $texto) {
        try {
            $condiciones = array_map(function($campo) {
                return "$campo LIKE ?";
            }, $campos);
            
            $sql = 'SELECT * FROM ' . $this->tabla . ' WHERE ' . implode(' OR ', $condiciones);
            $valores = array_fill(0, count($campos), "%$texto%");
            
            $this->logQuery($sql, $valores);
            $resultado = $this->db->exec($sql, $valores);
            
            return $this->respuestaExito($resultado);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    // Obtener registros con paginación
    public function obtenerPaginado($pagina = 1, $porPagina = 10) {
        try {
            $offset = ($pagina - 1) * $porPagina;
            $sql = "SELECT * FROM {$this->tabla} LIMIT ? OFFSET ?";
            $this->logQuery($sql, [$porPagina, $offset]);
            
            $total = $this->contarRegistros();
            if ($total['estado'] === 'error') {
                return $total;
            }
            
            $resultado = $this->db->exec($sql, [$porPagina, $offset]);
            
            return $this->respuestaExito([
                'datos' => $resultado,
                'total' => $total['datos']['total'],
                'pagina_actual' => $pagina,
                'por_pagina' => $porPagina,
                'total_paginas' => ceil($total['datos']['total'] / $porPagina)
            ]);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    // Actualización condicional
    public function actualizarDonde($condiciones, $datos) {
        try {
            if (empty($condiciones) || empty($datos)) {
                return $this->respuestaError('Condiciones o datos no proporcionados', null, 400);
            }

            $campos = array_map(function($campo) {
                return "$campo = ?";
            }, array_keys($datos));
            
            $where = array_map(function($campo) {
                return "$campo = ?";
            }, array_keys($condiciones));
            
            $sql = "UPDATE {$this->tabla} SET " . implode(', ', $campos) . 
                   " WHERE " . implode(' AND ', $where);
                   
            $valores = array_merge(array_values($datos), array_values($condiciones));
            
            $this->logQuery($sql, $valores);
            $resultado = $this->db->exec($sql, $valores);
            
            if ($resultado === false) {
                return $this->respuestaError('Error al actualizar los registros');
            }
            
            return $this->respuestaExito([
                'registros_actualizados' => $resultado
            ], 'Registros actualizados correctamente');
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function obtenerMarcadores() {
        try {
            $sql = "SELECT
                        tipo,
                        codinsclo,
                        nombre,
                        CAST(latitud AS DECIMAL(10, 8)) AS latitud,
                        CAST(longitud AS DECIMAL(11, 8)) AS longitud,
                        atributos,
                        rotativo
                    FROM (
                        SELECT
                            'cartel' as codinsclo,
                            'cartel' AS tipo,
                            c.nombre,
                            CAST(c.latitud AS DECIMAL(10, 8)) AS latitud,
                            CAST(c.longitud AS DECIMAL(11, 8)) AS longitud,
                            ct.atributos AS atributos,
                            c.rotativo
                        FROM
                            carteles c 
                            LEFT JOIN c_tiposcarteles ct ON (ct.id = c.id_tipocartel)
                        UNION ALL
                        SELECT
                            codinsclo,
                            'parking' AS tipo,
                            nombre,
                            CAST(latitud AS DECIMAL(10, 8)) AS latitud,
                            CAST(longitud AS DECIMAL(11, 8)) AS longitud,
                            json_counters AS atributos,
                            '' as rotativo
                        FROM
                            parkings
                    ) AS combined_results
                    WHERE latitud IS NOT NULL 
                    AND longitud IS NOT NULL
                    ORDER BY tipo, nombre";
            
            $this->logQuery($sql);
            $resultado = $this->db->exec($sql);
            
            return $this->respuestaExito($resultado);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function obtenerVariables($desde = null)
    {
        // Parte base de la consulta
        $sql = "SELECT * FROM variables";

        // Inicializamos los parámetros
        $params = [];

        // Añadimos la cláusula WHERE si se proporciona 'desde'
        if (!is_null($desde)) {
            $sql .= " WHERE fecha >= ?";
            $params[] = $desde;
        }

        // Añadimos la cláusula ORDER BY al final
        $sql .= " ORDER BY fecha DESC";

        // Ejecutamos la consulta con los parámetros
        $this->logQuery($sql, $params);
        $resultado = $this->db->exec($sql, $params);
        
        return $this->respuestaExito($resultado);
    }

    public function buscarPorEmail($email) {
        try {
            if (empty($email)) {
                $this->logger->error('Email vacío', [
                    'email' => $email,
                    'tabla' => $this->tabla
                ]);
                return false;
            }

            $sql = 'SELECT * FROM ' . $this->tabla . ' WHERE email = ?';
            $this->logQuery($sql, [$email]);
            $resultado = $this->db->exec($sql, [$email]);

            if (!$resultado) {
                return false;
            }

            // Cargar los datos en el objeto actual
            foreach ($resultado[0] as $campo => $valor) {
                $this->$campo = $valor;
            }

            return true;

        } catch (\Exception $e) {
            $mensaje = $e->getMessage();
            $this->logger->error('Error al buscar usuario por email', [
                'error' => $mensaje,
                'email' => $email,
                'tabla' => $this->tabla
            ]);
            return false;
        }
    }
} 
  
