import { computed, ref } from 'vue';

// Variables reactivas compartidas
const pluginsSeleccionados = ref([]);
const parkingsSeleccionados = ref([]);
const filtraPorFechaDe = ref('Entrada');

const rangoSeleccionado = ref([]);

// Funciones setters
const setPluginsSeleccionados = (plugins) => {
    pluginsSeleccionados.value = plugins;
    guardarEnLocalStorage();
};

const setParkingsSeleccionados = (parkings) => {
    parkingsSeleccionados.value = parkings;
    guardarEnLocalStorage();
};

const setfiltraPorFechaDe = (tipo) => {
    // Setter para filtraPorFechaDe
    filtraPorFechaDe.value = tipo;
    guardarEnLocalStorage(); // Guardar en localStorage al cambiar
};

const setRangoSeleccionado = (rango) => {
    rangoSeleccionado.value = rango;
    guardarEnLocalStorage();
};

// Función para guardar en localStorage
const guardarEnLocalStorage = () => {
    const datosAGuardar = {
        parkingsSeleccionados: parkingsSeleccionados.value,
        pluginsSeleccionados: pluginsSeleccionados.value,
        filtraPorFechaDe: filtraPorFechaDe.value, // Guardar filtraPorFechaDe
        rangoSeleccionado: convertirRangoAUTC(rangoSeleccionado.value) // Convertimos a UTC antes de guardar
    };
    localStorage.setItem('datosSeleccionados', JSON.stringify(datosAGuardar));
};

// Función para convertir el rango de fechas de Local a UTC antes de guardar
export const convertirRangoAUTC = (rango) => {
    return rango.map((fecha) =>
        fecha
            ? new Date(fecha.getTime() - fecha.getTimezoneOffset() * 60000)
            : null
    );
};

// Función para convertir el rango de fechas de UTC a Local al cargar
export const convertirRangoALocal = (rango) => {
    return rango.map((fecha) =>
        fecha
            ? new Date(
                  new Date(fecha).getTime() +
                      new Date(fecha).getTimezoneOffset() * 60000
              )
            : null
    );
};

// Función para cargar desde localStorage
const cargarDesdeLocalStorage = () => {
    const datosSeleccionados = JSON.parse(
        localStorage.getItem('datosSeleccionados')
    );
    if (datosSeleccionados) {
        parkingsSeleccionados.value =
            datosSeleccionados.parkingsSeleccionados || [];
        pluginsSeleccionados.value =
            datosSeleccionados.pluginsSeleccionados || [];
        filtraPorFechaDe.value =
            datosSeleccionados.filtraPorFechaDe || 'Entrada';
        // Convertir el rango de fechas de UTC a local al cargar
        rangoSeleccionado.value = convertirRangoALocal(
            datosSeleccionados.rangoSeleccionado || []
        );
    } else {
        // Inicializar valores si no hay datos
        parkingsSeleccionados.value = [];
        pluginsSeleccionados.value = [];
        filtraPorFechaDe.value = 'Entrada';
        rangoSeleccionado.value = [];
    }
};

cargarDesdeLocalStorage();

export function useSharedState() {
    return {
        parkingsSeleccionados: computed({
            get: () => parkingsSeleccionados.value,
            set: setParkingsSeleccionados
        }),
        pluginsSeleccionados: computed({
            get: () => pluginsSeleccionados.value,
            set: setPluginsSeleccionados
        }),
        filtraPorFechaDe: computed({
            get: () => filtraPorFechaDe.value,
            set: setfiltraPorFechaDe // Usar el setter
        }),
        rangoSeleccionado: computed({
            get: () => rangoSeleccionado.value,
            set: setRangoSeleccionado // Usar el setter
        }),
        setParkingsSeleccionados,
        setPluginsSeleccionados,
        setfiltraPorFechaDe,
        setRangoSeleccionado
    };
}
