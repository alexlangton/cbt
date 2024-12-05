<?php

// Rutas públicas
$rutasPublicas = [
    'POST /api/public/login' => 'AutenticacionController->login',
    'POST /api/public/logout' => 'AutenticacionController->logout',
    'GET /api/public/info' => 'AutenticacionController->obtenerInfo',
    'POST /api/public/recuperarPassword' => 'AutenticacionController->recuperarPassword',    
    'PUT /api/public/cambiarPassword' => 'AutenticacionController->cambiarPassword',
    'GET /api/public/actualizarContadores' => 'ContadoresController->actualizarTodosLosContadores',
    'GET /api/integration/panel-info/@id' => 'IntegracionController->obtenerInfoCartel'
];

// Rutas auxiliares del sistema
$rutasAuxiliaresSistema = [
    'GET  /api/test' => 'ParkingsController->obtener',
    'GET  /api/rutas' => 'SistemaController->obtenerRutas',
    'POST /api/crearUsuario' => 'CrearUsuarioController->crearUsuario'    
];

// Rutas del sistema
$rutasSistema = [  
    'GET  /api/datosLeaflet' => 'LeafletController->obtenerDatosLeaflet',
    'GET  /api/obtenerCartelesActualizados' => 'CartelController->obtenerCartelesActualizados'
];

// Rutas de backup y base de datos
$rutasBackup = [
    'GET  /api/database/download' => 'BaseDatosController->download',
    'POST /api/backup/create' => 'BaseDatosController->createBackup',
    'GET  /api/backup/ultimo' => 'BaseDatosController->getUltimo'
];

// Registrar rutas públicas
foreach ($rutasPublicas as $ruta => $controlador) {
    $f3->route($ruta, $controlador);
}

// Registrar rutas auxiliares del sistema
foreach ($rutasAuxiliaresSistema as $ruta => $controlador) {
    $f3->route($ruta, $controlador);
}

// Registrar rutas del sistema
foreach ($rutasSistema as $ruta => $controlador) {
    $f3->route($ruta, $controlador);
}

// Registrar rutas de backup
foreach ($rutasBackup as $ruta => $controlador) {
    $f3->route($ruta, $controlador);
}

// Configuración de recursos CRUD
$recursos = [
    'parkings',
    'carteles',
    'tiposcarteles',
    'usuarios',
    'logs'
];

// Configuración de rutas CRUD
$rutas_crud = [
    'GET /@recurso' => 'obtenerconfiltros',
    'GET /@recurso/@id' => 'obtener',
    'POST /@recurso' => 'guardarnuevo',
    'PUT /@recurso/@id' => 'guardar',
    'DELETE /@recurso' => 'borrar',
    'DELETE /@recurso/@id' => 'borrar'    
];

$rutas_adicionales = [
    'GET /@recurso/buscar' => 'buscarPorTexto',
    'GET /@recurso/pagina/@pagina/@por_pagina' => 'obtenerPaginado'
];

// Funciones auxiliares
function obtenerControlador($recurso, $config) {
    return is_array($config) && isset($config['controlador'])
        ? $config['controlador']
        : ucfirst($recurso);
}

function obtenerMetodosProhibidos($config) {
    return is_array($config) ? ($config['metodos_prohibidos'] ?? []) : [];
}

// Registrar rutas para cada recurso
foreach ($recursos as $recurso => $config) {
    // Normalizar configuración
    if (is_numeric($recurso)) {
        $recurso = $config;
        $config = [];
    }
    
    $controlador = obtenerControlador($recurso, $config);
    $metodos_prohibidos = obtenerMetodosProhibidos($config);
    
    // Registrar rutas CRUD
    foreach ($rutas_crud as $patron => $metodo) {
        $metodo_http = explode(' ', $patron)[0];
        
        if (!in_array($metodo_http, $metodos_prohibidos)) {
            $ruta = str_replace('@recurso', "api/$recurso", $patron);
            $f3->route($ruta, "{$controlador}Controller->$metodo");
        }
    }
    
    // Registrar rutas adicionales
    foreach ($rutas_adicionales as $patron => $metodo) {
        $ruta = str_replace('@recurso', "api/$recurso", $patron);
        $f3->route($ruta, "{$controlador}Controller->$metodo");
    }
} 