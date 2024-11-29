<?php

return [
    'fecha' => [
        'requerido',
        'datetime'
    ],
    'tipo' => [
        'requerido',
        'string',
        'enum:error,debug,info,sql,validador'
    ],
    'contenido' => [
        'requerido',
        'string',
        'max:65535'  // TEXT
    ],
    'metadata' => [
        'opcional',
        'string',
        'max:65535'  // TEXT
    ],
    'id_usuario' => [
        'opcional',
        'integer',
        'existe:usuarios,id'  // Validar que el usuario existe en la tabla usuarios
    ]
]; 