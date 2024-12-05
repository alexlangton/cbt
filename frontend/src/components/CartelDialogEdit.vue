<script setup>
import { useIconUrl } from '@/composables/useIconUrl';
import tiposCartelService from '@/services/tiposCartelService';
import cartelService from '@/services/cartelService';
import MarcadorCartel from '@/components/marcadores/MarcadorCartel.vue';
import { LIcon, LMap, LMarker, LTileLayer } from '@vue-leaflet/vue-leaflet';
import 'leaflet/dist/leaflet.css';
import Button from 'primevue/button';
import Dialog from 'primevue/dialog';
import InputNumber from 'primevue/inputnumber';
import InputText from 'primevue/inputtext';
import Textarea from 'primevue/textarea';
import Select from 'primevue/select';
import ToggleButton from 'primevue/togglebutton';
import { computed, ref, watch, onMounted, nextTick } from 'vue';
import { useToast } from 'primevue/usetoast';

const props = defineProps({
    visible: {
        type: Boolean,
        required: true
    },
    marker: {
        type: [Object, null],
        default: null
    },
    cartelData: {
        type: Object,
        default: () => ({
            id: null,
            nombre: '',
            latitud: null,
            longitud: null,
            id_tipocartel: null,
            rotativo: ''
        })
    },
    esModoEdicion: {
        type: Boolean,
        default: false
    },
    origen: {
        type: String,
        default: 'crud'
    }
});

const emit = defineEmits([
    'update:visible',
    'guardar',
    'cerrar',
    'guardadoExitoso',
    'recargarDatos'
]);

const toast = useToast();
const dialogVisible = ref(props.visible);
const dialogMapRef = ref(null);
const submitted = ref(false);
const zoom = ref(16);
const center = ref(props.cartelData.latitud ? [props.cartelData.latitud, props.cartelData.longitud] : [40.4563, -3.4807]);
const permitirEdicionCoordenadas = ref(false);
const isLoading = ref(false);
const isFormValid = computed(() => {
    return cartel.value.nombre && cartel.value.id_tipocartel && cartel.value.latitud && cartel.value.longitud;
});

const cartel = ref({
    id: null,
    nombre: '',
    latitud: props.cartelData.latitud,
    longitud: props.cartelData.longitud,
    id_tipocartel: null,
    rotativo: '',
    atributos: {
        parkings: []
    }
});

const tiposCartel = ref([]);

const permitirEdicionPosicion = computed(() => {
    if (props.esModoEdicion) {
        return permitirEdicionCoordenadas.value;
    }
    return true;
});

watch(() => props.visible, (newValue) => {
    dialogVisible.value = newValue;
});

watch(() => props.marker, (newMarker) => {
    if (newMarker && newMarker.type === 'cartel') {
        console.log('Marker recibido:', newMarker);
        cartel.value = {
            id: newMarker.id,
            nombre: newMarker.name,
            latitud: newMarker.lat,
            longitud: newMarker.lng,
            id_tipocartel: newMarker.id_tipocartel,
            rotativo: newMarker.rotativo,
            atributos: newMarker.atributos || { parkings: [] }
        };
        console.log('Cartel actualizado desde marker:', cartel.value);
        center.value = [newMarker.lat, newMarker.lng];
    }
}, { immediate: true });

// Simplificamos la función de carga
const cargarDatosCartel = async (id) => {
    try {
        return await cartelService.obtenerCartel(id);
    } catch (error) {
        console.error('Error al cargar cartel:', error);
        return null;
    }
};

// Simplificamos el watcher
watch(() => props.cartelData, async (newCartel) => {
    if (newCartel?.id) {
        const cartelCompleto = await cargarDatosCartel(newCartel.id);
        if (cartelCompleto) {
            cartel.value = {
                id: cartelCompleto.id,
                nombre: cartelCompleto.nombre,
                latitud: cartelCompleto.latitud,
                longitud: cartelCompleto.longitud,
                id_tipocartel: cartelCompleto.id_tipocartel,
                rotativo: cartelCompleto.rotativo,
                atributos: cartelCompleto.atributos || { parkings: [] }
            };
        }
    }
}, { immediate: true });

watch(
    [() => cartel.value.latitud, () => cartel.value.longitud],
    ([newLat, newLng]) => {
        if (newLat && newLng) {
            center.value = [newLat, newLng];
        }
    },
    { immediate: true }
);

watch(() => dialogVisible.value, (newValue) => {
    if (newValue) {
        setTimeout(invalidateMapSize, 100);
    }
});

