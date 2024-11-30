<?php

class Validador {
    private $errores = [];
    private $datos = [];
    private $reglas = [];
    private $db;
    private $logger;
    private $f3;

    public function __construct($f3) {
        $this->f3 = $f3;
        $this->db = $f3['DB'];
        $this->logger = new Logger($f3);
        
        $this->logger->validador('Inicializando validador', [
            'directorio_logs' => $f3['LOGS'],
            'validaciones_dir' => $f3['VALIDACIONES']
        ]);
        
        $this->cargarReglas($f3);
    }

    private function cargarReglas($f3) {
        $directorio = $f3['VALIDACIONES'];
        $this->logger->validador("Cargando reglas desde directorio: {$directorio}");
        
        if (is_dir($directorio)) {
            foreach (scandir($directorio) as $archivo) {
                if ($archivo != '.' && $archivo != '..') {
                    $tabla = pathinfo($archivo, PATHINFO_FILENAME);
                    $this->reglas[$tabla] = require $directorio . $archivo;
                    $this->logger->validador("Reglas cargadas para tabla: {$tabla}");
                }
            }
            $this->logger->validador("Reglas cargadas exitosamente para " . count($this->reglas) . " tablas");
        } else {
            $this->logger->validador("Directorio de validaciones no encontrado: {$directorio}");
        }
    }

    private function validarCampo($campo, $reglas) {
        $valor = $this->datos[$campo] ?? null;
        
        $this->logger->validador("Validando campo", [
            'campo' => $campo,
            'valor' => $valor,
            'reglas' => $reglas
        ]);
        
        $continuar = true;

        foreach ($reglas as $regla) {
            if (!$continuar) break;
            
            list($nombreRegla, $parametros) = $this->parsearRegla($regla);
            
            $this->logger->validador("Aplicando regla", [
                'campo' => $campo,
                'regla' => $nombreRegla,
                'parametros' => $parametros
            ]);
            
            $continuar = $this->aplicarRegla($nombreRegla, $campo, $valor, $parametros);
        }
    }

    private function parsearRegla($regla) {
        if (strpos($regla, ':') !== false) {
            list($nombreRegla, $parametros) = explode(':', $regla);
            return [$nombreRegla, explode(',', $parametros)];
        }
        return [$regla, []];
    }

    private function aplicarRegla($regla, $campo, $valor, $parametros) {
        $metodo = 'validar' . ucfirst($regla);
        if (method_exists($this, $metodo)) {
            return $this->$metodo($campo, $valor, $parametros);
        }
        return true;
    }

    private function validarRequerido($campo, $valor, $parametros) {
        if ($valor === null || $valor === '') {
            $this->logger->validador("Campo [$campo] requerido no proporcionado", [
                'campo' => $campo,
                'valor' => $valor
            ]);
            $this->errores[$campo][] = "El campo '$campo' es requerido";
        } else {
            $this->logger->validador("Campo requerido validado correctamente", [
                'campo' => $campo,
                'valor' => $valor
            ]);
        }
        return true;
    }

    private function validarOpcional($campo, $valor, $parametros) {
        if ($valor === null || $valor === '') {
            $this->logger->validador("Campo opcional vacío", [
                'campo' => $campo
            ]);
            unset($this->datos[$campo]);
            return false;
        }
        return true;
    }

    private function validarString($campo, $valor, $parametros) {
        if ($valor !== null && !is_string($valor)) {
            $this->logger->validador("Valor no es string", [
                'campo' => $campo,
                'valor' => $valor,
                'tipo_actual' => gettype($valor)
            ]);
            $this->errores[$campo][] = "El campo '$campo' debe ser texto";
        } else {
            $this->logger->validador("Validación string exitosa", [
                'campo' => $campo,
                'valor' => $valor
            ]);
        }
        return true;
    }

    private function validarEntero($campo, $valor, $parametros) {
        if ($valor !== null && !filter_var($valor, FILTER_VALIDATE_INT)) {
            $this->logger->validador("Valor no es entero", [
                'campo' => $campo,
                'valor' => $valor
            ]);
            $this->errores[$campo][] = "El campo '$campo' debe ser un número entero";
        } else {
            $this->logger->validador("Validación entero exitosa", [
                'campo' => $campo,
                'valor' => $valor
            ]);
        }
        return true;
    }

