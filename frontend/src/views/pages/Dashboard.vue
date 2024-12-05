<script setup>
    // Componentes externos
    import {
        LControl,
        LIcon,
        LMap,
        LMarker,
        LTileLayer
    } from '@vue-leaflet/vue-leaflet';
    import 'leaflet/dist/leaflet.css';
    import Button from 'primevue/button';
    import Checkbox from 'primevue/checkbox';

    // Componentes locales
    // import CartelDialogEdit from '@/components/CartelDialogInfo.vue';
    import ParkingDialog from '@/components/ParkingDialog.vue';
    import MarcadorCartel from '@/components/marcadores/MarcadorCartel.vue';
    import MarcadorParking from '@/components/marcadores/MarcadorParking.vue';

    // Composables y servicios
    import { useControlesMapa } from '@/composables/useControlesMapa';
    import { useMapaGeneral } from '@/composables/useMapaGeneral';
    import { useMarcadores } from '@/composables/useMarcadores';
    import { obtenerParking } from '@/services/parkingService';
    import { obtenerCartel } from '@/services/cartelService';
    import { computed, onMounted, onUnmounted, ref, watch } from 'vue';
    import { useToast } from 'primevue/usetoast';    
    import Toast from 'primevue/toast';
    import { useMapStore } from '@/stores/mapStore';
    import { storeToRefs } from 'pinia';

    // Inicialización de servicios
    const {
        marcadores,
        error,
        centro,
        limites,
        obtenerMarcadores,
        iniciarPolling,
        detenerPolling
    } = useMarcadores();

    const {
        mapRef,
        zoom,
        centroMapa,
        limitesMapa,
        invalidateMapSize,
        btnCentrarMapaClick,
        ajustarALimites
    } = useMapaGeneral(centro.value);

    const { controlesConfig, estado } = useControlesMapa();

    // Estados de diálogos
    const showCartelDialog = ref(false);
    const showCartelEditDialog = ref(false);
    const showParkingDialog = ref(false);
    const selectedMarker = ref(null);

    const ajusteInicialRealizado = ref(false);

    // Crear una única instancia del toast al inicio
    const toast = useToast();

    // Obtener el store y hacer reactivo el estado
    const mapStore = useMapStore();
    const { showLegend } = storeToRefs(mapStore);

    // Funciones de manejo de eventos
    const btnMarcadorClick = async (marcador) => {
        if (!marcador || !marcador.type) {
            console.error('Marcador inválido:', marcador);
            return;
        }

        try {
            selectedMarker.value = marcador;

            if (marcador.type === 'cartel') {
                const cartelData = await obtenerCartel(marcador.id);
                if (cartelData) {
                    selectedMarker.value = {
                        ...marcador,
                        ...cartelData,
                        type: 'cartel'                        
                    };
                    showCartelDialog.value = true;
                }
            } else if (marcador.type === 'parking') {
                if (!marcador.codinsclo) {
                    throw new Error('Identificador de parking no válido');
                }

                const parkingData = await obtenerParking(marcador.id);
                if (parkingData) {
                    selectedMarker.value = {
                        ...marcador,
                        ...parkingData,
                        type: 'parking',
                        codinsclo: marcador.codinsclo
                    };
                    showParkingDialog.value = true;
                }
            }
        } catch (error) {
            console.error('Error al procesar marcador:', error);
            toast.add({
                severity: 'error',
                summary: 'Error',
                detail: error.message || 'Error al cargar datos',
                life: 3000
            });
        }
    };

    // Computed properties
    const marcadoresFiltrados = computed(() => {
        return marcadores.value.filter((marcador) => {
            if (marcador.type === 'parking') {
                return estado.showParkings;
            } else if (marcador.type === 'cartel') {
                return estado.showCarteles;
            }
            return false;
        });
    });

    const onParkingGuardado = async () => {
        try {
            showParkingDialog.value = false;
            await obtenerMarcadores();
            selectedMarker.value = null;
        } catch (error) {
            console.error('Error al actualizar marcadores:', error);
        }
    };

    // Realizar el ajuste inicial una sola vez cuando el mapa esté listo
    const onMapReady = () => {
        invalidateMapSize();
        if (!ajusteInicialRealizado.value && limites.value?.length === 2) {
            ajustarALimites(limites.value);
            ajusteInicialRealizado.value = true;
        }
    };

    // Inicialización y limpieza combinada
    const INTERVALO_SONDEO = 5000; // Extraer el intervalo como constante

    onMounted(async () => {
        iniciarPolling(INTERVALO_SONDEO);

        const limpiarEventos = configurarEventos();
        onUnmounted(limpiarEventos);
    });

    const configurarEventos = () => {
        const iniciarSondeo = () => iniciarPolling(INTERVALO_SONDEO);

        window.addEventListener('blur', detenerPolling);
        window.addEventListener('focus', iniciarSondeo);

        return () => {
            detenerPolling();
            window.removeEventListener('blur', detenerPolling);
            window.removeEventListener('focus', iniciarSondeo);
        };
    };

    const cerrarDialogos = () => {
        showCartelDialog.value = false;
        showCartelEditDialog.value = false;
        showParkingDialog.value = false;
        selectedMarker.value = null;
    };

    const onCartelGuardado = async (cartelActualizado) => {
        try {
            if (selectedMarker.value) {
                selectedMarker.value = {
                    ...selectedMarker.value,
                    name: cartelActualizado.nombre,
                    rotativo: cartelActualizado.rotativo,
                    id_tipocartel: cartelActualizado.id_tipocartel
                };
            }
            
            await obtenerMarcadores();            
            
        } catch (error) {
            console.error('Error al actualizar cartel:', error);
            toast.add({
                severity: 'error',
                summary: 'Error',
                detail: error.message || 'No se pudo actualizar el cartel',
                life: 3000
            });
        }
    };

    // En el componente que contiene la leyenda
    watch(showLegend, (newValue) => {
        console.log('Estado de la leyenda cambiado a:', newValue);
    });

    // Función para manejar la edición del cartel
    const handleEditarCartel = (cartel) => {
        selectedMarker.value = cartel;
        showCartelDialog.value = false;
        showCartelEditDialog.value = true;
    };
