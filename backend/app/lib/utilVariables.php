<?php

class utilVariables
{
   private $array_variables;
   private $array_variables_calculadas;

   function __construct($f3)
   {
      list($this->array_variables, $this->array_variables_calculadas) = $this->obtenerDatosCombinados($f3);
   }

   // Método para obtener datos combinados de variables y variables calculadas
   private function obtenerDatosCombinados($f3)
   {
      // Ejecutar una consulta que devuelva tanto las variables como las variables calculadas
      $datosVariables = bdVariables::obtener($f3);
      $datosVariablesCalculadas = bdVariablesCalculadas::obtener($f3);

      // Procesar los resultados en arrays
      $array_variables = array_column($datosVariables, 'valor', 'clave');
      $array_variables_calculadas = array_column($datosVariablesCalculadas, 'script', 'clave');

      return [$array_variables, $array_variables_calculadas];
   }

   function obtenerValorVariable($clave)
   {
      // Verificar si $clave es null
      if (is_null($clave)) {
         return null;
      }

      // Buscar en el array de variables
      if (array_key_exists($clave, $this->array_variables)) {
         return $this->array_variables[$clave];
      }

      // Buscar en el array de variables calculadas
      if (array_key_exists($clave, $this->array_variables_calculadas)) {
         $script = $this->array_variables_calculadas[$clave];

         // Reemplazar variables usando la función de callback
         $script = preg_replace_callback('#\{{([^\{\}]*)\}}#', function ($coincidencia) {
            $claveInterna = $coincidencia[1];  // Acceder a la clave dentro de las llaves
            return $this->obtenerValorVariable($claveInterna);
         }, $script);

         // Evaluar el script de forma segura
         ob_start();
         eval($script);  // Advertencia: Usar `eval` solo cuando se confíe en el contenido del script
         $resultado = ob_get_clean();
         return $resultado;
      }

      // Si no se encuentra en ninguno de los arrays
      return null;
   }

   function reemplazarValoresEnJson($json)
   {
      // Decodificar JSON en un array
      $datos = json_decode($json, true);

      // Validar que se decodificó correctamente y es un array
      if (!is_array($datos)) {
         throw new Exception("El JSON proporcionado no es válido o no es un array.");
      }

      // Iterar y reemplazar valores en cada elemento del JSON
      foreach ($datos as $clave => $valor) {
         // Verifica que $valor sea un array y contenga las claves 'clave' y 'valor'
         if (is_array($valor) && isset($valor['clave']) && isset($valor['valor'])) {
            $nuevaClave = $this->obtenerValorVariable($valor['clave']);  // Usar $this-> para acceder a obtenerValorVariable
            $nuevoValor = $this->obtenerValorVariable($valor['valor']);

            // Reemplazar sólo si $nuevoValor no es null
            if (!is_null($nuevoValor)) {
               $datos[$clave]['clave'] = $nuevaClave;
               $datos[$clave]['valor'] = $nuevoValor;
            }
         }
      }

      // Codificar el array de vuelta a JSON
      return json_encode($datos, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
   }


}
