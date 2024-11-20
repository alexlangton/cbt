<?php class utilDB
{

   private static $db = null;

   static function getDB($f3)
   {
      try {
         // Verificar si las configuraciones necesarias están definidas
         if (!isset($f3['db.host'], $f3['db.name'], $f3['db.user'], $f3['db.pass'])) {
            throw new \Exception('Faltan parámetros de conexión a la base de datos');
         }

         // Crear la conexión a la base de datos
         self::$db = new \DB\SQL(
            "mysql:host={$f3['db.host']};dbname={$f3['db.name']};charset=utf8mb4",
            $f3['db.user'],
            $f3['db.pass'],
            [
               \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,  // Activar excepciones para errores de PDO
               \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,  // Establecer modo de obtención por defecto
               \PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4",  // Forzar UTF-8 para la conexión
               \PDO::ATTR_EMULATE_PREPARES => false  // Desactivar emulación de prepared statements
            ]
         );
      } catch (\PDOException $e) {
         // Manejo de errores de conexión PDO
         
         \Base::instance()->error(500, "Error de conexión a la base de datos: " . $e->getMessage());
      } catch (\Exception $e) {
         // Manejo de cualquier otro tipo de excepción
         
         \Base::instance()->error(500, "Error en la configuración de la base de datos: " . $e->getMessage());
      }

      return self::$db;
   }



   static function escaparValores($value)
   {
      // Manejar valores numéricos directamente
      if (is_numeric($value)) {
         $return = $value;
         return $return;
      }

      // Manejar valores de fecha con formato ISO 8601 (incluyendo zona horaria)
      if (strtotime($value) !== false) {
         // Detectar y manejar el formato ISO con "T" y "Z" (UTC)
         $fecha = date_create($value);
         if ($fecha !== false) {
            // Convertir al formato SQL Y-m-d H:i:s
            return "'" . date_format($fecha, 'Y-m-d H:i:s') . "'";
         }
      }
      // Escapar cadenas de texto
      return "'" . str_replace("'", "''", $value) . "'";
   }

   static function ensamblarConsulta($sql, $arrayParametros)
   {
      if (is_null($arrayParametros)) {
         return $sql;
      }
      foreach ($arrayParametros as $key => $value) {
         $sql = preg_replace('/\?/', self::escaparValores($value), $sql, 1);
      }
      return $sql;
   }

   // Función para obtener la primera operación en mayúsculas de una consulta SQL
   static function obtenerOperacionSql($sql)
   {
      // Eliminar espacios en blanco al inicio y al final, y dividir la consulta en palabras
      $palabras = preg_split('/\s+/', trim($sql));

      // Verificar si hay palabras en la consulta
      if (empty($palabras)) {
         return null; // Retornar null si no hay ninguna palabra
      }

      // Convertir la primera palabra a mayúsculas
      $primera = strtoupper($palabras[0]);

      // Verificar si es un SELECT COUNT(*)
      if ($primera === 'SELECT' && isset($palabras[1]) && strtoupper($palabras[1]) === 'COUNT(*)') {
         return 'COUNT';
      }

      // Retornar la primera palabra en mayúsculas
      return $primera;
   }


   static function ejecutarOperacionSql($f3, $sql, $parametros = null, $flag = null, $numeracion = [])
   {
      

      // Establecer modo de error en la conexión
      $f3['DB']->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

      // Obtener la operación SQL (INSERT, UPDATE, DELETE, etc.)
      $operacion = self::obtenerOperacionSql($sql);

      // Inicializar las variables de numeración
      foreach ($numeracion as $clave => $valor) {
         // Crea variables dinámicamente
         ${$clave} = $valor;
      }

      try {
         // Preparar la consulta SQL
         $preparada = $f3['DB']->prepare($sql);
         $esModificacion = in_array($operacion, ['INSERT', 'UPDATE', 'DELETE']);
         $resultado = null;

         // Si es una operación COUNT, asegurarse de que los parámetros son correctos
         if ($operacion === 'COUNT') {
            // Asegúrate de que el parámetro sea un valor escalar
            if (is_array($parametros) && count($parametros) === 1) {
               $parametros = $parametros[0]; // Extrae el primer elemento
            }

            // Ejecutar la consulta COUNT y retornar el total
            $resultado = $f3['DB']->query($sql, $parametros)->fetchColumn();
            return $resultado !== false ? (int) $resultado : 0; // Aseguramos que el resultado sea un entero
         }

         // Ejecutar la consulta según el tipo de operación
         if ($esModificacion) {
            $resultado = $preparada->execute($parametros);
            

            // Retornar el ID del último registro insertado si es una operación INSERT
            if ($operacion === 'INSERT') {
               if ($resultado) {
                  return $f3['DB']->lastInsertId();
               }
               throw new Exception('Error al insertar el registro');
            }
         } else {
            // Ejecutar SELECT u otra operación que devuelve resultados
            $preparada->execute($parametros);
            
            return $preparada->fetchAll(PDO::FETCH_ASSOC);
         }

         // Retornar los resultados en el formato adecuado
         return ($flag !== JSON_PRETTY_PRINT) ? $resultado : json_encode($resultado, $flag);
      } catch (PDOException $e) {
         // Manejo de excepciones específicas de PDO
         

         $errorMsg = "PDO Exception: " . $e->getMessage();
         
         throw new Exception($errorMsg);
      } catch (Exception $e) {
         
         // Manejo de excepciones generales
         $errorMsg = "Exception: " . $e->getMessage();
      
         throw new Exception($errorMsg);
      }
   }

   static function ejecutarOperacionSql2($db, $sql, $parametros = null, $flag = null, $numeracion = [])
   {
      

      // Establecer modo de error en la conexión
      $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

      // Obtener la operación SQL (INSERT, UPDATE, DELETE, etc.)
      $operacion = self::obtenerOperacionSql($sql);

      // Inicializar las variables de numeración
      foreach ($numeracion as $clave => $valor) {
         // Crea variables dinámicamente
         ${$clave} = $valor;
      }

      try {
         // Preparar la consulta SQL
         $preparada = $db->prepare($sql);
         $esModificacion = in_array($operacion, ['INSERT', 'UPDATE', 'DELETE']);
         $resultado = null;

         // Si es una operación COUNT, asegurarse de que los parámetros son correctos
         if ($operacion === 'COUNT') {
            // Asegúrate de que el parámetro sea un valor escalar
            if (is_array($parametros) && count($parametros) === 1) {
               $parametros = $parametros[0]; // Extrae el primer elemento
            }

            // Ejecutar la consulta COUNT y retornar el total
            $resultado = $db->query($sql, $parametros)->fetchColumn();
            return $resultado !== false ? (int) $resultado : 0; // Aseguramos que el resultado sea un entero
         }

         // Ejecutar la consulta según el tipo de operación
         if ($esModificacion) {
            $resultado = $preparada->execute($parametros);
            

            // Retornar el ID del último registro insertado si es una operación INSERT
            if ($operacion === 'INSERT') {
               if ($resultado) {
                  return $db->lastInsertId();
               }
               throw new Exception('Error al insertar el registro');
            }
         } else {
            // Ejecutar SELECT u otra operación que devuelve resultados
            $preparada->execute($parametros);
            
            return $preparada->fetchAll(PDO::FETCH_ASSOC);
         }

         // Retornar los resultados en el formato adecuado
         return ($flag !== JSON_PRETTY_PRINT) ? $resultado : json_encode($resultado, $flag);
      } catch (PDOException $e) {
         // Manejo de excepciones específicas de PDO
         

         $errorMsg = "PDO Exception: " . $e->getMessage();
         
         throw new Exception($errorMsg);
      } catch (Exception $e) {
         
         // Manejo de excepciones generales
         $errorMsg = "Exception: " . $e->getMessage();
         
         throw new Exception($errorMsg);
      }
   }



   static function obtenerStatus($data, $isAuth = true, $hasPermission = true, $isValid = true)
   {
      // Verificar si la consulta falló
      if ($data === false) {
         return 500; // Error interno del servidor
      }

      // Verificar si el usuario no está autenticado
      if (!$isAuth) {
         return 401; // No autorizado
      }

      // Verificar si el usuario no tiene permiso para acceder
      if (!$hasPermission) {
         return 403; // Prohibido
      }

      // Verificar si los datos de entrada no son válidos
      if (!$isValid) {
         return 422; // Entidad no procesable
      }

      // Verificar si no se encontraron datos
      if (empty($data)) {
         return 404; // No encontrado
      }

      // En todos los demás casos, la operación se realizó con éxito
      return 200; // OK
   }

   static function obtenerMensaje($estatus)
   {
      switch ($estatus) {
         case 200:
            return 'OK';
         case 204:
            return 'No hay contenido';
         case 400:
            return 'Solicitud mal formada';
         case 401:
            return 'No autorizado';
         case 403:
            return 'Prohibido';
         case 404:
            return 'No encontrado';
         case 422:
            return 'Entidad no procesable';
         case 500:
            return 'Error interno del servidor';
         default:
            return 'Código de estado desconocido';
      }
   }

   static function validarCamposRequeridos($campos, $input)
   {
      foreach ($campos as $campo) {
         if (!isset($input[$campo]) || empty($input[$campo])) {
            return ['error' => "El campo '{$campo}' es obligatorio y falta en la solicitud"];
         }
      }
      return true;
   }
}
