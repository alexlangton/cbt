<?php

class ConsultasVariables extends ConsultasSQL {
    protected $logger;

    public function __construct() {
        parent::__construct('variables');
        $this->logger = new Logger($this->f3);
        $this->logger->info('ConsultasVariables inicializada');
    }

    public function obtenerConFecha() {
        try {
            $this->logger->debug('Obteniendo variables con fecha');

            $sql = "SELECT * FROM variables";
            $params = [];

            $sql .= " ORDER BY fecha DESC";

            $this->logQuery($sql, $params);
            $resultado = $this->db->exec($sql, $params);
            
            $this->logger->debug('Variables obtenidas', [
                'cantidad' => count($resultado)
            ]);

            return $resultado;
        } catch (\Exception $e) {
            $this->logger->error('Error al obtener variables', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            throw $e;
        }
    }

    public function obtenerEstadisticasFechas($desde = null) {
        try {
            $this->logger->debug('Obteniendo estadísticas', ['desde' => $desde]);

            $sql = "SELECT MAX(fecha) as max, MIN(fecha) as min, COUNT(fecha) as total FROM variables";
            $params = [];

            if (!is_null($desde)) {
                $sql .= " WHERE fecha >= ?";
                $params[] = $desde;
            }

            $this->logQuery($sql, $params);
            $resultado = $this->db->exec($sql, $params);
            
            $this->logger->debug('Estadísticas obtenidas', ['resultado' => $resultado[0]]);
            return $resultado[0];
        } catch (\Exception $e) {
            $this->logger->error('Error al obtener estadísticas', [
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    public function insertarParametro($clave, $valor) {
        try {
            $this->logger->debug('Intentando insertar parámetro', [
                'clave' => $clave,
                'valor' => $valor
            ]);

            if (empty($clave)) {
                $this->logger->error('Intento de inserción con clave vacía');
                throw new \Exception('La clave no puede estar vacía');
            }

            $resultado = $this->db->exec(
                "INSERT INTO variables (clave, valor) VALUES (?, ?)",
                [$clave, $valor]
            );

            $this->logger->debug('Parámetro insertado', [
                'clave' => $clave,
                'resultado' => $resultado
            ]);

            return $resultado;
        } catch (\Exception $e) {
            $this->logger->error('Error al insertar parámetro', [
                'clave' => $clave,
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    public function actualizarParametro($clave, $nuevoValor) {
        try {
            $this->logger->debug('Intentando actualizar parámetro', [
                'clave' => $clave,
                'nuevo_valor' => $nuevoValor
            ]);

            if (empty($clave)) {
                $this->logger->error('Intento de actualización con clave vacía');
                throw new \Exception('La clave no puede estar vacía');
            }

            $sql = "UPDATE variables SET valor = ? WHERE clave = ?";
            $params = [$nuevoValor, $clave];
            
            $this->logQuery($sql, $params);
            $resultado = $this->db->exec($sql, $params);
            
            if ($resultado === false) {
                throw new \Exception('Error al actualizar el parámetro');
            }
            
            $this->logger->debug('Parámetro actualizado', [
                'clave' => $clave,
                'resultado' => $resultado
            ]);

            return $resultado;
        } catch (\Exception $e) {
            $this->logger->error('Error al actualizar parámetro', [
                'clave' => $clave,
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    public function obtenerClavesExistentes($claves) {
        try {
            $this->logger->debug('Buscando claves existentes', [
                'claves' => $claves
            ]);

            if (empty($claves) || !is_array($claves)) {
                return [];
            }

            $claves = array_filter($claves, function ($clave) {
                return !empty($clave) && is_string($clave);
            });

            if (empty($claves)) {
                return [];
            }

            $placeholders = rtrim(str_repeat('?,', count($claves)), ',');
            $sql = "SELECT clave FROM variables WHERE clave IN ($placeholders)";

            $this->logQuery($sql, $claves);
            $resultados = $this->db->exec($sql, $claves);

            $clavesExistentes = array_column($resultados, 'clave');
            
            $this->logger->debug('Claves encontradas', [
                'cantidad' => count($clavesExistentes)
            ]);

            return $clavesExistentes;
        } catch (\Exception $e) {
            $this->logger->error('Error al obtener claves existentes', [
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    public function sincronizarRegistro($atributos, $registros, $codinsclo, $entidad) {
        try {
            $this->logger->debug('Iniciando sincronización de registro', [
                'codinsclo' => $codinsclo,
                'entidad' => $entidad,
                'num_registros' => count($registros)
            ]);

            $clavesAVerificar = [];
            foreach ($registros as $registro) {
                foreach ($atributos as $atributo) {
                    $clavesAVerificar[] = "$codinsclo.$entidad.{$registro['id']}.$atributo";
                }
            }

            $clavesExistentes = $this->obtenerClavesExistentes($clavesAVerificar);

            foreach ($registros as $registro) {
                foreach ($atributos as $atributo) {
                    $clave = "$codinsclo.$entidad.{$registro['id']}.$atributo";
                    $valor = $registro[$atributo];

                    if (in_array($clave, $clavesExistentes)) {
                        $this->actualizarParametro($clave, $valor);
                    } else {
                        $this->insertarParametro($clave, $valor);
                    }
                }
            }

            $this->logger->info('Sincronización completada exitosamente');
            return true;

        } catch (\Exception $e) {
            $this->logger->error('Error en sincronización', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            throw $e;
        }
    }

    public function sincronizarRegistros($codinsclo, $entidad, $registros) {
        try {
            $this->logger->info('Iniciando sincronización de registros', [
                'codinsclo' => $codinsclo,
                'entidad' => $entidad,
                'num_registros' => count($registros)
            ]);

            // Validaciones iniciales
            if (empty($codinsclo)) {
                throw new \Exception('El código de instalación no puede estar vacío');
            }

            $atributos = [
                'zones' => ['description', 'total_spaces', 'available_spaces', 'occupied_spaces'],
                'counters' => ['description', 'value_expression', 'value'],
                'signs' => ['description', 'activation_expression', 'activated', 'forced']
            ];

            if (!isset($atributos[$entidad])) {
                throw new \Exception('Entidad no válida');
            }

            // Validar que cada registro tenga todos los atributos necesarios
            foreach ($registros as $index => $registro) {
                if (!isset($registro['id'])) {
                    throw new \Exception('Cada registro debe tener un ID');
                }
                
                foreach ($atributos[$entidad] as $atributo) {
                    if (!array_key_exists($atributo, $registro)) {
                        throw new \Exception(
                            "Falta el atributo '$atributo' en el registro {$registro['id']}"
                        );
                    }
                }
            }

            $this->sincronizarRegistro($atributos[$entidad], $registros, $codinsclo, $entidad);
            
            $this->logger->info('Sincronización finalizada exitosamente');
            return true;

        } catch (\Exception $e) {
            $this->logger->error('Error en sincronización', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            throw $e;
        }
    }
}
