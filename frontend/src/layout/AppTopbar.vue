<script setup>
    import { useLayout } from '@/layout/composables/layout';
    import { useFiltersStore } from '@/stores/filtersStore';
    import { useMapStore } from '@/stores/mapStore';
    import { computed, ref, watch } from 'vue'; // Asegúrate de importar ref y computed
    import { useRouter } from 'vue-router';
    import AppConfigurator from './AppConfigurator.vue';
    import LogoPrincipal from '@/components/LogoPrincipal.vue';

    const visibleRight = ref(false);

    const router = useRouter();
    const { onMenuToggle, toggleDarkMode, isDarkTheme } = useLayout();

    // Crear una instancia del store de filtros
    const filtersStore = useFiltersStore();

    const parkingsSeleccionados = computed(
        () => filtersStore.parkingsSeleccionados
    );
    const pluginsSeleccionados = computed(
        () => filtersStore.pluginsSeleccionados
    );
    const rangoSeleccionado = computed(() => filtersStore.rangoSeleccionado);
    const filtraPorFechaDe = computed(() => filtersStore.filtraPorFechaDe);

    // Propiedad computada para verificar si hay valores seleccionados
    const hayValoresSeleccionados = computed(() => {
        const rangoValido =
            Array.isArray(rangoSeleccionado.value) &&
            rangoSeleccionado.value.length === 2 &&
            rangoSeleccionado.value[0] !== null &&
            rangoSeleccionado.value[1] !== null;

        return (
            (parkingsSeleccionados.value &&
                parkingsSeleccionados.value.length > 0) ||
            (pluginsSeleccionados.value &&
                pluginsSeleccionados.value.length > 0) ||
            rangoValido
        );
    });

    watch(rangoSeleccionado, (newVal) => {
        console.log('rangoSeleccionado in AppTopbar.vue changed to:', newVal);
    });

    // Función para enviar datos al backend
    const enviarDatosAlBackend = async () => {
        const preferenciasPanel = JSON.parse(
            localStorage.getItem('preferenciasPanel')
        );
        const datosInicioSesion = JSON.parse(
            localStorage.getItem('datosInicioSesion')
        );

        if (preferenciasPanel && datosInicioSesion) {
            try {
                // Construir la URL dinámica con el email
                const url = `http://localhost/api/usuario/guardarPreferenciasPanel/${encodeURIComponent(datosInicioSesion.email)}`;

                console.log(url);

                // Hacer una solicitud POST al backend
                await axios.put(url, preferenciasPanel, {
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                console.log('Datos enviados con éxito al backend.');
            } catch (error) {
                console.error('Error al enviar datos al backend:', error);
            }
        }
    };

    // Función para redirigir al login de la app después de enviar los datos
    const redirigirALogin = async () => {
        await enviarDatosAlBackend(); // Enviar los datos al backend antes de redirigir
        // Borrar datos del localStorage después de que se envíen con éxito
        localStorage.removeItem('token');
        localStorage.removeItem('datosSeleccionados');
        console.log('Datos eliminados del localStorage');
        router.push('/'); // Redirigir a la ruta de inicio de sesión ('/')
    };

    // Función para formatear las fechas al formato dd/mm/yyyy
    const formatearFechas = (fechas) => {
        return fechas
            .map((fecha) => {
                const date = new Date(fecha); // Convierte a objeto Date
                const day = String(date.getDate()).padStart(2, '0'); // Día
                const month = String(date.getMonth() + 1).padStart(2, '0'); // Mes (0-indexado)
                const year = date.getFullYear(); // Año
                const hours = String(date.getHours()).padStart(2, '0'); // Horas
                const minutes = String(date.getMinutes()).padStart(2, '0'); // Minutos

                // Formato dd/mm/yyyy hh:mm
                return `${day}/${month}/${year} ${hours}:${minutes}`;
            })
            .join(' - '); // Une las fechas con un guion
    };

    // Función para formatear la fecha de filtrado
    const formatearFiltradoFechas = (tipo) => {
        switch (tipo) {
            case 'Salida':
                return 'hora de salida';
            case 'Entrada':
                return 'hora de entrada';
            case 'EntradaYSalida':
                return 'hora de entrada y salida';
            default:
                return 'Tipo no válido';
        }
    };

    // Obtener el store del mapa
    const mapStore = useMapStore();

    // Computed para el estado de la leyenda
    const showLegend = computed(() => mapStore.showLegend);

    // Función para alternar la leyenda
    const toggleLegend = () => {
        mapStore.toggleLegend();
    };
</script>

<template>
    <Drawer
        v-model:visible="visibleRight"
        header="Información"
        position="right"
    >
        <ul style="font-family: 'Lucida Console', Monaco, monospace">
            <li style="margin-bottom: 1em">
                <strong>Parkings seleccionados:</strong>
                <ul style="margin-top: 0.5em">
                    <li
                        v-for="(parking, index) in parkingsSeleccionados"
                        :key="index"
                    >
                        {{ parking.name }} (Código: {{ parking.code }})
                    </li>
                </ul>
            </li>

            <!-- Separador entre Parkings y Plugins -->
            <hr style="border: 1px solid #ccc; margin: 1.5em 0" />

            <li style="margin-bottom: 1em">
                <strong>Plug-ins seleccionados:</strong>
                <ul style="margin-top: 0.5em">
                    <li
                        v-for="(plugin, index) in pluginsSeleccionados"
                        :key="index"
                    >
                        {{ plugin.name }} (Código: {{ plugin.code }})
                    </li>
                </ul>
            </li>

            <!-- Separador entre Plugins y Rango Seleccionado -->
            <hr style="border: 1px solid #ccc; margin: 1.5em 0" />

            <li style="margin-bottom: 1em">
                <strong>Rango Seleccionado:</strong>
                {{ formatearFechas(rangoSeleccionado) }}
            </li>

            <!-- Separador entre Rango Seleccionado y Filtrado -->
            <hr style="border: 1px solid #ccc; margin: 1.5em 0" />

            <li style="margin-bottom: 1em">
                <strong>Filtrado por</strong>
                {{ formatearFiltradoFechas(filtraPorFechaDe) }}
            </li>
        </ul>
    </Drawer>

    <div class="layout-topbar">
        <div class="layout-topbar-logo-container">
            <button
                class="layout-menu-button layout-topbar-action"
                @click="onMenuToggle"
            >
                <i class="pi pi-bars"></i>
            </button>
            <router-link to="/" class="layout-topbar-logo">
                <LogoPrincipal height="30" width="30" />
                <span>V.1.0.0</span>
            </router-link>
        </div>

        <div class="layout-topbar-actions">
            <div class="layout-config-menu">
                <button
                    v-if="hayValoresSeleccionados"
                    type="button"
                    class="layout-topbar-action layout-topbar-action-highlight"
                    @click="visibleRight = true"
                >
                    <i class="pi pi-filter"></i>
                </button>
                <button
                    type="button"
                    class="layout-topbar-action layout-topbar-action-highlight"
                    @click="toggleDarkMode"
                >
                    <i
                        :class="[
                            'pi',
                            {
                                'pi-moon': isDarkTheme,
                                'pi-sun': !isDarkTheme
                            }
                        ]"
                    ></i>
                </button>
                <div class="relative">
                    <button
                        v-styleclass="{
                            selector: '@next',
                            enterFromClass: 'hidden',
                            enterActiveClass: 'animate-scalein',
                            leaveToClass: 'hidden',
                            leaveActiveClass: 'animate-fadeout',
                            hideOnOutsideClick: true
                        }"
                        type="button"
                        class="layout-topbar-action layout-topbar-action-highlight"
                    >
                        <i class="pi pi-palette"></i>
                    </button>
                    <AppConfigurator />
                </div>
                <button
                    type="button"
                    class="layout-topbar-action layout-topbar-action-highlight"
                    @click="toggleLegend"
                    v-tooltip.bottom="showLegend ? 'Ocultar leyenda' : 'Mostrar leyenda'"
                >
                    <i class="pi" :class="{
                        'pi-eye': showLegend,
                        'pi-eye-slash': !showLegend
                    }"></i>
                </button>
            </div>

            <div class="layout-topbar-menu hidden lg:block">
                <div class="layout-topbar-menu-content">
                    <button
                        type="button"
                        class="layout-topbar-action layout-topbar-action-highlight"
                        @click="redirigirALogin"
                    >
                        <i class="pi pi-times"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
