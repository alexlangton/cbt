<script setup>
    import MarcadorParking from '@/components/marcadores/MarcadorParking.vue';
    import { useIconUrl } from '@/composables/useIconUrl';
    import { useMarcadores } from '@/composables/useMarcadores';
    import parkingService from '@/services/parkingService';
    import { LIcon, LMap, LMarker, LTileLayer } from '@vue-leaflet/vue-leaflet';
    import 'leaflet/dist/leaflet.css';
    import Button from 'primevue/button';
    import Dialog from 'primevue/dialog';
    import IftaLabel from 'primevue/iftalabel';
    import InputNumber from 'primevue/inputnumber';
    import InputText from 'primevue/inputtext';
    import ToggleButton from 'primevue/togglebutton';
    import { computed, ref, watch } from 'vue';

    const props = defineProps({
        visible: {
            type: Boolean,
            required: true
        },
        marker: {
            type: Object,
            required: true
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

    const dialogVisible = ref(props.visible);
    const dialogMapRef = ref(null);
    const submitted = ref(false);
    const zoom = ref(16);
    const { centro } = useMarcadores();
    const center = ref(centro.value);

    // Única declaración de parking con coordenadas del centro
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

    // Observar cambios en visible prop
    watch(
        () => props.visible,
        (newValue) => {
            dialogVisible.value = newValue;
        }
    );

    // Observar cambios en el marcador seleccionado
    watch(
        () => props.marker,
        (newMarker) => {
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
            }
        },
        { immediate: true }
    );

    // Modificar el watch para observar parkingData
    watch(
        () => props.parkingData,
        (newParking) => {
            if (newParking) {
                parking.value = { ...newParking };
            } else {
                parking.value.latitud = centro.value[0];
                parking.value.longitud = centro.value[1];
            }
        },
        { immediate: true }
    );

    // Actualizar centro cuando cambian lat/lng
    watch(
        [() => parking.value.latitud, () => parking.value.longitud],
        ([newLat, newLng]) => {
            if (newLat && newLng) {
                center.value = [newLat, newLng];
            }
        },
        { immediate: true }
    );

    // Función para invalidar el tamaño del mapa
    const invalidateMapSize = () => {
        if (dialogMapRef.value?.leafletObject) {
            dialogMapRef.value.leafletObject.invalidateSize();
        }
    };

    // Actualizar mapa cuando el diálogo se abre
    watch(
        () => dialogVisible.value,
        (newValue) => {
            if (newValue) {
                setTimeout(invalidateMapSize, 100);
            }
        }
    );

    // Renombrar la variable para mayor claridad
    const permitirEdicionCoordenadas = ref(false);

    // Resetear el toggle cuando cambia el parking o se cierra el diálogo
    watch(
        [() => props.parkingData, () => dialogVisible.value],
        ([newParking, newVisible]) => {
            if (newParking || !newVisible) {
                permitirEdicionCoordenadas.value = false;
            }
        }
    );

    // Modificar el manejador de click en el mapa
    const handleMapClick = (event) => {
        // Solo permitir actualizar coordenadas si:
        // 1. Viene del CRUD
        // 2. Es nuevo parking O (es edición Y el toggle está activado)
        if (
            props.origen === 'crud' &&
            (!props.esModoEdicion || permitirEdicionCoordenadas.value)
        ) {
            const { lat, lng } = event.latlng;
            parking.value.latitud = Number(lat.toFixed(7));
            parking.value.longitud = Number(lng.toFixed(7));
        }
    };

    // Obtener la función para las URLs de iconos
    const { obtenerUrlDeIcono } = useIconUrl();

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
                emit('guardadoExitoso', {
                    origen: props.origen,
                    parking: resultado
                });
                cerrarDialog();
                emit('recargarDatos');
            }
        } catch (error) {
            console.error('Error al guardar parking:', error);
        }
    };

    const validarParking = (parking) => {
        return !!(parking.codinsclo && 
                  parking.nombre && 
                  parking.direccion && 
                  parking.latitud && 
                  parking.longitud);
    };

    const cerrarDialog = () => {
        submitted.value = false;
        dialogVisible.value = false;
        emit('update:visible', false);
        emit('cerrar');
    };

    const handleVisibleChange = (newValue) => {
        dialogVisible.value = newValue;
        emit('update:visible', newValue);
        if (!newValue) {
            emit('cerrar');
        }
    };

    // Computed para determinar si se permite editar la posición
    const permitirEdicionPosicion = computed(() => {
        return (
            props.origen === 'crud' &&
            (!props.esModoEdicion || permitirEdicionCoordenadas.value)
        );
    });
</script>

