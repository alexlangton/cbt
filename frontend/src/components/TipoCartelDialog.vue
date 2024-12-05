<script setup>
    import IftaLabel from 'primevue/iftalabel';
    import { ref, watch } from 'vue';

    const props = defineProps({
        visible: {
            type: Boolean,
            required: true
        },
        tipoCartelData: {
            type: Object,
            default: () => null
        },
        esModoEdicion: {
            type: Boolean,
            default: false
        }
    });

    const emit = defineEmits(['update:visible', 'guardar']);

    const dialogVisible = ref(props.visible);
    const tipoCartel = ref({
        id: null,
        descripcion: '',
        atributos: null
    });
    const submitted = ref(false);

    const formatearJSON = (texto) => {
        if (!texto) return '';
        try {
            const objetoJSON = typeof texto === 'string' ? JSON.parse(texto) : texto;
            return JSON.stringify(objetoJSON, null, 2);
        } catch (e) {
            return texto;
        }
    };

    watch(
        () => props.visible,
        (newValue) => {
            dialogVisible.value = newValue;
            if (!newValue) {
                submitted.value = false;
                if (!props.tipoCartelData) {
                    tipoCartel.value = {
                        id: null,
                        descripcion: '',
                        atributos: null
                    };
                }
            }
        }
    );

    watch(
        () => dialogVisible.value,
        (newValue) => {
            emit('update:visible', newValue);
        }
    );

    watch(
        () => props.tipoCartelData,
        (newTipoCartel) => {
            if (newTipoCartel) {
                tipoCartel.value = { 
                    ...newTipoCartel,
                    atributos: newTipoCartel.atributos ? formatearJSON(newTipoCartel.atributos) : null
                };
            }
        },
        { immediate: true }
    );

    const validarTipoCartel = (tipoCartel) => {
        return tipoCartel.descripcion?.trim();
    };

    const esJSONValido = (texto) => {
        if (!texto) return true;
        try {
            JSON.parse(texto);
            return true;
        } catch (e) {
            return false;
        }
    };

    const handleAtributosChange = (event) => {
        const texto = event.target.value;
        if (esJSONValido(texto)) {
            tipoCartel.value.atributos = formatearJSON(texto);
        }
    };

    const guardarTipoCartel = () => {
        submitted.value = true;

        if (!validarTipoCartel(tipoCartel.value)) {
            return;
        }

        const datosTipoCartel = {
            ...tipoCartel.value,
            atributos: tipoCartel.value.atributos ? formatearJSON(tipoCartel.value.atributos) : null
        };

        emit('guardar', datosTipoCartel);
    };

    const handleVisibleChange = (newValue) => {
        dialogVisible.value = newValue;
        emit('update:visible', newValue);
    };
</script>

<template>
    <Dialog
        v-model:visible="dialogVisible"
        :style="{ width: '800px' }"
        :modal="true"
        class="p-fluid"
        :header="esModoEdicion ? 'Editar Tipo de Cartel' : 'Nuevo Tipo de Cartel'"
        @update:visible="handleVisibleChange"
    >
        <div class="grid">
            <div class="col-12 mb-4">
                <div class="field">
                    <IftaLabel>
                        <InputText
                            id="descripcion"
                            v-model.trim="tipoCartel.descripcion"
                            :class="{ 'p-invalid': submitted && !tipoCartel.descripcion }"
                            required
                            autofocus
                        />
                        <label for="descripcion">Descripción</label>
                        <small class="p-error" v-if="submitted && !tipoCartel.descripcion">
                            La descripción es obligatoria
                        </small>
                    </IftaLabel>
                </div>
            </div>

            <div class="col-12">
                <div class="field">
                    <label for="atributos" class="font-bold">Atributos</label>
                    <div class="editor-container">
                        <Textarea
                            id="atributos"
                            v-model="tipoCartel.atributos"
                            @change="handleAtributosChange"
                            rows="10"
                            class="code-editor"
                            autoResize
                            placeholder="Introduzca los atributos en formato JSON..."
                        />
                    </div>
                    <small class="text-gray-500">
                        Utilice este espacio para definir los atributos del tipo de cartel en formato JSON
                    </small>
                </div>
            </div>
        </div>

        <template #footer>
            <div class="flex flex-wrap justify-content-end gap-2">
                <Button
                    label="Cancelar"
                    icon="pi pi-times"
                    outlined
                    @click="handleVisibleChange(false)"
                />
                <Button
                    label="Guardar"
                    icon="pi pi-check"
                    @click="guardarTipoCartel"
                />
            </div>
        </template>
    </Dialog>
</template>

<style scoped>
    .field {
        margin-bottom: 1.5rem;
    }

    .editor-container {
        background-color: var(--surface-card);
        border: 1px solid var(--surface-border);
        border-radius: 6px;
        padding: 0.5rem;
        margin-top: 0.5rem;
    }

    :deep(.code-editor) {
        font-family: 'Lucida Console', Monaco, monospace !important;
        background-color: var(--surface-section);
        color: var(--text-color);
        border: none;
        padding: 1rem;
        font-size: 14px;
        line-height: 1.5;
        width: 100%;
        min-height: 200px;
        white-space: pre;
        tab-size: 2;
    }

    :deep(.code-editor:focus) {
        box-shadow: none;
        border: none;
        outline: none;
    }

    :deep(.code-editor::placeholder) {
        color: var(--text-color-secondary);
    }

    :deep(.code-editor::-webkit-scrollbar) {
        width: 8px;
        height: 8px;
    }

    :deep(.code-editor::-webkit-scrollbar-track) {
        background: var(--surface-ground);
        border-radius: 4px;
    }

    :deep(.code-editor::-webkit-scrollbar-thumb) {
        background: var(--surface-border);
        border-radius: 4px;
    }

    :deep(.code-editor::-webkit-scrollbar-thumb:hover) {
        background: var(--surface-400);
    }
</style>
