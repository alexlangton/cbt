import AppLayout from '@/layout/AppLayout.vue';
import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            redirect: '/auth/login' // Redirect root to /auth/login
        },
        {
            path: '/auth/login',
            name: 'login',
            component: () => import('@/views/pages/auth/Login.vue')
        },
        {
            path: '/auth/nuevaContrasenia', // Make sure this is publicly accessible
            name: 'nuevaContrasenia',
            component: () => import('@/views/pages/auth/NuevaContrasenia.vue'),
            meta: { requiresAuth: false } // Ensure no auth required
        },
        {
            path: '/app',
            component: AppLayout,
            children: [
                {
                    path: '/pages/dashboard',
                    name: 'dashboard',
                    component: () => import('@/views/pages/Dashboard.vue')
                },
                {
                    path: '/crud/crudCarteles',
                    name: 'crudCarteles',
                    component: () => import('@/views/crud/crudCarteles.vue')
                },
                {
                    path: '/crud/crudTiposCarteles',
                    name: 'crudTiposCarteles',
                    component: () =>
                        import('@/views/crud/crudTiposCarteles.vue')
                },
                {
                    path: '/crud/crudParking',
                    name: 'crudParking',
                    component: () => import('@/views/crud/crudParking.vue')
                },
                {
                    path: '/crud/crudUsuarios',
                    name: 'crudUsuarios',
                    component: () => import('@/views/crud/crudUsuarios.vue')
                },
                {
                    path: '/documentation',
                    name: 'documentation',
                    component: () =>
                        import('@/views/utilidades/Documentation.vue')
                }
            ]
        },
        {
            path: '/pages/notfound',
            name: 'notfound',
            component: () => import('@/views/pages/NotFound.vue')
        },
        {
            path: '/auth/access',
            name: 'accessDenied',
            component: () => import('@/views/pages/auth/Access.vue')
        },
        {
            path: '/auth/error',
            name: 'error',
            component: () => import('@/views/pages/auth/Error.vue')
        },
        // Ruta para 404
        {
            path: '/:pathMatch(.*)*',
            redirect: '/pages/notfound' // Redirección para rutas no encontradas
        }
    ]
});

export default router;