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
        
        // Inicializar logger usando la clase Base de F3
        $this->logger = new \Log('validador.log');
        
        $this->logger->write('Inicializando validador', 'INFO');
        $this->cargarReglas($f3);
    }

    // Método helper para los logs
    private function log($mensaje, $nivel = 'DEBUG') {
        $this->logger->write($mensaje, $nivel);
    }

    private function cargarReglas($f3) {
        $directorio = $f3['VALIDACIONES'];
        $this->log("Cargando reglas desde directorio: {$directorio}");
        
        if (is_dir($directorio)) {
            foreach (scandir($directorio) as $archivo) {
                if ($archivo != '.' && $archivo != '..') {
                    $tabla = pathinfo($archivo, PATHINFO_FILENAME);
                    $this->reglas[$tabla] = require $directorio . $archivo;
                    $this->log("Reglas cargadas para tabla: {$tabla}");
                }
            }
            $this->log("Reglas cargadas exitosamente para " . count($this->reglas) . " tablas", 'INFO');
        } else {
            $this->log("Directorio de validaciones no encontrado: {$directorio}", 'ERROR');
        }
    }

    public function validar($tabla, $datos, $esActualizacion = false) {
        $this->log("Iniciando validación para tabla: {$tabla}" . ($esActualizacion ? " (actualización)" : " (inserción)"), 'INFO');
        $this->log("Datos a validar: " . json_encode($datos), 'DEBUG');
        
        $this->errores = [];
        $this->datos = $datos;

        if (!isset($this->reglas[$tabla])) {
            $this->log("No hay reglas definidas para la tabla: {$tabla}", 'ERROR');
            throw new Exception("No hay reglas de validación para la tabla: $tabla");
        }

        $this->validarCamposNoPermitidos($tabla);
        
        if (!$esActualizacion) {
            $this->log("Validando campos requeridos para inserción", 'DEBUG');
            $this->validarCamposRequeridos($tabla);
        } else {
            $this->log("Validando solo campos proporcionados para actualización", 'DEBUG');
            foreach ($this->datos as $campo => $valor) {
                if (isset($this->reglas[$tabla][$campo])) {
                    $this->validarCampo($campo, $this->reglas[$tabla][$campo]);
                }
            }
        }

        $resultado = [
            'valido' => empty($this->errores),
            'errores' => $this->errores,
            'datos_limpios' => $this->datos
        ];

        if ($resultado['valido']) {
            $this->log("Validación exitosa para tabla {$tabla}", 'INFO');
        } else {
            $this->log("Validación fallida para tabla {$tabla}: " . json_encode($this->errores), 'ERROR');
        }

        return $resultado;
    }

    private function validarCamposNoPermitidos($tabla) {
        $this->log("Verificando campos no permitidos para tabla: {$tabla}", 'DEBUG');
        
        foreach ($this->datos as $campo => $valor) {
            // Ignorar el campo 'id' si no está definido como requerido en las reglas
            if ($campo === 'id' && (!isset($this->reglas[$tabla]['id']) || !$this->esRequerido($this->reglas[$tabla]['id']))) {
                $this->log("Campo 'id' ignorado en validación de campos no permitidos", 'DEBUG');
                continue;
            }

            if (!isset($this->reglas[$tabla][$campo])) {
                $this->log("Campo no permitido encontrado: '{$campo}' en tabla {$tabla}", 'ERROR');
                $this->errores['campos_invalidos'][] = "El campo '$campo' no está permitido";
            }
        }
        
        if (empty($this->errores['campos_invalidos'])) {
            $this->log("No se encontraron campos no permitidos");
        }
    }

    // Método auxiliar para verificar si un campo es requerido
    private function esRequerido($reglas) {
        return is_array($reglas) && in_array('requerido', $reglas);
    }

    private function validarCamposRequeridos($tabla) {
        foreach ($this->reglas[$tabla] as $campo => $reglas) {
            $this->validarCampo($campo, $reglas);
        }
    }

    private function validarCampo($campo, $reglas) {
        $valor = $this->datos[$campo] ?? null;
        $this->log("Validando campo '{$campo}' con valor: " . json_encode($valor), 'DEBUG');
        
        $continuar = true;

        foreach ($reglas as $regla) {
            if (!$continuar) break;
            
            list($nombreRegla, $parametros) = $this->parsearRegla($regla);
            $this->log("Aplicando regla '{$nombreRegla}' con parámetros: " . json_encode($parametros), 'DEBUG');
            
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
        $this->log("Validando campo requerido: {$campo}");
        
        if ($valor === null || $valor === '') {
            $this->log("Campo requerido '{$campo}' no proporcionado", 'ERROR');
            $this->errores[$campo][] = "El campo '$campo' es requerido";
        } else {
            $this->log("Campo requerido '{$campo}' validado correctamente");
        }
        return true;
    }

    private function validarOpcional($campo, $valor, $parametros) {
        $this->log("Validando campo opcional: {$campo}");
        
        if ($valor === null || $valor === '') {
            $this->log("Campo opcional '{$campo}' vacío, removiendo del conjunto de datos");
            unset($this->datos[$campo]);
            return false;
        }
        return true;
    }

    private function validarString($campo, $valor, $parametros) {
        if ($valor !== null && !is_string($valor)) {
            $this->errores[$campo][] = "El campo '$campo' debe ser texto";
        }
        return true;
    }

    private function validarEntero($campo, $valor, $parametros) {
        if ($valor !== null && !filter_var($valor, FILTER_VALIDATE_INT)) {
            $this->errores[$campo][] = "El campo '$campo' debe ser un número entero";
        }
        return true;
    }

    private function validarEnum($campo, $valor, $parametros) {
        if ($valor !== null && !in_array($valor, $parametros)) {
            $this->errores[$campo][] = "El valor '$valor' no es válido para el campo '$campo'. Valores permitidos: " . implode(', ', $parametros);
        }
        return true;
    }

    private function validarMax($campo, $valor, $parametros) {
        if ($valor !== null && strlen($valor) > $parametros[0]) {
            $this->errores[$campo][] = "El campo '$campo' no puede tener más de {$parametros[0]} caracteres";
        }
        return true;
    }

    private function validarMin($campo, $valor, $parametros) {
        if ($valor !== null) {
            if (is_numeric($valor) && $valor < $parametros[0]) {
                $this->errores[$campo][] = "El campo '$campo' debe ser mayor o igual a {$parametros[0]}";
            }
        }
        return true;
    }

    private function validarFecha($campo, $valor, $parametros) {
        if ($valor !== null) {
            // Validar ESTRICTAMENTE el formato ISO
            $formatoISOFecha = '/^\d{4}-\d{2}-\d{2}$/';
            $formatoISOFechaHora = '/^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/';
            
            if (!preg_match($formatoISOFecha, $valor) && !preg_match($formatoISOFechaHora, $valor)) {
                $this->errores[$campo][] = "El campo '$campo' debe usar formato ISO: YYYY-MM-DD o YYYY-MM-DD HH:mm:ss";
                return true;
            }

            // Si el formato es correcto, validamos que la fecha sea válida
            $fecha = date_parse($valor);
            if ($fecha['error_count'] > 0 || !checkdate($fecha['month'], $fecha['day'], $fecha['year'])) {
                $this->errores[$campo][] = "La fecha proporcionada no es válida";
                return true;
            }

            // Validaciones adicionales (pasado, futuro, etc.)
            try {
                $dateTime = new DateTime($valor);
                $ahora = new DateTime();

                foreach ($parametros as $param) {
                    switch ($param) {
                        case 'pasado':
                            if ($dateTime > $ahora) {
                                $this->errores[$campo][] = "La fecha no puede ser futura";
                            }
                            break;

                        case 'futuro':
                            if ($dateTime < $ahora) {
                                $this->errores[$campo][] = "La fecha no puede ser pasada";
                            }
                            break;

                        case 'hoy_o_futuro':
                            $hoy = new DateTime('today');
                            if ($dateTime < $hoy) {
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
                $this->errores[$campo][] = "El campo '$campo' debe ser una hora válida en formato HH:MM:SS";
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
            $this->log("Verificando existencia en {$parametros[0]} para ID: {$valor}");
            
            $existe = $this->db->exec('SELECT 1 FROM ' . $parametros[0] . ' WHERE id = ?', [$valor]);
            
            if (empty($existe)) {
                $this->log("ID {$valor} no encontrado en tabla {$parametros[0]}", 'ERROR');
                $this->errores[$campo][] = "El ID proporcionado en '$campo' no existe en la tabla {$parametros[0]}";
            } else {
                $this->log("ID {$valor} verificado exitosamente en {$parametros[0]}");
            }
        }
        return true;
    }
} 