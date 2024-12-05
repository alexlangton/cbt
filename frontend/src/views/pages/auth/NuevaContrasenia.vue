<script setup>
    import FloatingConfigurator from '@/components/FloatingConfigurator.vue';
    import { useLayout } from '@/layout/composables/layout';
    import { useToast } from 'primevue/usetoast';
    import { computed, onMounted, ref, watch } from 'vue';
    import { useRouter } from 'vue-router';
    import LogoPrincipal from '@/components/LogoPrincipal.vue';
    import nuevaContraseniaService from '@/services/nuevaContraseniaService';

    // Variables reactivas
    const email = ref('');
    const token = ref('');
    const password = ref('');
    const confirmPassword = ref('');
    const display = ref(false);

    // Inicialización de router y toast
    const router = useRouter();
    const toast = useToast();

    const tamanioMinimo = 3;

    // Lista de condiciones de validación
    const condiciones = ref([
        `La contraseña debe tener al menos ${tamanioMinimo} caracteres.`,
        'La contraseña debe contener al menos una letra mayúscula.',
        'La contraseña debe contener al menos un número.',
        'Las contraseñas deben coincidir.'
    ]);

    // Obtener configuración de layout y URL del logo
    const { layoutConfig } = useLayout();

    // Función para mostrar el toast
    const mostrarToast = (severity, summary, detail) => {
        toast.add({ severity, summary, detail, life: 3000 });
    };

    // Validar la contraseña y actualizar las condiciones
    const validarContrasenia = () => {
        const nuevaCondiciones = [];
        const hasNumber = /\d/;
        const hasUpperCase = /[A-Z]/;

        if (password.value.length < tamanioMinimo) {
            nuevaCondiciones.push(
                `La contraseña debe tener al menos ${tamanioMinimo} caracteres.`
            );
        }
        if (!hasUpperCase.test(password.value)) {
            nuevaCondiciones.push(
                'La contraseña debe contener al menos una letra mayúscula.'
            );
        }
        if (!hasNumber.test(password.value)) {
            nuevaCondiciones.push(
                'La contraseña debe contener al menos un número.'
            );
        }
        if (password.value !== confirmPassword.value) {
            nuevaCondiciones.push('Las contraseñas deben coincidir.');
        }

        condiciones.value = nuevaCondiciones;
        return nuevaCondiciones.length === 0;
    };

    // Computed para habilitar el botón de guardar
    const esValidoGuardar = computed(() => {
        return validarContrasenia();
    });

    // Método para guardar la nueva contraseña
    const guardarContrasenia = () => {
        if (!validarContrasenia()) {
            mostrarToast(
                'error',
                'Error',
                'La contraseña no cumple con las condiciones requeridas.'
            );
            return;
        }

        if (!token.value) {
            mostrarToast('error', 'Error', 'El token es requerido.');
            return;
        }

        nuevaContraseniaService.cambiarPassword(email.value, token.value, password.value)
            .then(() => {
                mostrarToast(
                    'success',
                    'Contraseña actualizada',
                    'Tu contraseña ha sido actualizada exitosamente.'
                );
                router.push('/pages/dashboard');
            })
            .catch((error) => {
                console.error('Error al guardar nueva contraseña:', error);
                mostrarToast(
                    'error',
                    'Error',
                    'Error al guardar la nueva contraseña.'
                );
            });
    };

    // Observar cambios en la contraseña y la confirmación y mostrar mensajes toast
    watch([password, confirmPassword], validarContrasenia);

    // Obtener el parámetro email de la URL y asignarlo a la variable email
    onMounted(() => {
        const urlParams = new URLSearchParams(window.location.search);
        email.value = urlParams.get('email') || '';
        token.value = urlParams.get('token') || '';
        
        console.log('Email:', email.value);
        console.log('Token:', token.value);
    });

    // También podemos agregar un watch para ver cuando cambian estos valores
    watch([email, token], ([newEmail, newToken]) => {
        console.log('Email actualizado:', newEmail);
        console.log('Token actualizado:', newToken);
    });
</script>

<template>
    <FloatingConfigurator />

    <div
        class="bg-surface-50 dark:bg-surface-950 flex items-center justify-center min-h-screen min-w-[100vw] overflow-hidden"
    >
        <div class="flex flex-col items-center justify-center">
            <div
                style="
                    border-radius: 56px;
                    padding: 0.3rem;
                    background: var(--primary-color);
                "
            >
                <div
                    class="w-full bg-surface-0 dark:bg-surface-900 py-20 px-8 sm:px-20"
                    style="border-radius: 53px"
                >
                    <div class="text-center mb-8">
                        <LogoPrincipal height="300" width="300" />
                    </div>

                    <div>
                        <InputText
                            id="email1"
                            type="text"
                            placeholder="Dirección de correo electrónico"
                            class="w-full mb-3"
                            style="padding: 1rem"
                            v-model="email"
                            disabled
                        />

                        <label
                            for="password1"
                            class="block text-900 font-medium text-xl mb-2"
                        >
                            Nueva Contraseña
                        </label>
                        <Password
                            id="password1"
                            v-model="password"
                            placeholder="Contraseña"
                            :toggleMask="true"
                            class="w-full mb-3"
                            inputClass="w-full"
                            :inputStyle="{ padding: '1rem' }"
                            @keyup.enter="guardarContrasenia"
                        ></Password>

                        <label class="block text-900 font-medium text-xl mb-2">
                            Confirmar Contraseña
                        </label>
                        <Password
                            id="confirmPassword1"
                            v-model="confirmPassword"
                            placeholder="Confirmar Contraseña"
                            :toggleMask="true"
                            class="w-full mb-5"
                            inputClass="w-full"
                            :inputStyle="{ padding: '1rem' }"
                            @keyup.enter="guardarContrasenia"
                        ></Password>

                        <Button
                            label="Guardar"
                            class="w-full p-3 text-xl"
                            :disabled="!esValidoGuardar"
                            @click="guardarContrasenia"
                        ></Button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
    .pi-eye {
        transform: scale(1.6);
        margin-right: 1rem;
    }

    .pi-eye-slash {
        transform: scale(1.6);
        margin-right: 1rem;
    }

    .shadow {
        filter: url(#svgShadow);
    }
</style>
