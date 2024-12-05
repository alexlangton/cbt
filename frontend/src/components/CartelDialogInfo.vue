<script setup>
import { useIconUrl } from '@/composables/useIconUrl';
import MarcadorCartel from '@/components/marcadores/MarcadorCartel.vue';
import { LIcon, LMap, LMarker, LTileLayer } from '@vue-leaflet/vue-leaflet';
import 'leaflet/dist/leaflet.css';
import Button from 'primevue/button';
import Dialog from 'primevue/dialog';
import InputText from 'primevue/inputtext';
import Textarea from 'primevue/textarea';
import { computed, ref, watch } from 'vue';

const props = defineProps({
    visible: {
        type: Boolean,
        required: true
    },
    marker: {
        type: [Object, null],
        default: null
    }
});

const emit = defineEmits(['update:visible', 'cerrar', 'editarCartel']);

const dialogVisible = ref(props.visible);
const dialogMapRef = ref(null);
const zoom = ref(16);
const center = ref([40.4563, -3.4807]);

const cartel = ref({
    id: null,
    nombre: '',
    latitud: null,
    longitud: null,
    rotativo: '',
    atributos: {
        parkings: []
    }
});

// Función para decodificar texto UTF-8 y convertir a mayúsculas
const normalizarTexto = (texto) => {
    try {
        // Primero reemplazamos las secuencias UTF-8 específicas
        const textoLimpio = texto
            .replace(/U00F1/gi, 'ñ')
            .replace(/U00D1/gi, 'Ñ')
            .replace(/U00E1/gi, 'á')
            .replace(/U00E9/gi, 'é')
            .replace(/U00ED/gi, 'í')
            .replace(/U00F3/gi, 'ó')
            .replace(/U00FA/gi, 'ú');
            
        return textoLimpio
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .toUpperCase();
    } catch (error) {
        console.error('Error al decodificar el texto:', error);
        return texto.toUpperCase();
    }
};

// Modificar el computed de parkingsValidos para incluir la normalización
const parkingsValidos = computed(() => {
    return (cartel.value.atributos?.parkings?.filter(parking => 
        parking.name && parking.free !== undefined
    ) || []).map(parking => ({
        ...parking,
        normalizedName: normalizarTexto(parking.name)
    }));
});

watch(() => props.visible, (newValue) => {
    dialogVisible.value = newValue;
});

watch(() => props.marker, (newMarker) => {
    if (newMarker && newMarker.type === 'cartel') {
        cartel.value = {
            id: newMarker.id,
            nombre: newMarker.name,
            latitud: newMarker.lat,
            longitud: newMarker.lng,
            rotativo: newMarker.rotativo,
            atributos: newMarker.atributos || { parkings: [] }
        };
        center.value = [newMarker.lat, newMarker.lng];
    }
}, { immediate: true });

const cerrarDialog = () => {
    dialogVisible.value = false;
    emit('update:visible', false);
    emit('cerrar');
};

const handleVisibleChange = (newValue) => {
    dialogVisible.value = newValue;
    emit('update:visible', newValue);
    if (!newValue) {
        cerrarDialog();
    }
};

const { obtenerUrlDeIcono } = useIconUrl();

const invalidateMapSize = () => {
    if (dialogMapRef.value?.leafletObject) {
        dialogMapRef.value.leafletObject.invalidateSize();
    }
};

const abrirEdicion = () => {
    cerrarDialog();
    emit('editarCartel', cartel.value);
};
</script>

