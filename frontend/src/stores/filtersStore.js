// src/stores/filtersStore.js
import {
    convertirRangoALocal,
    convertirRangoAUTC
} from '@/layout/composables/useSharedState';
import { defineStore } from 'pinia';
import { ref } from 'vue';

export const useFiltersStore = defineStore('filters', () => {
    const parkingsSeleccionados = ref([]);
    const pluginsSeleccionados = ref([]);
    const filtraPorFechaDe = ref('Entrada');
    const rangoSeleccionado = ref([]);
    const fechas = ref([]); // Añadir fechas aquí

    const initStateFromLocalStorage = () => {
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
            rangoSeleccionado.value = convertirRangoALocal(
                datosSeleccionados.rangoSeleccionado || []
            );
            fechas.value = datosSeleccionados.fechas || []; // Inicializar fechas desde localStorage
        } else {
            parkingsSeleccionados.value = [];
            pluginsSeleccionados.value = [];
            filtraPorFechaDe.value = 'Entrada';
            rangoSeleccionado.value = [];
            fechas.value = []; // Inicializar como array vacío
        }
    };

    initStateFromLocalStorage();

    // Función para guardar en localStorage
    const guardarEnLocalStorage = () => {
        const datosAGuardar = {
            parkingsSeleccionados: parkingsSeleccionados.value,
            pluginsSeleccionados: pluginsSeleccionados.value,
            filtraPorFechaDe: filtraPorFechaDe.value,
            rangoSeleccionado: convertirRangoAUTC(rangoSeleccionado.value),
            fechas: fechas.value // Asegúrate de guardar las fechas
        };
        localStorage.setItem(
            'datosSeleccionados',
            JSON.stringify(datosAGuardar)
        );
    };

    // Funciones setters
    const setPluginsSeleccionados = (plugins) => {
        pluginsSeleccionados.value = plugins;
        guardarEnLocalStorage();
    };

    const setParkingsSeleccionados = (parkings) => {
        parkingsSeleccionados.value = parkings;
        guardarEnLocalStorage();
    };

    const setFiltraPorFechaDe = (tipo) => {
        filtraPorFechaDe.value = tipo;
        guardarEnLocalStorage();
    };

    const setRangoSeleccionado = (rango) => {
        rangoSeleccionado.value = rango;
        guardarEnLocalStorage();
    };

    const setFechas = (nuevasFechas) => {
        fechas.value = nuevasFechas; // Método para establecer fechas
        guardarEnLocalStorage();
    };

    // Acción para reiniciar los filtros
    const reiniciarFiltros = () => {
        parkingsSeleccionados.value = [];
        pluginsSeleccionados.value = [];
        filtraPorFechaDe.value = 'Entrada';
        rangoSeleccionado.value = [];
        fechas.value = [];
        guardarEnLocalStorage();
    };
    return {
        parkingsSeleccionados,
        pluginsSeleccionados,
        filtraPorFechaDe,
        rangoSeleccionado,
        fechas,
        setParkingsSeleccionados,
        setPluginsSeleccionados,
        setFiltraPorFechaDe,
        setRangoSeleccionado,
        setFechas,
        reiniciarFiltros
    };
});
