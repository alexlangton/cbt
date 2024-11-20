<script setup>
    import { useIconUrl } from '@/composables/useIconUrl';
    import parkingService from '@/services/parkingService';
    import Button from 'primevue/button';
    import Dialog from 'primevue/dialog';
    import IftaLabel from 'primevue/iftalabel';
    import InputNumber from 'primevue/inputnumber';
    import InputText from 'primevue/inputtext';
    import { ref, watch } from 'vue';

    const props = defineProps({
        visible: {
            type: Boolean,
            required: true
        },
        marker: {
            type: Object,
            default: null
        },
        parkingData: {
            type: Object,
            default: () => null
        },
        esModoEdicion: {
            type: Boolean,
            default: false
        },
        // Añadir prop para identificar el origen
        origen: {
            type: String,
            default: 'mapa' // 'mapa' o 'crud'
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
    const parking = ref({
        codinsclo: '',
        latitud: null,
        longitud: null,
        nombre: '',
        direccion: '',
        ciudad: '',
        codigo_postal: ''
    });
    const submitted = ref(false);

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
            }
        },
        { immediate: true }
    );

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
            }
        } catch (error) {
            console.error('Error al guardar parking:', error);
        }
    };

    const validarParking = (parking) => {
        if (!parking.codinsclo || !parking.nombre || !parking.direccion) {
            return false;
        }
        return true;
    };

    const cerrarDialog = () => {
        submitted.value = false;
        emit('update:visible', false);
    };

    const handleVisibleChange = (newValue) => {
        dialogVisible.value = newValue;
        emit('update:visible', newValue);
    };
</script>

<template>
    <Dialog
        :visible="dialogVisible"
        :style="{ width: '800px' }"
        :modal="true"
        class="p-fluid"
        @update:visible="handleVisibleChange"
    >
        <template #header>
            <div class="flex align-items-center gap-2">
                <img
                    :src="obtenerUrlDeIcono('parking')"
                    alt="Icono parking"
                    class="parking-icon"
                />
                <span>{{
                    origen === 'mapa'
                        ? 'Ver parking'
                        : esModoEdicion
                          ? 'Editar parking'
                          : 'Nuevo parking'
                }}</span>
            </div>
        </template>

        <div class="grid">
            <!-- Código de instalación -->
            <div class="col-12 mb-4">
                <IftaLabel>
                    <InputText
                        id="codinsclo"
                        v-model="parking.codinsclo"
                        v-keyfilter.int
                        :invalid="submitted && !parking.codinsclo"
                        :disabled="esModoEdicion"
                        required
                        autofocus
                        placeholder="Solo números enteros"
                    />
                    <label for="codinsclo">Código de instalación</label>
                </IftaLabel>
            </div>

            <!-- Nombre del parking -->
            <div class="col-12 mb-4">
                <IftaLabel>
                    <InputText
                        id="nombre"
                        v-model.trim="parking.nombre"
                        :invalid="submitted && !parking.nombre"
                        required
                    />
                    <label for="nombre">Nombre del parking</label>
                    <small class="p-error" v-if="submitted && !parking.nombre">
                        El nombre es obligatorio
                    </small>
                </IftaLabel>
            </div>

            <!-- Latitud y Longitud -->
            <div class="col-6 mb-4">
                <IftaLabel>
                    <InputNumber
                        id="latitud"
                        v-model="parking.latitud"
                        :minFractionDigits="7"
                        :maxFractionDigits="7"
                        :min="-90"
                        :max="90"
                        placeholder="Entre -90 y 90"
                    />
                    <label for="latitud">Latitud</label>
                </IftaLabel>
            </div>
            <div class="col-6 mb-4">
                <IftaLabel>
                    <InputNumber
                        id="longitud"
                        v-model="parking.longitud"
                        :minFractionDigits="7"
                        :maxFractionDigits="7"
                        :min="-180"
                        :max="180"
                        placeholder="Entre -180 y 180"
                    />
                    <label for="longitud">Longitud</label>
                </IftaLabel>
            </div>

            <!-- Dirección -->
            <div class="col-12 mb-4">
                <IftaLabel>
                    <InputText
                        id="direccion"
                        v-model.trim="parking.direccion"
                        :invalid="submitted && !parking.direccion"
                        required
                    />
                    <label for="direccion">Dirección</label>
                    <small
                        class="p-error"
                        v-if="submitted && !parking.direccion"
                    >
                        La dirección es obligatoria
                    </small>
                </IftaLabel>
            </div>

            <!-- Ciudad y Código Postal -->
            <div class="col-6 mb-4">
                <IftaLabel>
                    <InputText id="ciudad" v-model.trim="parking.ciudad" />
                    <label for="ciudad">Ciudad</label>
                </IftaLabel>
            </div>
            <div class="col-6 mb-4">
                <IftaLabel>
                    <InputText
                        id="codigo_postal"
                        v-model.trim="parking.codigo_postal"
                    />
                    <label for="codigo_postal">Código Postal</label>
                </IftaLabel>
            </div>
        </div>

        <template #footer>
            <Button
                label="Cerrar"
                icon="pi pi-times"
                text
                @click="cerrarDialog"
            />
            <Button
                label="Guardar"
                icon="pi pi-check"
                @click="guardarParking"
            />
        </template>
    </Dialog>
</template>

<style scoped>
    /* Estilos opcionales para mejorar la presentación */
    .flex {
        display: flex;
    }
    .flex-col {
        flex-direction: column;
    }
    .gap-2 {
        gap: 0.5rem;
    }
    .parking-icon {
        width: 24px;
        height: 24px;
    }
</style>
