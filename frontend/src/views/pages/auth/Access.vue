<script setup>
import FloatingConfigurator from '@/components/FloatingConfigurator.vue';
import LogoPrincipal from '@/components/LogoPrincipal.vue';
</script>

<template>
    <FloatingConfigurator />
    <div
        class="bg-surface-50 dark:bg-surface-950 flex items-center justify-center min-h-screen min-w-[100vw] overflow-hidden">
        <div class="flex flex-col items-center justify-center">
            <div style="
                    border-radius: 56px;
                    padding: 0.3rem;
                    background: var(--primary-color);
                ">
                <div class="w-full bg-surface-0 dark:bg-surface-900 py-20 px-8 sm:px-20 flex flex-col items-center"
                    style="border-radius: 53px">
                    <div class="gap-4 flex flex-col items-center">
                        <div class="flex justify-center items-center border-2 border-green-500 rounded-full" style="
                                width: 3.2rem;
                                height: 3.2rem;
                                border: 2px solid var(--primary-color);
                            ">
                            <i class="pi pi-fw pi-lock !text-2xl" style="color: var(--primary-color)"></i>
                        </div>
                        <h1 class="text-surface-900 dark:text-surface-0 font-bold text-4xl lg:text-5xl mb-2">
                            Acceso denegado
                        </h1>
                        <span class="text-muted-color mb-8">Actualmente no tienes los permisos necesarios. Por
                            favor, conctacta con el administrador del
                            sitio.</span>
                        <div class="text-center mb-8">
                            <LogoPrincipal height="300" width="300" />
                        </div>
                        <div class="col-span-12 mt-8 text-center">
                            <Button as="router-link" label="Ir a inicio" to="/" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