    private function validarEnum($campo, $valor, $parametros) {
        if ($valor !== null && !in_array($valor, $parametros)) {
            $this->logger->validador("Valor no permitido en enum", [
                'campo' => $campo,
                'valor' => $valor,
                'valores_permitidos' => $parametros
            ]);
            $this->errores[$campo][] = "El valor '$valor' no es válido para el campo '$campo'. Valores permitidos: " . implode(', ', $parametros);
        } else {
            $this->logger->validador("Validación enum exitosa", [
                'campo' => $campo,
                'valor' => $valor
            ]);
        }
        return true;
    }

    private function validarMax($campo, $valor, $parametros) {
        if ($valor === null) return true;

        $maximo = $parametros[0];
        
        if (is_numeric($valor)) {
            // Validación para números
            if ($valor > $maximo) {
                $this->logger->validador("Valor excede el máximo permitido", [
                    'campo' => $campo,
                    'valor' => $valor,
                    'maximo_permitido' => $maximo
                ]);
                $this->errores[$campo][] = "El campo '$campo' no puede ser mayor a {$maximo}";
            }
        } else {
            // Validación para strings
            if (strlen($valor) > $maximo) {
                $this->logger->validador("Longitud excede el máximo", [
                    'campo' => $campo,
                    'valor' => $valor,
                    'longitud_actual' => strlen($valor),
                    'maximo_permitido' => $maximo
                ]);
                $this->errores[$campo][] = "El campo '$campo' no puede tener más de {$maximo} caracteres";
            }
        }
        
        return true;
    }

    private function validarMin($campo, $valor, $parametros) {
        if ($valor !== null && is_numeric($valor) && $valor < $parametros[0]) {
            $this->logger->validador("Valor menor al mínimo permitido", [
                'campo' => $campo,
                'valor' => $valor,
                'minimo_permitido' => $parametros[0]
            ]);
            $this->errores[$campo][] = "El campo '$campo' debe ser mayor o igual a {$parametros[0]}";
        } else {
            $this->logger->validador("Validación min exitosa", [
                'campo' => $campo,
                'valor' => $valor
            ]);
        }
        return true;
    }

    private function validarFecha($campo, $valor, $parametros) {
        if ($valor !== null) {
            $this->logger->validador("Validando fecha", [
                'campo' => $campo,
                'valor' => $valor,
                'parametros' => $parametros
            ]);

            // Validar ESTRICTAMENTE el formato ISO
            $formatoISOFecha = '/^\d{4}-\d{2}-\d{2}$/';
            $formatoISOFechaHora = '/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/';
            
            if (!preg_match($formatoISOFecha, $valor) && !preg_match($formatoISOFechaHora, $valor)) {
                $this->logger->validador("Formato de fecha inválido", [
                    'campo' => $campo,
                    'valor' => $valor,
                    'formatos_esperados' => ['YYYY-MM-DD', 'YYYY-MM-DD HH:mm:ss']
                ]);
                $this->errores[$campo][] = "El campo '$campo' debe usar formato ISO: YYYY-MM-DD o YYYY-MM-DD HH:mm:ss";
                return true;
            }

            // Si el formato es correcto, validamos que la fecha sea válida
            $fecha = date_parse($valor);
            if ($fecha['error_count'] > 0 || !checkdate($fecha['month'], $fecha['day'], $fecha['year'])) {
                $this->logger->validador("Fecha inválida", [
                    'campo' => $campo,
                    'valor' => $valor,
                    'errores_parse' => $fecha['error_count']
                ]);
                $this->errores[$campo][] = "La fecha proporcionada no es válida";
                return true;
            }

            // Validaciones adicionales (pasado, futuro, etc.)
            try {
                $dateTime = new DateTime($valor);
                $ahora = new DateTime();

                foreach ($parametros as $param) {
                    $this->logger->validador("Validando restricción de fecha", [
                        'campo' => $campo,
                        'restriccion' => $param,
                        'valor' => $valor
                    ]);

                    switch ($param) {
                        case 'pasado':
                            if ($dateTime > $ahora) {
                                $this->logger->validador("Fecha futura no permitida", [
                                    'campo' => $campo,
                                    'valor' => $valor
                                ]);
                                $this->errores[$campo][] = "La fecha no puede ser futura";
                            }
                            break;

                        case 'futuro':
                            if ($dateTime < $ahora) {
                                $this->logger->validador("Fecha pasada no permitida", [
                                    'campo' => $campo,
                                    'valor' => $valor
                                ]);
                                $this->errores[$campo][] = "La fecha no puede ser pasada";
                            }
                            break;

                        case 'hoy_o_futuro':
                            $hoy = new DateTime('today');
                            if ($dateTime < $hoy) {
                                $this->logger->validador("Fecha anterior a hoy no permitida", [
                                    'campo' => $campo,
                                    'valor' => $valor
                                ]);
                                $this->errores[$campo][] = "La fecha debe ser hoy o futura";
                            }
                            break;
                    }
                }

            } catch (Exception $e) {
                $this->errores[$campo][] = "Error al procesar la fecha";
            }
        }
        return true;
    }

