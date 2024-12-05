<?php

class ConsultasAuth extends ConsultasSQL {
    private $hasheoPassword;

    public function __construct() {
        parent::__construct('usuarios');
        $this->hasheoPassword = new HasheoPassword();
    }

    public function obtenerUsuarioPorEmail($email) {
        $sql = "SELECT id, nombre, email, token, ultimo_inicio_sesion 
               FROM usuarios 
               WHERE email = ?";
        
        $this->logQuery($sql, [$email]);
        $resultado = $this->db->exec($sql, [$email]);
        return $resultado ? $resultado[0] : null;
    }

    public function verificarCredenciales($email, $pass) {
        $sql = "SELECT id, nombre, email, ultimo_inicio_sesion 
               FROM usuarios 
               WHERE email = ? AND pass = ?";
        $passwordHasheado = $this->hasheoPassword->hashear($pass);       
        
        $this->logQuery($sql, [$email, '[PROTECTED]']); // No logear passwords
        $resultado = $this->db->exec($sql, [$email, $passwordHasheado]);

        return $resultado ? $resultado[0] : null;
    }

    public function guardarToken($usuarioId, $token) {
        try {
            $this->logger->debug('Guardando token en usuario', [
                'usuario_id' => $usuarioId
            ]);

            $sql = "UPDATE usuarios 
                    SET token = ?,
                        ultimo_inicio_sesion = NOW() 
                    WHERE id = ?";
            
            $this->db->exec($sql, [
                $token,
                $usuarioId
            ]);

            return true;

        } catch (\Exception $e) {
            $this->logger->error('Error al guardar token', [
                'error' => $e->getMessage(),
                'usuario_id' => $usuarioId
            ]);
            return false;
        }
    }

    public function verificarToken($token) {
        try {
            $sql = "SELECT id, nombre, email, token, ultimo_inicio_sesion 
                    FROM usuarios 
                    WHERE token = ?";
            
            $this->logQuery($sql, [$token]);
            $resultado = $this->db->exec($sql, [$token]);
            
            if (!$resultado) {
                $this->logger->debug('No se encontró usuario con el token proporcionado');
                return null;
            }

            $usuario = $resultado[0];
            
            // Debug para ver qué campos vienen de la base de datos
            $this->logger->debug('Datos de usuario recuperados', [
                'campos_disponibles' => array_keys($usuario)
            ]);

            return [
                'id' => $usuario['id'],
                'email' => $usuario['email'],
                'nombre' => $usuario['nombre'],
                'ultimo_inicio_sesion' => $usuario['ultimo_inicio_sesion']
            ];

        } catch (Exception $e) {
            $this->logger->error('Error en verificación de token', [
                'error' => $e->getMessage(),
                'token' => substr($token, 0, 10) . '...'
            ]);
            return null;
        }
    }

    public function actualizarUltimoAcceso($usuarioId) {
        $sql = "UPDATE usuarios 
               SET ultimo_inicio_sesion = ? 
               WHERE id = ?";
        
        $ahora = date('Y-m-d H:i:s');
        $this->logQuery($sql, [$ahora, $usuarioId]);
        return $this->db->exec($sql, [$ahora, $usuarioId]);
    }

    public function invalidarToken($token) {
        $sql = "UPDATE usuarios SET token = NULL WHERE token = ?";
        $this->logQuery($sql, [$token]);
        return $this->db->exec($sql, [$token]);
    }

    public function crearUsuario($datos) {
        if (isset($datos['pass'])) {
            $datos['pass'] = $this->hasheoPassword->hashear($datos['pass']);
        }
        return $this->insertar($datos);
    }    

    public function guardarTokenRecuperacion($usuarioId, $token) {
        try {
            $this->logger->debug('Guardando token de recuperación', [
                'usuario_id' => $usuarioId
            ]);

            $sql = "UPDATE usuarios 
                    SET token = ?
                    WHERE id = ?";
            
            $this->logQuery($sql, ['[TOKEN]', $usuarioId]);
            return $this->db->exec($sql, [$token, $usuarioId]);

        } catch (\Exception $e) {
            $this->logger->error('Error al guardar token de recuperación', [
                'error' => $e->getMessage(),
                'usuario_id' => $usuarioId
            ]);
            return false;
        }
    }

    public function actualizarPassword($usuarioId, $password) {
        try {
            $passwordHasheado = $this->hasheoPassword->hashear($password);
            
            $sql = "UPDATE usuarios 
                    SET pass = ?,
                        token = NULL
                    WHERE id = ?";
            
            $this->logQuery($sql, ['[PROTECTED]', $usuarioId]);
            return $this->db->exec($sql, [$passwordHasheado, $usuarioId]);

        } catch (\Exception $e) {
            $this->logger->error('Error al actualizar contraseña', [
                'error' => $e->getMessage(),
                'usuario_id' => $usuarioId
            ]);
            return false;
        }
    }
} 