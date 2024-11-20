import { reactive, watch } from 'vue';

export function useControlesMapa() {
    // Función para cargar el estado desde localStorage
    const cargarEstadoGuardado = () => {
        try {
            const estadoGuardado = localStorage.getItem('dashboardConfig');
            if (estadoGuardado) {
                return JSON.parse(estadoGuardado);
            }
        } catch (error) {
            console.error('Error al cargar configuración:', error);
        }
        return null;
    };

    // Estado reactivo con valores iniciales desde localStorage
    const estado = reactive(
        cargarEstadoGuardado() || {
            showParkings: true,
            showCarteles: true,
            showNombres: true,
            showFondo: true,
            showOcupacion: true,
            showRotativo: false,
            animarRotativo: false
        }
    );

    // Configuración de los controles
    const controlesConfig = [
        {
            id: 'parkings',
            modelValue: () => estado.showParkings,
            label: 'Parkings',
            onChange: (value) => (estado.showParkings = value)
        },
        {
            id: 'carteles',
            modelValue: () => estado.showCarteles,
            label: 'Carteles',
            onChange: (value) => (estado.showCarteles = value)
        },
        {
            id: 'nombres',
            modelValue: () => estado.showNombres,
            label: 'Nombres',
            onChange: (value) => (estado.showNombres = value)
        },
        {
            id: 'fondo',
            modelValue: () => estado.showFondo,
            label: 'Fondo',
            onChange: (value) => (estado.showFondo = value)
        },
        {
            id: 'ocupacion',
            modelValue: () => estado.showOcupacion,
            label: 'Ocupación',
            onChange: (value) => (estado.showOcupacion = value)
        },
        {
            id: 'rotativo',
            modelValue: () => estado.showRotativo,
            label: 'Rotativo',
            onChange: (value) => (estado.showRotativo = value)
        },
        {
            id: 'animar',
            modelValue: () => estado.animarRotativo,
            label: 'Animar Rotativo',
            onChange: (value) => (estado.animarRotativo = value)
        }
    ];

    // Observar cambios y guardar en localStorage
    watch(
        estado,
        (newValue) => {
            localStorage.setItem('dashboardConfig', JSON.stringify(newValue));
        },
        { deep: true }
    );

    return {
        controlesConfig,
        estado
    };
}
