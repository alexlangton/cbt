<?php

class BaseController extends AutenticacionController {
    protected $tabla;
    protected $consultas;
    protected $logger;

    public function __construct($tabla = null) {
        parent::__construct();
        if ($tabla) {
            $this->tabla = $tabla;
            $this->consultas = new ConsultasSQL($tabla);
            $this->logger->info("BaseController inicializado para tabla: {$tabla}");
        }
    }

    public function obtener($f3, $params) {
        return $this->ejecutarOperacion(function() use ($params) {
            try {
                if (!isset($params['id'])) {
                    $this->logger->info("Solicitando todos los registros de {$this->tabla}");
                    $this->logger->debug("GET: obtenerTodos() llamado para {$this->tabla}");
                    $registros = $this->consultas->obtenerTodos();
                    return $this->respuestaExito($registros);
                }

                $id = $params['id'];
                $this->logger->info("Solicitando registro de {$this->tabla} con ID: {$id}");
                
                $validacionId = $this->validarId($id, $this->tabla);
                if ($validacionId !== true) {
                    $this->logger->error("ID inválido para {$this->tabla}: {$id}");
                    return $validacionId;
                }

                $registro = $this->consultas->obtenerPorId($id);
                if (!$registro) {
                    $this->logger->error("Registro no encontrado en {$this->tabla} con ID: {$id}");
                    return $this->errorRegistroNoEncontrado($id, $this->tabla);
                }

                $this->logger->debug("Registro encontrado: " . json_encode($registro));
                return $this->respuestaExito($registro);
                
            } catch (\PDOException $e) {
                $this->logger->error("Error en base de datos al obtener {$this->tabla}: " . $e->getMessage());
                throw $e;
            }
        }, "Error al obtener {$this->tabla}");
    }

    public function obtenerTodos($f3) {
        return $this->ejecutarOperacion(function() {
            return $this->respuestaExito(
                $this->consultas->obtenerTodos()
            );
        }, 'Error al obtener los registros');
    }

    private function procesarGuardado($datos, $id = null) {
        $operacion = $id ? 'actualización' : 'creación';
        
        $debeLogear = $this->tabla !== 'logs' || $id !== null;
        
        if ($debeLogear) {
            $this->logger->info("Iniciando {$operacion} en {$this->tabla}" . ($id ? " con ID: {$id}" : ""));
            $this->logger->debug("Datos recibidos para {$operacion}: " . json_encode($datos));
        }

        // Validación
        $validador = new Validador($this->f3);
        $validador->setDatos($datos);
        $esValido = $validador->validar($this->tabla, null, $id !== null);
        
        // Debug
        $this->logger->debug("Resultado de validación: " . json_encode([
            'esValido' => $esValido,
            'errores' => $validador->getErrores(),
            'datos' => $validador->getDatos()
        ]));

        // Verificar si la validación falló
        if (!$esValido) {
            if ($debeLogear) {
                $this->logger->error("Validación fallida para {$operacion} en {$this->tabla}: " . 
                    json_encode($validador->getErrores()));
            }
            return $this->respuestaError(
                'Datos inválidos',
                422,
                $validador->getErrores()
            );
        }

        if ($debeLogear) {
            $this->logger->info("Validación exitosa para {$operacion} en {$this->tabla}");
        }

        try {
            $datosLimpios = $validador->getDatos();
            
            if ($debeLogear) {
                $this->logger->debug("Datos a procesar: " . json_encode($datosLimpios));
            }
            
            $registro = $id ? 
                $this->consultas->actualizar($id, $datosLimpios) :
                $this->consultas->insertar($datosLimpios);

            if (!$registro) {
                if ($debeLogear) {
                    $this->logger->error("Error al ejecutar {$operacion} en {$this->tabla}");
                }
                throw new \Exception("Error al ejecutar {$operacion}");
            }

            if ($debeLogear) {
                $this->logger->info("{$operacion} completada exitosamente en {$this->tabla}");
                $this->logger->debug("Registro resultante: " . json_encode($registro));
            }
            
            return $this->respuestaExito(
                $registro,
                "Registro de {$operacion} realizado correctamente",
                $id ? 200 : 201
            );
        } catch (\Exception $e) {
            if ($debeLogear) {
                $this->logger->error("Error en {$operacion} para {$this->tabla}: " . $e->getMessage());
                $this->logger->debug("Stack trace: " . $e->getTraceAsString());
            }
            return $this->respuestaError($e->getMessage(), 500);
        }
    }

