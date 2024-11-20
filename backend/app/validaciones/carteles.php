<?php

return [
    'nombre' => [
        'opcional',
        'string',
        'max:50'
    ],
    'latitud' => [
        'opcional',
        'numeric',
        'min:0',
        'max:90'
    ],
    'longitud' => [
        'requerido',
        'numeric',
        'min:-180',
        'max:180'
    ],
    'id_tipocartel' => [
        'requerido',
        'entero',
        'min:1'
    ],
    'rotativo' => [
        'opcional',
        'string'
    ]
];