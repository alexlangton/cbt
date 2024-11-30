<script setup>
import MarcadorParking from '@/components/marcadores/MarcadorParking.vue';
import { useIconUrl } from '@/composables/useIconUrl';
import { useMarcadores } from '@/composables/useMarcadores';
import parkingService from '@/services/parkingService';
import { LIcon, LMap, LMarker, LTileLayer } from '@vue-leaflet/vue-leaflet';
import 'leaflet/dist/leaflet.css';
import Button from 'primevue/button';
import Dialog from 'primevue/dialog';
import InputNumber from 'primevue/inputnumber';
import InputText from 'primevue/inputtext';
import ToggleButton from 'primevue/togglebutton';
import { computed, ref, watch } from 'vue';
import { useToast } from 'primevue/usetoast';

const props = defineProps({
    visible: {
        type: Boolean,
        required: true
    },
    marker: {
        type: [Object, null],
        default: null,
        required: false
    },
    parkingData: {
        type: Object,
        default: () => ({
            id: null,
            codinsclo: '',
            latitud: null,
            longitud: null,
            nombre: '',
            direccion: '',
            ciudad: '',
            codigo_postal: ''
        })
    },
    esModoEdicion: {
        type: Boolean,
        default: false
    },
    origen: {
        type: String,
        required: true
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
const { centro } = useMarcadores();
const center = ref(centro.value);
const permitirEdicionCoordenadas = ref(false);

const parking = ref({
    id: null,
    codinsclo: '',
    latitud: centro.value[0],
    longitud: centro.value[1],
    nombre: '',
    direccion: '',
    ciudad: '',
    codigo_postal: ''
});

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
    if (newMarker && newMarker.type === 'parking') {
        parking.value = {
            id: newMarker.id,
            codinsclo: newMarker.codinsclo,
            latitud: newMarker.lat,
            longitud: newMarker.lng,
            nombre: newMarker.nombre,
            direccion: newMarker.direccion,
            ciudad: newMarker.ciudad,
            codigo_postal: newMarker.codigo_postal
        };
    } else if (!newMarker) {
        parking.value = {
            id: null,
            codinsclo: '',
            latitud: centro.value[0],
            longitud: centro.value[1],
            nombre: '',
            direccion: '',
            ciudad: '',
            codigo_postal: ''
        };
    }
}, { immediate: true });

watch(() => props.parkingData, (newParking) => {
    if (newParking) {
        parking.value = { ...newParking };
    } else {
        parking.value.latitud = centro.value[0];
        parking.value.longitud = centro.value[1];
    }
}, { immediate: true });

watch(
    [() => parking.value.latitud, () => parking.value.longitud],
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
    [() => props.parkingData, () => dialogVisible.value],
    ([newParking, newVisible]) => {
        if (newParking || !newVisible) {
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
        parking.value = {
            id: null,
            codinsclo: '',
            latitud: centro.value[0],
            longitud: centro.value[1],
            nombre: '',
            direccion: '',
            ciudad: '',
            codigo_postal: ''
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

const guardarParking = async () => {
    submitted.value = true;

    if (!validarParking(parking.value)) {
        return;
    }

    try {
        const resultado = await parkingService.guardarParking(
            parking.value,
            !props.esModoEdicion
        );

        if (resultado) {
            toast.add({
                severity: 'success',
                summary: 'Éxito',
                detail: `Parking ${props.esModoEdicion ? 'actualizado' : 'creado'} correctamente`,
                life: 3000
            });

            emit('guardadoExitoso', {
                origen: props.origen,
                parking: resultado
            });
            cerrarDialog();
            emit('recargarDatos');
        }
    } catch (error) {
        manejarError(error, 'Error al guardar parking');
    }
};

const validarParking = (parking) => {
    try {
        const camposRequeridos = {
            codinsclo: 'El código de instalación es obligatorio',
            nombre: 'El nombre es obligatorio',
            direccion: 'La dirección es obligatoria',
            latitud: 'La latitud es obligatoria',
            longitud: 'La longitud es obligatoria'
        };

        for (const [campo, mensaje] of Object.entries(camposRequeridos)) {
            if (!parking[campo]) {
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
        manejarError(error, 'Error en la validación del parking');
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
        parking.value.latitud = Number(lat.toFixed(7));
        parking.value.longitud = Number(lng.toFixed(7));
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
</script>

<template>
    <Dialog :visible="visible" :style="{ width: '1000px' }" :modal="true" class="p-fluid parking-dialog"
        @update:visible="handleVisibleChange">
        <!-- Header -->
        <template #header>
            <div class="flex align-items-center gap-2">
                <img :src="obtenerUrlDeIcono('parking')" alt="Icono parking" class="w-5 h-5" />
                <span class="text-lg font-medium">
                    {{ origen === 'mapa' ? 'Ver parking' : esModoEdicion ? 'Editar parking' : 'Nuevo parking' }}
                </span>
            </div>
        </template>

        <!-- Contenedor principal -->
        <div class="flex gap-3">
            <!-- Columna izquierda: Formulario -->
            <div class="w-8/12">
                <div class="card flex flex-col gap-4">
                    <!-- Código -->
                    <div class="flex flex-wrap gap-2">
                        <label for="codinsclo">Código de instalación [Cloud]</label>
                        <InputText id="codinsclo" v-model="parking.codinsclo" v-keyfilter.int
                            :class="{ 'p-invalid': submitted && !parking.codinsclo }" :disabled="esModoEdicion" />
                    </div>

                    <!-- Nombre -->
                    <div class="flex flex-wrap gap-2">
                        <label for="nombre">Nombre</label>
                        <InputText id="nombre" v-model.trim="parking.nombre"
                            :class="{ 'p-invalid': submitted && !parking.nombre }" />
                    </div>

                    <!-- Dirección -->
                    <div class="flex flex-wrap gap-2">
                        <label for="direccion">Dirección</label>
                        <InputText id="direccion" v-model.trim="parking.direccion"
                            :class="{ 'p-invalid': submitted && !parking.direccion }" />
                    </div>

                    <!-- Ciudad y CP -->
                    <div class="flex flex-col md:flex-row gap-4">
                        <div class="flex flex-wrap gap-2 w-8/12">
                            <label for="ciudad">Ciudad</label>
                            <InputText id="ciudad" v-model.trim="parking.ciudad" />
                        </div>
                        <div class="flex flex-wrap gap-2 w-4/12">
                            <label for="codigo_postal">C.P.</label>
                            <InputText id="codigo_postal" v-model.trim="parking.codigo_postal" />
                        </div>
                    </div>

                    <!-- Coordenadas con Toggle -->
                    <div class="flex flex-col gap-2">
                        <div class="flex justify-between items-center mb-2">
                            <label>Coordenadas</label>
                            <ToggleButton v-if="esModoEdicion" v-model="permitirEdicionCoordenadas" class="p-button-sm"
                                onLabel="Editable" offLabel="Bloqueado" onIcon="pi pi-lock-open" offIcon="pi pi-lock" />
                        </div>
                        <div class="flex gap-4">
                            <div class="flex flex-wrap gap-2 w-6/12">
                                <label for="latitud">Latitud</label>
                                <InputNumber id="latitud" v-model="parking.latitud" :minFractionDigits="7"
                                    :maxFractionDigits="7" :disabled="esModoEdicion && !permitirEdicionCoordenadas"
                                    :class="{ 'p-invalid': submitted && !parking.latitud }" />
                            </div>
                            <div class="flex flex-wrap gap-2 w-6/12">
                                <label for="longitud">Longitud</label>
                                <InputNumber id="longitud" v-model="parking.longitud" :minFractionDigits="7"
                                    :maxFractionDigits="7" :disabled="esModoEdicion && !permitirEdicionCoordenadas"
                                    :class="{ 'p-invalid': submitted && !parking.longitud }" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Columna derecha: Mapa -->
            <div class="w-4/12">

                <div class="mapa-container">
                    <l-map ref="dialogMapRef" v-model:zoom="zoom" v-model:center="center" :useGlobalLeaflet="false"
                        class="mapa-rectangular" :options="{
                            attributionControl: false,
                            zoomControl: true,
                            boxZoom: false,
                            keyboard: false,
                            tap: false
                        }" tabindex="-1" :class="{ 'cursor-crosshair': permitirEdicionPosicion }"
                        @ready="invalidateMapSize" @click="handleMapClick">
                        <l-tile-layer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" :attribution="''" />
                        <l-marker v-if="parking.latitud && parking.longitud"
                            :lat-lng="[parking.latitud, parking.longitud]">
                            <l-icon class-name="custom-icon">
                                <MarcadorParking :marcador="{
                                    ...parking,
                                    lat: parking.latitud,
                                    lng: parking.longitud,
                                    type: 'parking'
                                }" :mostrarOcupacion="false" :mostrarNombre="true"
                                    :esEditable="permitirEdicionPosicion" />
                            </l-icon>
                        </l-marker>
                    </l-map>
                </div>

            </div>
        </div>

        <!-- Footer -->
        <template #footer>
            <div class="flex justify-end gap-3 px-2">
                <Button 
                    label="Cancelar" 
                    icon="pi pi-times" 
                    class="p-button-text hover:bg-gray-100" 
                    :disabled="isLoading"
                    @click="cerrarDialog">
                    <template #icon>
                        <i class="pi pi-times mr-2 text-gray-500"></i>
                    </template>
                </Button>
                
                <Button 
                    label="Guardar" 
                    icon="pi pi-check"
                    class="p-button-primary" 
                    :loading="isLoading"
                    :disabled="isLoading || (submitted && !isFormValid)"
                    @click="guardarParking">
                    <template #icon>
                        <i class="pi pi-check mr-2"></i>
                    </template>
                </Button>
            </div>
        </template>
    </Dialog>
</template>

<style lang="scss" scoped>
/* Estilos del diálogo */
:deep(.parking-dialog) {
    display: flex;
    flex-direction: column;
    height: 90vh;

    .p-dialog-content {
        flex: 1;
        overflow: hidden !important;
        padding: 0.5rem !important;
        background: var(--surface-section);
        display: flex;
        flex-direction: column;
    }

    .p-dialog-header {
        padding: 0.5rem 1rem !important;
        background: var(--surface-section);
        border-bottom: 1px solid var(--surface-border);
    }

    .p-dialog-footer {
        padding: 0.5rem 1rem !important;
        background: var(--surface-section);
        border-top: 1px solid var(--surface-border);
    }
}

/* Contenedor principal */
.flex.gap-3 {
    flex: 1;
    min-height: 0;
    gap: 0.5rem !important;

    > div {
        height: 100%;
        display: flex;
        flex-direction: column;
    }
}

/* Card */
.card {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow: auto;
    background: var(--surface-section);
    padding: 0.75rem !important;
    margin: 0 !important;
    border-radius: var(--border-radius);
    box-shadow: var(--card-shadow);
}

/* Estilos del mapa */
.mapa-container {
    position: relative;
    width: 100%;
    height: calc(100vh - 250px);
    border: 1px solid var(--surface-border);
    border-radius: var(--border-radius);
    overflow: hidden;
}

.mapa-rectangular {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100% !important;
    height: 100% !important;
}

/* Estilos de Leaflet */
:deep {
    .leaflet-container {
        outline: none !important;
        border: none !important;
        background: var(--surface-ground) !important;
    }

    .leaflet-touch .leaflet-container {
        outline: none !important;
        border: none !important;
    }

    .leaflet-control-zoom a {
        background-color: var(--surface-section) !important;
        color: var(--text-color) !important;
        border: 1px solid var(--surface-border) !important;

        &:hover {
            background-color: var(--surface-hover) !important;
        }
    }

    .leaflet-control-attribution {
        display: none !important;
    }

    .leaflet-crosshair {
        cursor: crosshair !important;
    }
}

/* Inputs y controles */
:deep {
    .p-inputtext,
    .p-inputnumber-input {
        background: var(--surface-ground);
        border: 1px solid var(--surface-border);
        transition: background-color 0.2s, border-color 0.2s;
        border-radius: var(--border-radius);
        padding: 0.25rem 0.5rem !important;
        width: 100%;

        &:hover {
            border-color: var(--primary-color);
        }

        &:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 1px var(--primary-color);
        }
    }

    .p-togglebutton.p-button-sm {
        background: var(--surface-section);
        border: 1px solid var(--surface-border);
        font-size: 0.875rem;

        &.p-highlight {
            background: var(--primary-color);
            border-color: var(--primary-color);
        }
    }
}

/* Espaciados */
label {
    margin-bottom: 0.25rem !important;
}

.flex.flex-col.gap-4 {
    gap: 0.5rem !important;
}

:deep(.p-dialog-footer) {
    @apply bg-white border-t border-gray-200;
    padding: 1rem;

    .p-button {
        @apply transition-all duration-200;
        
        &.p-button-text:hover {
            @apply bg-gray-100;
        }
        
        &.p-button-primary {
            @apply shadow-sm;
            
            &:hover {
                @apply shadow-md;
            }
            
            &:disabled {
                @apply opacity-60 cursor-not-allowed;
            }
        }
    }
}
</style>
