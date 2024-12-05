import axios from './axios';

const nuevaContraseniaService = {
    async cambiarPassword(email, token, password) {
        try {
            const response = await axios.put('/api/public/cambiarPassword', {
                email,
                token,
                password
            });
            return response;
        } catch (error) {
            console.error('Error en cambiarPassword:', error);
            throw error;
        }
    },

    async enviarEnlaceRecuperacion(email) {
        try {
            const response = await axios.post('/api/public/recuperarPassword', {
                datos: {
                    email: email
                }
            });
            return response;
        } catch (error) {
            console.error('Error en enviarEnlaceRecuperacion:', error);
            throw error;
        }
    }
};

export default nuevaContraseniaService;