watch(
    [() => props.cartelData, () => dialogVisible.value],
    ([newCartel, newVisible]) => {
        if (newCartel || !newVisible) {
            permitirEdicionCoordenadas.value = false;
        }
    }
);

const manejarError = (error, mensaje) => {
    console.error(mensaje, error);
    toast.add({
        severity: 'error',
        summary: 'Error',
        detail: mensaje,
        life: 3000
    });
};

const cerrarDialog = () => {
    try {
        submitted.value = false;
        cartel.value = {
            id: null,
            nombre: '',
            latitud: props.cartelData.latitud,
            longitud: props.cartelData.longitud,
            id_tipocartel: null,
            rotativo: '',
            atributos: {
                parkings: []
            }
        };
        dialogVisible.value = false;
        emit('update:visible', false);
        emit('cerrar');
    } catch (error) {
        manejarError(error, 'Error al cerrar el diálogo');
    }
};

const handleVisibleChange = (newValue) => {
    try {
        dialogVisible.value = newValue;
        emit('update:visible', newValue);
        if (!newValue) {
            cerrarDialog();
        }
    } catch (error) {
        manejarError(error, 'Error al cambiar visibilidad del diálogo');
    }
};

const guardarCartel = async () => {
    submitted.value = true;

    if (!isFormValid.value) {
        return;
    }

    isLoading.value = true;

    try {
        const cartelData = { ...cartel.value };
        if (!cartelData.id_tipocartel) {
            cartelData.id_tipocartel = null;
        }

        const resultado = await cartelService.guardarCartel(
            cartelData,
            !props.esModoEdicion
        );

        if (resultado) {
            toast.add({
                severity: 'success',
                summary: 'Éxito',
                detail: `Cartel ${props.esModoEdicion ? 'actualizado' : 'creado'} correctamente`,
                life: 3000
            });

            emit('guardadoExitoso', {
                origen: props.origen,
                cartel: resultado
            });
            cerrarDialog();
            emit('recargarDatos');
        }
    } catch (error) {
        manejarError(error, 'Error al guardar cartel');
    } finally {
        isLoading.value = false;
    }
};

const validarCartel = (cartel) => {
    try {
        const camposRequeridos = {
            nombre: 'El nombre es obligatorio',
            id_tipocartel: 'El tipo de cartel es obligatorio',
            latitud: 'La latitud es obligatoria',
            longitud: 'La longitud es obligatoria'
        };

        for (const [campo, mensaje] of Object.entries(camposRequeridos)) {
            if (!cartel[campo]) {
                toast.add({
                    severity: 'error',
                    summary: 'Error de validación',
                    detail: mensaje,
                    life: 3000
                });
                return false;
            }
        }
        return true;
    } catch (error) {
        manejarError(error, 'Error en la validación del cartel');
        return false;
    }
};

const invalidateMapSize = () => {
    if (dialogMapRef.value?.leafletObject) {
        dialogMapRef.value.leafletObject.invalidateSize();
        actualizarCursorMapa(permitirEdicionPosicion.value);
    }
};

const handleMapClick = (event) => {
    if (permitirEdicionPosicion.value) {
        const { lat, lng } = event.latlng;
        cartel.value.latitud = Number(lat.toFixed(7));
        cartel.value.longitud = Number(lng.toFixed(7));
    }
};

const { obtenerUrlDeIcono } = useIconUrl();

const actualizarCursorMapa = (permitirEdicion) => {
    if (dialogMapRef.value?.leafletObject) {
        const map = dialogMapRef.value.leafletObject;
        const container = map.getContainer();

        if (permitirEdicion) {
            container.style.cursor = 'crosshair';
            container.classList.remove('leaflet-grab');
            container.classList.add('leaflet-crosshair');
        } else {
            container.style.cursor = '';
            container.classList.add('leaflet-grab');
            container.classList.remove('leaflet-crosshair');
        }
    }
};

watch(() => permitirEdicionPosicion.value, (newValue) => {
    actualizarCursorMapa(newValue);
});

// Modifica el onMounted para cargar los tipos de cartel
onMounted(async () => {
    try {
        const tipos = await tiposCartelService.cargarTiposCartel();
        console.log('Respuesta del servicio tipos cartel:', {
            datos: tipos,
            tipo: typeof tipos,
            propiedades: tipos.map(t => Object.keys(t)),
            valores: tipos.map(t => Object.entries(t))
        });
        
        tiposCartel.value = tipos.map(tipo => ({
            id: tipo.id,
            descripcion: tipo.descripcion
        }));
        
        console.log('Tipos de cartel procesados:', tiposCartel.value);
    } catch (error) {
        console.error('Error al cargar tipos de cartel:', error);
    }
});

