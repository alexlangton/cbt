<?php

class IntegracionController extends JsonController
{
    protected $logger;
    protected $f3;

    const ERROR_JSON_ENCODING = 'Error al codificar JSON: ';
    const ERROR_CARTEL_NO_ENCONTRADO = 'Cartel no encontrado';
    const ERROR_INTERNO_SERVIDOR = 'Error interno del servidor';

    private function initLogger()
    {
        if (!$this->f3) {
            $this->f3 = Base::instance();
            $this->logger = new Logger($this->f3);
        }
    }

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
            
            $response = json_encode($data, $jsonOptions);
            
            if ($response === false) {
                throw new \Exception(self::ERROR_JSON_ENCODING . json_last_error_msg());
            }
            
            echo $response;
            exit;
        } catch (\Exception $e) {
            // Log del error
            error_log("Error en jsonResponse: " . $e->getMessage());
            
            // Respuesta de error genérica
            echo json_encode([
                'estado' => 'error',
                'mensaje' => self::ERROR_INTERNO_SERVIDOR,
                'codigo' => 500
            ]);
            exit;
        }
    }

    public function obtenerInfoCartel($f3)
    {
        $this->initLogger();
        $id = $f3->get('PARAMS.id');
        $this->logger->info("Obteniendo cartel con ID: " . $id);
        
        try {
            return $this->ejecutarOperacion(function() use ($id) {
                $this->logger->info("Iniciando consulta de cartel");
                
                $carteles = new ConsultasMarcadores();
                $cartel = $carteles->obtenerCartel($id);
                
                $this->logger->info("Resultado de consulta: " . json_encode($cartel));
                
                if (!$cartel) {
                    $this->logger->error("No se encontró el cartel con ID: " . $id);
                    return $this->respuestaError(self::ERROR_CARTEL_NO_ENCONTRADO, 404);
                }

                $json = $carteles->obtenerAtributosJsonTipoCartel($cartel['id_tipocartel']);
                
                $jsonArray = $json ? json_decode($json, true) : [];
                $jsonArray['text'] = $cartel['rotativo'] ?? '';

                $utilVariables = new UtilVariables();
                $jsonModificado = $utilVariables->reemplazarValoresEnJson(json_encode($jsonArray));
                $jsonArray = json_decode($jsonModificado, true) ?: [];
                
                $this->logger->info("Respuesta final: " . json_encode($jsonArray));
                
                return $this->jsonResponse($jsonArray, 200);
            }, 'Error al obtener información del cartel');
        } catch (\Exception $e) {
            $this->logger->error("Excepción capturada: " . $e->getMessage());
            return $this->respuestaError(self::ERROR_INTERNO_SERVIDOR, 500);
        }
    }       
}       
