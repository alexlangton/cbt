<script setup>
    // Importar componentes PrimeVue
    import Button from 'primevue/button';
    import Column from 'primevue/column';
    import DataTable from 'primevue/datatable';
    import Dialog from 'primevue/dialog';
    import IconField from 'primevue/iconfield';
    import InputIcon from 'primevue/inputicon';
    import InputText from 'primevue/inputtext';
    import Toolbar from 'primevue/toolbar';
    import { useToast } from 'primevue/usetoast';
    
    // Componentes locales y servicios
    import DialogCartel from '@/components/CartelDialog.vue';
    import cartelService from '@/services/cartelService';
    import tiposCartelService from '@/services/tiposCartelService';
    import { onBeforeMount, onMounted, ref } from 'vue';

    // Definir FilterMatchMode localmente
    const FilterMatchMode = {
        STARTS_WITH: 'startsWith',
        CONTAINS: 'contains',
        NOT_CONTAINS: 'notContains',
        ENDS_WITH: 'endsWith',
        EQUALS: 'equals',
        NOT_EQUALS: 'notEquals',
        IN: 'in',
        LESS_THAN: 'lt',
        LESS_THAN_OR_EQUAL_TO: 'lte',
        GREATER_THAN: 'gt',
        GREATER_THAN_OR_EQUAL_TO: 'gte',
        BETWEEN: 'between',
        DATE_IS: 'dateIs',
        DATE_IS_NOT: 'dateIsNot',
        DATE_BEFORE: 'dateBefore',
        DATE_AFTER: 'dateAfter'
    };

    // Inicialización del toast
    const toast = useToast();

    // Variables reactivas
    const carteles = ref([]);
    const cartel = ref({
        id: null,
        nombre: '',
        latitud: null,
        longitud: null,
        id_tipocartel: null,
        rotativo: ''
    });
    const cartelDialog = ref(false);
    const borrarCartelDialog = ref(false);
    const borrarCartelesDialog = ref(false);
    const cartelesSeleccionados = ref([]);
    const dt = ref(null);
    const filters = ref({});
    const tiposCartel = ref([]);

    // Función para resetear el objeto cartel
    const resetCartel = () => {
        cartel.value = {
            id: null,
            nombre: '',
            latitud: null,
            longitud: null,
            id_tipocartel: null,
            rotativo: ''
        };
    };

    // Función para mostrar notificaciones
    const mostrarToast = (severity, summary, detail) => {
        let tiempo = severity === 'error' ? 10000 : 2000;
        toast.add({ severity, summary, detail, life: tiempo });
    };

    // Funciones Axios usando async/await
    const cargarCartelesAxios = async () => {
        try {
            carteles.value = await cartelService.cargarCarteles();
            console.log(carteles.value);
        } catch (error) {
            manejarError(error, 'Error al cargar carteles');
        }
    };

    const handleGuardarCartel = async (cartelData) => {
        try {
            await cartelService.guardarCartel(cartelData, !cartelData.id);
        } catch (error) {
            manejarError(error, 'Error al guardar cartel');
        }
    };

    const clickEditarCartel = async (id) => {
        console.log('ID recibido:', id);
        try {
            cartel.value = await cartelService.obtenerCartel(id);
            console.log('Cartel obtenido:', cartel.value);
            cartelDialog.value = true;
        } catch (error) {
            manejarError(error, 'Error al cargar cartel');
        }
    };

    const clickConfirmarBorrarCartel = (data) => {
        cartel.value = data;
        borrarCartelDialog.value = true;
    };

    const clickDeleteCartel = async () => {
        try {
            await cartelService.borrarCartel(cartel.value.id);
            await cargarCartelesAxios();
            borrarCartelDialog.value = false;
            resetCartel();
            mostrarToast('success', 'OK', 'Cartel eliminado correctamente');
        } catch (error) {
            manejarError(error, 'Error al borrar cartel');
        }
    };

    const clickBorrarCartelesSeleccionados = async () => {
        const data = {
            id: cartelesSeleccionados.value.map((val) => val.id)
        };
        try {
            await cartelService.borrarCartelesSeleccionados(data);
            await cargarCartelesAxios();
        } finally {
            borrarCartelesDialog.value = false;
            cartelesSeleccionados.value = null;
        }
    };

    const exportCSV = () => {
        dt.value.exportCSV();
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

    onMounted(async () => {
        try {
            await Promise.all([
                cargarCartelesAxios(),
                cargarTiposCartel()
            ]);
        } catch (error) {
            manejarError(error, 'Error al cargar datos iniciales');
        }
    });

    const clickConfirmarBorradoSeleccionados = () => {
        borrarCartelesDialog.value = true;
    };

    // Funciones de acción
    const nuevoCartel = () => {
        cartel.value = {
            id: null,
            nombre: '',
            latitud: null,
            longitud: null,
            id_tipocartel: null,
            rotativo: ''
        };
        cartelDialog.value = true;
    };

    const manejarGuardadoExitoso = (resultado) => {
        console.log('Cartel guardado exitosamente:', resultado);
        cargarCartelesAxios();
        mostrarToast('success', 'Éxito', 'Cartel guardado correctamente');
    };

    const cerrarDialog = () => {
        cartelDialog.value = false;
        resetCartel();
    };

    // Función para manejar errores (si no la tienes ya)
    const manejarError = (error, mensaje) => {
        console.error(mensaje, error);
        mostrarToast('error', 'Error', mensaje);
    };

    // Cargar tipos de cartel
    const cargarTiposCartel = async () => {
        try {
            tiposCartel.value = await tiposCartelService.cargarTiposCartel();
        } catch (error) {
            manejarError(error, 'Error al cargar tipos de cartel');
        }
    };

    // Obtener descripción del tipo de cartel
    const obtenerDescripcionTipoCartel = (idTipoCartel) => {
        const tipo = tiposCartel.value.find(t => t.id === idTipoCartel);
        return tipo?.descripcion || 'No especificado';
    };
</script>

<template>
    <div class="layout-content">
        <div class="card">
            <div class="surface-section p-4">
                <!-- Título y Toolbar -->
                <div class="flex justify-content-between align-items-center mb-3">
                    <h5 class="m-0">Gestión de Carteles</h5>
                </div>

                <!-- Toolbar con botones -->
                <Toolbar class="mb-4">
                    <template #start>
                        <Button
                            label="Nuevo Cartel"
                            icon="pi pi-plus"
                            class="mr-2"
                            severity="secondary"
                            outlined
                            @click="nuevoCartel"
                        />
                        <Button
                            label="Borrar"
                            icon="pi pi-trash"
                            severity="secondary"
                            outlined
                            @click="clickConfirmarBorradoSeleccionados"
                            :disabled="!cartelesSeleccionados?.length"
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
                    :value="carteles"
                    v-model:selection="cartelesSeleccionados"
                    dataKey="id"
                    :paginator="true"
                    :rows="10"
                    :filters="filters"
                    paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
                    :rowsPerPageOptions="[5, 10, 25]"
                    currentPageReportTemplate="Mostrando {first} a {last} de {totalRecords} carteles"
                    class="p-datatable-sm"
                    stripedRows
                    tableStyle="min-width: 50rem"
                >
                    <Column
                        selectionMode="multiple"
                        style="width: 3rem"
                    />
                    
                    <Column
                        field="nombre"
                        header="Nombre"
                        :sortable="true"
                        style="width: 40%"
                    />
                    
                    <Column
                        field="id_tipocartel"
                        header="Tipo"
                        :sortable="true"
                        style="width: 30%"
                    >
                        <template #body="{ data }">
                            {{ obtenerDescripcionTipoCartel(data.id_tipocartel) }}
                        </template>
                    </Column>

                    <Column style="width: 10rem">
                        <template #body="slotProps">
                            <div class="flex gap-2 justify-content-center">
                                <Button
                                    icon="pi pi-pencil"
                                    rounded
                                    outlined
                                    @click="clickEditarCartel(slotProps.data.id)"
                                />
                                <Button
                                    icon="pi pi-trash"
                                    severity="danger"
                                    rounded
                                    outlined
                                    @click="clickConfirmarBorrarCartel(slotProps.data)"
                                />
                            </div>
                        </template>
                    </Column>
                </DataTable>

                <!-- Diálogos -->
                <DialogCartel
                    v-model:visible="cartelDialog"
                    :cartelData="cartel"
                    :esModoEdicion="!!cartel.id"
                    @guardadoExitoso="manejarGuardadoExitoso"
                    @recargarDatos="cargarCartelesAxios"
                    @cerrar="cerrarDialog"
                />

                <!-- Diálogos de confirmación -->
                <Dialog
                    v-model:visible="borrarCartelDialog"
                    :style="{ width: '450px' }"
                    header="Confirmar borrado"
                    :modal="true"
                >
                    <!-- ... contenido del diálogo ... -->
                </Dialog>

                <Dialog
                    v-model:visible="borrarCartelesDialog"
                    :style="{ width: '450px' }"
                    header="Confirmar borrado múltiple"
                    :modal="true"
                >
                    <!-- ... contenido del diálogo ... -->
                </Dialog>
            </div>
        </div>
        <Toast />
    </div>
</template>

<style lang="scss">
.p-toast {
    z-index: 9999;
}
</style>
