import axios from './axios';

const BASE_URL = '/api/tiposcarteles';

const formatearTipoCartel = (tipoCartel) => {
    if (!tipoCartel) return null;

    return {
        ...tipoCartel,
        id: parseInt(tipoCartel.id),
        descripcion: tipoCartel.descripcion?.trim() || '',
        atributos: tipoCartel.atributos?.trim() || null
    };
};

export const cargarTiposCartel = async () => {
    try {
        const { data } = await axios.get(BASE_URL);
        const tiposCartel = data.datos?.datos || data.datos || [];        
        return Array.isArray(tiposCartel) ? tiposCartel.map(formatearTipoCartel) : [];
    } catch (error) {
        console.error('Error al cargar tipos de cartel:', error);
        throw error;
    }
};

export const obtenerTipoCartel = async (id) => {
    try {
        const { data } = await axios.get(`${BASE_URL}/${id}`);
        const tipoCartel = data.datos?.datos || data.datos;
        return formatearTipoCartel(Array.isArray(tipoCartel) ? tipoCartel[0] : tipoCartel);
    } catch (error) {
        console.error(`Error al obtener tipo de cartel ${id}:`, error);
        throw error;
    }
};

export const guardarTipoCartel = async (tipoCartel, esNuevo = false) => {
    console.log('Datos recibidos para guardar:', tipoCartel);
    console.log('Es nuevo:', esNuevo);
    try {
        const tipoCartelFormateado = formatearTipoCartel(tipoCartel);
        if (!tipoCartelFormateado) throw new Error('Datos de tipo de cartel inválidos');
        console.log('Datos formateados:', tipoCartelFormateado);
        
        const method = esNuevo ? 'post' : 'put';
        const url = esNuevo ? BASE_URL : `${BASE_URL}/${tipoCartelFormateado.id}`;

        const { data } = await axios[method](url, tipoCartelFormateado);
        return formatearTipoCartel(data.datos || data);
    } catch (error) {
        console.error('Error al guardar tipo de cartel:', error);
        throw error;
    }
};

export const borrarTipoCartel = async (id) => {
    if (!id) throw new Error('ID de tipo de cartel requerido');
    
    try {
        const { data } = await axios.delete(`${BASE_URL}/${id}`);
        return data;
    } catch (error) {
        console.error(`Error al borrar tipo de cartel ${id}:`, error);
        throw error;
    }
};

export default {
    cargarTiposCartel,
    obtenerTipoCartel,
    guardarTipoCartel,
    borrarTipoCartel
};
