<?php

class bdVariablesCalculadas
{
   // Método para obtener todas las variables calculadas
   static function obtener($f3)
   {
      return utilDB::ejecutarOperacionSql($f3, "SELECT * FROM variables_calculadas");
   }


   // Método para obtener una variable calculada por ID
   static function obtenerPorId($f3, $id)
   {
      // Asegúrate de validar el ID antes de realizar la consulta
      if (!is_numeric($id)) {
         throw new Exception("ID inválido"); // Lanza una excepción si el ID no es válido
      }

      // Realiza la consulta a la base de datos para obtener la variable calculada específica
      return utilDB::ejecutarOperacionSql($f3, "SELECT * FROM variables_calculadas WHERE id = ?", [$id]);
   }


   static function obtenerScripts($f3)
   {
      // Retornar solo los valores de 'script' como un array
      return array_column(self::obtener($f3), 'clave', 'script');
   }



   // Método para guardar una nueva variable calculada
   static function guardarNueva($f3, $datos)
   {
      // Preparar la consulta SQL
      $sql = "INSERT INTO variables_calculadas (clave, script) VALUES (?, ?)";

      // Ejecutar la operación SQL
      $resultado = utilDB::ejecutarOperacionSql($f3, $sql, [
         $datos['clave'],
         $datos['script'] // Guardar el script PHP asociado
      ]);

      // Retornar el resultado de la operación
      return $resultado;
   }

   // Método para actualizar una variable calculada existente
   static function guardar($f3, $id, $datos)
   {
      // Asegúrate de validar el ID
      if (!is_numeric($id)) {
         throw new Exception("ID inválido");
      }

      // Preparar la consulta SQL
      $sql = "UPDATE variables_calculadas SET clave = ?, script = ? WHERE id = ?";

      // Ejecutar la operación SQL
      $resultado = utilDB::ejecutarOperacionSql($f3, $sql, [
         $datos['clave'],
         $datos['script'], // Actualiza el script PHP
         $id
      ]);

      // Retornar el resultado de la operación
      return $resultado;
   }

   // Método para borrar una variable calculada por su ID
   static function borrar($f3, $id)
   {
      // Asegúrate de que el ID sea un número válido
      if (!is_numeric($id)) {
         return false; // O manejar el error según tu lógica
      }

      // Prepara la consulta SQL para eliminar el registro
      $query = "DELETE FROM variables_calculadas WHERE id = ?";

      // Ejecuta la operación de base de datos
      $resultado = utilDB::ejecutarOperacionSql($f3, $query, [$id]);

      // Retorna true si se eliminó un registro, de lo contrario false
      return $resultado > 0;
   }
}
