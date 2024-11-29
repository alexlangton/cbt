import axios from './axios';

const BASE_URL = '/api/usuarios';

const formatearUsuario = (usuario) => {
    if (!usuario) return null;

    return {
        id: usuario.id ? Number(usuario.id) : null,
        nombre: usuario.nombre?.trim() || '',
        email: usuario.email?.trim() || '',
        ultimo_inicio_sesion: usuario.ultimo_inicio_sesion || null
    };
};

const formatearUsuarioParaEnvio = (usuario, esNuevo = false) => {
    const usuarioFormateado = {
        nombre: usuario.nombre?.trim() || '',
        email: usuario.email?.trim() || '',
    };

    if (!esNuevo && usuario.id) {
        usuarioFormateado.id = Number(usuario.id);
    }

    if (usuario.pass?.trim()) {
        usuarioFormateado.pass = usuario.pass.trim();
    }

    return usuarioFormateado;
};

export const cargarUsuarios = async () => {
    try {
        const { data } = await axios.get(BASE_URL);
        const usuarios = data.datos?.datos || [];
        return Array.isArray(usuarios) ? usuarios.map(formatearUsuario) : [];
    } catch (error) {
        console.error('Error al cargar usuarios:', error);
        throw error;
    }
};

export const obtenerUsuario = async (id) => {
    try {
        const { data } = await axios.get(`${BASE_URL}/${id}`);
        const usuario = data.datos?.datos;
        return formatearUsuario(Array.isArray(usuario) ? usuario[0] : usuario);
    } catch (error) {
        console.error(`Error al obtener usuario ${id}:`, error);
        throw error;
    }
};

export const guardarUsuario = async (usuario, esNuevo = false) => {
    try {
        const method = esNuevo ? 'post' : 'put';
        const url = esNuevo ? BASE_URL : `${BASE_URL}/${usuario.id}`;
        
        const usuarioParaEnviar = formatearUsuarioParaEnvio(usuario, esNuevo);
        
        console.log('Datos a enviar:', usuarioParaEnviar);
        
        const { data } = await axios[method](url, usuarioParaEnviar);
        
        if (!data.datos) {
            throw new Error(data.mensaje || 'Error al procesar la solicitud');
        }
        
        return formatearUsuario(data.datos);
    } catch (error) {
        if (error.response?.status === 422) {
            throw new Error('Datos inválidos: ' + (error.response.data.mensaje || 'Verifica los campos requeridos'));
        }
        console.error('Error al guardar usuario:', error);
        throw error;
    }
};

export const cambiarPassword = async (id, passwordData) => {
    try {
        const { data } = await axios.patch(`${BASE_URL}/${id}/password`, passwordData);
        return data?.datos || null;
    } catch (error) {
        console.error('Error al cambiar contraseña:', error);
        throw error;
    }
};

export const borrarUsuario = async (id) => {
    try {
        const { data } = await axios.delete(`${BASE_URL}/${id}`);
        return data.datos || { message: 'Usuario eliminado correctamente' };
    } catch (error) {
        console.error(`Error al borrar usuario ${id}:`, error);
        throw new Error(error.response?.data?.mensaje || 'Error al borrar usuario');
    }
};

export const borrarUsuariosSeleccionados = async (ids) => {
    try {
        const { data } = await axios.delete(BASE_URL, { data: { ids } });
        return data.datos || { message: 'Usuarios eliminados correctamente' };
    } catch (error) {
        console.error('Error al borrar usuarios seleccionados:', error);
        throw new Error(error.response?.data?.mensaje || 'Error al borrar usuarios');
    }
};

export const recuperarPassword = async (email) => {
    try {
        const response = await axios.post('/api/public/recuperarPassword', {
            datos: {
                email: email
            }
        });
        return response.data;
    } catch (error) {
        if (error.response?.data?.error) {
            throw new Error(error.response.data.error);
        }
        throw error;
    }
};

export default {
    cargarUsuarios,
    obtenerUsuario,
    guardarUsuario,
    cambiarPassword,
    borrarUsuario,
    borrarUsuariosSeleccionados,
    recuperarPassword
};
