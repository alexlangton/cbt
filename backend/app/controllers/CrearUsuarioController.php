<?php 

class CrearUsuarioController extends Controller {
    protected $logger;
    protected $consultas;

    
    public function crearUsuario($f3) {
        $this->logger->debug('Crear usuario');
        
        // Obtener y decodificar el JSON del body
        $datos = json_decode($f3->get('BODY'), true);
        
        // Crear instancia de ConsultasSQL para la tabla usuarios
        $consulta = new ConsultasSQL('usuarios');
        return $consulta->insertar($datos);
    }
}
