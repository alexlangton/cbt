<?php

use Firebase\JWT\JWT;
use Firebase\JWT\Key;

class TokenManager {
    private $secretKey;
    private $consultasAuth;
    private $logger;

    public function __construct() {
        // Obtener la clave secreta del entorno
        $this->secretKey = getenv('CLAVE_SECRETA_HASH') ?: '10011110';
        $this->consultasAuth = new ConsultasAuth();
        $this->logger = new Logger(Base::instance());
        
        $this->logger->debug('TokenManager inicializado', [
            'clave_configurada' => !empty($this->secretKey)
        ]);
    }

    public function generarToken($datos) {
        try {
            $this->logger->debug('Generando token', [
                'datos' => array_keys($datos)
            ]);

            // Asegurar que los datos son serializables
            $datosToken = [
                'iat' => $datos['iat'] ?? time(),
                'exp' => $datos['exp'] ?? (time() + 86400),
                'usuario' => [
                    'id' => $datos['usuario']['id'] ?? null,
                    'email' => $datos['usuario']['email'] ?? null
                ]
            ];

            // Validar datos requeridos
            if (empty($datosToken['usuario']['id']) || empty($datosToken['usuario']['email'])) {
                throw new \Exception('Datos de usuario incompletos para el token');
            }

            // Generar firma
            $header = base64_encode(json_encode(['alg' => 'HS256', 'typ' => 'JWT']));
            $payload = base64_encode(json_encode($datosToken));
            $firma = hash_hmac('sha256', $header . '.' . $payload, $this->secretKey);

            // Construir token JWT
            $token = $header . '.' . $payload . '.' . $firma;

            $this->logger->info('Token generado exitosamente', [
                'usuario_id' => $datosToken['usuario']['id']
            ]);

            return $token;

        } catch (\Exception $e) {
            $this->logger->error('Error generando token', [
                'error' => $e->getMessage()
            ]);
            throw $e;
        }
    }

    public function verificarToken($token) {
        try {
            $this->logger->debug('Verificando token');

            if (empty($token)) {
                return ['valido' => false, 'mensaje' => 'Token vacío'];
            }

            // Separar componentes del token
            $partes = explode('.', $token);
            if (count($partes) !== 3) {
                return ['valido' => false, 'mensaje' => 'Formato de token inválido'];
            }

            list($header, $payload, $firmaRecibida) = $partes;

            // Verificar firma
            $firmaCalculada = hash_hmac('sha256', $header . '.' . $payload, $this->secretKey);
            if (!hash_equals($firmaRecibida, $firmaCalculada)) {
                return ['valido' => false, 'mensaje' => 'Firma inválida'];
            }

            // Decodificar payload
            $datosToken = json_decode(base64_decode($payload), true);
            if (!$datosToken) {
                return ['valido' => false, 'mensaje' => 'Payload inválido'];
            }

            // Verificar expiración
            if (isset($datosToken['exp']) && $datosToken['exp'] < time()) {
                return ['valido' => false, 'mensaje' => 'Token expirado'];
            }

            // Verificar usuario
            if (!isset($datosToken['usuario'])) {
                return ['valido' => false, 'mensaje' => 'Datos de usuario no encontrados'];
            }

            $this->logger->info('Token verificado exitosamente', [
                'usuario_id' => $datosToken['usuario']['id'] ?? 'no disponible'
            ]);

            return [
                'valido' => true,
                'usuario' => $datosToken['usuario']
            ];

        } catch (\Exception $e) {
            $this->logger->error('Error verificando token', [
                'error' => $e->getMessage()
            ]);
            return ['valido' => false, 'mensaje' => 'Error al verificar token'];
        }
    }

    public function obtenerToken() {
        $f3 = Base::instance();
        $authHeader = $f3->get('HEADERS.Authorization');
        
        if ($authHeader && preg_match('/Bearer\s+(.*)$/i', $authHeader, $matches)) {
            return $matches[1];
        }
        
        return null;
    }

    public function invalidarToken($token) {
        try {
            return $this->consultasAuth->invalidarToken($token);
        } catch (\Exception $e) {
            $this->logger->error('Error invalidando token', [
                'error' => $e->getMessage()
            ]);
            return false;
        }
    }
} 