    public function guardarnuevo($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            $this->logger->info("Iniciando creación de nuevo registro en {$this->tabla}");
            
            // Log del body recibido
            $this->logger->debug("Body recibido: " . $f3->get('BODY'));
            
            $resultadoJSON = $this->decodificarJSON($f3->get('BODY'));
            if ($resultadoJSON['error']) {
                $this->logger->error("Error al decodificar JSON para {$this->tabla}: " . json_encode($resultadoJSON['error']));
                return $resultadoJSON['response'];
            }

            $this->logger->debug("Datos JSON decodificados: " . json_encode($resultadoJSON['datos']));
            
            $resultado = $this->procesarGuardado($resultadoJSON['datos']);
            
            if (isset($resultado['error'])) {
                $this->logger->error("Error al procesar guardado en {$this->tabla}: " . json_encode($resultado));
            } else {
                $this->logger->info("Nuevo registro creado exitosamente en {$this->tabla}");
            }
            
            return $resultado;
        }, 'Error al crear el registro');
    }

    public function guardar($f3, $params) {
        return $this->ejecutarOperacion(function() use ($f3, $params) {
            $validacionId = $this->validarId($params['id'] ?? null, $this->tabla);
            if ($validacionId !== true) return $validacionId;

            $resultadoJSON = $this->decodificarJSON($f3->get('BODY'));
            if ($resultadoJSON['error']) {
                return $resultadoJSON['response'];
            }

            $registro = $this->consultas->obtenerPorId($params['id']);
            if (!$registro) {
                return $this->errorRegistroNoEncontrado($params['id'], $this->tabla);
            }

            return $this->procesarGuardado($resultadoJSON['datos'], $params['id']);
        }, 'Error al actualizar el registro');
    }

    public function borrar($f3, $params) {
        $this->logger->info("BaseController borrando en tabla: {$this->tabla}");
        return $this->ejecutarOperacion(function() use ($params) {
            // Si no hay ID y es la tabla logs, borrar toda la tabla
            if (!isset($params['id']) && $this->tabla === 'logs') {
                $this->logger->info("Iniciando borrado completo de la tabla logs");
                
                try {
                    $sql = "DELETE FROM logs";
                    $resultado = $this->db->exec($sql);
                    
                    $this->logger->info("Se eliminaron {$resultado} registros de logs");
                    return $this->respuestaExito(
                        ['registros_eliminados' => $resultado],
                        'Registros eliminados correctamente'
                    );
                } catch (\Exception $e) {
                    $this->logger->error("Error al borrar tabla logs: " . $e->getMessage());
                    return $this->respuestaError(
                        'Error al eliminar los registros',
                        500
                    );
                }
            }

            // Para otras tablas o cuando hay ID específico
            if (!isset($params['id'])) {
                $this->logger->error("Intento de borrado sin ID en {$this->tabla}");
                return $this->respuestaError(
                    'Se requiere un ID para eliminar el registro',
                    400
                );
            }

            $id = $params['id'];
            $this->logger->debug("Intentando borrar registro en {$this->tabla} con ID: {$id}");
            
            // Validar el ID
            $validacionId = $this->validarId($id, $this->tabla);
            if ($validacionId !== true) {
                $this->logger->debug("ID inválido para borrar en {$this->tabla}: {$id}");
                return $validacionId;
            }

            // Verificar si el registro existe
            if (!$this->consultas->obtenerPorId($id)) {
                $this->logger->debug("Registro no encontrado en {$this->tabla} con ID: {$id}");
                return $this->respuestaError(
                    'El registro no existe',
                    404
                );
            }

            // Intentar eliminar el registro
            if (!$this->consultas->eliminar($id)) {
                $this->logger->error("Error al eliminar registro en {$this->tabla} con ID: {$id}");
                return $this->respuestaError(
                    'Error al eliminar el registro',
                    500
                );
            }

            $this->logger->info("Registro eliminado exitosamente en {$this->tabla} con ID: {$id}");
            return $this->respuestaExito(
                null,
                'Registro eliminado correctamente'
            );
        }, 'Error al eliminar el registro');
    }

    public function obtenerConFiltros($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            // Obtener y loguear todos los datos posibles
            $this->logger->info('REQUEST_URI: ' . $f3->get('REQUEST_URI'));
            $this->logger->info('QUERY: ' . $f3->get('QUERY'));
            $this->logger->info('GET array: ' . print_r($f3->get('GET'), true));
            $this->logger->info('SERVER REQUEST_URI: ' . $_SERVER['REQUEST_URI']);
            
            // Obtener los parámetros GET de forma directa
            parse_str($_SERVER['QUERY_STRING'] ?? '', $queryParams);
            $this->logger->info('Query params parseados: ' . json_encode($queryParams));
            
            // Usar los parámetros parseados directamente
            $filtrosDecodificados = [];
            foreach ($queryParams as $key => $value) {
                $keyDecodificada = urldecode($key);
                $keyDecodificada = preg_replace('/([><]=?)/', ' $1 ', $keyDecodificada);
                $keyDecodificada = trim($keyDecodificada);
                $filtrosDecodificados[$keyDecodificada] = $value === '' ? '0' : $value;
            }

            $this->logger->info('Filtros finales: ' . json_encode($filtrosDecodificados));
            
            return $this->respuestaExito(
                $this->consultas->buscarConFiltros(
                    $filtrosDecodificados,
                    $f3->get('GET.orden'),
                    $f3->get('GET.limite')
                )
            );
        }, 'Error al obtener los registros');
    }

    public function buscarPorTexto($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            $texto = $f3->get('GET.texto');
            if (!$texto) {
                return $this->respuestaError('Texto de búsqueda no proporcionado');
            }
            
            $campos = $f3->get('GET.campos') ? 
                      explode(',', $f3->get('GET.campos')) : 
                      ['nombre'];
            
            return $this->respuestaExito(
                $this->consultas->buscarTexto($campos, $texto)
            );
        }, 'Error en la búsqueda');
    }

    public function obtenerPaginado($f3, $params) {
        return $this->ejecutarOperacion(function() use ($params) {
            $pagina = (int)($params['pagina'] ?? 1);
            $porPagina = (int)($params['por_pagina'] ?? 10);
            
            $resultadoConsulta = $this->consultas->obtenerPaginado($pagina, $porPagina);
            
            // Verificar si hay error en la consulta
            if ($resultadoConsulta['estado'] === 'error') {
                return $this->respuestaError(
                    $resultadoConsulta['mensaje'],
                    $resultadoConsulta['detalles'] ?? null
                );
            }

            // Extraer los datos de paginación
            $datos = $resultadoConsulta['datos'];
            
            return $this->respuestaExito($datos['datos'], null, 200, [
                'paginacion' => [
                    'total' => $datos['total'],
                    'pagina_actual' => $datos['pagina_actual'],
                    'por_pagina' => $datos['por_pagina'],
                    'total_paginas' => $datos['total_paginas']
                ]
            ]);
        }, 'Error al obtener los registros');
    }
} 