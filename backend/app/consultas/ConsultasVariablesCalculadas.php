<?php

class ConsultasVariablesCalculadas extends ConsultasSQL {
    public function __construct() {
        parent::__construct('variables_calculadas');
    }

    public function obtenerScripts() {
        try {
            $resultado = $this->obtenerTodos();
            
            if ($resultado['estado'] === 'error') {
                return $resultado;
            }

            $scripts = array_column($resultado['datos'], 'clave', 'script');
            return $this->respuestaExito($scripts);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function guardarNueva($datos) {
        try {
            if (empty($datos['clave']) || empty($datos['script'])) {
                return $this->respuestaError('La clave y el script son requeridos', null, 400);
            }

            return $this->insertar([
                'clave' => $datos['clave'],
                'script' => $datos['script']
            ]);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function guardar($id, $datos) {
        try {
            if (!is_numeric($id)) {
                return $this->respuestaError('ID inválido', null, 400);
            }

            if (empty($datos['clave']) || empty($datos['script'])) {
                return $this->respuestaError('La clave y el script son requeridos', null, 400);
            }

            return $this->actualizar($id, [
                'clave' => $datos['clave'],
                'script' => $datos['script']
            ]);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function borrar($id) {
        try {
            if (!is_numeric($id)) {
                return $this->respuestaError('ID inválido', null, 400);
            }

            $resultado = parent::eliminar($id);
            
            if ($resultado['estado'] === 'error') {
                return $resultado;
            }

            return $this->respuestaExito(
                ['id' => $id],
                'Variable calculada eliminada correctamente'
            );
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    // Método adicional para validar un script
    public function validarScript($script) {
        try {
            // Aquí podrías agregar validación de sintaxis PHP
            // o cualquier otra validación específica para scripts
            
            if (empty($script)) {
                return $this->respuestaError('El script no puede estar vacío', null, 400);
            }

            // Ejemplo de validación básica
            if (strpos($script, '<?php') !== false) {
                return $this->respuestaError('El script no debe incluir las etiquetas PHP', null, 400);
            }

            return $this->respuestaExito(null, 'Script válido');
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }
}
