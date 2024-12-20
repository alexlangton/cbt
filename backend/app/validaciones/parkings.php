<?php

return [
    'codinsclo' => [
        'requerido',
        'entero',
        'min:1'
    ],
    'latitud' => [
        'opcional',
        'numeric',
        'min:-90',
        'max:90'
    ],
    'longitud' => [
        'opcional',
        'numeric',
        'min:-180',
        'max:180'
    ],
    'nombre' => [
        'requerido',
        'string',
        'max:255'
    ],
    'direccion' => [
        'opcional',
        'string',
        'max:255'
    ],
    'ciudad' => [
        'opcional',
        'string'
    ],
    'codigo_postal' => [
        'opcional',
        'string'
    ],
    'json_counters' => [
        'opcional',
        'json'
    ],
    'ultima_actualizacion' => [
        'opcional',
        'fecha'
    ]
];