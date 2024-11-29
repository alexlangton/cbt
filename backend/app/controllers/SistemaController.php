<?php

class SistemaController extends JsonController {
    public function obtenerRutas($f3) {
        $rutas = [];
        foreach ($f3->ROUTES as $ruta => $handler) {
            // Incluir rutas API y públicas, pero excluir las auxiliares
            if (strpos($ruta, '/api/') === 0 && 
                !in_array($ruta, [
                    'GET /api/rutas',
                    'GET /api/test',
                    'POST /api/crearUsuario'
                ])) {
                $rutas[] = [
                    'ruta' => $ruta,
                    'metodo' => explode(' ', $ruta)[0],
                    'controlador' => $handler
                ];
            }
        }
        
        return $this->respuestaExito($rutas, 'Rutas obtenidas exitosamente');
    }

    

    public function obtenerTiposLogs($f3) {
        $logPath = $f3->get('LOGS');
        $archivos = glob($logPath . '*.log');
        
        $tipos = array_map(function($archivo) {
            $nombre = basename($archivo, '.log');
            return [
                'label' => ucfirst($nombre),
                'value' => $nombre
            ];
        }, $archivos);

        return $this->respuestaExito([
            'tipos' => $tipos
        ], 'Tipos de logs obtenidos exitosamente');
    }
} 