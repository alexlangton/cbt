<?php

class LeafletController extends AutenticacionController
{

    public function __construct()
    {
        parent::__construct();

        if (!$this->f3) {
            $this->f3 = Base::instance();
            $this->logger = new Logger($this->f3);
        }
    }


    public function obtenerDatosLeaflet($f3)
    {
        return $this->ejecutarOperacion(function () use ($f3) {
            $this->logger->debug('Iniciando obtención de datos Leaflet');

            // Obtener carteles
            try {
                $latitudesCarteles = [];
                $longitudesCarteles = [];
                $carteles = utilLeaflet::obtenerCarteles($f3, $latitudesCarteles, $longitudesCarteles);
                $this->logger->info('Carteles obtenidos', [
                    'cantidad' => count($carteles),
                    'latitudes' => count($latitudesCarteles),
                    'longitudes' => count($longitudesCarteles)
                ]);
            } catch (\Exception $e) {
                $this->logger->error('Error al obtener carteles', [
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                throw $e;
            }

            // Obtener parkings
            try {
                $latitudesParkings = [];
                $longitudesParkings = [];
                $parkings = utilLeaflet::obtenerParkings($f3, $latitudesParkings, $longitudesParkings);
                $this->logger->info('Parkings obtenidos', [
                    'cantidad' => count($parkings),
                    'latitudes' => count($latitudesParkings),
                    'longitudes' => count($longitudesParkings)
                ]);
            } catch (\Exception $e) {
                $this->logger->error('Error al obtener parkings', [
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                throw $e;
            }

            // Combinar coordenadas
            $latitudes = array_merge($latitudesCarteles, $latitudesParkings);
            $longitudes = array_merge($longitudesCarteles, $longitudesParkings);

            if (empty($latitudes) || empty($longitudes)) {
                $this->logger->error('Datos de coordenadas vacíos', [
                    'latitudes' => count($latitudes),
                    'longitudes' => count($longitudes)
                ]);

                return $this->respuestaError(
                    'No se encontraron coordenadas válidas',
                    [
                        'carteles_count' => count($carteles),
                        'parkings_count' => count($parkings)
                    ],
                    500
                );
            }

            try {
                $centro = utilLeaflet::calcularCentroide($latitudes, $longitudes);
                $limites = utilLeaflet::calcularLimites($latitudes, $longitudes);

                $this->logger->info('Datos del mapa calculados', [
                    'centro' => $centro,
                    'limites' => $limites,
                    'total_marcadores' => count($carteles) + count($parkings)
                ]);

                return $this->respuestaExito([
                    'centro' => $centro,
                    'limites' => $limites,
                    'marcadores' => [
                        'carteles' => $carteles,
                        'parkings' => $parkings
                    ]
                ]);
            } catch (\Exception $e) {
                $this->logger->error('Error al calcular datos del mapa', [
                    'error' => $e->getMessage(),
                    'trace' => $e->getTraceAsString()
                ]);
                throw $e;
            }
        }, 'Error al obtener datos del mapa');
    }
}
