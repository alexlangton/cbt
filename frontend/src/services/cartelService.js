import axios from 'axios';

const BASE_URL = 'http://localhost/api/carteles';

const formatearCartel = (cartel) => {
    if (!cartel) return null;
    
    return {
        id: cartel.id,
        nombre: cartel.nombre?.trim() || '',
        latitud: parseFloat(cartel.latitud),
        longitud: parseFloat(cartel.longitud),
        id_tipocartel: parseInt(cartel.id_tipocartel),
        rotativo: cartel.rotativo?.trim() || ''
    };
};

export const cargarCarteles = async () => {
    try {
        const { data: { datos: { datos: carteles } } } = await axios.get(BASE_URL);
        return Array.isArray(carteles) ? carteles.map(formatearCartel) : [];
    } catch (error) {
        console.error('Error al cargar carteles:', error);
        throw error;
    }
};

export const obtenerCartel = async (id) => {
    try {
        const { data: { datos: { datos: cartel } } } = await axios.get(`${BASE_URL}/${id}`);
        return formatearCartel(cartel);
    } catch (error) {
        console.error(`Error al obtener cartel ${id}:`, error);
        throw error;
    }
};

export const guardarCartel = async (cartel, esNuevo = false) => {
    try {
        const cartelFormateado = formatearCartel(cartel);
        if (!cartelFormateado) throw new Error('Datos de cartel inválidos');

        const config = {
            method: esNuevo ? 'post' : 'put',
            url: esNuevo ? BASE_URL : `${BASE_URL}/${cartelFormateado.id}`,
            data: cartelFormateado
        };

        const { data } = await axios(config);
        return formatearCartel(data);
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