const resetCartel = () => {
    cartel.value = {
        id: null,
        nombre: '',
        latitud: 40.4563,
        longitud: -3.4807,
        id_tipocartel: null,
        rotativo: '',
        atributos: {
            parkings: []
        }
    };
    center.value = [40.4563, -3.4807];
};

const mapRef = ref(null);

// Función mejorada para inicializar el mapa
const initializeMap = async () => {
    try {
        await nextTick();
        if (mapRef.value?.leafletObject) {
            mapRef.value.leafletObject.invalidateSize();

            // Si hay coordenadas del cartel, usarlas como centro
            if (cartel.value.latitud && cartel.value.longitud) {
                center.value = [cartel.value.latitud, cartel.value.longitud];
            }
        }
    } catch (error) {
        console.error('Error inicializando mapa:', error);
    }
};

// Observar cambios en la visibilidad del diálogo
watch(() => dialogVisible.value, async (newValue) => {
    if (newValue) {
        await initializeMap();
    }
});

onMounted(async () => {
    await initializeMap();
});

// Añade un watcher para el id_tipocartel
watch(() => cartel.value.id_tipocartel, (newValue) => {
    console.log('id_tipocartel cambiado a:', newValue);
}, { immediate: true });
</script>

<template>
    <Dialog :visible="visible" :style="{ width: '1200px' }" :modal="true" class="p-fluid cartel-dialog"
        @update:visible="handleVisibleChange">
        <!-- Header -->
        <template #header>
            <div class="flex align-items-center gap-2">
                <img :src="obtenerUrlDeIcono('cartel')" alt="Icono cartel" class="w-5 h-5" />
                <span class="text-lg font-medium">
                    {{ origen === 'mapa' ? 'Ver cartel' : esModoEdicion ? 'Editar cartel' : 'Nuevo cartel' }}
                </span>
            </div>
        </template>

        <!-- Contenedor principal -->
        <div class="flex gap-4">
            <!-- Contenedor del mapa -->
            <div class="w-1/2">
                <div class="map-container">
                    <l-map ref="dialogMapRef" v-model:zoom="zoom" v-model:center="center" :useGlobalLeaflet="false"
                        class="mapa-rectangular" :class="{ 'cursor-crosshair': permitirEdicionPosicion }" tabindex="-1"
                        :options="{
                            attributionControl: false,
                            zoomControl: true,
                            boxZoom: false,
                            keyboard: false,
                            tap: false
                        }" @ready="invalidateMapSize" @click="handleMapClick">
                        <l-tile-layer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" :attribution="''" />
                        <l-marker v-if="cartel.latitud && cartel.longitud" :lat-lng="[cartel.latitud, cartel.longitud]">
                            <l-icon class-name="custom-icon">
                                <MarcadorCartel :marcador="{
                                    ...cartel,
                                    lat: cartel.latitud,
                                    lng: cartel.longitud,
                                    type: 'cartel'
                                }" :mostrarNombre="true" :esEditable="permitirEdicionPosicion" />
                            </l-icon>
                        </l-marker>
                    </l-map>
                </div>
                <div class="flex justify-between items-center mt-3" v-if="esModoEdicion">
                    <label class="font-medium">Edición de coordenadas</label>
                    <ToggleButton v-model="permitirEdicionCoordenadas" class="p-button-sm" onLabel="Editable"
                        offLabel="Bloqueado" onIcon="pi pi-lock-open" offIcon="pi pi-lock" />
                </div>
            </div>

            <!-- Formulario -->
            <div class="w-1/2">
                <div class="card flex flex-col gap-4">
                    <!-- Código -->

                    <div class="flex flex-wrap gap-2">
                        <label for="cartel-nombre">Nombre</label>
                        <InputText id="cartel-nombre" name="nombre" v-model.trim="cartel.nombre"
                            :class="{ 'p-invalid': submitted && !cartel.nombre }" />
                    </div>


                    <label for="cartel-tipocartel">Tipo de Cartel</label>
                    <Select id="cartel-tipocartel" name="id_tipocartel" v-model="cartel.id_tipocartel"
                        :options="tiposCartel" optionLabel="descripcion" optionValue="id"
                        placeholder="Seleccione un tipo de cartel"
                        :class="{ 'p-invalid': submitted && !cartel.id_tipocartel }" />


                    <div class="flex flex-wrap gap-2">
                        <div class="grid">
                            <div class="col-6">
                                <label for="cartel-latitud">Latitud</label>
                                <InputNumber id="cartel-latitud" name="latitud" v-model="cartel.latitud"
                                    :minFractionDigits="7" :maxFractionDigits="7"
                                    :disabled="esModoEdicion && !permitirEdicionCoordenadas"
                                    :class="{ 'p-invalid': submitted && !cartel.latitud }" />
                            </div>
                            <div class="col-6">
                                <label for="cartel-longitud">Longitud</label>
                                <InputNumber id="cartel-longitud" name="longitud" v-model="cartel.longitud"
                                    :minFractionDigits="7" :maxFractionDigits="7"
                                    :disabled="esModoEdicion && !permitirEdicionCoordenadas"
                                    :class="{ 'p-invalid': submitted && !cartel.longitud }" />
                            </div>
                        </div>
                    </div>

                    <div class="flex flex-wrap gap-2">
                        <label for="cartel-rotativo">Texto rotativo</label>
                        <Textarea 
                            id="cartel-rotativo" 
                            :modelValue="cartel.rotativo"
                            @update:modelValue="value => cartel.rotativo = value?.toUpperCase()"
                            rows="3" 
                            autoResize 
                        />
                    </div>
                </div>

            </div>
        </div>

        <!-- Footer -->
        <template #footer>
            <div class="flex justify-end gap-3 px-2">
                <Button label="Cancelar" icon="pi pi-times" class="p-button-text hover:bg-gray-100"
                    :disabled="isLoading" @click="cerrarDialog">
                    <template #icon>
                        <i class="pi pi-times mr-2 text-gray-500"></i>
                    </template>
                </Button>

                <Button label="Guardar" icon="pi pi-check" class="p-button-primary" :loading="isLoading"
                    :disabled="isLoading || (submitted && !isFormValid)" @click="guardarCartel">
                    <template #icon>
                        <i class="pi pi-check mr-2"></i>
                    </template>
                </Button>
            </div>
        </template>
    </Dialog>
