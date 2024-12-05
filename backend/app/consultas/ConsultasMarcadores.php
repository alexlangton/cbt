<?php

class ConsultasMarcadores extends ConsultasSQL {
    protected $logger;

    public function __construct() {
        parent::__construct('marcadores');
        $this->logger = new Logger(\Base::instance());
    }

    public function obtenerPorTipo($tipo = null) {
        try {
            if ($tipo === 'cartel') {
                return $this->obtenerCarteles();
            }

            if ($tipo === 'parking') {
                return $this->obtenerParkings();
            }

            // Si no se especifica tipo, devolver todos
            return $this->obtenerTodos();
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    protected function obtenerCarteles() {
        try {
            $sql = "
                SELECT
                    CAST(c.id AS CHAR) as id,  
                    CAST(c.id AS CHAR) as codinsclo,  
                    'cartel' AS tipo,
                    c.nombre,
                    CAST(c.latitud AS DECIMAL(10, 8)) AS latitud,
                    CAST(c.longitud AS DECIMAL(11, 8)) AS longitud,
                    ct.atributos AS atributos,
                    c.rotativo
                FROM
                    carteles c 
                    LEFT JOIN c_tiposcarteles ct ON (ct.id = c.id_tipocartel)
                WHERE 
                    c.latitud IS NOT NULL 
                    AND c.longitud IS NOT NULL
                ORDER BY c.nombre
            ";

            $this->logQuery($sql);
            $resultado = $this->db->exec($sql);
            
            return $this->respuestaExito($resultado);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function obtenerCartel($id) {
        try {
            $sql = "SELECT * FROM carteles WHERE id = ?";
            $this->logQuery($sql);
            $resultado = $this->db->exec($sql, [$id]);
            
            if (empty($resultado)) {
                $this->logger->warning("No se encontró el cartel con ID: $id");
                return null;
            }
            
            return $resultado[0];
        } catch (\Exception $e) {
            $this->logger->error("Error al obtener el cartel con ID: $id", [
                'exception' => $e->getMessage()
            ]);
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function obtenerAtributosJsonTipoCartel($id) {
        try {
            $sql = "SELECT atributos FROM c_tiposcarteles WHERE id = ?";
            $this->logQuery($sql);
            $resultado = $this->db->exec($sql, [$id]);
            
            if (empty($resultado)) {
                $this->logger->warning("No se encontraron atributos para el tipo de cartel con ID: $id");
                return null;
            }
            
            return $resultado[0]['atributos'];
        } catch (\Exception $e) {
            $this->logger->error("Error al obtener atributos para el tipo de cartel con ID: $id", [
                'exception' => $e->getMessage()
            ]);
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    protected function obtenerParkings() {
        try {
            $sql = "
                SELECT
                    CAST(p.id AS CHAR) as id,  
                    p.codinsclo,  
                    'parking' AS tipo,
                    p.nombre,
                    CAST(p.latitud AS DECIMAL(10, 8)) AS latitud,
                    CAST(p.longitud AS DECIMAL(11, 8)) AS longitud,
                    p.json_counters AS atributos,
                    '' as rotativo
                FROM
                    parkings p
                WHERE 
                    p.latitud IS NOT NULL 
                    AND p.longitud IS NOT NULL
                ORDER BY p.nombre
            ";

            $this->logQuery($sql);
            $resultado = $this->db->exec($sql);
            
            return $this->respuestaExito($resultado);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function obtenerTodos() {
        try {
            $sql = "
                SELECT * FROM (
                    SELECT
                        CAST(c.id AS CHAR) as id,  
                        CAST(c.id AS CHAR) as codinsclo,  
                        'cartel' AS tipo,
                        c.nombre,
                        CAST(c.latitud AS DECIMAL(10, 8)) AS latitud,
                        CAST(c.longitud AS DECIMAL(11, 8)) AS longitud,
                        ct.atributos AS atributos,
                        c.rotativo
                    FROM
                        carteles c 
                        LEFT JOIN c_tiposcarteles ct ON (ct.id = c.id_tipocartel)
                    WHERE 
                        c.latitud IS NOT NULL 
                        AND c.longitud IS NOT NULL
                    
                    UNION ALL
                    
                    SELECT
                        CAST(p.id AS CHAR) as id,  
                        p.codinsclo,  
                        'parking' AS tipo,
                        p.nombre,
                        CAST(p.latitud AS DECIMAL(10, 8)) AS latitud,
                        CAST(p.longitud AS DECIMAL(11, 8)) AS longitud,
                        p.json_counters AS atributos,
                        '' as rotativo
                    FROM
                        parkings p
                    WHERE 
                        p.latitud IS NOT NULL 
                        AND p.longitud IS NOT NULL
                ) AS combined_results
                ORDER BY tipo, nombre
            ";

            $this->logQuery($sql);
            $resultado = $this->db->exec($sql);
            
            return $this->respuestaExito($resultado);
        } catch (\Exception $e) {
            $error = $this->manejarError($e);
            return $this->respuestaError(
                $error['mensaje'],
                $error,
                $error['codigo'] ?? 500
            );
        }
    }

    public function obtenerRegistrosMarcadores() {
        try {
            $tipo = $this->f3->get('PARAMS.tipo') ?? null;
            if ($tipo === 'cartel') {
                return $this->obtenerCarteles()['datos'] ?? [];
            }
            if ($tipo === 'parking') {
                return $this->obtenerParkings()['datos'] ?? [];
            }
            return $this->obtenerTodos()['datos'] ?? [];
        } catch (\Exception $e) {
            $this->logger->error('Error en obtenerRegistrosMarcadores', [
                'error' => $e->getMessage()
            ]);
            return [];
        }
    }
}
