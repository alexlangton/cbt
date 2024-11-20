<?php
class LeafletController extends JSONController
{
   public function obtenerDatosLeaflet($f3)
   {
      

      // Intentamos obtener los marcadores y validamos si están completos
      $marcadores = utilLeaflet::obtenerMarcadores($f3, $latitudes, $longitudes);

      

      //Comprobamos que todos los datos necesarios fueron obtenidos correctamente
      if (!empty($latitudes) && !empty($longitudes) && !empty($marcadores)) {
         return $this->respuestaExito( [
            'centro' => utilLeaflet::calcularCentroide($latitudes, $longitudes),
            'limites' => utilLeaflet::calcularLimites($latitudes, $longitudes),
            'marcadores' => $marcadores
         ]);
      } else {
         // Si falla la obtención de datos, se devuelve un mensaje de error más detallado
         return $this->respuestaError([
            'mensaje' => 'Intente nuevamente más tarde.'
         ], 500);
      }
   }
}
