import AppLayout from '@/layout/AppLayout.vue';
import { createRouter, createWebHistory } from 'vue-router';

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            name: 'root',
            redirect: () => {
                const token = localStorage.getItem('token');
                return token ? { name: 'dashboard' } : { name: 'login' };
            }
        },
        {
            path: '/auth/login',
            name: 'login',
            component: () => import('@/views/pages/auth/Login.vue'),
            meta: { requiresAuth: false }
        },
        {
            path: '/auth/nuevaContrasenia',
            name: 'nuevaContrasenia',
            component: () => import('@/views/pages/auth/NuevaContrasenia.vue'),
            meta: { requiresAuth: false }
        },
        {
            path: '/app',
            component: AppLayout,
            children: [
                {
                    path: '/pages/dashboard',
                    name: 'dashboard',
                    component: () => import('@/views/pages/Dashboard.vue'),
                    meta: { requiresAuth: true }
                },
                {
                    path: '/crud/crudCarteles',
                    name: 'crudCarteles',
                    component: () => import('@/views/crud/crudCarteles.vue')
                },
                {
                    path: '/crud/crudTiposCarteles',
                    name: 'crudTiposCarteles',
                    component: () => import('@/views/crud/crudTiposCarteles.vue')
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
                    component: () => import('@/views/utilidades/Documentation.vue')
                },
                {
                    path: '/pages/backup',
                    name: 'backup',
                    component: () => import('@/views/pages/BackupView.vue'),
                    meta: {
                        breadcrumb: [{ label: 'Backup Base de Datos' }]
                    }
                },
                {
                    path: '/pages/logs',
                    name: 'logs',
                    component: () => import('@/views/pages/LogViewer.vue'),
                    meta: {
                        breadcrumb: [{ label: 'Logs del Sistema' }]
                    }
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
        // Ruta para manejar rutas no encontradas
        {
            path: '/:pathMatch(.*)*',
            redirect: '/auth/login' // Cambiado: redirige a login en lugar de notfound
        }
    ]
});

// Agregar navegación guard global
router.beforeEach((to, from, next) => {
    const token = localStorage.getItem('token');
    
    // Si la ruta requiere autenticación y no hay token
    if (to.meta.requiresAuth && !token) {
        next({ name: 'login' });
    }
    // Si intenta acceder a login con un token válido
    else if (to.name === 'login' && token) {
        next({ name: 'dashboard' });
    }
    // En cualquier otro caso, permitir la navegación
    else {
        next();
    }
});

export default router;
