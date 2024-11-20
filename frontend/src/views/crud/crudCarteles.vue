<script setup>
    import DialogCartel from '@/components/CartelDialog.vue';
    import cartelService from '@/services/cartelService';
    import { FilterMatchMode } from '@primevue/core/api';
    import { useToast } from 'primevue/usetoast';
    import { onBeforeMount, onMounted, ref } from 'vue';

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
            await cargarCartelesAxios();
            cartelDialog.value = false;
            mostrarToast('success', 'OK', 'Cartel guardado correctamente');
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

    onMounted(() => {
        cargarCartelesAxios();
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
</script>

<template>
    <div>
        <div class="card">
            <Toolbar class="mb-6">
                <template #start>
                    <Button
                        label="Nuevo Cartel"
                        icon="pi pi-plus"
                        class="mr-2"
                        severity="secondary"
                        @click="nuevoCartel"
                    />
                    <Button
                        label="Borrar"
                        icon="pi pi-trash"
                        severity="secondary"
                        @click="clickConfirmarBorradoSeleccionados"
                        :disabled="
                            !cartelesSeleccionados ||
                            !cartelesSeleccionados.length
                        "
                    />
                </template>

                <template #end>
                    <Button
                        label="CSV"
                        icon="pi pi-upload"
                        severity="secondary"
                        @click="exportCSV($event)"
                    />
                </template>
            </Toolbar>

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
                exportFilename="Carteles"
            >
                <template #header>
                    <div
                        class="flex flex-wrap gap-2 items-center justify-between"
                    >
                        <h1 class="m-0">Carteles</h1>
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
                    selectionMode="multiple"
                    headerStyle="width: 3rem"
                ></Column>
                <Column
                    field="nombre"
                    header="Nombre"
                    :sortable="true"
                    headerStyle="width:20%; min-width:10rem;"
                ></Column>
                <Column
                    field="id_tipocartel"
                    header="Tipo"
                    :sortable="true"
                    headerStyle="width:10%; min-width:8rem;"
                ></Column>
                <Column
                    field="latitud"
                    header="Latitud"
                    :sortable="true"
                    headerStyle="width:15%; min-width:10rem;"
                ></Column>
                <Column
                    field="longitud"
                    header="Longitud"
                    :sortable="true"
                    headerStyle="width:15%; min-width:10rem;"
                ></Column>
                <Column
                    field="rotativo"
                    header="Texto Rotativo"
                    :sortable="true"
                    headerStyle="width:30%; min-width:15rem;"
                ></Column>

                <Column headerStyle="min-width:10rem;">
                    <template #body="slotProps">
                        <Button
                            icon="pi pi-pencil"
                            class="mr-2"
                            rounded
                            outlined
                            @click="clickEditarCartel(slotProps.data.id)"
                        />
                        <Button
                            icon="pi pi-trash"
                            class="mt-2"
                            severity="danger"
                            rounded
                            outlined
                            @click="clickConfirmarBorrarCartel(slotProps.data)"
                        />
                    </template>
                </Column>
            </DataTable>

            <!-- Reemplazar el diálogo anterior por el nuevo componente -->
            <DialogCartel
                v-model:visible="cartelDialog"
                :cartelData="cartel"
                :esModoEdicion="!!cartel.id"
                @guardar="handleGuardarCartel"
                @update:visible="(val) => (cartelDialog = val)"
            />

            <!-- Diálogo de confirmación para borrar un cartel -->
            <Dialog
                v-model:visible="borrarCartelDialog"
                :style="{ width: '450px' }"
                header="Confirma el borrado del cartel"
                :modal="true"
            >
                <div class="flex align-items-center justify-content-center">
                    <i
                        class="pi pi-exclamation-triangle mr-3"
                        style="font-size: 2rem"
                    />
                    <span v-if="cartel"
                        >Seguro que quieres borrar el cartel con ID
                        <b>{{ cartel.id }}</b
                        >?</span
                    >
                </div>
                <template #footer>
                    <Button
                        label="No"
                        icon="pi pi-times"
                        text
                        @click="borrarCartelDialog = false"
                    />
                    <Button
                        label="Sí"
                        icon="pi pi-check"
                        text
                        @click="clickDeleteCartel"
                    />
                </template>
            </Dialog>

            <!-- Diálogo de confirmación para borrar carteles seleccionados -->
            <Dialog
                v-model:visible="borrarCartelesDialog"
                :style="{ width: '450px' }"
                header="Atención, selección múltiple de carteles."
                :modal="true"
            >
                <div class="flex align-items-center justify-content-center">
                    <i
                        class="pi pi-exclamation-triangle mr-3"
                        style="font-size: 2rem"
                    />
                    <span
                        >¿Estás seguro de que quieres borrar los carteles
                        seleccionados?</span
                    >
                </div>
                <template #footer>
                    <Button
                        label="No"
                        icon="pi pi-times"
                        text
                        @click="borrarCartelesDialog = false"
                    />
                    <Button
                        label="Sí"
                        icon="pi pi-check"
                        text
                        @click="clickBorrarCartelesSeleccionados"
                    />
                </template>
            </Dialog>
        </div>
    </div>
</template>
