<script setup>
    import ParkingDialog from '@/components/ParkingDialog.vue';
    import { useMarcadores } from '@/composables/useMarcadores';
    import {
        borrarParking,
        borrarParkingsSeleccionados,
        cargarParkings,
        obtenerParking
    } from '@/services/parkingService';
    import { FilterMatchMode } from '@primevue/core/api';
    import { useToast } from 'primevue/usetoast';
    import { onBeforeMount, onMounted, ref } from 'vue';

    const toast = useToast();
    const parkings = ref(null);
    const parkingDialog = ref(false);
    const esModoEdicion = ref(false);
    const borrarParkingDialog = ref(false);
    const borrarParkingsDialog = ref(false);
    const parkingsSeleccionados = ref(null);
    const dt = ref(null);

    const limpiarParking = () => ({
        id: null,
        codinsclo: '',
        latitud: null,
        longitud: null,
        nombre: '',
        direccion: '',
        ciudad: '',
        codigo_postal: ''
    });

    const parking = ref(limpiarParking());
    const filters = ref({});
    const submitted = ref(false);

    const mostrarToast = (severity, summary, detail) => {
        let tiempo = severity == 'error' ? 10000 : 2000;
        toast.add({ severity, summary, detail, life: tiempo });
    };

    let actualizacionEnCurso = false;

    const actualizarParkings = async () => {
        if (actualizacionEnCurso) return;

        try {
            actualizacionEnCurso = true;
            const data = await cargarParkings();
            parkings.value = data;
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al cargar parkings');
            console.error('Error al cargar parkings:', error);
        } finally {
            actualizacionEnCurso = false;
        }
    };

    const validarParking = (parking) => {
        if (!parking.nombre?.trim()) {
            mostrarToast('error', 'Error', 'El nombre es obligatorio');
            return false;
        }
        if (!parking.codinsclo) {
            mostrarToast(
                'error',
                'Error',
                'El código de instalación es obligatorio'
            );
            return false;
        }
        if (!parking.direccion?.trim()) {
            mostrarToast('error', 'Error', 'La dirección es obligatoria');
            return false;
        }
        if (
            parking.latitud &&
            (parking.latitud < -90 || parking.latitud > 90)
        ) {
            mostrarToast(
                'error',
                'Error',
                'La latitud debe estar entre -90 y 90'
            );
            return false;
        }
        if (
            parking.longitud &&
            (parking.longitud < -180 || parking.longitud > 180)
        ) {
            mostrarToast(
                'error',
                'Error',
                'La longitud debe estar entre -180 y 180'
            );
            return false;
        }
        return true;
    };

    const clickDeleteParking = () => {
        borrarParking(parking.value.id)
            .then(async (respuesta) => {
                mostrarToast('success', 'OK', 'Parking borrado correctamente');
                await actualizarParkings();
                borrarParkingDialog.value = false;
                parking.value = limpiarParking();
            })
            .catch((error) => {
                mostrarToast('error', 'Error', 'Error al borrar parking');
                console.error('Error al borrar parking:', error);
                borrarParkingDialog.value = false;
            });
    };

    const clickBorrarParkingsSeleccionados = () => {
        const ids = parkingsSeleccionados.value.map(val => val.id);

        borrarParkingsSeleccionados(ids)
            .then(async (respuesta) => {
                mostrarToast('success', 'Borrado multiple', 'Parkings borrados correctamente');
                await actualizarParkings();
                borrarParkingsDialog.value = false;
                parkingsSeleccionados.value = null;
            })
            .catch((error) => {
                mostrarToast('error', 'Error', 'Error al borrar parkings');
                console.error('Error al borrar parkings:', error);
                borrarParkingsDialog.value = false;
            });
    };

    const clickEditarParking = (id) => {
        obtenerParking(id)
            .then((data) => {
                if (data) {
                    parking.value = { ...data };
                    esModoEdicion.value = true;
                    parkingDialog.value = true;
                }
            })
            .catch((error) => {
                mostrarToast('error', 'Error', 'Error al cargar parking');
                console.error('Error al cargar parking:', error);
            });
    };

    const { centro } = useMarcadores();

    const clickCrearNuevoParking = () => {
        parking.value = {
            ...limpiarParking(),
            latitud: centro.value[0],
            longitud: centro.value[1]
        };
        submitted.value = false;
        esModoEdicion.value = false;
        parkingDialog.value = true;
    };

    const clickConfirmarBorrarParking = (data) => {
        parking.value = data;
        borrarParkingDialog.value = true;
        parkingDialog.value = false;
    };

    const clickExportarCSV = () => {
        dt.value.exportCSV();
    };

    const clickConfirmarBorradoSeleccionados = () => {
        borrarParkingsDialog.value = true;
    };

    const initFilters = () => {
        filters.value = {
            global: { value: null, matchMode: FilterMatchMode.CONTAINS }
        };
    };

    const handleGuardadoExitoso = async ({
        origen,
        parking: parkingActualizado
    }) => {
        if (origen === 'crud') {
            parkingDialog.value = false;
            parking.value = limpiarParking();
            await actualizarParkings();
        }
    };

    onMounted(() => {
        actualizarParkings();
    });

    onBeforeMount(() => {
        initFilters();
    });