</script>

<template>
    <Toast />
    <div class="card">
        <l-map
            :useGlobalLeaflet="false"
            ref="mapRef"
            v-model:zoom="zoom"
            v-model:center="centroMapa"
            class="mapa-leaflet"
            @ready="onMapReady"
        >
            <l-tile-layer
                url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                layer-type="base"
                name="OpenStreetMap"
            />

            <!-- Control personalizado para los checkboxes -->
            <l-control position="topright" v-show="showLegend">
                <div
                    class="leaflet-control leaflet-bar map-controls surface-card p-2"
                >
                    <div class="flex flex-col gap-1">
                        <div
                            class="control-checkbox"
                            v-for="control in controlesConfig"
                            :key="control.id"
                        >
                            <Checkbox
                                :model-value="control.modelValue()"
                                @update:model-value="control.onChange"
                                :inputId="control.id"
                                binary
                            />
                            <label :for="control.id" class="text-color">
                                {{ control.label }}
                            </label>
                        </div>
                    </div>
                </div>
            </l-control>

            <!-- Control para el botón de centrado -->
            <l-control position="bottomleft">
                <div
                    class="leaflet-control leaflet-bar map-controls surface-card"
                >
                    <Button
                        @click="btnCentrarMapaClick"
                        class="p-button-sm"
                        label="Centrar Mapa"
                    />
                </div>
            </l-control>

            <!-- Resto de los componentes del mapa -->
            <l-marker
                v-for="marcador in marcadoresFiltrados"
                :key="marcador.uniqueId"
                :lat-lng="[marcador.lat, marcador.lng]"
                @click="btnMarcadorClick(marcador)"
            >
                <l-icon class-name="custom-icon">
                    <div class="marker-content">
                        <div
                            :class="`marker-tooltip${estado.showFondo ? '-fondo' : ''}`"
                        >
                            <MarcadorParking
                                v-if="marcador.type === 'parking'"
                                :marcador="marcador"
                                :mostrarOcupacion="estado.showOcupacion"
                                :mostrarNombre="estado.showNombres"
                            />
                            <MarcadorCartel
                                v-else-if="marcador.type === 'cartel'"
                                :marcador="marcador"
                                :mostrarNombre="estado.showNombres"
                                :mostrarRotativo="estado.showRotativo"
                                :animarRotativo="estado.animarRotativo"
                            />
                        </div>
                    </div>
                </l-icon>
            </l-marker>

            <div v-if="error" class="p-message p-message-error">
                {{ error }}
            </div>
        </l-map>

        <ParkingDialog
            v-model:visible="showParkingDialog"
            :marker="selectedMarker"
            :es-modo-edicion="true"
            origen="mapa"
            @guardadoExitoso="onParkingGuardado"
            @update:visible="(val) => {
                if (!val) {
                    selectedMarker = null;
                    showParkingDialog = false;
                }
            }"
        />

        <CartelDialogInfo
            v-model:visible="showCartelDialog"
            :marker="selectedMarker"
            origen="mapa"
            @editarCartel="handleEditarCartel"
            @update:visible="(val) => {
                if (!val) {
                    selectedMarker = null;
                    showCartelDialog = false;
                }
            }"
        />

        <!-- Diálogo de edición del cartel -->
        <CartelDialogEdit
            v-if="showCartelEditDialog"
            v-model:visible="showCartelEditDialog"
            :cartelData="selectedMarker"
            :esModoEdicion="true"
            @guardadoExitoso="onCartelGuardado"
            @cerrar="cerrarDialogos"
        />
    </div>
