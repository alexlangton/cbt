<script setup>
import LogoPrincipal from '@/components/LogoPrincipal.vue';
import FloatingConfigurator from '@/components/FloatingConfigurator.vue';
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useToast } from 'primevue/usetoast';
import { useLayout } from '@/layout/composables/layout';
import nuevaContraseniaService from '@/services/nuevaContraseniaService';
import Toast from 'primevue/toast';
import loginService from '@/services/loginService';

// Declaración de variables reactivas
const email = ref('');
const password = ref('');
const display = ref(false);

// Inicialización de router y toast
const router = useRouter();
const toast = useToast();

// Obtener configuración de layout y URL del logo
const { layoutConfig } = useLayout();

// Función para mostrar el toast
const mostrarToast = (severity, summary, detail) => {
    console.log('Toast:', { severity, summary, detail });
    toast.add({ 
        severity, 
        summary, 
        detail, 
        life: 10000,
        closable: true,
        sticky: severity === 'error'
    });
};

// Función para validar el formato del correo electrónico
const validarEmail = (email) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
};

// Función para manejar el inicio de sesión
const handleLogin = async (event) => {
    event.preventDefault();

    try {
        if (!email.value) {
            mostrarToast(
                'error',
                'Error iniciando sesión',
                'Por favor, ingresa correo electrónico'
            );
            return;
        }

        if (!validarEmail(email.value)) {
            mostrarToast(
                'error',
                'Error iniciando sesión',
                'Por favor, ingresa un correo electrónico válido'
            );
            return;
        }

        if (!password.value) {
            mostrarToast(
                'error',
                'Error iniciando sesión',
                'Por favor, ingresa contraseña'
            );
            return;
        }

        const response = await loginService.login(email.value, password.value);
        
        if (response.data.estado === 'exito' && response.data.datos.token) {
            // Guardamos toda la información relevante en localStorage
            localStorage.setItem('token', response.data.datos.token);
            localStorage.setItem('usuario', JSON.stringify(response.data.datos.usuario));
            localStorage.setItem('sesion', JSON.stringify(response.data.datos.sesion));
            
            mostrarToast(
                'success',
                'Éxito',
                `Bienvenido ${response.data.datos.usuario.nombre}`
            );
            
            setTimeout(() => {
                router.push({ name: 'dashboard' }); 
            }, 3000);
        } else {
            password.value = '';
            mostrarToast(
                'error',
                'Error de acceso',
                response.data.mensaje || 'Credenciales incorrectas. Por favor, verifica tus datos.'
            );
        }
    } catch (error) {
        console.error('Error al iniciar sesión:', error);
        password.value = '';
        mostrarToast(
            'error',
            'Error de conexión',
            error.response?.data?.mensaje || 'No se pudo conectar con el servidor. Por favor, intenta de nuevo más tarde.'
        );
    }
};

const open = () => {
    display.value = true;
};

const close = () => {
    display.value = false;
};

// Función para enviar el correo de recuperación
const enviarCorreoRecuperacion = async () => {
    try {
        if (!email.value || !validarEmail(email.value)) {
            mostrarToast(
                'error',
                'Error',
                'Por favor, ingresa un correo electrónico válido'
            );
            return;
        }

        const response = await nuevaContraseniaService.enviarEnlaceRecuperacion(email.value);
        console.log('Respuesta recuperación:', response.data);
        
        mostrarToast(
            'success',
            'Correo enviado',
            response.data.mensaje || `Se ha enviado un correo a ${email.value} con instrucciones para recuperar tu contraseña`
        );
        display.value = false;
    } catch (error) {
        console.error('Error al enviar correo de recuperación:', error);
        mostrarToast(
            'error',
            'Error',
            error.response?.data?.mensaje || 'Error al enviar correo de recuperación. Por favor, intenta de nuevo.'
        );
    }
};
</script>

<template>
    <Toast position="top-left" />
    <FloatingConfigurator />

    <div class="bg-surface-50 dark:bg-surface-950 flex items-center justify-center min-h-screen min-w-[100vw] overflow-hidden">
        <div class="flex flex-col items-center justify-center">
            <div style="border-radius: 56px; padding: 0.3rem; background: var(--primary-color);">
                <div class="w-full bg-surface-0 dark:bg-surface-900 py-20 px-8 sm:px-20" style="border-radius: 53px">
                    <div class="text-center mb-8">
                        <LogoPrincipal height="300" width="300" />
                    </div>

                    <form @submit.prevent="handleLogin">
                        <div>
                            <label for="email" class="block text-900 text-xl font-medium mb-2">
                                Correo electrónico
                            </label>
                            <InputText
                                id="email"
                                name="email"
                                type="email"
                                placeholder="Correo electrónico"
                                class="w-full md:w-30rem mb-5"
                                style="padding: 1rem"
                                v-model="email"
                                autocomplete="username email"
                            />

                            <label for="password_input" class="block text-900 font-medium text-xl mb-2">
                                Contraseña
                            </label>
                            <Password 
                                id="password" 
                                name="password"
                                v-model="password" 
                                placeholder="Contraseña" 
                                :toggleMask="true"
                                class="w-full mb-3" 
                                inputClass="w-full" 
                                :inputStyle="{ padding: '1rem' }"
                                :feedback="false"
                                :inputProps="{
                                    id: 'password_input',
                                    name: 'password',
                                    autocomplete: 'current-password'
                                }"
                            />

                            <div class="flex align-items-center justify-content-between mb-5 gap-5">
                                <div class="flex align-items-center"></div>
                                <a @click="open" class="font-medium no-underline ml-2 text-right cursor-pointer"
                                    style="color: var(--primary-color)">
                                    ¿Has olvidado tu contraseña?
                                </a>
                            </div>

                            <Button 
                                label="Iniciar sesión" 
                                class="w-full p-3 text-xl"
                                type="submit"
                            />
                        </div>
                    </form>

                    <Dialog header="Recuperar contraseña" v-model:visible="display"
                        :breakpoints="{ '960px': '75vw' }" :style="{ width: '30vw' }" :modal="true">
                        <div class="p-fluid">
                            <p class="mb-4">
                                Se enviará un correo electrónico a la
                                dirección proporcionada con un enlace para
                                restablecer tu contraseña. Por favor, revisa
                                tu bandeja de entrada y sigue las
                                instrucciones proporcionadas en el correo
                                electrónico.
                            </p>

                            <label class="block text-900 text-xl font-medium mb-2">
                                Correo electrónico
                            </label>
                            <InputText id="emailRecuperacion" type="text" placeholder="Dirección de correo electrónico"
                                class="w-full mb-5" style="padding: 1rem" v-model="emailRecuperacion" />
                        </div>
                        <template #footer>
                            <Button label="Enviar" @click="enviarCorreoRecuperacion" icon="pi pi-check"
                                class="w-full p-3 text-xl" />
                            <Button label="Cancelar" @click="close" icon="pi pi-times" class="w-full p-3 text-xl" />
                        </template>
                    </Dialog>
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
