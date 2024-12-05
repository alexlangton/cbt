import axios from './axios';

const loginService = {
    async login(email, password) {
        try {
            const response = await axios.post('/api/public/login', {
                email,
                pass: password
            });
            return response;
        } catch (error) {
            console.error('Error en login:', error);
            throw error;
        }
    }
};

export default loginService;
