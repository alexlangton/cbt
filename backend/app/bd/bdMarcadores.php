<?php class bdMarcadores {

   static function obtener($f3, $tipo){

      if($tipo == 'cartel'){
         return self::obtenerCarteles($f3, $tipo);
      }

      if($tipo == 'parking'){
         return self::obtenerParkings($f3, $tipo);
      }  

      return [];
   }

   static function obtenerCarteles($f3, $tipo){
      return utilDB::ejecutarOperacionSql(
         $f3,"
         SELECT
            CAST(c.id AS CHAR) as id,  
            CAST(c.id AS CHAR) as codinsclo,  
            'cartel' AS tipo,
            c.nombre,
            CAST(c.latitud AS DECIMAL(10, 8)) AS latitud,
            CAST(c.longitud AS DECIMAL(11, 8)) AS longitud,
            ct.atributos AS atributos,
            c.rotativo
         FROM
            carteles c 
            LEFT JOIN c_tiposcarteles ct ON (ct.id = c.id_tipocartel)
         WHERE 
            c.latitud IS NOT NULL 
            AND c.longitud IS NOT NULL
         ORDER BY c.nombre;
         "
      );
   }

   static function obtenerParkings($f3, $tipo){
      return utilDB::ejecutarOperacionSql(
         $f3,"
         SELECT
            CAST(p.id AS CHAR) as id,  
            p.codinsclo,  
            'parking' AS tipo,
            p.nombre,
            CAST(p.latitud AS DECIMAL(10, 8)) AS latitud,
            CAST(p.longitud AS DECIMAL(11, 8)) AS longitud,
            p.json_counters AS atributos,
            '' as rotativo
         FROM
            parkings p
         WHERE 
            p.latitud IS NOT NULL 
            AND p.longitud IS NOT NULL
         ORDER BY p.nombre;
         "
      );
   }
}