</template>
<style lang="scss" scoped>
.formgrid {
    margin-top: 1rem;

    .field {
        margin-bottom: 1.5rem;
    }
}

label {
    font-weight: 500;
    margin-bottom: 0.5rem;
}

.p-inputtext,
.p-inputnumber,
.p-dropdown,
.p-textarea {
    width: 100%;
}

.p-inputtext,
.p-inputnumber,
.p-dropdown,
.p-textarea {
    border-color: var(--surface-border);
    background: var(--surface-ground);
    color: var(--text-color);
    border-radius: 4px;
    transition: border-color 0.2s;

    &:hover {
        border-color: var(--primary-color);
    }

    &:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 1px var(--primary-color);
    }

    &.p-invalid {
        border-color: var(--red-500);

        &:focus {
            box-shadow: 0 0 0 1px var(--red-500);
        }
    }
}

:deep {
    .p-togglebutton.p-button-sm {
        background: var(--surface-card);
        border: 1px solid var(--surface-border);
        font-size: 0.875rem;
        color: var(--text-color);

        .p-button-icon {
            color: var(--text-color);
        }

        &.p-highlight {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: var(--text-color);

            &:hover {
                background: var(--primary-600);
                border-color: var(--primary-600);
            }

            .p-button-icon {
                color: var(--text-color);
            }
        }

        &:not(.p-highlight) {
            &:hover {
                background: var(--surface-hover);
                border-color: var(--surface-border);
                color: var(--text-color);
            }
        }
    }
}

.map-container {
    position: relative;
    width: 100%;
    padding-top: 100%;
    margin-bottom: 0;

    .mapa-rectangular {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        height: 100% !important;
        width: 100%;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

        &.cursor-crosshair {
            cursor: crosshair !important;

            :deep(.leaflet-container),
            :deep(.leaflet-grab),
            :deep(.leaflet-interactive) {
                cursor: crosshair !important;
            }
        }
    }
}

:deep(.p-dialog-content) {
    padding: 1rem;
    overflow-y: hidden !important;
}

:deep(.p-dialog) {
    max-height: 90vh;
    display: flex;
    flex-direction: column;
}

:deep(.p-dialog-content) {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.flex.gap-4 {
    flex: 1;
    min-height: 0;
}

:deep(.leaflet-container.cursor-crosshair) {
    cursor: crosshair !important;
}
</style>
