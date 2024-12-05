<?php

class utilVariables
{
   private $array_variables;
   private $array_variables_calculadas;
   private $logger;

   function __construct()
   {
      $this->logger = new Logger(\Base::instance());
      $this->logger->info('Inicializando utilVariables');
      $this->cargarVariables();
   }

   private function cargarVariables()
   {
      try {
         $consultasVariables = new ConsultasVariables();
         $consultasVariablesCalculadas = new ConsultasVariablesCalculadas();

         $this->array_variables = array_column(
            $consultasVariables->obtenerConFecha(),
            'valor',
            'clave'
         );

         $this->array_variables_calculadas = array_column(
            $consultasVariablesCalculadas->obtenerScripts(),
            'script',
            'clave'
         );

         $this->logger->debug('Variables cargadas', [
            'simples' => count($this->array_variables),
            'calculadas' => count($this->array_variables_calculadas)
         ]);
      } catch (\Exception $e) {
         $this->logger->error('Error al cargar variables', ['error' => $e->getMessage()]);
         throw $e;
      }
   }

   function obtenerValorVariable($clave)
   {
      if (empty($clave)) return null;

      // Buscar en variables simples
      if (isset($this->array_variables[$clave])) {
         return $this->array_variables[$clave];
      }

      // Buscar en variables calculadas
      if (isset($this->array_variables_calculadas[$clave])) {
         return $this->evaluarScript(
            $this->array_variables_calculadas[$clave]
         );
      }

      $this->logger->warning('Variable no encontrada', ['clave' => $clave]);
      return null;
   }

   private function evaluarScript($script)
   {
      try {
         $script = preg_replace_callback(
            '#\{{([^\{\}]*)\}}#',
            fn($match) => $this->obtenerValorVariable($match[1]),
            $script
         );

         ob_start();
         eval($script);
         return ob_get_clean();
      } catch (\Exception $e) {
         $this->logger->error('Error al evaluar script', [
            'script' => $script,
            'error' => $e->getMessage()
         ]);
         return null;
      }
   }

   function reemplazarValoresEnJson($json)
   {
      $this->logger->debug('Iniciando reemplazo de valores en JSON', [
         'json_original' => $json
      ]);

      try {
         $datos = json_decode($json, true);

         if (!is_array($datos)) {
            $this->logger->error('JSON inválido', [
               'json' => $json,
               'error' => json_last_error_msg()
            ]);
            throw new Exception("El JSON proporcionado no es válido o no es un array.");
         }

         // Función recursiva para procesar cualquier nivel del array
         $procesarArray = function($array) use (&$procesarArray) {
            foreach ($array as $clave => $valor) {
               if (is_array($valor)) {
                  $array[$clave] = $procesarArray($valor);
               } elseif (is_string($valor)) {
                  $nuevoValor = $this->obtenerValorVariable($valor);
                  if (!is_null($nuevoValor)) {
                     // Convertir a número si es posible
                     if (is_numeric($nuevoValor)) {
                        $array[$clave] = $nuevoValor * 1; // Conversión a número
                     } else {
                        $array[$clave] = $nuevoValor;
                     }
                     
                     $this->logger->debug('Valor reemplazado', [
                        'clave' => $clave,
                        'valor_original' => $valor,
                        'nuevo_valor' => $array[$clave],
                        'tipo' => gettype($array[$clave])
                     ]);
                  }
               }
            }
            return $array;
         };

         $datos = $procesarArray($datos);

         // Convertir el array procesado de nuevo a JSON
         $jsonFinal = json_encode($datos);
         if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Error al codificar JSON final: " . json_last_error_msg());
         }

         return $jsonFinal;

      } catch (Exception $e) {
         $this->logger->error('Error al procesar JSON', [
            'error' => $e->getMessage()
         ]);
         throw $e;
      }
   }
}
