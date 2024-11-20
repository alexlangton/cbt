<script setup>
    import TipoCartelDialog from '@/components/TipoCartelDialog.vue';
    import tiposCartelService from '@/services/tiposCartelService';
    import { FilterMatchMode } from '@primevue/core/api';
    import { useToast } from 'primevue/usetoast';
    import { onBeforeMount, onMounted, ref } from 'vue';

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
    const filters = ref({});

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
            global: { value: null, matchMode: FilterMatchMode.CONTAINS }
        };
    };

    // Hooks del ciclo de vida
    onBeforeMount(() => {
        initFilters();
    });

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
    <div>
        <div class="card">
            <Toolbar class="mb-6">
                <template #start>
                    <Button
                        label="Nuevo"
                        icon="pi pi-plus"
                        class="mr-2"
                        severity="secondary"
                        @click="nuevoTipoCartel"
                    />
                </template>
                <template #end>
                    <Button
                        label="CSV"
                        icon="pi pi-upload"
                        severity="secondary"
                        @click="exportCSV"
                    />
                </template>
            </Toolbar>

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
            >
                <template #header>
                    <div
                        class="flex flex-wrap gap-2 items-center justify-between"
                    >
                        <h4 class="m-0">Tipos de Cartel</h4>
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
                </template>

                <Column
                    field="id"
                    header="ID"
                    :sortable="true"
                    headerStyle="width:10%; min-width:8rem;"
                />
                <Column
                    field="descripcion"
                    header="Descripción"
                    :sortable="true"
                    headerStyle="width:60%; min-width:10rem;"
                />
                <Column
                    field="atributos"
                    header="Atributos"
                    :sortable="true"
                    headerStyle="width:20%; min-width:10rem;"
                />
                <Column headerStyle="min-width:10rem;">
                    <template #body="slotProps">
                        <Button
                            icon="pi pi-pencil"
                            class="mr-2"
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
</template>
