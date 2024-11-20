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

   static function obtenerMarcadores($f3, &$latitudes, &$longitudes)
   {
      // Inicialización
      $nuevo = [];
      $latitudes = [];
      $longitudes = [];

      // Obtención de registros
      $registros = bdMarcadores::obtener($f3);

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

               // Valida y reemplaza los valores en JSON de atributos
               $atributos = $registro['atributos'];
               if ($atributos) {  // Asegura que atributos sea JSON válido
                  $jsonModificado = $util->reemplazarValoresEnJson($atributos); // reemplazo de valores
                  $atributosModificados = json_decode($jsonModificado, true); // Decodifica el JSON resultante
               } else {
                  error_log("Atributos no válidos o JSON mal formado para registro ID: {$registro['codinsclo']}");
                  $atributosModificados = []; // Usa un array vacío si hay un error en atributos
               }

               // Construcción del array de resultados
               $nuevo[] = [
                  'id' => $registro['id'],
                  'codinsclo' => $registro['codinsclo'],
                  'type' => $registro['tipo'],
                  'name' => $registro['nombre'],
                  'lat' => $lat,
                  'lng' => $lng,
                  'rotativo' => $registro['rotativo'],
                  'atributos' => $atributosModificados
               ];
            } else {
               // Manejo de valores no válidos
               error_log("Valor no numérico encontrado: latitud = {$registro['latitud']}, longitud = {$registro['longitud']}");
            }
         }
      } else {
         error_log("No se encontraron registros o los datos no están en el formato adecuado.");
      }

      // Retorna el array completo con los valores modificados
      return $nuevo;
   }
}
