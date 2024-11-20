import axios from 'axios';
import { onMounted, onUnmounted, ref } from 'vue';

const API_URL = 'http://localhost/api/datosLeaflet';

const marcadores = ref([]);
const cargando = ref(false);
const error = ref(null);
const centro = ref([40.45394425, -3.481518075]);
const limites = ref([]);
const existePollingActivo = ref(false);
const usuarioEstaInteractuando = ref(false);

let intervalId = null;
let timeoutInactividad = null;

export function useMarcadores() {
    const obtenerMarcadores = async () => {
        if (usuarioEstaInteractuando.value || cargando.value) return;

        try {
            cargando.value = true;
            error.value = null;

            const respuesta = await axios.get(API_URL);
            const datos = respuesta.data.datos;

            if (datos?.marcadores) {
                console.log('Datos recibidos:', datos);
                marcadores.value = [...datos.marcadores];
                centro.value = datos.centro || centro.value;
                limites.value = datos.limites || [];
                error.value = null;
            } else {
                throw new Error('Estructura de datos inválida');
            }
        } catch (err) {
            console.error('Error al cargar marcadores:', err);
            error.value =
                'Error al cargar los marcadores. Por favor, intente más tarde.';
        } finally {
            cargando.value = false;
        }
    };

    const iniciarPolling = (intervalo = 5000) => {
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
