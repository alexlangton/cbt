<script setup>
    import DialogUsuario from '@/components/UsuarioDialog.vue';
    import usuarioService from '@/services/usuarioService';
    import { FilterMatchMode } from '@primevue/core/api';
    import { useToast } from 'primevue/usetoast';
    import { onBeforeMount, onMounted, ref } from 'vue';

    const toast = useToast();
    const usuarios = ref(null);
    const dialogUsuarioVisible = ref(false);
    const esModoEdicion = ref(false);
    const borrarUsuarioDialog = ref(false);
    const borrarUsuariosDialog = ref(false);
    const usuariosSeleccionados = ref(null);
    const dt = ref(null);

    const limpiarUsuario = () => ({
        id: null,
        nombre: '',
        email: '',
        pass: ''
    });

    const usuario = ref(limpiarUsuario());
    const filters = ref({});
    const submitted = ref(false);

    const mostrarToast = (severity, summary, detail) => {
        let tiempo = severity === 'error' ? 10000 : 2000;
        toast.add({ severity, summary, detail, life: tiempo });
    };

    let actualizacionEnCurso = false;

    const actualizarUsuarios = async () => {
        if (actualizacionEnCurso) return;

        try {
            actualizacionEnCurso = true;
            const data = await usuarioService.cargarUsuarios();
            usuarios.value = data;
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al cargar usuarios');
            console.error('Error al cargar usuarios:', error);
        } finally {
            actualizacionEnCurso = false;
        }
    };

    const clickDeleteUsuario = async () => {
        try {
            await usuarioService.borrarUsuario(usuario.value.id);
            mostrarToast('success', 'OK', 'Usuario borrado correctamente');
            await actualizarUsuarios();
            borrarUsuarioDialog.value = false;
            usuario.value = limpiarUsuario();
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al borrar usuario');
            console.error('Error al borrar usuario:', error);
        }
    };

    const clickBorrarUsuariosSeleccionados = async () => {
        const ids = usuariosSeleccionados.value.map(val => val.id);
        try {
            const respuesta = await usuarioService.borrarUsuariosSeleccionados(ids);
            mostrarToast('success', 'Borrado múltiple', respuesta.message);
            await actualizarUsuarios();
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al borrar usuarios');
            console.error('Error al borrar usuarios:', error);
        } finally {
            borrarUsuariosDialog.value = false;
            usuariosSeleccionados.value = null;
        }
    };

    const clickEditarUsuario = async (id) => {
        try {
            const data = await usuarioService.obtenerUsuario(id);
            if (data) {
                usuario.value = { ...data };
                esModoEdicion.value = true;
                dialogUsuarioVisible.value = true;
            }
        } catch (error) {
            mostrarToast('error', 'Error', 'Error al cargar usuario');
            console.error('Error al cargar usuario:', error);
        }
    };

    const clickCrearNuevoUsuario = () => {
        usuario.value = limpiarUsuario();
        submitted.value = false;
        esModoEdicion.value = false;
        dialogUsuarioVisible.value = true;
    };

    const clickConfirmarBorrarUsuario = (data) => {
        usuario.value = data;
        borrarUsuarioDialog.value = true;
        dialogUsuarioVisible.value = false;
    };

    const clickExportarCSV = () => {
        dt.value.exportCSV();
    };

    const clickConfirmarBorradoSeleccionados = () => {
        borrarUsuariosDialog.value = true;
    };

    const initFilters = () => {
        filters.value = {
            global: { value: null, matchMode: FilterMatchMode.CONTAINS }
        };
    };

    const handleGuardadoExitoso = async (usuarioGuardado) => {
        try {
            await actualizarUsuarios();
            mostrarToast('success', 'OK', 'Usuario guardado correctamente');
        } catch (error) {
            console.error('Error al actualizar usuarios:', error);
            mostrarToast('error', 'Error', 'Error al actualizar la lista');
        } finally {
            dialogUsuarioVisible.value = false;
            usuario.value = limpiarUsuario();
        }
    };

    onMounted(() => {
        actualizarUsuarios();
    });

    onBeforeMount(() => {
        initFilters();
    });
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
                        @click="clickCrearNuevoUsuario"
                    />
                    <Button
                        label="Borrar"
                        icon="pi pi-trash"
                        severity="secondary"
                        @click="clickConfirmarBorradoSeleccionados"
                        :disabled="
                            !usuariosSeleccionados ||
                            !usuariosSeleccionados.length
                        "
                    />
                </template>

                <template #end>
                    <Button
                        label="CSV"
                        icon="pi pi-upload"
                        severity="secondary"
                        @click="clickExportarCSV"
                    />
                </template>
            </Toolbar>

            <DataTable
                ref="dt"
                :value="usuarios"
                v-model:selection="usuariosSeleccionados"
                dataKey="id"
                :paginator="true"
                :rows="10"
                :filters="filters"
                paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
                :rowsPerPageOptions="[5, 10, 25]"
                currentPageReportTemplate="Mostrando {first} a {last} de {totalRecords} usuarios"
            >
                <template #header>
                    <div class="flex flex-wrap gap-2 items-center justify-between">
                        <h4 class="m-0">Usuarios</h4>
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
                    headerStyle="width:30%; min-width:10rem;"
                ></Column>
                <Column
                    field="email"
                    header="Email"
                    :sortable="true"
                    headerStyle="width:30%; min-width:10rem;"
                ></Column>
                <Column
                    field="ultimo_inicio_sesion"
                    header="Último acceso"
                    :sortable="true"
                    headerStyle="width:20%; min-width:10rem;"
                >
                    <template #body="slotProps">
                        {{ slotProps.data.ultimo_inicio_sesion ? new Date(slotProps.data.ultimo_inicio_sesion).toLocaleString() : '-' }}
                    </template>
                </Column>

                <Column headerStyle="min-width:10rem;">
                    <template #body="slotProps">
                        <Button
                            icon="pi pi-pencil"
                            class="mr-2"
                            rounded
                            outlined
                            @click="clickEditarUsuario(slotProps.data.id)"
                        />
                        <Button
                            icon="pi pi-trash"
                            severity="danger"
                            rounded
                            outlined
                            @click="clickConfirmarBorrarUsuario(slotProps.data)"
                        />
                    </template>
                </Column>
            </DataTable>

            <DialogUsuario
                v-model:visible="dialogUsuarioVisible"
                :usuario="usuario"
                :esModoEdicion="esModoEdicion"
                @guardar-usuario="handleGuardadoExitoso"
                @error="(msg) => mostrarToast('error', 'Error', msg)"
                @update:visible="
                    (val) => {
                        dialogUsuarioVisible = val;
                        if (!val) usuario.value = limpiarUsuario();
                    }
                "
            />

            <Dialog
                v-model:visible="borrarUsuarioDialog"
                :style="{ width: '450px' }"
                header="Confirma el borrado del usuario"
                :modal="true"
            >
                <div class="flex align-items-center justify-content-center">
                    <i
                        class="pi pi-exclamation-triangle mr-3"
                        style="font-size: 2rem"
                    />
                    <span v-if="usuario">
                        Seguro que quieres borrar el usuario
                        <b>{{ usuario.email }}</b
                        >?
                    </span>
                </div>
                <template #footer>
                    <Button
                        label="No"
                        icon="pi pi-times"
                        text
                        @click="borrarUsuarioDialog = false"
                    />
                    <Button
                        label="Sí"
                        icon="pi pi-check"
                        text
                        @click="clickDeleteUsuario"
                    />
                </template>
            </Dialog>

            <Dialog
                v-model:visible="borrarUsuariosDialog"
                :style="{ width: '450px' }"
                header="Atención, selección múltiple de usuarios."
                :modal="true"
            >
                <div class="flex align-items-center justify-content-center">
                    <i
                        class="pi pi-exclamation-triangle mr-3"
                        style="font-size: 2rem"
                    />
                    <span
                        >¿Estás seguro de que quieres borrar los usuarios
                        seleccionados?</span
                    >
                </div>
                <template #footer>
                    <Button
                        label="No"
                        icon="pi pi-times"
                        text
                        @click="borrarUsuariosDialog = false"
                    />
                    <Button
                        label="Sí"
                        icon="pi pi-check"
                        text
                        @click="clickBorrarUsuariosSeleccionados"
                    />
                </template>
            </Dialog>
        </div>
    </div>
</template>

<style scoped>
:deep(.p-inputtext) {
    padding-left: 2.5rem;
}

:deep(.p-input-icon-left) {
    position: relative;
}

:deep(.p-input-icon-left i) {
    position: absolute;
    left: 0.75rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-color-secondary);
}
</style>