</template>

<style lang="scss">
    :root {
        --marker-size: 35px;
        --tooltip-padding: 5px;
        --tooltip-font-size: 12px;
        --spacing-sm: 4px;
        --spacing-md: 8px;
        --spacing-lg: 20px;
    }

    /* Estilos de la tarjeta */
    .card {
        border-radius: 8px;
        display: flex;
        flex-direction: column;
        padding: 0;
        min-height: calc(100vh - 9rem);
    }

    /* Estilos del mapa */
    .mapa-leaflet {
        height: calc(100vh - 9rem);
        width: 100%;
    }

    /* Asegurarse que el contenedor del mapa tenga altura */
    :deep(.leaflet-container) {
        height: 100% !important;
        width: 100%;
    }

    /* Ocultar atribución de Leaflet */
    .leaflet-control-attribution {
        display: none !important;
    }

    /* Estilos de marcadores y controles que sí necesitamos */
    .custom-icon {
        background: none !important;
        border: none;
        box-shadow: none !important;
    }

    .marker-content {
        display: flex;
        flex-direction: column;
        align-items: center;
        transform: translate(-50%, -50%);
    }

    /* Estilos de tooltip */
    .marker-tooltip,
    .marker-tooltip-fondo {
        padding: var(--tooltip-padding);
        font-size: var(--tooltip-font-size);
        white-space: nowrap;
        margin-top: var(--spacing-sm);
        background-color: var(--surface-card);
        border: 1px solid var(--surface-border);
        border-radius: 4px;
    }

    .marker-tooltip:not(.marker-tooltip-fondo) {
        background-color: transparent;
        border: none;
    }

    /* Control de animaciones */
    .no-animation * {
        animation-play-state: paused !important;
    }

    /* Estilos para controles del mapa */
    .map-controls {
        border-radius: 4px;
        box-shadow: 0 1px 5px rgba(0, 0, 0, 0.4);
        background-color: white;
    }

    .control-checkbox {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        white-space: nowrap;
        font-size: 12px;
        padding: 2px 0;
    }

    .control-checkbox label {
        cursor: pointer;
        user-select: none;
        color: #000;
    }

    /* Ajuste específico para modo oscuro */
    [data-theme='dark'] .map-controls {
        background-color: white;
    }

    [data-theme='dark'] .control-checkbox label {
        color: #000;
    }

    /* Z-index y visibilidad */
    .leaflet-control {
        z-index: 1000;
    }

    /* Ajustes para el botón de centrado */
    .map-controls .p-button-sm {
        padding: 0.5rem 1rem;
        font-size: 0.875rem;
        white-space: nowrap;
    }

    .mapa-leaflet {
        flex: 1;
        min-height: 0; /* importante para que flex funcione correctamente */
        width: 100%;
    }

    /* Ajustes específicos para Sakai */
    :deep(.layout-main-container) {
        height: 100vh;
        display: flex;
        flex-direction: column;
    }

    :deep(.layout-main) {
        flex: 1;
        min-height: 0;
    }

    .leaflet-control {
        transition: opacity 0.3s ease-in-out;
    }
</style>
