import axios from './axios';

const BASE_URL = '/api/parkings';

const formatearParking = (parking) => {
    if (!parking) return null;

    return {
        ...parking,
        id: parking.id ? Number(parking.id) : null,
        codinsclo: parking.codinsclo ? Number(parking.codinsclo) : null,
        latitud: parking.latitud ? Number(parking.latitud) : null,
        longitud: parking.longitud ? Number(parking.longitud) : null,
        nombre: parking.nombre?.trim() || '',
        direccion: parking.direccion?.trim() || null,
        ciudad: parking.ciudad?.trim() || null,
        codigo_postal: parking.codigo_postal?.trim() || null,
        json_counters: parking.json_counters ? JSON.parse(parking.json_counters) : null,
        ultima_actualizacion: parking.ultima_actualizacion || null
    };
};

export const cargarParkings = async () => {
    try {
        const { data } = await axios.get(BASE_URL);
        const parkings = data?.datos?.datos || [];
        return Array.isArray(parkings) ? parkings.map(formatearParking) : [];
    } catch (error) {
        console.error('Error al cargar parkings:', error);
        throw error;
    }
};

export const obtenerParking = async (id) => {
    try {
        console.log(`Obteniendo parking con id ${id}`);    
        const { data } = await axios.get(`${BASE_URL}/${id}`);
        console.log(`Datos obtenidos: ${JSON.stringify(data)}`);
        const parkingData = data?.datos?.datos;
        
        if (!parkingData) {
            throw new Error('No se recibieron datos del parking');
        }

        const parking = Array.isArray(parkingData) ? parkingData[0] : parkingData;
        
        return formatearParking(parking);
    } catch (error) {
        console.error(`Error al obtener parking ${id}:`, error);
        throw error;
    }
};

export const guardarParking = async (parking, esNuevo = false) => {
    try {
        const parkingFormateado = formatearParking(parking);
        if (!parkingFormateado) throw new Error('Datos de parking inválidos');

        const method = esNuevo ? 'post' : 'put';
        const url = esNuevo ? BASE_URL : `${BASE_URL}/${parkingFormateado.id}`;
        
        const { data } = await axios[method](url, parkingFormateado);
        const resultado = data?.datos?.datos;
        return formatearParking(resultado);
    } catch (error) {
        console.error('Error al guardar parking:', error);
        throw error;
    }
};

export const borrarParking = async (id) => {
    if (!id) throw new Error('ID de parking requerido');
    
    try {
        const { data } = await axios.delete(`${BASE_URL}/${id}`);
        return data?.datos || null;
    } catch (error) {
        console.error(`Error al borrar parking con id ${id}:`, error);
        throw error;
    }
};

export const borrarParkingsSeleccionados = async (ids) => {
    if (!Array.isArray(ids) || ids.length === 0) {
        throw new Error('Se requiere un array de IDs válido');
    }

    try {
        const { data } = await axios.delete(BASE_URL, { data: ids });
        return data?.datos || null;
    } catch (error) {
        console.error('Error al borrar parkings seleccionados:', error);
        throw error;
    }
};

export default {
    cargarParkings,
    obtenerParking,
    guardarParking,
    borrarParking,
    borrarParkingsSeleccionados
};