<template>
    <Dialog
        :visible="visible"
        :style="{ width: '1200px' }"
        :modal="true"
        class="p-fluid"
        :header="esModoEdicion ? 'Editando parking' : 'Nuevo parking'"
        @update:visible="(val) => $emit('update:visible', val)"
    >
        <!-- Header -->
        <template #header>
            <div class="flex align-items-center gap-2">
                <img :src="obtenerUrlDeIcono('parking')" alt="Icono parking" class="parking-icon" />
                <span class="text-lg font-medium">
                    {{ origen === 'mapa' ? 'Ver parking' : esModoEdicion ? 'Editar parking' : 'Nuevo parking' }}
                </span>
            </div>
        </template>

        <!-- Contenedor principal -->
        <div class="flex gap-3">
            <!-- Columna izquierda: Formulario -->
            <div class="form-column">
                <div class="form-container p-3">
                    <!-- Código -->
                    <div class="form-field">
                        <IftaLabel>
                            <InputText id="codinsclo" 
                                     v-model="parking.codinsclo" 
                                     v-keyfilter.int
                                     :invalid="submitted && !parking.codinsclo"
                                     :disabled="esModoEdicion" />
                            <label>Código*</label>
                        </IftaLabel>
                    </div>

                    <!-- Nombre -->
                    <div class="form-field">
                        <IftaLabel>
                            <InputText id="nombre" 
                                     v-model.trim="parking.nombre"
                             :invalid="submitted && !parking.nombre" />
                            <label>Nombre*</label>
                        </IftaLabel>
                    </div>

                    <!-- Dirección -->
                    <div class="form-field">
                        <IftaLabel>
                            <InputText id="direccion" 
                                     v-model.trim="parking.direccion"
                             :invalid="submitted && !parking.direccion" />
                            <label>Dirección*</label>
                        </IftaLabel>
                    </div>

                    <!-- Ciudad y CP -->
                    <div class="form-field-inline">
                        <div class="field-ciudad">
                            <IftaLabel>
                                <InputText id="ciudad" 
                                         v-model.trim="parking.ciudad" />
                                <label>Ciudad</label>
                            </IftaLabel>
                        </div>
                        <div class="field-cp">
                            <IftaLabel>
                                <InputText id="codigo_postal" 
                                         v-model.trim="parking.codigo_postal" />
                                <label>C.P.</label>
                            </IftaLabel>
                        </div>
                    </div>

                    <!-- Toggle para edición de coordenadas -->
                    <div class="form-field" v-if="esModoEdicion">
                        <div class="flex align-items-center justify-content-between">
                            <small class="text-secondary">
                                <i class="pi pi-info-circle mr-1"></i>
                                Activar para permitir la edición de coordenadas
                            </small>
                            <ToggleButton v-model="permitirEdicionCoordenadas"
                                        class="p-button-sm"
                                        onLabel="Sí"
                                        offLabel="No"
                                        onIcon="pi pi-lock-open"
                                        offIcon="pi pi-lock" />
                        </div>
                    </div>

                    <!-- Latitud y Longitud -->
                    <div class="form-field-inline">
                        <div class="field-lat">
                            <IftaLabel>
                                <InputNumber id="latitud"
                                           v-model="parking.latitud"
                                           :minFractionDigits="7"
                                           :maxFractionDigits="7"
                                           :disabled="esModoEdicion && !permitirEdicionCoordenadas" />
                                <label>Latitud</label>
                            </IftaLabel>
                        </div>
                        <div class="field-lng">
                            <IftaLabel>
                                <InputNumber id="longitud"
                                           v-model="parking.longitud"
                                           :minFractionDigits="7"
                                           :maxFractionDigits="7"
                                           :disabled="esModoEdicion && !permitirEdicionCoordenadas" />
                                <label>Longitud</label>
                            </IftaLabel>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Columna derecha: Mapa cuadrado -->
            <div class="map-column">
                <div class="map-container">
                    <l-map ref="dialogMapRef"
                          v-model:zoom="zoom"
                          v-model:center="center"
                          :useGlobalLeaflet="false"
                          class="dialog-map"
                          :class="{ 'cursor-crosshair': permitirEdicionPosicion }"
                          @ready="invalidateMapSize"
                          @click="handleMapClick">
                        <l-tile-layer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
                        <l-marker v-if="parking.latitud && parking.longitud"
                                :lat-lng="[parking.latitud, parking.longitud]">
                            <l-icon class-name="custom-icon">
                                <MarcadorParking :marcador="{
                                    ...parking,
                                    lat: parking.latitud,
                                    lng: parking.longitud,
                                    type: 'parking'
                                }"
                                :mostrarOcupacion="false"
                                :mostrarNombre="true"
                                :esEditable="permitirEdicionPosicion" />
                            </l-icon>
                        </l-marker>
                    </l-map>
                </div>
            </div>
        </div>

        <!-- Footer simplificado -->
        <template #footer>
            <div class="flex justify-content-end gap-2">
                <Button label="Cerrar" 
                        icon="pi pi-times" 
                        text 
                        @click="cerrarDialog" />
                <Button label="Guardar" 
                        icon="pi pi-check" 
                        @click="guardarParking" />
            </div>
        </template>
    </Dialog>
