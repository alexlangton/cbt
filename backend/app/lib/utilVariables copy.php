<?php

class utilVariables
{
   private $array_variables;
   private $array_variables_calculadas;
   private $logger;
   private $f3;

   function __construct()
   {
      $this->f3 = \Base::instance();
      $this->logger = new Logger($this->f3);
      $this->logger->info('Inicializando utilVariables');
      list($this->array_variables, $this->array_variables_calculadas) = $this->obtenerDatosCombinados();
   }

   private function obtenerDatosCombinados()
   {
      $consultasVariables = new ConsultasVariables();
      $datosVariables = $consultasVariables->obtenerConFecha();
      $array_variables = array_column($datosVariables, 'valor', 'clave');

      $this->logger->debug('Variables obtenidas2', json_encode($array_variables));

      $consultasVariablesCalculadas = new ConsultasVariablesCalculadas();
      $datosVariablesCalculadas = $consultasVariablesCalculadas->obtenerScripts();
      $array_variables_calculadas = array_column($datosVariablesCalculadas, 'script', 'clave');

      $this->logger->debug('Variables calculadas obtenidas', [
         'cantidad' => count($array_variables_calculadas)
      ]);

      return [$array_variables, $array_variables_calculadas];
   }

   function obtenerValorVariable($clave)
   {
      $this->logger->debug('Obteniendo valor de variable', ['clave' => $clave]);

      if (is_null($clave)) {
         $this->logger->error('Clave nula proporcionada');
         return null;
      }

      if (array_key_exists($clave, $this->array_variables)) {
         $valor = $this->array_variables[$clave];
         $this->logger->debug('Valor encontrado en variables simples', [
            'clave' => $clave,
            'valor' => $valor
         ]);
         return $valor;
      }

      if (array_key_exists($clave, $this->array_variables_calculadas)) {
         $script = $this->array_variables_calculadas[$clave];
         $this->logger->debug('Variable calculada encontrada', [
            'clave' => $clave,
            'script_original' => $script
         ]);

         $script = preg_replace_callback('#\{{([^\{\}]*)\}}#', function ($coincidencia) {
            $claveInterna = $coincidencia[1];
            $this->logger->debug('Procesando variable interna', [
               'clave_interna' => $claveInterna
            ]);
            return $this->obtenerValorVariable($claveInterna);
         }, $script);

         $this->logger->debug('Script procesado', [
            'script_final' => $script
         ]);

         ob_start();
         try {
            eval($script);
            $resultado = ob_get_clean();
            $this->logger->debug('Script evaluado exitosamente', [
               'resultado' => $resultado
            ]);
            return $resultado;
         } catch (\Exception $e) {
            ob_end_clean();
            $this->logger->error('Error al evaluar script', [
               'error' => $e->getMessage(),
               'script' => $script
            ]);
            return null;
         }
      }

      $this->logger->error('Variable no encontrada', ['clave' => $clave]);
      return null;
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
               $this->logger->debug('Procesando elemento', [
                  'clave' => $clave,
                  'tipo' => gettype($valor)
               ]);

               if (is_array($valor)) {
                  $array[$clave] = $procesarArray($valor);
               } elseif (is_string($valor)) {
                  $nuevoValor = $this->obtenerValorVariable($valor);
                  if (!is_null($nuevoValor)) {
                     $array[$clave] = $nuevoValor;
                     $this->logger->debug('Valor reemplazado', [
                        'clave' => $clave,
                        'valor_original' => $valor,
                        'nuevo_valor' => $nuevoValor
                     ]);
                  } else {
                     $this->logger->debug('Valor mantenido original', [
                        'clave' => $clave,
                        'valor' => $valor
                     ]);
                  }
               }
            }
            return $array;
         };

         // Procesar todo el array recursivamente
         $datos = $procesarArray($datos);

         $jsonFinal = json_encode($datos, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE);
         
         if (json_last_error() !== JSON_ERROR_NONE) {
            $this->logger->error('Error al codificar JSON final', [
               'error' => json_last_error_msg()
            ]);
            throw new Exception("Error al codificar JSON final: " . json_last_error_msg());
         }

         $this->logger->debug('JSON procesado exitosamente', [
            'json_final' => $jsonFinal
         ]);
         
         return $jsonFinal;

      } catch (Exception $e) {
         $this->logger->error('Error al procesar JSON', [
            'error' => $e->getMessage(),
            'json_original' => $json
         ]);
         throw $e;
      }
   }
}
