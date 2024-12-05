<?php

class ContadoresController extends JSONController
{
    protected $db;
    protected $tabla;
    protected $logger;
    protected $json_respuesta;

    public function __construct()
    {
        parent::__construct();
        $this->tabla = 'parkings';
    }

    /**
     * Obtiene un array con todos los códigos de instalación (codinsclo).
     */
    public function obtenerArrayCodinsclos()
    {
        $result = $this->db->exec('SELECT codinsclo FROM ' . $this->tabla);
        return array_column($result, 'codinsclo');
    }

    /**
     * Actualiza la columna json_counters para un parking específico.
     */
    public function actualizarJsonCounters($json, $codinsclo)
    {
        if (empty($json) || empty($codinsclo)) {
            throw new InvalidArgumentException("JSON de contadores y código de instalación son requeridos.");
        }

        $this->db->exec(
            'UPDATE ' . $this->tabla . ' SET json_counters = ? WHERE codinsclo = ?',
            [$json, $codinsclo]
        );
    }

    public function actualizarVariables($json, $codinsclo)
    {
        if (empty($json) || empty($codinsclo)) {
            throw new InvalidArgumentException("JSON de contadores y código de instalación son requeridos.");
        }   
        
        // Decodificar el JSON si viene como string
        $datos = is_string($json) ? json_decode($json, true) : $json;
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new InvalidArgumentException("Error al decodificar el JSON: " . json_last_error_msg());
        }

        $consultasVariables = new ConsultasVariables();
        $entidades = ['counters', 'zones', 'signs'];
        
        foreach ($entidades as $entidad) {
            if (isset($datos[$entidad]) && !empty($datos[$entidad])) {
                $registros = $datos[$entidad];
                
                $this->logger->debug('Procesando entidad', [
                    'entidad' => $entidad,
                    'num_registros' => count($registros)
                ]);

                try {
                    $consultasVariables->sincronizarRegistros($codinsclo, $entidad, $registros);
                } catch (Exception $e) {
                    $this->logger->error('Error al sincronizar registros', [
                        'codinsclo' => $codinsclo,
                        'entidad' => $entidad,
                        'error' => $e->getMessage()
                    ]);
                    throw $e;
                }
            } else {
                $this->logger->debug('Sin registros para sincronizar', [
                    'entidad' => $entidad
                ]);
            }
        }
    }

    /**
     * Actualiza los contadores de un parking específico.
     */
    public function actualizarContadoresParking($codinsclo)
    {
        if (empty($codinsclo)) {
            return $this->respuestaError(
                'El código de instalación no puede estar vacío.',
                400
            );
        }

        try {
            $json = SAGACloudServidor::obtenerStatusCounters($this->f3, $codinsclo);
            if (empty($json)) {
                return $this->respuestaError(
                    'Los contadores obtenidos están vacíos.',
                    400
                );
            }
        } catch (Exception $e) {
            $this->logger->error('contadores', "Error al obtener los contadores: {$e->getMessage()}");
            return $this->respuestaError(
                "No se pudieron obtener los contadores",
                500,
                ['codinsclo' => $codinsclo, 'error' => $e->getMessage()]
            );
        }

        try {
            $this->actualizarJsonCounters($json, $codinsclo);
            $this->actualizarVariables($json, $codinsclo);
        } catch (Exception $e) {
            $this->logger->error('contadores', "Error al actualizar los contadores: {$e->getMessage()}");
            return $this->respuestaError(
                "Error al actualizar los contadores",
                500,
                ['codinsclo' => $codinsclo, 'error' => $e->getMessage()]
            );
        }
    }

    /**
     * Actualiza los contadores de todos los parkings.
     */
    public function actualizarTodosLosContadores()
    {
        $codinsclos = $this->obtenerArrayCodinsclos();
        $resultados = [];

        foreach ($codinsclos as $codinsclo) {
            try {
                $this->actualizarContadoresParking($codinsclo);
                $this->logger->info('contadores', "Contadores de {$codinsclo} actualizados exitosamente");
                $resultados[] = ['message' => "Contadores de {$codinsclo} actualizados exitosamente"];
            } catch (Exception $e) {
                $this->logger->error('contadores', "Error al actualizar contadores de {$codinsclo}: {$e->getMessage()}");
                $resultados[] = [
                    'error' => "Error al actualizar contadores de {$codinsclo}",
                    'details' => $e->getMessage()
                ];
            }
        }
        $this->json_respuesta = $resultados;
    }

    /**
     * Obtiene los contadores actuales de un parking específico.
     */
    public function obtenerContadores()
    {
        try {
            $codinsclo = $this->f3['PARAMS.codinsclo'];
            if (empty($codinsclo)) {
                return $this->respuestaError(
                    "Código de instalación no proporcionado",
                    400
                );
            }

            $contadores = json_decode(SAGACloudServidor::obtenerStatusCounters($this->f3, $codinsclo));
            if (empty($contadores)) {
                return $this->respuestaError(
                    "No se encontraron contadores",
                    404,
                    ['codinsclo' => $codinsclo]
                );
            }

            return $this->respuestaExito($contadores);

        } catch (Exception $e) {
            $this->logger->error('contadores', "Error al obtener contadores para codinsclo {$codinsclo}: {$e->getMessage()}");
            return $this->respuestaError(
                "Error al obtener los contadores",
                500,
                ['codinsclo' => $codinsclo, 'error' => $e->getMessage()]
            );
        }
    }
}
