<?php
require 'vendor/autoload.php';

$f3 = Base::instance();

// Configuración básica
$f3->set('DEBUG', 3);
$f3->set('CORS.origin', '*');

// Configurar la base URL
$f3->set('BASE', '/');

// Cargar configuración básica
$f3->config('config/config.ini');

// Logging de todas las peticiones usando nuestro Logger
$f3->route('GET|POST|PUT|DELETE|PATCH *', function($f3) {
    $logger = new Logger($f3);
    
    $request = [
        'method' => $f3->get('VERB'),
        'url' => $f3->get('URI'),
        'query_params' => $f3->get('GET'),
        'body_params' => $f3->get('POST'),
        'headers' => getallheaders(),
        'ip' => $f3->get('IP'),
        'user_agent' => $f3->get('AGENT')
    ];

    // Capturar body raw para peticiones POST/PUT/PATCH/DELETE
    if (in_array($f3->get('VERB'), ['POST', 'PUT', 'PATCH', 'DELETE'])) {
        $rawData = file_get_contents('php://input');
        if (!empty($rawData)) {
            $request['raw_body'] = $rawData;
        }
    }

    $mensaje = sprintf(
        "%s %s - IP: %s", 
        $request['method'],
        $request['url'],
        $request['ip']
    );

    $logger->request($mensaje, $request);
}, ['before' => true]);

// Cargar rutas
require 'config/routes.php';

$f3->run();
