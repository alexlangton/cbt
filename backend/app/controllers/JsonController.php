<?php

class JsonController extends Controller {
    // El beforeRoute será implementado por AutenticacionController
    public function beforeRoute($f3) {
        // Método vacío que será sobreescrito
    }

    // Métodos de respuesta JSON
    protected function jsonResponse($data, $code = 200) {
        // Asegurar que los headers no se han enviado ya
        if (!headers_sent()) {
            header('Content-Type: application/json; charset=utf-8');
            http_response_code($code);
            
            // Headers de seguridad
            header('X-Content-Type-Options: nosniff');
            header('X-Frame-Options: DENY');
            header('X-XSS-Protection: 1; mode=block');
        }
        
        try {
            $jsonOptions = JSON_UNESCAPED_UNICODE | 
                          JSON_UNESCAPED_SLASHES | 
                          JSON_INVALID_UTF8_SUBSTITUTE;
            
            if ($this->f3->get('DEBUG')) {
                $jsonOptions |= JSON_PRETTY_PRINT;
            }
            
            $response = json_encode($this->formatearRespuesta($data), $jsonOptions);
            
            if ($response === false) {
                throw new \Exception('Error al codificar JSON: ' . json_last_error_msg());
            }
            
            echo $response;
            exit;
        } catch (\Exception $e) {
            // Log del error
            error_log("Error en jsonResponse: " . $e->getMessage());
            
            // Respuesta de error genérica
            echo json_encode([
                'estado' => 'error',
                'mensaje' => 'Error interno del servidor',
                'codigo' => 500
            ]);
            exit;
        }
    }

    private function formatearRespuesta($data) {
        try {
            if (is_array($data) && isset($data['estado'])) {
                return $this->sanitizarRespuesta($data);
            }
            
            return [
                'estado' => 'exito',
                'datos' => $this->sanitizarRespuesta($data),
                'timestamp' => date('Y-m-d H:i:s')
            ];
        } catch (\Exception $e) {
            error_log("Error en formatearRespuesta: " . $e->getMessage());
            return [
                'estado' => 'error',
                'mensaje' => 'Error al procesar la respuesta',
                'codigo' => 500
            ];
        }
    }

    protected function sanitizarRespuesta($data) {
        if (is_null($data)) {
            return null;
        }
        
        if (is_string($data)) {
            return $this->sanitizarString($data);
        }
        
        if (is_array($data)) {
            $resultado = [];
            foreach ($data as $key => $value) {
                $resultado[$key] = $this->sanitizarRespuesta($value);
            }
            return $resultado;
        }
        
        return $data;
    }

    private function sanitizarString($texto) {
        if (empty($texto)) {
            return $texto;
        }
        
        try {
            $encoding = mb_detect_encoding($texto, ['UTF-8', 'ISO-8859-1', 'ASCII'], true);
            return mb_convert_encoding($texto, 'UTF-8', $encoding ?: 'UTF-8');
        } catch (\Exception $e) {
            error_log("Error en sanitizarString: " . $e->getMessage());
            return $texto;
        }
    }

    protected function respuestaExito($datos = null, $mensaje = null, $codigo = 200, $metadata = null) {
        $respuesta = ['estado' => 'exito'];
        
        if ($mensaje) {
            $respuesta['mensaje'] = $this->sanitizarRespuesta($mensaje);
        }
        if ($datos !== null) {
            $respuesta['datos'] = is_array($datos) ? 
                array_map([$this, 'sanitizarRespuesta'], $datos) : 
                $this->sanitizarRespuesta($datos);
        }
        if ($metadata) {
            $respuesta['metadata'] = $metadata;
        }
        
        return $this->jsonResponse($respuesta, $codigo);
    }

    protected function respuestaError($mensaje, $codigo = 400, $detalles = null) {
        $respuesta = [
            'estado' => 'error',
            'mensaje' => $mensaje
        ];
        
        if ($detalles !== null) {
            $respuesta['detalles'] = $detalles;
        }
        
        return $this->jsonResponse($respuesta, $codigo);
    }

    // Manejo de errores y validaciones
    protected function manejarError(\Exception $e, $mensaje = null) {
        $this->logger->error($e->getMessage());
        return $this->respuestaError(
            $mensaje ?? 'Error interno del servidor',
            500,
            $this->f3->get('DEBUG') ? ['error' => $e->getMessage()] : null
        );
    }

    protected function ejecutarOperacion(callable $operacion, $mensajeError) {
        try {
            return $operacion();
        } catch (\Exception $e) {
            return $this->manejarError($e, $mensajeError);
        }
    }

    // Utilidades de validación
    protected function validarId($id, $tabla) {
        // Validar que el ID no sea nulo o vacío
        if (empty($id)) {
            return $this->respuestaError(
                'ID no proporcionado',
                400,
                ['tabla' => $tabla]
            );
        }

        // Validar que el ID sea numérico y positivo
        if (!is_numeric($id) || $id <= 0 || !ctype_digit((string)$id)) {
            return $this->respuestaError(
                'ID inválido',
                400,
                [
                    'tabla' => $tabla,
                    'id' => $id,
                    'tipo_esperado' => 'entero positivo'
                ]
            );
        }

        return true;
    }

    protected function errorRegistroNoEncontrado($id, $tabla) {
        return $this->respuestaError(
            "Registro no encontrado",
            404,
            [
                'tabla' => $tabla,
                'id' => $id
            ]
        );
    }

    // Procesamiento de JSON
    protected function decodificarJSON($rawBody, $contexto = '') {
        if (empty($rawBody)) {
            return [
                'error' => true,
                'response' => [
                    'estado' => 'error',
                    'mensaje' => 'No se proporcionaron datos',
                    'timestamp' => date('Y-m-d H:i:s')
                ]
            ];
        }

        $datos = json_decode($rawBody, true);
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            $error = json_last_error_msg();
            $this->logger->error("Error decodificando JSON{$contexto}: $error");
            return [
                'error' => true,
                'response' => [
                    'estado' => 'error',
                    'mensaje' => 'Formato JSON inválido',
                    'detalles' => $this->f3->get('DEBUG') ? ['error' => $error] : null,
                    'timestamp' => date('Y-m-d H:i:s')
                ]
            ];
        }
        
        return ['error' => false, 'datos' => $datos];
    }
} 