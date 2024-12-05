<?php class bdVariables
{
   static function obtener($f3, $desde = null)
   {
      // Parte base de la consulta
      $baseQuery = "SELECT * FROM variables";

      // Inicializamos los parámetros
      $params = [];

      // Añadimos la cláusula WHERE si se proporciona 'desde'
      if (!is_null($desde)) {
         $baseQuery .= " WHERE fecha >= ?";
         $params[] = $desde;
      }

      // Añadimos la cláusula ORDER BY al final
      $baseQuery .= " ORDER BY fecha DESC";

      // Ejecutamos la consulta con los parámetros
      return utilDB::ejecutarOperacionSql($f3, $baseQuery, $params);
   }

   static function obtenerEstadisticasFechas($f3, $desde = NULL)
   {
      // Parte común de la consulta
      $baseQuery = "SELECT MAX(fecha) as max, MIN(fecha) as min, COUNT(fecha) as total FROM variables";

      if (is_null($desde)) {
         // Si no se proporciona 'desde', se usa la consulta base sin modificaciones
         $query = $baseQuery;
         // No se necesitan parámetros adicionales
         $params = [];
      } else {
         // Si se proporciona 'desde', se añade la cláusula WHERE
         $query = $baseQuery . " WHERE fecha >= ?";
         // Definimos el parámetro con el valor de 'desde'
         $params = [$desde];
      }

      // Ejecutamos la consulta con los parámetros
      return utilDB::ejecutarOperacionSql($f3, $query, $params);
   }

   static function borrarTodo($f3)
   {
      return utilDB::ejecutarOperacionSql($f3, "DELETE FROM variables");
   }



   static function insertarParametro($f3, $clave, $valor)
   {
      utilDB::ejecutarOperacionSql(
         $f3,
         "INSERT INTO variables (clave, valor) VALUES (?, ?)",
         [$clave, $valor]
      );
   }

   static function actualizarParametro($f3, $clave, $nuevoValor)
   {
      utilDB::ejecutarOperacionSql(
         $f3,
         "UPDATE variables SET valor = ? WHERE clave = ?",
         [$nuevoValor, $clave]
      );
   }

   static function obtenerClavesExistentes($f3, $claves)
   {
      // Verificar que se pasa un array de claves válidas
      if (empty($claves) || !is_array($claves)) {
         return [];
      }

      // Filtrar claves vacías y no válidas
      $claves = array_filter($claves, function ($clave) {
         return !empty($clave) && is_string($clave);
      });

      // Si no hay claves válidas, devolver un array vacío
      if (empty($claves)) {
         return [];
      }

      // Crear una cadena de consulta SQL con los placeholders
      $placeholders = rtrim(str_repeat('?,', count($claves)), ',');
      $sql = "SELECT clave FROM variables WHERE clave IN ($placeholders)";

      // Ejecutar la consulta para obtener las claves existentes
      $resultados = utilDB::ejecutarOperacionSql($f3, $sql, $claves);

      // Crear un array de claves existentes para su fácil verificación
      $clavesExistentes = [];
      foreach ($resultados as $resultado) {
         $clavesExistentes[] = $resultado['clave'];
      }

      return $clavesExistentes; // Devolver las claves existentes
   }

   static function sincronizarRegistro($f3, $atributos, $registros, $codinsclo, $entidad)
   {
      // Crear un array para almacenar todas las claves a verificar
      $clavesAVerificar = [];

      foreach ($registros as $registro) {
         foreach ($atributos as $atributo) {
            $clave = "$codinsclo.$entidad.{$registro['id']}.$atributo";
            $clavesAVerificar[] = $clave; // Agregar clave al array
         }
      }

      // Obtener todas las claves existentes de una sola vez
      $clavesExistentes = self::obtenerClavesExistentes($f3, $clavesAVerificar);

      foreach ($registros as $registro) {
         foreach ($atributos as $atributo) {
            $clave = "$codinsclo.$entidad.{$registro['id']}.$atributo";
            $valor = $registro[$atributo];

            // Verificar si la clave existe en el array de claves existentes
            if (in_array($clave, $clavesExistentes)) {
               self::actualizarParametro($f3, $clave, $valor);
            } else {
               self::insertarParametro($f3, $clave, $valor);
            }
         }
      }
   }

   // entidades: zones, counters, signs
   static function sincronizarRegistros($f3, $codinsclo, $entidad, $registros)
   {
      $zones = ['description', 'total_spaces', 'available_spaces', 'occupied_spaces'];
      $counters = ['description', 'value_expression', 'value'];
      $signs = ['description', 'activation_expression', 'activated', 'forced'];
      self::sincronizarRegistro($f3, $$entidad, $registros, $codinsclo, $entidad);
   }
}
