<script setup>
    import { ref } from 'vue';

    import AppMenuItem from './AppMenuItem.vue';

    const model = ref([
        {
            label: 'Actividad',
            icon: 'pi pi-briefcase',
            items: [
                {
                    label: 'Dashboard',
                    icon: 'pi pi-home',
                    to: '/pages/dashboard'
                }
            ]
        },
        {
            label: 'Recursos',
            icon: 'pi pi-briefcase',
            items: [
                {
                    label: 'Carteles',
                    icon: 'pi pi-desktop',
                    items: [
                        {
                            label: 'Gestión Carteles',
                            icon: 'pi pi-list',
                            to: '/crud/crudCarteles'
                        },
                        {
                            label: 'Tipos de Carteles',
                            icon: 'pi pi-tag',
                            to: '/crud/crudTiposCarteles'
                        }
                    ]
                },
                {
                    label: 'Parkings',
                    icon: 'pi pi-car',
                    to: '/crud/crudParking'
                }
            ]
        },
        {
            label: 'Recursos humanos',
            icon: 'pi pi-briefcase',
            items: [
                {
                    label: 'Usuarios',
                    icon: 'pi pi-user',
                    to: '/crud/crudUsuarios'
                }
            ]
        },
        {
            label: 'Autenticación',
            icon: 'pi pi-user',
            items: [
                {
                    label: 'Login',
                    icon: 'pi pi-sign-in',
                    to: '/auth/login'
                },
                {
                    label: 'Nueva Contraseña',
                    icon: 'pi pi-key',
                    to: '/auth/nuevaContrasenia'
                },
                {
                    label: 'Acceso Denegado',
                    icon: 'pi pi-lock',
                    to: '/auth/access'
                }
            ]
        },
        {
            label: 'Soporte Técnico',
            icon: 'pi pi-question',
            items: [
                {
                    label: 'Documentación',
                    icon: 'pi pi-book',
                    to: '/documentation'
                }
            ]
        }
    ]);
</script>

<template>
    <ul class="layout-menu">
        <template v-for="(item, i) in model" :key="item">
            <app-menu-item
                v-if="!item.separator"
                :item="item"
                :index="i"
            ></app-menu-item>
            <li v-if="item.separator" class="menu-separator"></li>
        </template>
    </ul>
</template>

<style lang="scss" scoped></style>
