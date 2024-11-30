<?php

class BaseDatosController extends AutenticacionController {
    protected $logger;

    public function __construct() {
        parent::__construct();
        $this->logger = new Logger($this->f3);
    }

    private function obtenerUltimaFechaBackup() {
        try {
            $backupDir = $this->f3->get('BACKUP_DIR');
            $this->logger->debug("Directorio de backups: " . $backupDir);
            
            if (!is_dir($backupDir)) {
                $this->logger->error("Directorio de backups no encontrado", [
                    'directorio' => $backupDir
                ]);
                return null;
            }
            $this->logger->debug("Directorio de backups encontrado", [
                'directorio' => $backupDir
            ]);

            $archivos = glob($backupDir . "/backup_*.sql");
            $this->logger->debug("Archivos de backups encontrados", [
                'archivos' => $archivos
            ]);     

            if (empty($archivos)) {
                $this->logger->info("No se encontraron archivos de backup");
                return null;        
            }

            usort($archivos, function($a, $b) {
                return filemtime($b) - filemtime($a);
            });

            $ultimoBackup = $archivos[0];
            $timestamp = filemtime($ultimoBackup);
            $nombreArchivo = basename($ultimoBackup);

            $this->logger->debug("Último backup encontrado", [
                'archivo' => $nombreArchivo,
                'fecha' => date('Y-m-d H:i:s', $timestamp)
            ]);

            return [
                'timestamp' => date('c', $timestamp),
                'fecha_formateada' => date('Y-m-d H:i:s', $timestamp),
                'archivo' => $nombreArchivo,
                'tamaño' => filesize($ultimoBackup),
                'ruta' => $ultimoBackup
            ];

        } catch (Exception $e) {
            $this->logger->error("Error al obtener fecha del último backup", [
                'error' => $e->getMessage()
            ]);
            return null;
        }
    }

    public function getUltimo() {
        $this->logger->info("Obteniendo información del último backup");
        try {
            $infoBackup = $this->obtenerUltimaFechaBackup();
            $this->logger->debug("Información del último backup", [
                'infoBackup' => $infoBackup
            ]);

            if ($infoBackup === null) {
                $this->respuestaExito(
                    [
                        'fecha' => null,
                        'metadata' => null,
                        'estado' => 'sin_backups'
                    ],
                    'No hay backups disponibles'
                );
                return;
            }

            $this->logger->debug("Información del último backup obtenida correctamente", [
                'infoBackup' => $infoBackup
            ]); 

            $this->respuestaExito(
                [
                    'fecha' => $infoBackup['timestamp'],
                    'metadata' => [
                        'fecha_formateada' => $infoBackup['fecha_formateada'],
                        'archivo' => $infoBackup['archivo'],
                        'tamaño' => $infoBackup['tamaño'],
                        'tamaño_formateado' => $this->formatearTamaño($infoBackup['tamaño'])
                    ],
                    'estado' => 'con_backup'
                ],
                'Información del último backup obtenida correctamente'
            );

        } catch (Exception $e) {
            $this->logger->error("Error al obtener información del último backup: " . $e->getMessage());
            $this->respuestaError(
                'Error al obtener información del último backup',
                500,
                ['error' => $e->getMessage()]
            );
        }
    }

    private function formatearTamaño($bytes) {
        $unidades = ['B', 'KB', 'MB', 'GB'];
        $i = 0;
        while ($bytes >= 1024 && $i < count($unidades) - 1) {
            $bytes /= 1024;
            $i++;
        }
        return round($bytes, 2) . ' ' . $unidades[$i];
    }

