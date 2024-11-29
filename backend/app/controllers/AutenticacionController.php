<?php

use App\Services\EmailService;

class AutenticacionController extends JsonController {
    protected $consultasAuth;
    protected $tokenManager;
    protected $logger;
    protected $emailService;

    public function __construct() {
        parent::__construct();
        $this->consultasAuth = new ConsultasAuth();
        $this->tokenManager = new TokenManager();
        $this->logger = new Logger($this->f3);
        $this->emailService = new \App\Services\EmailService();
        
        // Añadir logging inicial
        $this->logger->debug('Constructor AutenticacionController - Inicio');
        
        // Verificar autenticación inmediatamente después de la inicialización
        $rutaActual = $this->f3->get('PATTERN');
        
        if (!$this->esRutaPublica($rutaActual)) {
            $this->logger->debug('Ruta no pública, verificando autenticación', [
                'ruta' => $rutaActual,
                'headers' => $this->f3->get('HEADERS')
            ]);
            
            $resultado = $this->verificarAutenticacion($this->f3);
            
            if ($resultado === true) {
                $this->logger->debug('Autenticación exitosa en constructor', [
                    'usuario' => $this->f3->get('USUARIO'),
                    'ruta' => $rutaActual
                ]);
            } else {
                $this->logger->debug('Autenticación fallida en constructor', [
                    'resultado' => $resultado,
                    'ruta' => $rutaActual
                ]);
                
                // Si la ruta no es pública y la autenticación falla, lanzar excepción
                if (is_array($resultado) && isset($resultado['codigo'])) {
                    throw new \Exception($resultado['mensaje'], $resultado['codigo']);
                }
            }
        } else {
            $this->logger->debug('Ruta pública, omitiendo verificación de autenticación', [
                'ruta' => $rutaActual
            ]);
        }
    }

    protected function esRutaPublica($ruta) {
        $rutasPublicas = [
            '/api/public/login',
            '/api/public/logout',
            '/api/public/recuperarPassword',
            '/api/public/sesion/info'
        ];
        
        $esPublica = strpos($ruta, '/api/public/') === 0 || in_array($ruta, $rutasPublicas);
        
        $this->logger->debug('Verificando ruta pública', [
            'ruta' => $ruta,
            'es_publica' => $esPublica
        ]);
        
        return $esPublica;
    }