<template>
    <Dialog :visible="visible" :style="{ width: '1200px' }" :modal="true" class="p-fluid cartel-dialog"
        @update:visible="handleVisibleChange">
        <!-- Header -->
        <template #header>
            <div class="flex align-items-center gap-2">
                <img :src="obtenerUrlDeIcono('cartel')" alt="Icono cartel" class="w-5 h-5" />
                <span class="text-lg font-medium">
                    Información del cartel
                </span>
            </div>
        </template>

        <!-- Contenedor principal -->
        <div class="flex gap-4">
            <!-- Contenedor del mapa -->
            <div class="w-1/3">
                <div class="map-container">
                    <l-map ref="dialogMapRef" v-model:zoom="zoom" v-model:center="center" :useGlobalLeaflet="false"
                        class="mapa-rectangular" tabindex="-1"
                        :options="{
                            attributionControl: false,
                            zoomControl: true,
                            boxZoom: false,
                            keyboard: false,
                            tap: false
                        }" @ready="invalidateMapSize">
                        <l-tile-layer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" :attribution="''" />
                        <l-marker v-if="cartel.latitud && cartel.longitud" :lat-lng="[cartel.latitud, cartel.longitud]">
                            <l-icon class-name="custom-icon">
                                <MarcadorCartel :marcador="{
                                    ...cartel,
                                    lat: cartel.latitud,
                                    lng: cartel.longitud,
                                    type: 'cartel'
                                }" :mostrarNombre="true" :esEditable="false" />
                            </l-icon>
                        </l-marker>
                    </l-map>
                </div>
            </div>

            <!-- Contenedor de información -->
            <div class="w-2/3">
                <div class="info-container">
                    <!-- Nombre fuera del card -->
                    <div class="basic-info mb-4">
                        <div class="flex flex-wrap gap-2 mb-4">
                            <label for="cartel-nombre">Nombre</label>
                            <InputText id="cartel-nombre" :modelValue="cartel.nombre" disabled />
                        </div>
                    </div>

                    <!-- Card negro con parkings y texto rotativo -->
                    <div class="card-info bg-black p-4">
                        <!-- Parkings relacionados -->
                        <div class="parkings-container">
                            <div v-if="parkingsValidos.length > 0" class="grid grid-cols-2 gap-4">
                                <div v-for="parking in parkingsValidos" :key="parking.name" class="parking-item">
                                    <img :src="obtenerUrlDeIcono('parking')" alt="Iconoparking" class="parking-icon" />
                                    <span class="parking-name">{{ parking.normalizedName }}</span>
                                    <div class="parking-info">
                                        <span class="parking-spaces text-right font-bold text-2xl text-yellow-300">{{ parking.free }}</span>
                                        <span class="parking-total text-sm text-yellow-400">/{{ parking.total }}</span>
                                    </div>
                                </div>
                            </div>
                            <div v-else class="text-center text-gray-500 py-4">
                                No hay parkings relacionados con este cartel
                            </div>
                        </div>

                        <!-- Texto rotativo con botón de edición -->
                        <div class="rotativo-container mt-4">
                            <div class="flex justify-between items-center mb-2">
                                
                                <Button 
                                    type="button"
                                    icon="pi pi-pencil"
                                    class="p-button-rounded p-button-text p-button-sm"
                                    @click="abrirEdicion"
                                    v-tooltip.top="'Editar cartel'"
                                />
                            </div>
                            <Textarea 
                                id="cartel-rotativo" 
                                :modelValue="cartel.rotativo"
                                disabled                                
                                autoResize 
                                class="rotativo-text"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <template #footer>
            <div class="flex justify-end gap-3 px-2">
                <Button label="Cerrar" icon="pi pi-times" class="p-button-text hover:bg-gray-100"
                    @click="cerrarDialog">
                    <template #icon>
                        <i class="pi pi-times mr-2 text-gray-500"></i>
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

.info-container {
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.parkings-container {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.row {
    display: flex;
    justify-content: space-between;
    gap: 1rem;
}

.parking-item {
    flex: 1;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem;
    background-color: black !important;
    border: 1px solid #333 !important;
}

.parking-icon {
    width: 30px;
    height: 30px;
    object-fit: contain;
    flex-shrink: 0;
}

.parking-name {
    font-weight: 500;
    color: white !important;
    flex: 1;
    min-width: 0;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.parking-info {
    display: flex;
    align-items: baseline;
    gap: 0.25rem;
    flex-shrink: 0;
    min-width: 70px; // Asegura un ancho mínimo para los números
    justify-content: flex-end; // Alinea los números a la derecha
}

.parking-spaces {
    font-weight: 600;
    color: var(--primary-color);
    text-shadow: 0 0 10px rgba(253, 224, 71, 0.5); /* Brillo amarillo */
}

.parking-total {
    color: var(--text-color-secondary);
    text-shadow: 0 0 5px rgba(253, 224, 71, 0.3); /* Brillo más sutil para el total */
}

.rotativo-container {
    margin-top: 1rem;

    .p-button-rounded {
        width: 2rem;
        height: 2rem;
        
        &:hover {
            background: var(--surface-hover);
        }

        .p-button-icon {
            font-size: 1rem;
            color: var(--text-color-secondary);
        }
    }
}

.basic-info {
    .field {
        width: 100%;
        
        label {
            color: var(--text-color);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .p-inputtext:disabled {
            background-color: var(--surface-ground);
            color: var(--text-color);
            border-color: var(--surface-border);
        }
    }
}

.card-info {
    border-radius: 0 !important;
    background-color: black !important;
    border: 1px solid #333 !important;
}

.rotativo-text {
    color: #FFD700 !important;
    background-color: #1a1a1a !important;
    border-color: #333 !important;

    &:disabled {
        color: #FFD700 !important;
        opacity: 1;
    }
}
</style>
