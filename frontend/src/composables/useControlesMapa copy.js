import { ref, watch } from 'vue';

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

    // Estados de visibilidad con valores iniciales desde localStorage
    const estadoInicial = cargarEstadoGuardado() || {
        showParkings: true,
        showCarteles: true,
        showNombres: true,
        showFondo: true,
        showOcupacion: true,
        showRotativo: false,
        animarRotativo: false
    };

    // Referencias reactivas para cada control
    const showParkings = ref(estadoInicial.showParkings);
    const showCarteles = ref(estadoInicial.showCarteles);
    const showNombres = ref(estadoInicial.showNombres);
    const showFondo = ref(estadoInicial.showFondo);
    const showOcupacion = ref(estadoInicial.showOcupacion);
    const showRotativo = ref(estadoInicial.showRotativo);
    const animarRotativo = ref(estadoInicial.animarRotativo);

    // Configuración de los controles
    const controlesConfig = [
        { id: 'parkings', ref: showParkings, label: 'Parkings' },
        { id: 'carteles', ref: showCarteles, label: 'Carteles' },
        { id: 'nombres', ref: showNombres, label: 'Nombres' },
        { id: 'fondo', ref: showFondo, label: 'Fondo' },
        { id: 'ocupacion', ref: showOcupacion, label: 'Ocupación' },
        { id: 'rotativo', ref: showRotativo, label: 'Rotativo' },
        { id: 'animar', ref: animarRotativo, label: 'Animar Rotativo' }
    ];

    // Observar cambios y guardar en localStorage
    watch(
        [
            showParkings,
            showCarteles,
            showNombres,
            showFondo,
            showOcupacion,
            showRotativo,
            animarRotativo
        ],
        () => {
            const configuracion = {
                showParkings: showParkings.value,
                showCarteles: showCarteles.value,
                showNombres: showNombres.value,
                showFondo: showFondo.value,
                showOcupacion: showOcupacion.value,
                showRotativo: showRotativo.value,
                animarRotativo: animarRotativo.value
            };
            localStorage.setItem(
                'dashboardConfig',
                JSON.stringify(configuracion)
            );
        },
        { deep: true }
    );

    return {
        controlesConfig,
        showParkings,
        showCarteles,
        showNombres,
        showFondo,
        showOcupacion,
        showRotativo,
        animarRotativo
    };
}