    public function verificarAutenticacion($f3) {
        try {
            $rutaActual = $f3->get('PATTERN');
            $this->logger->debug('Verificando autenticación', [
                'ruta' => $rutaActual,
                'metodo' => $f3->get('VERB')
            ]);

            if ($this->esRutaPublica($rutaActual)) {
                $this->logger->debug('Ruta pública, permitiendo acceso');
                return true;
            }

            $token = $this->tokenManager->obtenerToken();
            if (!$token) {
                $this->logger->debug('Token no encontrado');
                return [
                    'estado' => 'error',
                    'mensaje' => 'Token no proporcionado',
                    'codigo' => 401
                ];
            }

            $resultadoToken = $this->tokenManager->verificarToken($token);
            $this->logger->debug('Resultado verificación token', [
                'valido' => $resultadoToken['valido'] ?? false,
                'tiene_usuario' => isset($resultadoToken['usuario']),
                'datos_usuario' => $resultadoToken['usuario'] ?? 'no disponible'
            ]);

            if ($resultadoToken['valido'] && isset($resultadoToken['usuario'])) {
                // Establecer el usuario en la sesión de F3
                $f3->set('USUARIO', $resultadoToken['usuario']);
                
                // Establecer el ID en el logger
                if (isset($resultadoToken['usuario']['id'])) {
                    $this->logger->setIdUsuario($resultadoToken['usuario']['id']);
                }

                $this->logger->debug('Usuario establecido en F3', [
                    'id' => $resultadoToken['usuario']['id'] ?? 'no disponible',
                    'email' => $resultadoToken['usuario']['email'] ?? 'no disponible'
                ]);

                return true;
            }

            $this->logger->debug('Token inválido o sin datos de usuario');
            return [
                'estado' => 'error',
                'mensaje' => $resultadoToken['mensaje'] ?? 'Token inválido',
                'codigo' => 401
            ];

        } catch (\Exception $e) {
            $this->logger->error('Error en verificación de autenticación', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return [
                'estado' => 'error',
                'mensaje' => 'Error de autenticación',
                'codigo' => 500
            ];
        }
    }

    protected function validarDatosLogin($datos) {
        if (!isset($datos['email']) || !isset($datos['pass'])) {
            $this->logger->info('Intento de login con datos incompletos', [
                'datos_recibidos' => array_keys($datos)
            ]);
            
            return [
                'valido' => false,
                'error' => 'Email y contraseña son requeridos',
                'codigo' => 400
            ];
        }
        return ['valido' => true];
    }

    protected function procesarResultadoToken($token, $email) {
        if ($token['estado'] === 'error') {
            $this->logger->error('Error al generar token', [
                'email' => $email,
                'error' => $token['mensaje']
            ]);
            
            return $this->respuestaError(
                'Error al generar el token',
                500,
                $token['mensaje'] ?? null
            );
        }
        return null;
    }

    public function login($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            try {
                $this->logger->debug('Iniciando proceso de login');
                
                // 1. Obtener y validar datos de entrada
                $rawBody = $f3->get('BODY');
                $this->logger->debug('Body recibido', ['body' => $rawBody]);
                
                if (empty($rawBody)) {
                    return $this->respuestaError('No se recibieron datos', 400);
                }
                
                // 2. Decodificar JSON
                $resultado = $this->decodificarJSON($rawBody, ' en login');
                if ($resultado['error']) {
                    $this->logger->error('Error decodificando JSON', [
                        'error' => $resultado['response']
                    ]);
                    return $resultado['response'];
                }
                
                // 3. Validar campos requeridos
                $datos = $resultado['datos'];
                $this->logger->debug('Datos decodificados', [
                    'campos' => array_keys($datos)
                ]);
                
                if (empty($datos['email']) || empty($datos['pass'])) {
                    return $this->respuestaError('Email y contraseña son requeridos', 400);
                }
                
                // 4. Autenticar usuario
                $this->logger->debug('Intentando autenticar usuario', [
                    'email' => $datos['email']
                ]);
                
                $usuario = $this->consultasAuth->verificarCredenciales(
                    $datos['email'], 
                    $datos['pass']
                );
                
                if (!$usuario) {
                    $this->logger->info('Credenciales inválidas', [
                        'email' => $datos['email']
                    ]);
                    return $this->respuestaError('Credenciales inválidas', 401);
                }
                
                // 5. Generar token
                $this->logger->debug('Generando token para usuario', [
                    'usuario_id' => $usuario['id']
                ]);
                
                try {
                    $token = $this->generarToken($usuario);
                } catch (\Exception $e) {
                    $this->logger->error('Error generando token', [
                        'error' => $e->getMessage()
                    ]);
                    throw $e;
                }
                
                // 6. Preparar respuesta
                $this->logger->debug('Preparando datos de respuesta');
                $datosRespuesta = $this->prepararDatosRespuesta($usuario, $token);
                
                return $this->respuestaExito(
                    $datosRespuesta,
                    'Inicio de sesión exitoso'
                );
                
            } catch (\Exception $e) {
                $this->logger->error('Error en login: ' . $e->getMessage());
                return $this->respuestaError('Error en el proceso de login', 500);
            }
        }, 'Error en el proceso de login');
    }

    public function logout($f3) {
        return $this->ejecutarOperacion(function() {
            $token = $this->tokenManager->obtenerToken();
            if (!$token) {
                $this->logger->info('Intento de logout sin token');
                return $this->respuestaError('Token no proporcionado', 401);
            }

            $resultadoToken = $this->tokenManager->verificarToken($token);
            if ($resultadoToken['valido']) {
                // Registrar el logout con el ID del usuario antes de invalidar el token
                $this->logger->info('Logout de usuario', [
                    'usuario_id' => $resultadoToken['usuario']['id'],
                    'email' => $resultadoToken['usuario']['email']
                ]);
            }

            // Limpiar el ID de usuario en el logger después del logout
            $this->logger->setIdUsuario(null);

            if (!$this->tokenManager->invalidarToken($token)) {
                $this->logger->error('Error al invalidar token');
                return $this->respuestaError('Error al cerrar sesión', 500);
            }

            return $this->respuestaExito(null, 'Sesión cerrada correctamente');
        }, 'Error en el proceso de logout');
    }

    public function obtenerInfo($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            $this->logger->debug('Obteniendo información del usuario');
            
            try {
                // Información básica por defecto
                $info = [
                    'estado' => [
                        'autenticado' => false
                    ]
                ];

                // Obtener token del header Authorization
                $authHeader = $f3->get('HEADERS.Authorization');
                $token = null;
                
                if ($authHeader && preg_match('/Bearer\s+(.*)$/i', $authHeader, $matches)) {
                    $token = $matches[1];
                    $this->logger->debug('Token recibido en header', ['token' => substr($token, 0, 10) . '...']);
                    
                    if ($token) {
                        $resultadoToken = $this->tokenManager->verificarToken($token);
                        if ($resultadoToken && isset($resultadoToken['valido']) && $resultadoToken['valido']) {
                            // Obtener información del usuario
                            $usuario = $this->consultasAuth->obtenerUsuarioPorEmail($resultadoToken['usuario']['email']);
                            
                            if ($usuario) {
                                $info = [
                                    'estado' => [
                                        'autenticado' => true
                                    ],
                                    'usuario' => [
                                        'id' => $usuario['id'],
                                        'nombre' => $usuario['nombre'],
                                        'email' => $usuario['email'],
                                        'ultimo_inicio_sesion' => $usuario['ultimo_inicio_sesion']
                                    ]
                                ];

                                $this->logger->debug('Usuario autenticado', [
                                    'usuario' => $usuario['email'],
                                    'ip' => $f3->get('IP')
                                ]);
                            }
                        } else {
                            $this->logger->error('Token inválido', [
                                'ip' => $f3->get('IP')
                            ]);
                        }
                    }
                } else {
                    $this->logger->debug('No se encontró token en el header Authorization');
                }

                // Información del contexto
                $info['contexto'] = [
                    'ip' => $f3->get('IP'),
                    'navegador' => $f3->get('AGENT'),
                    'fecha_hora' => date('Y-m-d H:i:s')
                ];

                return $this->respuestaExito(
                    $info,
                    $info['estado']['autenticado'] 
                        ? 'Usuario autenticado'
                        : 'Usuario no autenticado'
                );

            } catch (Exception $e) {
                $this->logger->error('Error al obtener información', [
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                
                return $this->respuestaError(
                    'Error al obtener la información',
                    500,
                    $this->f3->get('DEBUG') ? $e->getMessage() : null
                );
            }
        }, 'Error al obtener información');
    }

    /**
     * Convierte el código de estado de sesión a texto descriptivo
     * @param int $estado
     * @return string
     */
    private function obtenerEstadoSesion($estado) {
        switch ($estado) {
            case PHP_SESSION_DISABLED:
                return 'Sesiones deshabilitadas';
            case PHP_SESSION_NONE:
                return 'Sesión no iniciada';
            case PHP_SESSION_ACTIVE:
                return 'Sesión activa';
            default:
                return 'Estado desconocido';
        }
    }

    public function recuperarPassword($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            $this->logger->debug('Iniciando proceso de recuperación de contraseña', [
                'body' => $f3->get('BODY')  // Agregar log para ver qué llega
            ]);
            
            try {
                $body = $f3->get('BODY');
                if (empty($body)) {
                    return $this->respuestaError('No hay body', 400);
                }

                $datos = json_decode($body, true);
                if (json_last_error() !== JSON_ERROR_NONE) {
                    return $this->respuestaError('JSON inválido: ' . json_last_error_msg(), 400);
                }

                $this->logger->debug('Datos decodificados', [
                    'datos' => $datos  // Agregar log para ver el resultado
                ]);

                if (!isset($datos['datos']) || !isset($datos['datos']['email'])) {
                    return $this->respuestaError('El email es requerido', 400);
                }

                $email = $datos['datos']['email'];

                // Verificar si el usuario existe
                $usuario = $this->consultasAuth->obtenerUsuarioPorEmail($email);
                if (!$usuario) {
                    $this->logger->info('Intento de recuperación con email no registrado', [
                        'email' => $email
                    ]);
                    return $this->respuestaError('Usuario no encontrado', 404);
                }

                // Generar token único
                $token = bin2hex(random_bytes(32));

                // Guardar token
                if (!$this->consultasAuth->guardarToken($usuario['id'], $token)) {
                    return $this->respuestaError('Error al procesar la solicitud', 500);
                }

                // Enviar correo
                try {
                    $this->emailService->enviarCorreoRecuperacion($email, $token);

                    $this->logger->info('Correo de recuperación enviado', [
                        'email' => $email
                    ]);

                    return $this->respuestaExito(
                        null,
                        'Se ha enviado un correo con las instrucciones para recuperar tu contraseña',
                        200,
                        ['charset' => 'utf-8']
                    );

                } catch (\Exception $e) {
                    $this->logger->error('Error al enviar correo de recuperación', [
                        'error' => $e->getMessage(),
                        'email' => $email
                    ]);
                    return $this->respuestaError('Error al enviar el correo de recuperación', 500);
                }

            } catch (\Exception $e) {
                $this->logger->error('Error en el proceso de recuperación', [
                    'error' => $e->getMessage()
                ]);
                return $this->respuestaError('Error en el proceso de recuperación', 500);
            }
        }, 'Error en el proceso de recuperación de contraseña');
    }

    public function cambiarPassword($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            $this->logger->debug('Iniciando proceso de cambio de contraseña');
            
            try {
                $resultadoJSON = $this->decodificarJSON($f3->get('BODY'));
                if ($resultadoJSON['error']) {
                    return $resultadoJSON['response'];
                }

                $datos = $resultadoJSON['datos'];
                $token = $datos['token'] ?? null;
                $password = $datos['password'] ?? null;

                if (!$token || !$password) {
                    return $this->respuestaError('Datos incompletos', 400);
                }

                // Verificar token
                $resultadoToken = $this->tokenManager->verificarToken($token);
                if (!$resultadoToken['valido'] || !isset($resultadoToken['usuario'])) {
                    $this->logger->info('Intento de cambio de contraseña con token inválido');
                    return $this->respuestaError('Token no válido', 400);
                }

                $usuario = $resultadoToken['usuario'];

                // Actualizar contraseña
                if (!$this->consultasAuth->actualizarPassword($usuario['id'], $password)) {
                    $this->logger->error('Error al actualizar contraseña', [
                        'usuario_id' => $usuario['id']
                    ]);
                    return $this->respuestaError('Error al actualizar la contraseña', 500);
                }

                $this->logger->info('Contraseña actualizada correctamente', [
                    'usuario_id' => $usuario['id']
                ]);

                return $this->respuestaExito(
                    null,
                    'Contraseña actualizada correctamente'
                );

            } catch (\Exception $e) {
                $this->logger->error('Error en el cambio de contraseña', [
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                
                return $this->respuestaError(
                    'Error al cambiar la contraseña',
                    500,
                    $this->f3->get('DEBUG') ? $e->getMessage() : null
                );
            }
        }, 'Error en el proceso de cambio de contraseña');
    }

    protected function generarToken($usuario) {
        try {
            if (!isset($usuario['id']) || !isset($usuario['email'])) {
                $this->logger->error('Datos de usuario incompletos para generar token', [
                    'usuario' => $usuario
                ]);
                throw new \Exception('Datos de usuario incompletos para generar token');
            }
            
            $datosToken = [
                'iat' => time(),
                'exp' => time() + 86400, // 24 horas
                'usuario' => [
                    'id' => $usuario['id'],
                    'email' => $usuario['email']
                ]
            ];
            
            $this->logger->debug('Generando token con datos', [
                'usuario_id' => $usuario['id'],
                'email' => $usuario['email']
            ]);
            
            $token = $this->tokenManager->generarToken($datosToken);
            
            if (!$token) {
                throw new \Exception('Error generando token');
            }
            
            // Guardar el token en la base de datos
            if (!$this->consultasAuth->guardarToken($usuario['id'], $token)) {
                $this->logger->error('Error al guardar token en BD', [
                    'usuario_id' => $usuario['id']
                ]);
                throw new \Exception('Error guardando token en base de datos');
            }
            
            $this->logger->info('Token generado y guardado correctamente', [
                'usuario_id' => $usuario['id']
            ]);
            
            return $token;
            
        } catch (\Exception $e) {
            $this->logger->error('Error en generarToken', [
                'error' => $e->getMessage(),
                'usuario_id' => $usuario['id'] ?? 'no disponible'
            ]);
            throw $e;
        }
    }

    protected function prepararDatosRespuesta($usuario, $token) {
        try {
            // Preparar datos del usuario (omitiendo información sensible)
            $datosUsuario = [
                'id' => $usuario['id'],
                'nombre' => $usuario['nombre'],
                'email' => $usuario['email'],
                'ultimo_acceso' => $usuario['ultimo_inicio_sesion'] ?? date('Y-m-d H:i:s')
            ];
            
            // Datos de la sesión
            $datosSesion = [
                'creada' => date('Y-m-d H:i:s'),
                'expira' => date('Y-m-d H:i:s', time() + 86400), // 24 horas
                'ip' => $this->f3->get('IP')
            ];
            
            $this->logger->debug('Datos de respuesta preparados', [
                'usuario_id' => $usuario['id']
            ]);
            
            return [
                'token' => $token,
                'usuario' => $datosUsuario,
                'sesion' => $datosSesion
            ];
            
        } catch (\Exception $e) {
            $this->logger->error('Error preparando datos de respuesta', [
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }
} 