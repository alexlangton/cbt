<?php

return [
    'descripcion' => [
        'requerido',
        'string',
        'max:255'
    ],
    'atributos' => [
        'opcional',
        'string',
        'max:16777215'  // Tamaño máximo de MEDIUMTEXT en bytes
    ]
];