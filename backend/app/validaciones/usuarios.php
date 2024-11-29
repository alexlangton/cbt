<?php

return [
    'nombre' => [
        'requerido',
        'string',
        'max:255'
    ],
    'email' => [
        'requerido',
        'string',
        'email',
        'max:255',
        'unico:usuarios' 
    ],
    'pass' => [
        'requerido',
        'string'
    ],
    'token' => [
        'opcional',
        'string'
    ],
    'ultimo_inicio_sesion' => [
        'opcional',
        'datetime'
    ]
];