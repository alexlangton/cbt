<script setup>
import DialogUsuario from '@/components/UsuarioDialog.vue';
import usuarioService from '@/services/usuarioService';
import { useToast } from 'primevue/usetoast';
import Button from 'primevue/button';
import Column from 'primevue/column';
import DataTable from 'primevue/datatable';
import Dialog from 'primevue/dialog';
import InputText from 'primevue/inputtext';
import Toolbar from 'primevue/toolbar';
import Toast from 'primevue/toast';
import { onBeforeMount, onMounted, ref } from 'vue';

// Referencias y estados
const toast = useToast();
const dt = ref(null);
const usuarios = ref(null);
const usuario = ref({ id: null, nombre: '', email: '', pass: '' });
const usuariosSeleccionados = ref(null);
const filters = ref({ 
    global: { value: null, matchMode: 'contains' } 
});

// Estados de diálogos
const dialogUsuarioVisible = ref(false);
const borrarUsuarioDialog = ref(false);
const borrarUsuariosDialog = ref(false);
const esModoEdicion = ref(false);

// Control de actualizaciones
let actualizacionEnCurso = false;

// Funciones auxiliares
const mostrarToast = (severity, summary, detail) => {
    toast.add({ 
        severity, 
        summary, 
        detail, 
        life: severity === 'error' ? 10000 : 2000 
    });
};

// Operaciones CRUD
const actualizarUsuarios = async () => {
    if (actualizacionEnCurso) return;
    actualizacionEnCurso = true;
    
    try {
        usuarios.value = await usuarioService.cargarUsuarios();
    } catch (error) {
        mostrarToast('error', 'Error', 'Error al cargar usuarios');
        console.error(error);
    } finally {
        actualizacionEnCurso = false;
    }
};

const handleGuardadoExitoso = async () => {
    try {
        await actualizarUsuarios();
        mostrarToast('success', 'OK', 'Usuario guardado correctamente');
        dialogUsuarioVisible.value = false;
        usuario.value = { id: null, nombre: '', email: '', pass: '' };
    } catch (error) {
        mostrarToast('error', 'Error', 'Error al actualizar la lista');
    }
};

// Acciones de usuario
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
    }
};

const clickDeleteUsuario = async () => {
    try {
        await usuarioService.borrarUsuario(usuario.value.id);
        mostrarToast('success', 'OK', 'Usuario borrado correctamente');
        await actualizarUsuarios();
        borrarUsuarioDialog.value = false;
        usuario.value = { id: null, nombre: '', email: '', pass: '' };
    } catch (error) {
        mostrarToast('error', 'Error', 'Error al borrar usuario');
    }
};

const clickBorrarUsuariosSeleccionados = async () => {
    try {
        const ids = usuariosSeleccionados.value.map(val => val.id);
        const respuesta = await usuarioService.borrarUsuariosSeleccionados(ids);
        mostrarToast('success', 'Borrado múltiple', respuesta.message);
        await actualizarUsuarios();
    } catch (error) {
        mostrarToast('error', 'Error', 'Error al borrar usuarios');
    } finally {
        borrarUsuariosDialog.value = false;
        usuariosSeleccionados.value = null;
    }
};

// Añadir esta función
const enviarRecuperacionPassword = async (email) => {
    try {
        await usuarioService.recuperarPassword(email);
        mostrarToast('success', 'OK', 'Email de recuperación enviado correctamente');
    } catch (error) {
        mostrarToast('error', 'Error', 'Error al enviar email de recuperación');
        console.error(error);
    }
};

// Inicialización
onMounted(actualizarUsuarios);
onBeforeMount(() => filters.value = {
    global: { value: null, matchMode: 'contains' }
});
</script>

