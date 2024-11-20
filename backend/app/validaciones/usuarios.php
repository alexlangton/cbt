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
        'unico:usuarios'  // Para asegurar que el email sea único en la tabla
    ],
    'pass' => [
        'requerido',
        'string',
        'min:8',         // Mínimo 8 caracteres para seguridad
        'max:255'
    ],
    'token' => [
        'opcional',
        'string',
        'max:255'
    ],
    'ultimo_inicio_sesion' => [
        'opcional',
        'datetime'
    ]
];