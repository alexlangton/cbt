import axios from './axios';

const BASE_URL = '/api/carteles';

const formatearCartel = (cartel, incluirId = true) => {
    if (!cartel) return null;
    
    const cartelFormateado = {
        nombre: cartel.nombre?.trim() || '',
        latitud: parseFloat(cartel.latitud),
        longitud: parseFloat(cartel.longitud),
        id_tipocartel: parseInt(cartel.id_tipocartel),
        rotativo: cartel.rotativo?.trim() || ''
    };

    if (cartel.id) {
        cartelFormateado.id = cartel.id;
    }
    
    return cartelFormateado;
};

export const cargarCarteles = async () => {
    try {
        const { data } = await axios.get(BASE_URL);
        console.log('Carteles recibidos del servidor:', data);
        const carteles = data.datos?.datos || data.datos || [];
        return Array.isArray(carteles) ? carteles.map(formatearCartel) : [];
    } catch (error) {
        console.error('Error al cargar carteles:', error);
        throw error;
    }
};

export const obtenerCartel = async (id) => {
    try {
        const { data } = await axios.get(`${BASE_URL}/${id}`);
        const cartel = data.datos?.datos || data.datos;
        return formatearCartel(cartel);
    } catch (error) {
        console.error(`Error al obtener cartel ${id}:`, error);
        throw error;
    }
};

export const guardarCartel = async (cartel, esNuevo = false) => {
    try {
        const cartelFormateado = formatearCartel(cartel, !esNuevo);
        if (!cartelFormateado) throw new Error('Datos de cartel inválidos');

        console.log('Enviando cartel:', {
            esNuevo,
            datos: cartelFormateado,
            url: esNuevo ? BASE_URL : `${BASE_URL}/${cartel.id}`
        });

        const method = esNuevo ? 'post' : 'put';
        const url = esNuevo ? BASE_URL : `${BASE_URL}/${cartel.id}`;

        try {
            const { data } = await axios[method](url, cartelFormateado);
            console.log('Respuesta del servidor:', data);
            return formatearCartel(data.datos || data);
        } catch (error) {
            if (error.response) {
                console.error('Error detallado:', {
                    status: error.response.status,
                    headers: error.response.headers,
                    data: error.response.data,
                    config: error.config
                });
                
                const mensaje = error.response.data?.mensaje || 'Error del servidor';
                throw new Error(mensaje);
            } else if (error.request) {
                console.error('No hubo respuesta:', error.request);
                throw new Error('No se pudo conectar con el servidor');
            } else {
                console.error('Error de configuración:', error.message);
                throw error;
            }
        }
    } catch (error) {
        console.error('Error al guardar cartel:', error);
        throw error;
    }
};

export const borrarCartel = async (id) => {
    if (!id) throw new Error('ID de cartel requerido');
    
    try {
        const { data } = await axios.delete(`${BASE_URL}/${id}`);
        return data;
    } catch (error) {
        console.error(`Error al borrar cartel ${id}:`, error);
        throw error;
    }
};

export const borrarCartelesSeleccionados = async (ids) => {
    if (!Array.isArray(ids) || ids.length === 0) {
        throw new Error('Se requiere un array de IDs válido');
    }

    try {
        const { data } = await axios.delete(BASE_URL, { data: ids });
        return data;
    } catch (error) {
        console.error('Error al borrar carteles seleccionados:', error);
        throw error;
    }
};

export default {
    cargarCarteles,
    obtenerCartel,
    guardarCartel,
    borrarCartel,
    borrarCartelesSeleccionados
};
