import axios from '@/services/axios';
import { ref, onMounted, onUnmounted } from 'vue';

const API_URL = '/api/datosLeaflet';

export function useMarcadores() {
    const marcadores = ref([]);
    const cargando = ref(false);
    const error = ref(null);
    const centro = ref([40.45394425, -3.481518075]);
    const limites = ref([]);
    const existePollingActivo = ref(false);
    const usuarioEstaInteractuando = ref(false);

    let intervalId = null;
    let timeoutInactividad = null;

    const obtenerMarcadores = async () => {
        if (usuarioEstaInteractuando.value || cargando.value) return;

        try {
            cargando.value = true;
            error.value = null;

            const { data } = await axios.get(API_URL);
            const { datos } = data;

            if (datos?.marcadores) {
                // Procesar carteles
                const cartelesProcesados = (datos.marcadores.carteles || []).map(cartel => ({
                    ...cartel,
                    uniqueId: `cartel_${cartel.id}`
                }));

                // Procesar parkings
                const parkingsProcesados = (datos.marcadores.parkings || []).map(parking => ({
                    ...parking,
                    uniqueId: `parking_${parking.id}`
                }));

                // Combinar todos los marcadores
                marcadores.value = [...cartelesProcesados, ...parkingsProcesados];
                
                centro.value = datos.centro || centro.value;
                limites.value = datos.limites || [];
            } else {
                throw new Error('Estructura de datos inválida');
            }
        } catch (err) {
            console.error('Error al cargar marcadores:', err);
            error.value = 'Error al cargar los marcadores. Por favor, intente más tarde.';
        } finally {
            cargando.value = false;
        }
    };

    const iniciarPolling = (intervalo = 15000) => {
        if (existePollingActivo.value) return;

        existePollingActivo.value = true;
        obtenerMarcadores();

        intervalId = setInterval(() => {
            if (existePollingActivo.value) {
                obtenerMarcadores();
            }
        }, intervalo);
    };

    const detenerPolling = () => {
        existePollingActivo.value = false;
        if (intervalId) {
            clearInterval(intervalId);
            intervalId = null;
        }
    };

    const finalizarInteraccion = () => {
        if (timeoutInactividad) {
            clearTimeout(timeoutInactividad);
        }
        timeoutInactividad = setTimeout(() => {
            const elementoActivo = document.activeElement;
            const estaEditando =
                elementoActivo &&
                (elementoActivo.tagName === 'INPUT' ||
                    elementoActivo.tagName === 'TEXTAREA' ||
                    elementoActivo.tagName === 'SELECT' ||
                    elementoActivo.isContentEditable ||
                    elementoActivo.closest('.p-inputnumber') ||
                    elementoActivo.closest('.p-dropdown') ||
                    elementoActivo.closest('.p-calendar'));

            if (!estaEditando) {
                usuarioEstaInteractuando.value = false;
                if (existePollingActivo.value) {
                    obtenerMarcadores();
                }
            }
        }, 2000);
    };

    onMounted(() => {
        window.addEventListener('focus', finalizarInteraccion);
        window.addEventListener('blur', finalizarInteraccion);
    });

    onUnmounted(() => {
        window.removeEventListener('focus', finalizarInteraccion);
        window.removeEventListener('blur', finalizarInteraccion);
        detenerPolling();
        if (timeoutInactividad) {
            clearTimeout(timeoutInactividad);
        }
    });

    return {
        marcadores,
        cargando,
        error,
        centro,
        limites,
        obtenerMarcadores,
        iniciarPolling,
        detenerPolling
    };
}
