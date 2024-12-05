<?php

class SAGACloudServidor
{
   private static $logger;
   private static $f3;

   private static function initLogger()
   {
      if (!self::$f3) {
         self::$f3 = Base::instance();
         self::$logger = new Logger(self::$f3);
      }
   }

   public static function realizarPeticion($f3, $metodo, $recurso, $contenido = NULL)
   {
      self::initLogger();
      $respuesta = Web::instance()->request(
         $f3['SAGACloudServidor.URL_BASE'] . $recurso,
         [
            'method' => $metodo,
            'header' => [
               'Authorization: Basic ' . base64_encode($f3['SAGACloudServidor.USER'] . ':' . $f3['SAGACloudServidor.PASS']),
               'Content-type: application/json'
            ],
            'content' => $contenido,
            'timeout' => 12
         ]
      );
      $respuesta['status_line'] = explode(' ', $respuesta['headers'][0], 3);
      
      if ($respuesta['error'] != '') {
         throw new Exception($respuesta['error']);
      }
      return $respuesta['body'];
   }    

   static function obtenerRegistrosConsultaSQL($f3, $codinsclo, $consulta)
   {
      return SELF::realizarPeticion(
         $f3, 
         'POST', 
         "/api/parking/$codinsclo/system/sql", 
         '{ "command": "' . $consulta . '" }'
      );
   }

   static function obtenerStatusCounters($f3, $codinsclo)
   {
      return self::realizarPeticion($f3, 'GET', "/api/parking/$codinsclo/status/counters");
   }

   static function obtenerConfiguracion($f3, $codinsclo)
   {
      return self::realizarPeticion($f3, 'GET', "/api/parking/$codinsclo/configuration/parking");
   }
   
   static function obtenerStatusCounters2($f3)
   {
      echo self::realizarPeticion($f3, 'GET', "/api/parking/1362/status/counters");
   }
}
