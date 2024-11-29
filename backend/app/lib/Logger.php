<?php

class Logger {
    protected $f3;
    protected $logPath;
    protected $db;
    protected $idUsuario;

    public function __construct($f3) {
        $this->f3 = $f3;
        $this->logPath = $f3->get('LOGPATH');
        $this->idUsuario = null;
        
        if (!is_dir($this->logPath)) {
            mkdir($this->logPath, 0777, true);
        }

        if ($this->f3->exists('DB')) {
            $this->db = $this->f3->get('DB');
        }
    }

    public function setIdUsuario($id) {
        $this->idUsuario = $id;
    }

    protected function log($nivel, $mensaje, $archivo, $metadata = null) {
        try {
            $fecha = date('Y-m-d H:i:s');
            $logMessage = "[$fecha] $nivel: $mensaje" . PHP_EOL;
            
            // Escribir en archivo (mantener saltos de línea para el archivo)
            $this->f3->write($this->logPath . '/' . $archivo, $logMessage, true);
            $this->f3->write($this->logPath . '/' . $archivo, $metadata ? json_encode($metadata) : null . PHP_EOL, true);

            // Escribir en BD si está disponible
            if ($this->db) {
                try {
                    // Limpiar saltos de línea del mensaje y metadata
                    $mensajeLimpio = str_replace(["\r\n", "\r", "\n"], ' ', $mensaje);
                    
                    // Si metadata es un string, limpiar saltos de línea
                    if (is_string($metadata)) {
                        $metadata = str_replace(["\r\n", "\r", "\n"], ' ', $metadata);
                    } 
                    // Si metadata es un array u objeto, limpiar saltos de línea en sus valores
                    elseif (is_array($metadata) || is_object($metadata)) {
                        $metadata = json_decode(json_encode($metadata), true); // Convertir a array
                        array_walk_recursive($metadata, function(&$valor) {
                            if (is_string($valor)) {
                                $valor = str_replace(["\r\n", "\r", "\n"], ' ', $valor);
                            }
                        });
                    }

                    $this->db->exec(
                        'INSERT INTO logs (fecha, tipo, contenido, metadata, id_usuario) VALUES (?, ?, ?, ?, ?)',
                        [
                            $fecha,
                            strtolower($nivel),
                            $mensajeLimpio,
                            $metadata ? json_encode($metadata) : null,
                            $this->idUsuario
                        ]
                    );
                } catch (\Exception $e) {
                    $errorMsg = "[{$fecha}] ERROR: Error al escribir en BD: {$e->getMessage()}" . PHP_EOL;
                    $this->f3->write($this->logPath . '/error.log', $errorMsg, true);
                }
            }
        } catch (\Exception $e) {
            $errorMsg = date('Y-m-d H:i:s') . " ERROR: {$e->getMessage()}" . PHP_EOL;
            $this->f3->write($this->logPath . '/error.log', $errorMsg, true);
        }
    }

    public function debug($mensaje, $metadata = null) {
        $this->log('DEBUG', $mensaje, 'debug.log', $metadata);
    }

    public function error($mensaje, $metadata = null) {
        $this->log('ERROR', $mensaje, 'error.log', $metadata);
    }

    public function info($mensaje, $metadata = null) {
        $this->log('INFO', $mensaje, 'info.log', $metadata);
    }

    public function sql($mensaje, $metadata = null) {
        $this->log('SQL', $mensaje, 'sql.log', $metadata);
    }

    public function validador($mensaje, $metadata = null) {
        $this->log('VALIDADOR', $mensaje, 'validador.log', $metadata);
    }

    public function request($mensaje, $metadata = null) {
        $this->log('REQUEST', $mensaje, 'peticiones.log', $metadata);
    }

    public function getLogs($tipo = null, $desde = null, $hasta = null, $limite = 100, $pagina = 1) {
        try {
            $sql = 'SELECT SQL_CALC_FOUND_ROWS * FROM logs WHERE 1=1';
            $params = [];

            if ($tipo) {
                $sql .= ' AND tipo = ?';
                $params[] = $tipo;
            }

            if ($desde) {
                $sql .= ' AND fecha >= ?';
                $params[] = $desde;
            }

            if ($hasta) {
                $sql .= ' AND fecha <= ?';
                $params[] = $hasta;
            }

            // Calcular offset para paginación
            $offset = ($pagina - 1) * $limite;
            $sql .= ' ORDER BY fecha DESC LIMIT ? OFFSET ?';
            $params[] = $limite;
            $params[] = $offset;

            // Ejecutar consulta principal
            $logs = $this->db->exec($sql, $params);
            
            // Obtener total de registros sin límite
            $total = $this->db->exec('SELECT FOUND_ROWS() as total')[0]['total'];

            return [
                'estado' => 'exito',
                'datos' => [
                    'logs' => $logs,
                    'total' => (int)$total
                ]
            ];

        } catch (\Exception $e) {
            $this->error("Error obteniendo logs: " . $e->getMessage(), [
                'tipo' => $tipo,
                'desde' => $desde,
                'hasta' => $hasta,
                'limite' => $limite,
                'pagina' => $pagina
            ]);
            
            throw $e;
        }
    }

    public function limpiarLogs($fechaLimite) {
        try {
            // Validar formato de fecha
            if (!strtotime($fechaLimite)) {
                throw new \Exception('Formato de fecha límite inválido');
            }

            // Eliminar registros antiguos
            $sql = "DELETE FROM logs WHERE fecha < ?";
            $resultado = $this->db->exec($sql, [$fechaLimite]);

            // Registrar la operación de limpieza
            $this->info("Se eliminaron $resultado logs anteriores a $fechaLimite", [
                'registros_eliminados' => $resultado,
                'fecha_limite' => $fechaLimite
            ]);

            return $resultado;

        } catch (\Exception $e) {
            // Registrar el error
            $this->error("Error al limpiar logs: " . $e->getMessage(), [
                'fecha_limite' => $fechaLimite,
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }
} 