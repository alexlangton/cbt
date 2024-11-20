<script setup>
    import usuarioService from '@/services/usuarioService';
    import { ref, watch } from 'vue';
    import Dialog from 'primevue/dialog';
    import InputText from 'primevue/inputtext';
    import Password from 'primevue/password';
    import Button from 'primevue/button';

    const props = defineProps({
        visible: {
            type: Boolean,
            required: true
        },
        usuario: {
            type: Object,
            required: true
        },
        esModoEdicion: {
            type: Boolean,
            default: false
        }
    });

    const emit = defineEmits(['update:visible', 'guardar-usuario', 'error']);

    const usuario = ref({
        id: props.usuario?.id || null,
        nombre: props.usuario?.nombre || '',
        email: props.usuario?.email || '',
        pass: props.usuario?.pass || ''
    });

    const submitted = ref(false);
    const cargando = ref(false);

    watch(
        () => props.usuario,
        (newVal) => {
            if (newVal) {
                usuario.value = {
                    id: newVal.id || null,
                    nombre: newVal.nombre || '',
                    email: newVal.email || '',
                    pass: newVal.pass || ''
                };
            }
        },
        { deep: true }
    );

    const validarUsuario = () => {
        if (!usuario.value.nombre?.trim()) {
            return { valido: false, mensaje: 'El nombre es obligatorio' };
        }
        if (!usuario.value.email?.trim()) {
            return { valido: false, mensaje: 'El email es obligatorio' };
        }
        if (!props.esModoEdicion && !usuario.value.pass?.trim()) {
            return {
                valido: false,
                mensaje: 'La contraseña es obligatoria para nuevos usuarios'
            };
        }
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(usuario.value.email)) {
            return {
                valido: false,
                mensaje: 'El formato del email no es válido'
            };
        }
        return { valido: true };
    };

    const guardarUsuario = async () => {
        submitted.value = true;
        const validacion = validarUsuario();

        if (!validacion.valido) {
            emit('error', validacion.mensaje);
            return;
        }

        try {
            cargando.value = true;
            const resultado = await usuarioService.guardarUsuario(
                usuario.value,
                !props.esModoEdicion
            );

            emit('guardar-usuario', resultado);
            cerrarDialog();
        } catch (error) {
            console.error('Error al guardar usuario:', error);
            emit('error', error.message || 'Error al guardar usuario');
        } finally {
            cargando.value = false;
        }
    };

    const cerrarDialog = () => {
        usuario.value = JSON.parse(JSON.stringify(props.usuario));
        submitted.value = false;
        emit('update:visible', false);
    };
</script>

<template>
    <Dialog
        :visible="visible"
        :style="{ width: '500px' }"
        :header="esModoEdicion ? 'Editar Usuario' : 'Nuevo Usuario'"
        :modal="true"
        class="p-fluid"
        :closable="!cargando"
        :closeOnEscape="!cargando"
        @update:visible="cerrarDialog"
    >
        <div class="flex flex-col gap-4 w-full">
            <div class="flex flex-col gap-1">
                <label for="nombre" class="font-bold">Nombre</label>
                <span class="p-input-icon-left w-full">
                    <i class="pi pi-user" />
                    <InputText
                        id="nombre"
                        v-model.trim="usuario.nombre"
                        placeholder="Ingrese el nombre"
                        required="true"
                        autofocus
                        :class="{ 'p-invalid': submitted && !usuario.nombre }"
                    />
                </span>
                <small class="p-error" v-if="submitted && !usuario.nombre">
                    El nombre es obligatorio.
                </small>
            </div>

            <div class="flex flex-col gap-1">
                <label for="email" class="font-bold">Email</label>
                <span class="p-input-icon-left w-full">
                    <i class="pi pi-envelope" />
                    <InputText
                        id="email"
                        v-model.trim="usuario.email"
                        placeholder="correo@ejemplo.com"
                        required="true"
                        type="email"
                        :class="{ 'p-invalid': submitted && !usuario.email }"
                    />
                </span>
                <small class="p-error" v-if="submitted && !usuario.email">
                    El email es obligatorio.
                </small>
            </div>

            <div v-if="!esModoEdicion" class="flex flex-col gap-1">
                <label for="password" class="font-bold">Contraseña</label>
                <Password
                    id="password"
                    v-model="usuario.pass"
                    placeholder="Ingrese la contraseña"
                    :feedback="true"
                    :toggleMask="true"
                    class="w-full"
                    :class="{ 'p-invalid': submitted && !usuario.pass }"
                >
                    <template #header>
                        <h6>Ingrese una contraseña</h6>
                    </template>
                    <template #footer>
                        <p class="mt-2">Sugerencias:</p>
                        <ul class="pl-2 ml-2 mt-0 line-height-3">
                            <li>Al menos una minúscula</li>
                            <li>Al menos una mayúscula</li>
                            <li>Al menos un número</li>
                            <li>Mínimo 8 caracteres</li>
                        </ul>
                    </template>
                </Password>
                <small class="p-error" v-if="submitted && !usuario.pass">
                    La contraseña es obligatoria para nuevos usuarios.
                </small>
            </div>
        </div>

        <template #footer>
            <div class="flex justify-content-end gap-2">
                <Button
                    label="Cancelar"
                    icon="pi pi-times"
                    class="p-button-text"
                    @click="cerrarDialog"
                    :disabled="cargando"
                />
                <Button
                    label="Guardar"
                    icon="pi pi-check"
                    class="p-button-primary"
                    @click="guardarUsuario"
                    :loading="cargando"
                />
            </div>
        </template>
    </Dialog>
</template>

<style scoped>
:deep(.p-password input) {
    width: 100%;
}

:deep(.p-password-panel) {
    transform-origin: top;
}

:deep(.p-dialog-header) {
    border-bottom: 1px solid var(--surface-border);
    padding: 1.5rem;
}

:deep(.p-dialog-content) {
    padding: 1.5rem;
}

:deep(.p-dialog-footer) {
    border-top: 1px solid var(--surface-border);
    padding: 1.5rem;
}

:deep(.p-inputtext) {
    padding-left: 2.5rem;
}

.p-input-icon-left {
    position: relative;
}

.p-input-icon-left i {
    position: absolute;
    left: 0.75rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-color-secondary);
}

.p-invalid {
    border-color: var(--red-500) !important;
}

.p-error {
    color: var(--red-500);
    font-size: 0.875rem;
    margin-top: 0.25rem;
}
</style>
