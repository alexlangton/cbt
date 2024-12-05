<?php class utilLeaflet
{
   static function limpiarValoresVacios($valores)
   {
      // Filtra los valores vacíos (empty) del array
      return array_filter($valores, function ($value) {
         return !empty($value); // Elimina valores que sean empty (null, 0, '', etc.)
      });
   }

   static function calcularCentroide($latitudes, $longitudes)
   {
      // Usa la función auxiliar para limpiar los valores vacíos
      $latitudes = self::limpiarValoresVacios($latitudes);
      $longitudes = self::limpiarValoresVacios($longitudes);

      // Verifica que los arrays no queden vacíos después del filtrado
      if (empty($latitudes) || empty($longitudes)) {
         return null; // O devuelve un valor adecuado si no hay datos válidos
      }

      // Calcular el centroide (promedio de las latitudes y longitudes)
      return [
         array_sum($latitudes) / count($latitudes),
         array_sum($longitudes) / count($longitudes)
      ];
   }

   static function calcularLimites($latitudes, $longitudes)
   {
      // Usa la función auxiliar para limpiar los valores vacíos
      $latitudes = self::limpiarValoresVacios($latitudes);
      $longitudes = self::limpiarValoresVacios($longitudes);

      // Verifica que los arrays no queden vacíos después del filtrado
      if (empty($latitudes) || empty($longitudes)) {
         return null; // O devuelve un valor adecuado si no hay datos válidos
      }

      // Calcula los límites (esquinas del rectángulo que encierra los puntos)
      return [
         [min($latitudes), min($longitudes)],  // Esquina suroeste
         [max($latitudes), max($longitudes)]   // Esquina noreste
      ];
   }

   static function obtenerMarcadores($f3, $tipo, &$latitudes, &$longitudes)
   {
      // Inicialización
      $nuevo = [];
      $latitudes = [];
      $longitudes = [];

      $consultasMarcadores = new ConsultasMarcadores();
      $registros = $consultasMarcadores->obtenerRegistrosMarcadores($f3, $tipo);

      // Verifica que haya resultados antes de procesarlos
      if ($registros && is_array($registros)) {
         $util = new utilVariables($f3);

         foreach ($registros as $registro) {
            $lat = floatval($registro['latitud']);
            $lng = floatval($registro['longitud']);

            // Validación de latitud y longitud
            if (is_numeric($lat) && is_numeric($lng) && !is_nan($lat) && !is_nan($lng)) {
               $latitudes[] = $lat;
               $longitudes[] = $lng;

               // Manejo de atributos
               $atributos = $registro['atributos'];
               $atributosModificados = [];
               
               if ($atributos) {
                  try {
                     // Si es un array, convertirlo a JSON primero
                     if (is_array($atributos)) {
                        $atributos = json_encode($atributos);
                     }
                     
                     // Ahora que tenemos una cadena JSON, podemos procesarla
                     if (is_string($atributos)) {
                        $jsonModificado = $util->reemplazarValoresEnJson($atributos);
                        if ($jsonModificado !== false) {
                           $atributosModificados = json_decode($jsonModificado, true) ?? [];
                        }
                     }
                  } catch (\Exception $e) {
                     error_log("Error procesando atributos: " . $e->getMessage());
                     $atributosModificados = [];
                  }
               }

               // Construcción del marcador
               $marcador = [
                  'id' => $registro['id'],
                  'type' => $registro['tipo'],
                  'name' => $registro['nombre'],
                  'lat' => $lat,
                  'lng' => $lng,
                  'atributos' => $atributosModificados
               ];

               // Añadir campos específicos según el tipo
               if ($registro['tipo'] === 'parking') {
                  $marcador['codinsclo'] = $registro['codinsclo'];
               } elseif ($registro['tipo'] === 'cartel') {
                  $marcador['rotativo'] = $registro['rotativo'];
               }

               $nuevo[] = $marcador;
            }
         }
      }
      return $nuevo;
   }

   static function obtenerCarteles($f3, &$latitudes, &$longitudes)
   {
      return self::obtenerMarcadores($f3, 'cartel', $latitudes, $longitudes);
   }

   static function obtenerParkings($f3, &$latitudes, &$longitudes)
   {
      return self::obtenerMarcadores($f3, 'parking', $latitudes, $longitudes);
   }
}
