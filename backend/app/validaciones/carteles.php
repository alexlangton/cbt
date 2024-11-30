<?php

return [
    'nombre' => [
        'opcional',
        'string',
        'max:50'
    ],
    'latitud' => [
        'opcional',
        'decimal',
        'min:-90',
        'max:90'
    ],
    'longitud' => [
        'requerido',
        'decimal',
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