</template>

<style lang="scss" scoped>
.parking-dialog {
    :deep(.p-dialog-content) {
        padding: 1.5rem;
        height: 600px;
    }
}

// Columnas principales con flex
.flex {
    display: flex;
    width: 100%;  // Asegura que el contenedor flex ocupe todo el ancho
    gap: 1.5rem;
    height: 100%;
}

.form-column {
    flex: 0 0 40%;
    min-width: 400px;
}

.map-column {
    flex: 1;
    position: relative;
}

.map-container {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: var(--surface-card);
    border-radius: var(--border-radius);
    box-shadow: var(--card-shadow);
    overflow: hidden;
}

.dialog-map {
    width: 100%;
    height: 100%;
}

.card-container {
    height: 100%;
    background: var(--surface-card);
    border-radius: var(--border-radius);
    box-shadow: var(--card-shadow);
}

.form-section {
    margin-bottom: 1.5rem;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid var(--surface-border);

    &:last-child {
        margin-bottom: 0;
        padding-bottom: 0;
        border-bottom: none;
    }

    .flex-column {
        display: flex;
        flex-direction: column;
    }
}

.section-title {
    color: var(--primary-color);
    font-size: 0.875rem;
    font-weight: 600;
    margin-bottom: 1rem;
    padding-bottom: 0.25rem;
    border-bottom: 2px solid var(--primary-color);
    display: inline-block;
}

:deep(.p-inputtext),
:deep(.p-inputnumber-input) {
    width: 100%;
    padding: 0.5rem;
    font-size: 0.875rem;
}

.coordinate-hint {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: var(--text-color-secondary);
    font-size: 0.75rem;
    margin-top: 0.5rem;
    padding: 0.5rem;
    background: var(--surface-ground);
    border-radius: var(--border-radius);
}

.parking-icon {
    width: 20px;
    height: 20px;
}

/* Ajustes para inputs más compactos */
:deep(.p-inputtext),
:deep(.p-inputnumber-input) {
    &.p-invalid {
        border-color: var(--red-500);
    }
}

:deep(.p-togglebutton) {
    &.p-button {
        padding: 0.25rem 0.5rem;
        font-size: 0.75rem;
    }
}

:deep(.leaflet-container) {
    width: 100% !important;
    height: 100% !important;
}

.custom-icon {
    background: none !important;
    border: none;
    box-shadow: none !important;
    
    :deep(.marker-content) {
        transform: scale(0.5); // Reducir el tamaño del icono a la mitad
    }
}

// Asegurar que los labels e inputs no se solapen
:deep(.p-float-label) {
    margin-bottom: 1rem;
    
    label {
        background: var(--surface-card);
        padding: 0 0.25rem;
    }
}

.ciudad-cp-container {
    display: flex;
    gap: 1rem;
    width: 50%;  // Ocupa solo el 50% del ancho disponible
    
    :deep(.p-float-label) {
        flex: 1;  // Distribuye el espacio disponible entre los inputs
    }
}

.flex {
    display: flex;
    width: 100%;  // Asegura que el contenedor flex ocupe todo el ancho
    gap: 1rem;

    .w-8 {
        flex: 0 0 75%;  // Ciudad ocupará el 75% del espacio
    }

    .w-4 {
        flex: 0 0 25%;  // C.P. ocupará el 25% del espacio
    }
}

.flex-container {
    width: 100%;
    max-width: 100%;
    
    .flex {
        display: flex;
        gap: 1rem;
        width: 100%;

        .w-8 {
            flex: 0 0 75%;  // Ciudad
        }

        .w-4 {
            flex: 0 0 25%;  // C.P.
        }
    }
}

:deep(.p-inputtext),
:deep(.p-inputnumber-input) {
    width: 100%;
    max-width: 100%;
}

.form-section {
    width: 100%;
    max-width: 100%;
}

.form-container {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;  // Espacio entre todos los elementos del formulario
}

.form-field {
    width: 100%;
}

.form-field-inline {
    display: flex;
    gap: 1rem;
    width: 100%;

    .field-ciudad, .field-lat {
        flex: 3;  // 75% del espacio
    }
    .field-cp, .field-lng {
        flex: 1;  // 25% del espacio
    }
}

:deep(.p-float-label) {
    width: 100%;
    
    label {
        background: var(--surface-card);
        padding: 0 0.25rem;
    }
}

:deep(.p-inputtext),
:deep(.p-inputnumber-input) {
    width: 100%;
}

.coordinate-hint {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: var(--text-color-secondary);
    font-size: 0.75rem;
    padding: 0.5rem;
    background: var(--surface-ground);
    border-radius: var(--border-radius);
}

.text-secondary {
    color: var(--text-color-secondary);
}
</style>
