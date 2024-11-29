import axios from 'axios';

const BASE_URL = '/api/logs';

const formatearLog = (log) => {
    if (!log) return null;
    
    try {
        return {
            id: log.id,
            fecha: log.fecha,
            tipo: log.tipo,
            contenido: log.contenido,
            metadata: typeof log.metadata === 'string' ? JSON.parse(log.metadata) : log.metadata,
            id_usuario: log.id_usuario
        };
    } catch (error) {
        console.error('Error al formatear log:', error);
        return log;
    }
};

const logService = {
    async cargarLogs(params = {}) {
        try {
            const token = localStorage.getItem('token');
            
            const response = await axios.get(BASE_URL, {
                params,
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            });
            
            return response.data;
        } catch (error) {
            console.error('Error al cargar logs:', error);
            throw error;
        }
    },

    async borrarLogs() {
        console.log('Borrando logs...');
        try {
            const token = localStorage.getItem('token');
            
            const response = await axios.delete(BASE_URL, {
                headers: {
                    'Authorization': `Bearer ${token}`
                }
            });
            
            return response.data;
        } catch (error) {
            console.error('Error al borrar logs:', error);
            throw error;
        }
    }
};

export default logService;