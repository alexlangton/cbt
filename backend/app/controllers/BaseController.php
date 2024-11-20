<?php

class BaseController extends AutenticacionController {
    protected $tabla;
    protected $consultas;
    protected $logger;

    public function __construct($tabla = null) {
        parent::__construct();
        if ($tabla) {
            $this->tabla = $tabla;
            $this->consultas = new ConsultasSQL($tabla);
            $this->logger->info("BaseController inicializado para tabla: {$tabla}");
        }
    }

    public function obtener($f3, $params) {
        return $this->ejecutarOperacion(function() use ($params) {
            try {
                if (!isset($params['id'])) {
                    $this->logger->info("Solicitando todos los registros de {$this->tabla}");
                    $this->logger->debug("GET: obtenerTodos() llamado para {$this->tabla}");
                    $registros = $this->consultas->obtenerTodos();
                    return $this->respuestaExito($registros);
                }

                $id = $params['id'];
                $this->logger->info("Solicitando registro de {$this->tabla} con ID: {$id}");
                
                $validacionId = $this->validarId($id, $this->tabla);
                if ($validacionId !== true) {
                    $this->logger->error("ID inválido para {$this->tabla}: {$id}");
                    return $validacionId;
                }

                $registro = $this->consultas->obtenerPorId($id);
                if (!$registro) {
                    $this->logger->error("Registro no encontrado en {$this->tabla} con ID: {$id}");
                    return $this->errorRegistroNoEncontrado($id, $this->tabla);
                }

                $this->logger->debug("Registro encontrado: " . json_encode($registro));
                return $this->respuestaExito($registro);
                
            } catch (\PDOException $e) {
                $this->logger->error("Error en base de datos al obtener {$this->tabla}: " . $e->getMessage());
                throw $e;
            }
        }, "Error al obtener {$this->tabla}");
    }

    public function obtenerTodos($f3) {
        return $this->ejecutarOperacion(function() {
            return $this->respuestaExito(
                $this->consultas->obtenerTodos()
            );
        }, 'Error al obtener los registros');
    }

    private function procesarGuardado($datos, $id = null) {
        $operacion = $id ? 'actualización' : 'creación';
        
        // Log de inicio de operación
        $this->logger->info("Iniciando {$operacion} en {$this->tabla}" . ($id ? " con ID: {$id}" : ""));
        
        // Log detallado de datos recibidos
        $this->logger->debug("Datos recibidos para {$operacion}: " . json_encode($datos));

        // Validación
        $validador = new Validador($this->f3);
        $resultado = $validador->validar($this->tabla, $datos, $id !== null);
        $this->logger->debug("Resultado completo de validación: " . json_encode($resultado));

        if (!$resultado['valido']) {
            $this->logger->error("Validación fallida para {$operacion} en {$this->tabla}: " . json_encode($resultado['errores']));
            return $this->respuestaError(
                'Datos inválidos',
                422,
                $resultado['errores']
            );
        }

        $this->logger->info("Validación exitosa para {$operacion} en {$this->tabla}");

        try {
            $this->logger->debug("Datos limpios a procesar: " . json_encode($resultado['datos_limpios']));
            
            $registro = $id ? 
                $this->consultas->actualizar($id, $resultado['datos_limpios']) :
                $this->consultas->insertar($resultado['datos_limpios']);

            if (!$registro) {
                $this->logger->error("Error al ejecutar {$operacion} en {$this->tabla}");
                throw new \Exception("Error al ejecutar {$operacion}");
            }

            $this->logger->info("Operación {$operacion} completada exitosamente en {$this->tabla}");
            $this->logger->debug("Registro resultante: " . json_encode($registro));
            
            return $this->respuestaExito(
                $registro,
                "Registro de {$operacion} realizado correctamente",
                $id ? 200 : 201
            );
        } catch (\Exception $e) {
            $this->logger->error("Error en {$operacion} para {$this->tabla}: " . $e->getMessage());
            $this->logger->debug("Stack trace: " . $e->getTraceAsString());
            return $this->respuestaError($e->getMessage(), 500);
        }
    }