<template>
    <div class="layout-content">
        <div class="card">
            <div class="surface-section p-4">
                <!-- Título y Toolbar -->
                <div class="flex justify-content-between align-items-center mb-3">
                    <h5 class="m-0">Gestión de Usuarios</h5>
                </div>

                <Toolbar class="mb-4">
                    <template #start>
                        <Button label="Nuevo" icon="pi pi-plus" severity="secondary" outlined 
                            class="mr-2" @click="dialogUsuarioVisible = true; esModoEdicion = false" />
                        <Button label="Borrar" icon="pi pi-trash" severity="secondary" outlined
                            @click="borrarUsuariosDialog = true" 
                            :disabled="!usuariosSeleccionados?.length" />
                    </template>
                    <template #end>
                        <Button label="Exportar CSV" icon="pi pi-upload" severity="secondary" 
                            outlined @click="dt.exportCSV()" />
                    </template>
                </Toolbar>

                <!-- Buscador -->
                <div class="flex justify-content-end mb-4">
                    <span class="p-input-icon-left">
                        <i class="pi pi-search" />
                        <InputText v-model="filters['global'].value" placeholder="Buscar..." />
                    </span>
                </div>

                <!-- DataTable -->
                <DataTable ref="dt" :value="usuarios" v-model:selection="usuariosSeleccionados"
                    dataKey="id" :paginator="true" :rows="10" :filters="filters"
                    class="p-datatable-sm" stripedRows tableStyle="min-width: 50rem"
                    paginatorTemplate="FirstPageLink PrevPageLink PageLinks NextPageLink LastPageLink CurrentPageReport RowsPerPageDropdown"
                    :rowsPerPageOptions="[5, 10, 25]"
                    currentPageReportTemplate="Mostrando {first} a {last} de {totalRecords} usuarios">
                    
                    <Column selectionMode="multiple" style="width: 3rem" />
                    <Column field="nombre" header="Nombre" :sortable="true" style="width: 15rem" />
                    <Column field="email" header="Email" :sortable="true" style="width: 20rem" />
                    <Column field="ultimo_inicio_sesion" header="Último acceso" :sortable="true" 
                        style="width: 12rem">
                        <template #body="{ data }">
                            {{ data.ultimo_inicio_sesion ? new Date(data.ultimo_inicio_sesion).toLocaleString() : '-' }}
                        </template>
                    </Column>
                    <Column style="width: 12rem">
                        <template #body="{ data }">
                            <div class="flex gap-2 justify-content-center">
                                <Button icon="pi pi-pencil" 
                                    rounded outlined 
                                    @click="clickEditarUsuario(data.id)" 
                                    v-tooltip.top="'Editar usuario'"
                                />
                                <Button icon="pi pi-envelope" 
                                    rounded outlined 
                                    severity="info"
                                    @click="enviarRecuperacionPassword(data.email)"
                                    v-tooltip.top="'Enviar recuperación de contraseña'"
                                />
                                <Button icon="pi pi-trash" 
                                    severity="danger" 
                                    rounded outlined
                                    @click="usuario = data; borrarUsuarioDialog = true"
                                    v-tooltip.top="'Eliminar usuario'"
                                />
                            </div>
                        </template>
                    </Column>
                </DataTable>

                <!-- Diálogos -->
                <DialogUsuario v-model:visible="dialogUsuarioVisible"
                    :usuario="usuario" :esModoEdicion="esModoEdicion"
                    @guardar-usuario="handleGuardadoExitoso"
                    @error="msg => mostrarToast('error', 'Error', msg)" />

                <!-- Diálogos de confirmación -->
                <Dialog v-model:visible="borrarUsuarioDialog" header="Confirmar borrado" 
                    :style="{ width: '450px' }" :modal="true">
                    <div class="confirmation-content">
                        <i class="pi pi-exclamation-triangle mr-3" style="font-size: 2rem" />
                        <span>¿Seguro que quieres borrar el usuario <b>{{ usuario.email }}</b>?</span>
                    </div>
                    <template #footer>
                        <Button label="No" icon="pi pi-times" text @click="borrarUsuarioDialog = false" />
                        <Button label="Sí" icon="pi pi-check" text @click="clickDeleteUsuario" />
                    </template>
                </Dialog>

                <Dialog v-model:visible="borrarUsuariosDialog" header="Confirmar borrado múltiple"
                    :style="{ width: '450px' }" :modal="true">
                    <div class="confirmation-content">
                        <i class="pi pi-exclamation-triangle mr-3" style="font-size: 2rem" />
                        <span>¿Estás seguro de que quieres borrar los usuarios seleccionados?</span>
                    </div>
                    <template #footer>
                        <Button label="No" icon="pi pi-times" text @click="borrarUsuariosDialog = false" />
                        <Button label="Sí" icon="pi pi-check" text @click="clickBorrarUsuariosSeleccionados" />
                    </template>
                </Dialog>
            </div>
        </div>
        <Toast />
    </div>
</template>

<style lang="scss" scoped>
.confirmation-content {
    display: flex;
    align-items: center;
    justify-content: center;
}
</style>