</script>

<template>
    <div class="layout-content">
        <div class="card">
            <div class="surface-section p-4">
                <!-- Título -->
                <div class="flex justify-content-between align-items-center mb-3">
                    <h5 class="m-0">Gestión de Parkings</h5>
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
                            @click="clickCrearNuevoParking"
                        />
                        <Button
                            label="Borrar"
                            icon="pi pi-trash"
                            severity="secondary"
                            outlined
                            @click="clickConfirmarBorradoSeleccionados"
                            :disabled="!parkingsSeleccionados?.length"
                        />
                    </template>
                    <template #end>
                        <Button
                            label="Exportar CSV"
                            icon="pi pi-upload"
                            severity="secondary"
                            outlined
                            @click="clickExportarCSV"
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
                    :value="parkings"
                    v-model:selection="parkingsSeleccionados"
                    dataKey="id"
                    :paginator="true"
                    :rows="10"
                    :filters="filters"
                    paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
                    :rowsPerPageOptions="[5, 10, 25]"
                    currentPageReportTemplate="Mostrando {first} a {last} de {totalRecords} parkings"
                    class="p-datatable-sm"
                    stripedRows
                    tableStyle="min-width: 50rem"
                >
                    <Column
                        selectionMode="multiple"
                        style="width: 3rem"
                    />
                    <Column
                        field="codinsclo"
                        header="Código de instalación"
                        :sortable="true"
                        style="width: 15rem"
                    />
                    <Column
                        field="nombre"
                        header="Nombre"
                        :sortable="true"
                        style="width: 15rem"
                    />
                    <Column
                        field="direccion"
                        header="Dirección"
                        :sortable="true"
                        style="min-width: 20rem"
                    />
                    <Column
                        field="ultima_actualizacion"
                        header="Últ. Act."
                        :sortable="true"
                        style="width: 12rem"
                    >
                        <template #body="slotProps">
                            {{ new Date(slotProps.data.ultima_actualizacion).toLocaleString() }}
                        </template>
                    </Column>
                    <Column style="width: 10rem">
                        <template #body="slotProps">
                            <div class="flex gap-2 justify-content-center">
                                <Button
                                    icon="pi pi-pencil"
                                    rounded
                                    outlined
                                    @click="clickEditarParking(slotProps.data.id)"
                                />
                                <Button
                                    icon="pi pi-trash"
                                    severity="danger"
                                    rounded
                                    outlined
                                    @click="clickConfirmarBorrarParking(slotProps.data)"
                                />
                            </div>
                        </template>
                    </Column>
                </DataTable>

                <!-- Diálogos -->
                <ParkingDialog
                    v-model:visible="parkingDialog"
                    :parking-data="parking"
                    :es-modo-edicion="esModoEdicion"
                    origen="crud"
                    @guardadoExitoso="handleGuardadoExitoso"
                />

                <Dialog
                    v-model:visible="borrarParkingDialog"
                    :style="{ width: '450px' }"
                    header="Confirmar borrado"
                    :modal="true"
                >
                    <div class="flex align-items-center justify-content-center">
                        <i
                            class="pi pi-exclamation-triangle mr-3"
                            style="font-size: 2rem"
                        />
                        <span v-if="parking">
                            Seguro que quieres borrar el parking
                            <b>{{ parking.nombre }}</b>
                            ?
                        </span>
                    </div>
                    <template #footer>
                        <Button
                            label="No"
                            icon="pi pi-times"
                            text
                            @click="borrarParkingDialog = false"
                        />
                        <Button
                            label="Si"
                            icon="pi pi-check"
                            text
                            @click="clickDeleteParking"
                        />
                    </template>
                </Dialog>

                <Dialog
                    v-model:visible="borrarParkingsDialog"
                    :style="{ width: '450px' }"
                    header="Confirmar borrado múltiple"
                    :modal="true"
                >
                    <div class="flex align-items-center justify-content-center">
                        <i
                            class="pi pi-exclamation-triangle mr-3"
                            style="font-size: 2rem"
                        />
                        <span v-if="parking">
                            ¿Estás seguro de que quieres borrar los parkings
                            seleccionados?
                        </span>
                    </div>
                    <template #footer>
                        <Button
                            label="No"
                            icon="pi pi-times"
                            text
                            @click="borrarParkingsDialog = false"
                        />
                        <Button
                            label="Si"
                            icon="pi pi-check"
                            text
                            @click="clickBorrarParkingsSeleccionados"
                        />
                    </template>
                </Dialog>
            </div>
        </div>
        <Toast />
    </div>
</template>

<style lang="scss" scoped>
/* Solo mantenemos los estilos necesarios para el mapa */
.mapa-leaflet {
    height: calc(100vh - 9rem);
    width: 100%;
    border-radius: var(--border-radius);
}

:deep(.leaflet-container) {
    height: 100% !important;
    width: 100%;
    background: var(--surface-ground) !important;
    border-radius: var(--border-radius);
}

:deep(.p-button.p-button-outlined) {
    padding: 0.5rem;
    
    .p-button-icon {
        font-size: 1rem;
    }
}
</style>