    public function createBackup($f3) {
        $this->logger->debug("Creando backup");
        return $this->ejecutarOperacion(function() {
            try {
                $backupDir = $this->f3->get('BACKUP_DIR');
                $this->logger->debug("Directorio de backups: " . $backupDir);
                // Verificar configuración
                if (!$backupDir) {
                    $this->logger->error("BACKUP_DIR no está configurado en config.ini");
                    throw new Exception("Configuración de backup incompleta");
                }
                $this->logger->debug("BACKUP_DIR configurado: " . $backupDir);
                // Verificar y crear directorio
                if (!is_dir($backupDir)) {
                    $this->logger->info("Intentando crear directorio de backups: " . $backupDir);
                    if (!mkdir($backupDir, 0755, true)) {
                        $this->logger->error("No se pudo crear el directorio de backups", [
                            'directorio' => $backupDir,
                            'permisos' => fileperms(dirname($backupDir))
                        ]);
                        throw new Exception("No se pudo crear el directorio de backups");
                    }
                }
                $this->logger->debug("Directorio de backups creado: " . $backupDir);
                // Verificar permisos de escritura
                if (!is_writable($backupDir)) {
                    $this->logger->error("El directorio de backups no tiene permisos de escritura", [
                        'directorio' => $backupDir,
                        'permisos' => fileperms($backupDir)
                    ]);
                    throw new Exception("El directorio de backups no tiene permisos de escritura");
                }
                $this->logger->debug("Directorio de backups tiene permisos de escritura", [
                    'directorio' => $backupDir,
                    'permisos' => fileperms($backupDir)
                ]); 

                // Obtener configuración DB (MODIFICAR ESTA PARTE)
                $dbConfig = [
                    'host' => $this->f3->get('db.host'),
                    'name' => $this->f3->get('db.name'),
                    'user' => $this->f3->get('db.user'),
                    'password' => $this->f3->get('db.pass')
                ];

                $this->logger->debug("Configuración de base de datos", [
                    'host' => $dbConfig['host'],
                    'database' => $dbConfig['name'],
                    'user' => $dbConfig['user']
                ]);

                if (empty($dbConfig['host']) || empty($dbConfig['name']) || empty($dbConfig['user'])) {
                    $this->logger->error("Configuración de base de datos incompleta");
                    throw new Exception("Configuración de base de datos incompleta");
                }

                // Preparar comando mysqldump (ACTUALIZAR VARIABLES)
                $dbHost = $dbConfig['host'];
                $dbName = $dbConfig['name'];
                $dbUser = $dbConfig['user'];
                $dbPass = $dbConfig['password'];

                $timestamp = date('Y-m-d_H-i-s');
                $backupFile = "{$backupDir}/backup_{$timestamp}.sql";
                $this->logger->debug("Archivo de backup a crear", [
                    'archivo' => $backupFile
                ]);
                $this->logger->debug("Timestamp", [
                    'timestamp' => $timestamp
                ]);
                // Verificar si mysqldump está disponible
                exec('which mysqldump', $output, $returnVar);
                if ($returnVar !== 0) {
                    $this->logger->error("mysqldump no está disponible en el sistema");
                    throw new Exception("mysqldump no está disponible en el sistema");
                }
                $this->logger->debug("mysqldump disponible", [
                    'output' => $output
                ]); 

                $command = sprintf(
                    'mysqldump --host=%s --user=%s --password=%s %s > %s 2>&1',
                    escapeshellarg($dbHost),
                    escapeshellarg($dbUser),
                    escapeshellarg($dbPass),
                    escapeshellarg($dbName),
                    escapeshellarg($backupFile)
                );

                $this->logger->debug("Ejecutando comando de backup");
                
                // Ejecutar y capturar cualquier error
                exec($command, $output, $returnVar);
                
                if ($returnVar !== 0) {
                    $this->logger->error("Error al ejecutar mysqldump", [
                        'codigo' => $returnVar,
                        'salida' => $output
                    ]);
                    throw new Exception("Error al ejecutar mysqldump: " . implode("\n", $output));
                }

                if (!file_exists($backupFile)) {
                    $this->logger->error("El archivo de backup no se creó");
                    throw new Exception("El archivo de backup no se creó");
                }

                $infoBackup = [
                    'archivo' => basename($backupFile),
                    'fecha' => date('c'),
                    'tamaño' => filesize($backupFile),
                    'tamaño_formateado' => $this->formatearTamaño(filesize($backupFile))
                ];

                $this->logger->info("Backup creado exitosamente", $infoBackup);

                return $this->respuestaExito(
                    $infoBackup,
                    'Backup creado correctamente'
                );

            } catch (Exception $e) {
                $this->logger->error("Error al crear backup", [
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                return $this->respuestaError(
                    'Error al crear el backup: ' . $e->getMessage(),
                    500
                );
            }
        }, 'Error al crear el backup');
    }
    public function download() {
        $tempFile = null;
        try {
            $this->logger->info('=== INICIANDO DESCARGA DE BASE DE DATOS ===');

            // Verificar mysqldump
            $this->verificarMysqlDump();

            // Validar configuración
            $dbConfig = $this->validarConfiguracionDB();
            
            // Probar conexión
            $this->probarConexionDB($dbConfig);

            // Crear archivo temporal
            $tempFile = $this->crearArchivoTemporal();

            // Ejecutar mysqldump
            $this->ejecutarMysqlDump($dbConfig, $tempFile);

            // Enviar archivo
            $this->enviarArchivo($tempFile);

        } catch (Exception $e) {
            $this->manejarErrorDescarga($e);
        } finally {
            if ($tempFile) {
                $this->limpiarArchivoTemporal($tempFile);
            }
        }
    }

    private function verificarMysqlDump() {
        $this->logger->info('Verificando mysqldump');
        exec('which mysqldump 2>&1', $output, $returnVar);
        if ($returnVar !== 0) {
            throw new Exception('mysqldump no está instalado en el sistema');
        }
        $this->logger->info('mysqldump encontrado en: ' . $output[0]);
    }

    private function probarConexionDB($dbConfig) {
        $this->logger->info('Probando conexión a la base de datos');
        $testCommand = sprintf(
            'mysql -h%s -u%s -p%s -e "SELECT 1" 2>&1',
            escapeshellarg($dbConfig['host']),
            escapeshellarg($dbConfig['user']),
            escapeshellarg($dbConfig['pass'])
        );
        
        exec($testCommand, $output, $returnVar);
        if ($returnVar !== 0) {
            throw new Exception('Error de conexión: ' . implode("\n", $output));
        }
    }

    private function enviarArchivo($tempFile) {
        $filesize = filesize($tempFile);
        if ($filesize === 0) {
            throw new Exception('El archivo de backup está vacío');
        }

        $filename = "torrejon_" . date('Y-m-d_His') . ".sql";
        
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename="' . $filename . '"');
        header('Content-Length: ' . $filesize);
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        
        readfile($tempFile);
        exit;
    }

    private function manejarErrorDescarga($e) {
        $this->logger->error('=== ERROR EN DESCARGA ===');
        $this->logger->error($e->getMessage());
        
        header_remove();
        header('HTTP/1.1 500 Internal Server Error');
        header('Content-Type: application/json');
        
        echo json_encode([
            'estado' => 'error',
            'mensaje' => $e->getMessage(),
            'detalles' => $this->f3->get('DEBUG') ? [
                'file' => basename($e->getFile()),
                'line' => $e->getLine()
            ] : null
        ]);
    }

    private function crearArchivoTemporal() {
        $tempFile = tempnam(sys_get_temp_dir(), 'sql_');
        if (!$tempFile) {
            throw new Exception('No se pudo crear el archivo temporal');
        }
        chmod($tempFile, 0666);
        return $tempFile;
    }

    private function limpiarArchivoTemporal($tempFile) {
        if (file_exists($tempFile)) {
            unlink($tempFile);
        }
    }

    private function validarConfiguracionDB() {
        $dbConfig = [
            'host' => $this->f3->get('db.host'),
            'name' => $this->f3->get('db.name'),
            'user' => $this->f3->get('db.user'),
            'pass' => $this->f3->get('db.pass')
        ];

        foreach ($dbConfig as $key => $value) {
            if ($key !== 'pass' && empty($value)) {
                throw new Exception("Falta configuración de base de datos: {$key}");
            }
        }

        return $dbConfig;
    }

    private function ejecutarMysqlDump($dbConfig, $tempFile) {
        $this->logger->info('Ejecutando mysqldump');
        $command = sprintf(
            'mysqldump %s -h%s -u%s -p%s %s > %s 2>&1',
            implode(' ', $this->getMysqlDumpOptions()),
            escapeshellarg($dbConfig['host']),
            escapeshellarg($dbConfig['user']),
            escapeshellarg($dbConfig['pass']),
            escapeshellarg($dbConfig['name']),
            escapeshellarg($tempFile)
        );
        
        $this->logger->debug('Comando (sin password): ' . 
            preg_replace('/-p[^ ]+/', '-p****', $command));

        exec($command, $output, $returnVar);
        
        if ($returnVar !== 0) {
            throw new Exception('Error en mysqldump: ' . implode("\n", $output));
        }
    }

    private function getMysqlDumpOptions() {
        return [
            '--no-tablespaces',
            '--skip-lock-tables',
            '--single-transaction',
            '--quick',
            '--add-drop-table',
            '--create-options',
            '--extended-insert',
            '--set-charset'
        ];
    }

   

    

    

   
    
} 