    private function validarHora($campo, $valor, $parametros) {
        if ($valor !== null) {
            if (!preg_match('/^([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$/', $valor)) {
                $this->logger->validador("Formato de hora inválido", [
                    'campo' => $campo,
                    'valor' => $valor,
                    'formato_esperado' => 'HH:MM:SS'
                ]);
                $this->errores[$campo][] = "El campo '$campo' debe ser una hora válida en formato HH:MM:SS";
            } else {
                $this->logger->validador("Validación hora exitosa", [
                    'campo' => $campo,
                    'valor' => $valor
                ]);
            }
        }
        return true;
    }

    private function validarDecimal($campo, $valor, $parametros) {
        if ($valor !== null && !is_numeric($valor)) {
            $this->errores[$campo][] = "El campo '$campo' debe ser un número decimal";
        }
        return true;
    }

    private function validarExiste($campo, $valor, $parametros) {
        if ($valor !== null) {
            $this->logger->validador("Verificando existencia en {$parametros[0]} para ID: {$valor}");
            
            $existe = $this->db->exec('SELECT 1 FROM ' . $parametros[0] . ' WHERE id = ?', [$valor]);
            
            if (empty($existe)) {
                $this->logger->validador("ID {$valor} no encontrado en tabla {$parametros[0]}");
                $this->errores[$campo][] = "El ID proporcionado en '$campo' no existe en la tabla {$parametros[0]}";
            } else {
                $this->logger->validador("ID {$valor} verificado exitosamente en {$parametros[0]}");
            }
        }
        return true;
    }

    public function setDatos($datos) {
        $this->datos = $datos;
        $this->errores = [];
    }

    public function validar($tabla, $datos = null, $esActualizacion = false) {
        if ($datos !== null) {
            $this->setDatos($datos);
        }

        $this->logger->validador("Iniciando validación", [
            'tabla' => $tabla,
            'es_actualizacion' => $esActualizacion,
            'datos' => $this->datos
        ]);
        
        if (!isset($this->reglas[$tabla])) {
            $this->logger->validador("No hay reglas definidas", [
                'tabla' => $tabla
            ]);
            return false;
        }

        foreach ($this->reglas[$tabla] as $campo => $reglas) {
            // Si es actualización y el campo no está presente en los datos, lo saltamos
            if ($esActualizacion && !array_key_exists($campo, $this->datos)) {
                $this->logger->validador("Campo omitido en actualización", [
                    'tabla' => $tabla,
                    'campo' => $campo
                ]);
                continue;
            }

            $this->logger->validador("Procesando campo", [
                'tabla' => $tabla,
                'campo' => $campo,
                'reglas' => $reglas,
                'es_actualizacion' => $esActualizacion
            ]);
            $this->validarCampo($campo, $reglas);
        }

        $hayErrores = !empty($this->errores);
        
        if ($hayErrores) {
            $this->logger->validador("Validación fallida", [
                'tabla' => $tabla,
                'errores' => $this->errores,
                'es_actualizacion' => $esActualizacion
            ]);
        } else {
            $this->logger->validador("Validación exitosa", [
                'tabla' => $tabla,
                'es_actualizacion' => $esActualizacion
            ]);
        }

        return !$hayErrores;
    }

    /**
     * Obtiene los errores de validación
     * @return array
     */
    public function getErrores() {
        return $this->errores;
    }

    /**
     * Obtiene los datos validados
     * @return array
     */
    public function getDatos() {
        return $this->datos;
    }
} 