    public function guardarnuevo($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            $this->logger->info("Iniciando creación de nuevo registro en {$this->tabla}");
            
            // Log del body recibido
            $this->logger->debug("Body recibido: " . $f3->get('BODY'));
            
            $resultadoJSON = $this->decodificarJSON($f3->get('BODY'));
            if ($resultadoJSON['error']) {
                $this->logger->error("Error al decodificar JSON para {$this->tabla}: " . json_encode($resultadoJSON['error']));
                return $resultadoJSON['response'];
            }

            $this->logger->debug("Datos JSON decodificados: " . json_encode($resultadoJSON['datos']));
            
            $resultado = $this->procesarGuardado($resultadoJSON['datos']);
            
            if (isset($resultado['error'])) {
                $this->logger->error("Error al procesar guardado en {$this->tabla}: " . json_encode($resultado));
            } else {
                $this->logger->info("Nuevo registro creado exitosamente en {$this->tabla}");
            }
            
            return $resultado;
        }, 'Error al crear el registro');
    }

    public function guardar($f3, $params) {
        return $this->ejecutarOperacion(function() use ($f3, $params) {
            $validacionId = $this->validarId($params['id'] ?? null, $this->tabla);
            if ($validacionId !== true) return $validacionId;

            $resultadoJSON = $this->decodificarJSON($f3->get('BODY'));
            if ($resultadoJSON['error']) {
                return $resultadoJSON['response'];
            }

            $registro = $this->consultas->obtenerPorId($params['id']);
            if (!$registro) {
                return $this->errorRegistroNoEncontrado($params['id'], $this->tabla);
            }

            return $this->procesarGuardado($resultadoJSON['datos'], $params['id']);
        }, 'Error al actualizar el registro');
    }

    public function borrar($f3, $params) {
        return $this->ejecutarOperacion(function() use ($params) {
            $this->logger->debug("Intentando borrar registro en {$this->tabla} con ID: {$params['id']}");
            
            $validacionId = $this->validarId($params['id'] ?? null, $this->tabla);
            if ($validacionId !== true) {
                $this->logger->debug("ID inválido para borrar en {$this->tabla}: {$params['id']}");
                return $validacionId;
            }

            if (!$this->consultas->eliminar($params['id'])) {
                $this->logger->debug("Error al eliminar registro en {$this->tabla} con ID: {$params['id']}");
                return $this->respuestaError('Error al eliminar el registro', 500);
            }

            $this->logger->debug("Registro eliminado exitosamente en {$this->tabla} con ID: {$params['id']}");
            return $this->respuestaExito(null, 'Registro eliminado correctamente');
        }, 'Error al eliminar el registro');
    }

    public function obtenerConFiltros($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            $filtros = array_filter($f3->get('GET'), function($valor) {
                return !empty($valor);
            });
            
            return $this->respuestaExito(
                $this->consultas->buscarConFiltros(
                    $filtros,
                    $f3->get('GET.orden'),
                    $f3->get('GET.limite')
                )
            );
        }, 'Error al obtener los registros');
    }

    public function buscarPorTexto($f3) {
        return $this->ejecutarOperacion(function() use ($f3) {
            $texto = $f3->get('GET.texto');
            if (!$texto) {
                return $this->respuestaError('Texto de búsqueda no proporcionado');
            }
            
            $campos = $f3->get('GET.campos') ? 
                      explode(',', $f3->get('GET.campos')) : 
                      ['nombre'];
            
            return $this->respuestaExito(
                $this->consultas->buscarTexto($campos, $texto)
            );
        }, 'Error en la búsqueda');
    }

    public function obtenerPaginado($f3, $params) {
        return $this->ejecutarOperacion(function() use ($params) {
            $pagina = (int)($params['pagina'] ?? 1);
            $porPagina = (int)($params['por_pagina'] ?? 10);
            
            $resultadoConsulta = $this->consultas->obtenerPaginado($pagina, $porPagina);
            
            // Verificar si hay error en la consulta
            if ($resultadoConsulta['estado'] === 'error') {
                return $this->respuestaError(
                    $resultadoConsulta['mensaje'],
                    $resultadoConsulta['detalles'] ?? null
                );
            }

            // Extraer los datos de paginación
            $datos = $resultadoConsulta['datos'];
            
            return $this->respuestaExito($datos['datos'], null, 200, [
                'paginacion' => [
                    'total' => $datos['total'],
                    'pagina_actual' => $datos['pagina_actual'],
                    'por_pagina' => $datos['por_pagina'],
                    'total_paginas' => $datos['total_paginas']
                ]
            ]);
        }, 'Error al obtener los registros');
    }
} 