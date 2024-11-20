<?php

class ConsultasAuth extends ConsultasSQL {
    private $hasheoPassword;

    public function __construct() {
        parent::__construct('usuarios');
        $this->hasheoPassword = new HasheoPassword();
    }

    public function verificarCredenciales($email, $pass) {
        $sql = "SELECT * FROM usuarios WHERE email = ? AND pass = ?";
        $passwordHasheado = $this->hasheoPassword->hashear($pass);       
        
        $this->logQuery($sql, [$email, $passwordHasheado]); // No logear passwords
        $resultado = $this->db->exec($sql, [$email, $passwordHasheado]);

        return $resultado ? $resultado[0] : null;
    }

    public function guardarToken($email, $token) {
        try {
            $datos = [
                'token' => $token,                
                'fecha_creacion_token' => date('Y-m-d H:i:s')
            ];
            
            $sql = "UPDATE usuarios SET token = ? WHERE email = ?";
            $this->logQuery($sql, [$token, $email]);
            $resultado = $this->db->exec($sql, [$token, $email]);
            
            if ($resultado === false) {
                return [
                    'estado' => 'error',
                    'mensaje' => 'Error al guardar el token en la base de datos'
                ];
            }
            
            return [
                'estado' => 'exito',
                'datos' => [
                    'token' => $token                 
                ]
            ];
            
        } catch (Exception $e) {
            return [
                'estado' => 'error',
                'mensaje' => 'Error en el proceso de guardado del token'
            ];
        }
    }

    

    public function verificarToken($token) {
        $sql = "SELECT * FROM usuarios WHERE token = ? AND expiracion > NOW()";
        $this->logQuery($sql, [$token]);
        $resultado = $this->db->exec($sql, [$token]);
        return $resultado ? $resultado[0] : null;
    }

    public function invalidarToken($token) {
        $sql = "UPDATE usuarios SET token = NULL, expiracion = NULL, fecha_creacion_token = NULL WHERE token = ?";
        $this->logQuery($sql, [$token]);
        return $this->db->exec($sql, [$token]);
    }

    public function limpiarTokensExpirados() {
        $sql = "UPDATE usuarios SET token = NULL, expiracion = NULL, fecha_creacion_token = NULL WHERE expiracion < NOW()";
        $this->logQuery($sql);
        return $this->db->exec($sql);
    }

    public function crearUsuario($datos) {
        if (isset($datos['pass'])) {
            $datos['pass'] = $this->hasheoPassword->hashear($datos['pass']);
        }
        return $this->insertar($datos);
    }    
} 