<script setup>
    import { useIconUrl } from '@/composables/useIconUrl';
    import tiposCartelService from '@/services/tiposCartelService';
    import cartelService from '@/services/cartelService';
    import Button from 'primevue/button';
    import Dialog from 'primevue/dialog';
    import Select from 'primevue/select';
    import IftaLabel from 'primevue/iftalabel';
    import InputNumber from 'primevue/inputnumber';
    import InputText from 'primevue/inputtext';
    import Textarea from 'primevue/textarea';
    import { onMounted, ref, watch } from 'vue';

    const props = defineProps({
        visible: {
            type: Boolean,
            required: true
        },
        marker: {
            type: Object,
            default: null
        },
        cartelData: {
            type: Object,
            default: () => null
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

    const cartel = ref({
        id: null,
        nombre: '',
        latitud: null,
        longitud: null,
        id_tipocartel: null,
        rotativo: ''
    });

    const tiposCartel = ref([]);
    const submitted = ref(false);

    const { obtenerUrlDeIcono } = useIconUrl();

    // Cargar tipos de cartel
    onMounted(async () => {
        try {
            const tipos = await tiposCartelService.cargarTiposCartel();
            console.log('Tipos de cartel disponibles:', tipos);
            tiposCartel.value = tipos;
            
            // Si ya tenemos un id_tipocartel, verificar que exista en los tipos
            if (cartel.value.id_tipocartel) {
                const tipoExiste = tipos.some(t => t.id === cartel.value.id_tipocartel);
                if (!tipoExiste) {
                    console.warn('Tipo de cartel no encontrado:', cartel.value.id_tipocartel);
                    cartel.value.id_tipocartel = null;
                }
            }
        } catch (error) {
            console.error('Error al cargar tipos de cartel:', error);
        }
    });

    // Watch para ver cambios en tiposCartel y cartel.id_tipocartel
    watch(tiposCartel, (newTipos) => {
        console.log('Tipos de cartel actualizados:', newTipos);
    }, { deep: true });

    watch(() => cartel.value.id_tipocartel, (newId) => {
        console.log('Nuevo id_tipocartel:', newId);
        if (newId && tiposCartel.value.length) {
            const tipo = tiposCartel.value.find(t => t.id === newId);
            console.log('Tipo encontrado:', tipo);
        }
    });

    const validarCartel = (cartel) => {
        const camposRequeridos = {
            nombre: 'El nombre es obligatorio',
            id_tipocartel: 'El tipo de cartel es obligatorio',
            longitud: 'La longitud es obligatoria'
        };

        for (const [campo, mensaje] of Object.entries(camposRequeridos)) {
            if (!cartel[campo]) {
                useToast().add({
                    severity: 'error',
                    summary: 'Error de validación',
                    detail: mensaje,
                    life: 3000
                });
                return false;
            }
        }
        return true;
    };

    const guardarCartel = async () => {
        submitted.value = true;

        if (!validarCartel(cartel.value)) {
            return;
        }

        try {
            emit('guardar', cartel.value);
            emit('guardadoExitoso', cartel.value);
            emit('recargarDatos');
            cerrarDialog();
        } catch (error) {
            console.error('Error al guardar cartel:', error);
            useToast().add({
                severity: 'error',
                summary: 'Error',
                detail: 'No se pudo guardar el cartel',
                life: 3000
            });
        }
    };

    const cerrarDialog = () => {
        submitted.value = false;
        cartel.value = {
            id: null,
            nombre: '',
            latitud: null,
            longitud: null,
            id_tipocartel: null,
            rotativo: ''
        };
        emit('update:visible', false);
        emit('cerrar');
    };

    // Watch para actualizar datos cuando cambia el marcador
    watch(
        () => props.marker,
        async (newMarker) => {
            if (newMarker && newMarker.type === 'cartel') {
                try {
                    // Cargar datos completos del cartel
                    const cartelCompleto = await cartelService.obtenerCartel(newMarker.id);
                    console.log('Datos completos del cartel:', cartelCompleto);
                    
                    if (cartelCompleto) {
                        cartel.value = {
                            id: cartelCompleto.id,
                            nombre: cartelCompleto.nombre,
                            latitud: cartelCompleto.latitud,
                            longitud: cartelCompleto.longitud,
                            id_tipocartel: cartelCompleto.id_tipocartel,
                            rotativo: cartelCompleto.rotativo
                        };
                        
                        console.log('Cartel actualizado:', cartel.value);
                    }
                } catch (error) {
                    console.error('Error al cargar datos del cartel:', error);
                }
            }
        },
        { immediate: true }
    );

    // Watch para actualizar datos cuando cambia cartelData
    watch(
        () => props.cartelData,
        (newCartelData) => {
            if (newCartelData) {
                console.log('Actualizando cartel con cartelData:', newCartelData);
                cartel.value = {
                    ...cartel.value,
                    ...newCartelData,
                    id_tipocartel: Number(newCartelData.id_tipocartel) // Aseguramos que sea número
                };
            }
        },
        { immediate: true }
    );
</script>

<template>
    <Dialog
        :visible="visible"
        :style="{ width: '650px' }"
        :modal="true"
        class="p-fluid"
        :header="esModoEdicion ? 'Editando cartel' : 'Nuevo cartel'"
        @update:visible="$emit('update:visible', $event)"
    >
        <template #header>
            <div class="flex align-items-center gap-2">
                <img
                    :src="obtenerUrlDeIcono('cartel')"
                    alt="Icono cartel"
                    class="cartel-icon"
                />
                <span>{{
                    origen === 'mapa'
                        ? 'Ver cartel'
                        : esModoEdicion
                          ? 'Editar cartel'
                          : 'Nuevo cartel'
                }}</span>
            </div>
        </template>

        <div class="grid">
            <!-- Nombre -->
            <div class="col-12 mb-4">
                <IftaLabel>
                    <InputText
                        id="nombre"
                        v-model.trim="cartel.nombre"
                        :invalid="submitted && !cartel.nombre"
                        required
                        autofocus
                    />
                    <label for="nombre">Nombre</label>
                    <small class="p-error" v-if="submitted && !cartel.nombre">
                        El nombre es obligatorio
                    </small>
                </IftaLabel>
            </div>

            <!-- Tipo de Cartel -->
            <div class="col-12 mb-4">
                <IftaLabel>
                    <Select
                        v-model="cartel.id_tipocartel"
                        inputId="id_tipocartel"
                        :options="tiposCartel"
                        optionLabel="descripcion"
                        optionValue="id"
                        placeholder="Seleccione un tipo de cartel"
                        class="w-full"
                        :class="{ 'p-invalid': submitted && !cartel.id_tipocartel }"
                        variant="filled"
                        required
                    />
                    <label for="id_tipocartel" class="select-label">Tipo de Cartel</label>
                </IftaLabel>
            </div>

            <!-- Latitud y Longitud -->
            <div class="col-6 mb-4">
                <IftaLabel>
                    <InputNumber
                        id="latitud"
                        v-model="cartel.latitud"
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
                        v-model="cartel.longitud"
                        :minFractionDigits="7"
                        :maxFractionDigits="7"
                        :min="-180"
                        :max="180"
                        :invalid="submitted && !cartel.longitud"
                        required
                        placeholder="Entre -180 y 180"
                    />
                    <label for="longitud">Longitud</label>
                    <small class="p-error" v-if="submitted && !cartel.longitud">
                        La longitud es obligatoria
                    </small>
                </IftaLabel>
            </div>

            <!-- Texto rotativo -->
            <div class="col-12">
                <IftaLabel>
                    <Textarea
                        id="rotativo"
                        v-model="cartel.rotativo"
                        rows="3"
                        autoResize
                        class="w-full"
                        placeholder="Texto rotativo o desplazante del cartel"
                    />
                    <label for="rotativo">Texto rotativo</label>
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
            <Button label="Guardar" icon="pi pi-check" @click="guardarCartel" />
        </template>
    </Dialog>
</template>

<style scoped>
    .flex {
        display: flex;
    }
    .gap-2 {
        gap: 0.5rem;
    }
    .cartel-icon {
        width: 24px;
        height: 24px;
    }
</style>

<style lang="scss" scoped>
:deep() {
    .p-float-label {
        position: relative;
        
        .p-select {
            padding-top: 1.25rem;
            
            &.p-select-filled {
                background-color: var(--surface-ground);
            }
        }
        
        label {
            position: absolute;
            top: -0.75rem;
            left: 1rem;
            line-height: 1;
            padding: 0 0.25rem;
            background-color: var(--surface-overlay);
            color: var(--text-color-secondary);
            transition: all 0.2s ease-in-out;
        }
        
        .p-select:focus ~ label,
        .p-select.p-filled ~ label {
            top: -0.75rem;
            font-size: 0.85rem;
            color: var(--primary-color);
        }
    }

    .p-select-items {
        padding: 0.5rem 0;
    }

    .p-select-item {
        padding: 0.5rem 1rem;
    }
}

// Ajuste específico para el label del select
.select-label {
    z-index: 1;
    background-color: var(--surface-card) !important;
}

// Asegurar que el diálogo sea responsive
@media screen and (max-width: 768px) {
    :deep(.p-dialog) {
        width: 90vw !important;
    }
}
</style>
