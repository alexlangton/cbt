<?php class bdMarcadores {
   static function obtener($f3){
      return utilDB::ejecutarOperacionSql(
         $f3,"
         -- Seleccionar todos los campos necesarios del resultado combinado
            SELECT
               resultados_combinados.id,                    -- ID único del marcador
               resultados_combinados.tipo,                  -- Tipo de marcador (cartel o parking)
               resultados_combinados.codinsclo,            -- Código de inscripción (para parkings) o ID (para carteles)
               resultados_combinados.nombre,                -- Nombre del marcador
               CAST(resultados_combinados.latitud AS DECIMAL(10, 8)) AS latitud,    -- Latitud con 8 decimales
               CAST(resultados_combinados.longitud AS DECIMAL(11, 8)) AS longitud,  -- Longitud con 8 decimales
               resultados_combinados.atributos,             -- Atributos JSON del marcador
               resultados_combinados.rotativo               -- Campo rotativo (solo para carteles)
            FROM (
               -- Subconsulta para CARTELES
               SELECT
                  CAST(c.id AS CHAR) as id,          -- Convertir ID a texto
                  CAST(c.id AS CHAR) as codinsclo,   -- Usar el mismo ID como código
                  'cartel' AS tipo,                  -- Tipo fijo 'cartel'
                  c.nombre,                          -- Nombre del cartel
                  CAST(c.latitud AS DECIMAL(10, 8)) AS latitud,    -- Latitud con precisión
                  CAST(c.longitud AS DECIMAL(11, 8)) AS longitud,  -- Longitud con precisión
                  ct.atributos AS atributos,         -- Atributos del tipo de cartel
                  c.rotativo                         -- Campo rotativo del cartel
               FROM
                  carteles c 
                  LEFT JOIN c_tiposcarteles ct ON (ct.id = c.id_tipocartel)  -- Unión con tipos de carteles
               
               UNION ALL  -- Combinar con PARKINGS
               
               -- Subconsulta para PARKINGS
               SELECT
                  CAST(p.id AS CHAR) as id,          -- Convertir ID a texto
                  p.codinsclo,                       -- Código de inscripción del parking
                  'parking' AS tipo,                 -- Tipo fijo 'parking'
                  p.nombre,                          -- Nombre del parking
                  CAST(p.latitud AS DECIMAL(10, 8)) AS latitud,    -- Latitud con precisión
                  CAST(p.longitud AS DECIMAL(11, 8)) AS longitud,  -- Longitud con precisión
                  p.json_counters AS atributos,      -- Contadores JSON del parking
                  '' as rotativo                     -- Campo vacío para rotativo (no aplica en parkings)
               FROM
                  parkings p
            ) AS resultados_combinados  -- Alias para el resultado combinado

            -- Filtrar solo marcadores con coordenadas válidas
            WHERE resultados_combinados.latitud IS NOT NULL 
            AND resultados_combinados.longitud IS NOT NULL

            -- Ordenar primero por tipo y luego por nombre
            ORDER BY resultados_combinados.tipo, resultados_combinados.nombre;
         "
      );
   }
}