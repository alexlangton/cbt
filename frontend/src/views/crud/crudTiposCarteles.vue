<script setup>
    import TipoCartelDialog from '@/components/TipoCartelDialog.vue';
    import tiposCartelService from '@/services/tiposCartelService';
    import { useToast } from 'primevue/usetoast';
    import { onMounted, ref } from 'vue';

    const toast = useToast();

    // Variables reactivas
    const tiposCartel = ref([]);
    const tipoCartel = ref({
        id: null,
        descripcion: '',
        atributos: null
    });
    const tipoCartelDialog = ref(false);
    const borrarTipoCartelDialog = ref(false);
    const dt = ref(null);
    const filters = ref({
        global: { value: null, matchMode: 'contains' }
    });

    // Función para mostrar notificaciones
    const mostrarToast = (severity, summary, detail) => {
        let tiempo = severity === 'error' ? 10000 : 2000;
        toast.add({ severity, summary, detail, life: tiempo });
    };

    // Cargar tipos de cartel
    const cargarTiposCartel = async () => {
        try {
            tiposCartel.value = await tiposCartelService.cargarTiposCartel();
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al cargar tipos de cartel');
        }
    };

    // Guardar tipo de cartel
    const handleGuardarTipoCartel = async (tipoCartelData) => {
        
        try {
            await tiposCartelService.guardarTipoCartel(
                tipoCartelData,
                !tipoCartelData.id
            );
            await cargarTiposCartel();
            tipoCartelDialog.value = false;
            mostrarToast(
                'success',
                'OK',
                'Tipo de cartel guardado correctamente'
            );
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al guardar tipo de cartel');
        }
    };

    // Editar tipo de cartel
    const editarTipoCartel = async (id) => {
        try {
            tipoCartel.value = await tiposCartelService.obtenerTipoCartel(id);
            tipoCartelDialog.value = true;
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al cargar tipo de cartel');
        }
    };

    // Borrar tipo de cartel
    const borrarTipoCartel = async () => {
        try {
            await tiposCartelService.borrarTipoCartel(tipoCartel.value.id);
            await cargarTiposCartel();
            borrarTipoCartelDialog.value = false;
            tipoCartel.value = {};
            mostrarToast(
                'success',
                'OK',
                'Tipo de cartel eliminado correctamente'
            );
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al eliminar tipo de cartel');
        }
    };

    // Inicialización de filtros
    const initFilters = () => {
        filters.value = {
            global: { value: null, matchMode: 'contains' }
        };
    };

    // Hooks del ciclo de vida
    onMounted(() => {
        cargarTiposCartel();
    });

    const nuevoTipoCartel = () => {
        tipoCartel.value = {
            id: null,
            descripcion: '',
            atributos: null
        };
        tipoCartelDialog.value = true;
    };

    const confirmarBorrado = (data) => {
        tipoCartel.value = data;
        borrarTipoCartelDialog.value = true;
    };

    const exportCSV = () => {
        dt.value.exportCSV();
    };
</script>

<template>
    <div class="layout-content">
        <div class="card">
            <div class="surface-section p-4">
                <!-- Título -->
                <div class="flex justify-content-between align-items-center mb-3">
                    <h5 class="m-0">Gestión de Tipos de Cartel</h5>
                </div>

                <!-- Toolbar -->
                <Toolbar class="mb-4">
                    <template #start>
                        <Button
                            label="Nuevo"
                            icon="pi pi-plus"
                            severity="secondary"
                            outlined
                            class="mr-2"
                            @click="nuevoTipoCartel"
                        />
                    </template>
                    <template #end>
                        <Button
                            label="Exportar CSV"
                            icon="pi pi-upload"
                            severity="secondary"
                            outlined
                            @click="exportCSV"
                        />
                    </template>
                </Toolbar>

                <!-- Buscador -->
                <div class="flex justify-content-end mb-4">
                    <IconField>
                        <InputIcon>
                            <i class="pi pi-search" />
                        </InputIcon>
                        <InputText
                            v-model="filters['global'].value"
                            placeholder="Buscar..."
                        />
                    </IconField>
                </div>

                <!-- DataTable -->
                <DataTable
                    ref="dt"
                    :value="tiposCartel"
                    dataKey="id"
                    :paginator="true"
                    :rows="10"
                    :filters="filters"
                    paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
                    :rowsPerPageOptions="[5, 10, 25]"
                    currentPageReportTemplate="Mostrando {first} a {last} de {totalRecords} tipos de cartel"
                    class="p-datatable-sm"
                    stripedRows
                    tableStyle="min-width: 50rem"
                >
                    <Column
                        field="id"
                        header="ID"
                        :sortable="true"
                        style="width: 10rem"
                    />
                    <Column
                        field="descripcion"
                        header="Descripción"
                        :sortable="true"
                        style="min-width: 15rem"
                    />
                    <Column style="width: 10rem">
                        <template #body="slotProps">
                            <div class="flex gap-2 justify-content-center">
                                <Button
                                    icon="pi pi-pencil"
                                    rounded
                                    outlined
                                    @click="editarTipoCartel(slotProps.data.id)"
                                />
                                <Button
                                    icon="pi pi-trash"
                                    severity="danger"
                                    rounded
                                    outlined
                                    @click="confirmarBorrado(slotProps.data)"
                                />
                            </div>
                        </template>
                    </Column>
                </DataTable>

                <TipoCartelDialog
                    v-model:visible="tipoCartelDialog"
                    :tipoCartelData="tipoCartel"
                    :esModoEdicion="!!tipoCartel.id"
                    @guardar="handleGuardarTipoCartel"
                />

                <Dialog
                    v-model:visible="borrarTipoCartelDialog"
                    :style="{ width: '450px' }"
                    header="Confirmar borrado"
                    :modal="true"
                >
                    <div class="flex align-items-center justify-content-center">
                        <i
                            class="pi pi-exclamation-triangle mr-3"
                            style="font-size: 2rem"
                        />
                        <span v-if="tipoCartel">
                            ¿Seguro que quieres borrar el tipo de cartel
                            <b>{{ tipoCartel.descripcion }}</b
                            >?
                        </span>
                    </div>
                    <template #footer>
                        <Button
                            label="No"
                            icon="pi pi-times"
                            text
                            @click="borrarTipoCartelDialog = false"
                        />
                        <Button
                            label="Sí"
                            icon="pi pi-check"
                            text
                            @click="borrarTipoCartel"
                        />
                    </template>
                </Dialog>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>
:deep(.p-button.p-button-outlined) {
    padding: 0.5rem;
    
    .p-button-icon {
        font-size: 1rem;
    }
}

:deep(.p-datatable) {
    .p-datatable-tbody > tr > td,
    .p-datatable-thead > tr > th {
        padding: 0.75rem 1rem;
    }
    
    .p-datatable-tbody > tr > td {
        line-height: 1.5;
    }
}
</style>
