<script setup>
import { ref, onMounted } from 'vue';

const endpoints = ref({
    public: {
        title: 'Rutas Públicas',
        icon: 'pi pi-unlock',
        routes: [
            {
                method: 'POST',
                path: '/api/public/login',
                controller: 'AutenticacionController->login',
                description: 'Autenticación de usuarios en el sistema'
            },
            {
                method: 'POST',
                path: '/api/public/logout',
                controller: 'AutenticacionController->logout',
                description: 'Cierre de sesión de usuarios'
            },
            {
                method: 'POST',
                path: '/api/public/recuperarPassword',
                controller: 'AutenticacionController->recuperarPassword',
                description: 'Recuperación de contraseña'
            }
        ]
    },
    system: {
        title: 'Rutas del Sistema',
        icon: 'pi pi-cog',
        routes: [
            {
                method: 'GET',
                path: '/api/test',
                controller: 'ParkingsController->obtener',
                description: 'Test de conexión'
            },
            {
                method: 'POST',
                path: '/api/crearUsuario',
                controller: 'CrearUsuarioController->crearUsuario',
                description: 'Creación de nuevos usuarios'
            },
            {
                method: 'GET',
                path: '/api/datosLeaflet',
                controller: 'LeafletController->obtenerDatosLeaflet',
                description: 'Obtención de datos para el mapa'
            },
            {
                method: 'GET',
                path: '/api/obtenerCartelesActualizados',
                controller: 'CartelController->obtenerCartelesActualizados',
                description: 'Obtención de carteles actualizados'
            }
        ]
    },
    backup: {
        title: 'Rutas de Backup',
        icon: 'pi pi-database',
        routes: [
            {
                method: 'GET',
                path: '/api/database/download',
                controller: 'DatabaseController->download',
                description: 'Descarga de copia de seguridad de la base de datos'
            },
            {
                method: 'POST',
                path: '/api/backup/create',
                controller: 'BackupController->createBackup',
                description: 'Creación de nueva copia de seguridad'
            }
        ]
    },
    crud: {
        title: 'Rutas CRUD',
        icon: 'pi pi-table',
        resources: ['parkings', 'carteles', 'tiposcarteles', 'usuarios'],
        operations: [
            {
                method: 'GET',
                path: '/@recurso',
                action: 'obtenerconfiltros',
                description: 'Obtener listado con filtros'
            },
            {
                method: 'GET',
                path: '/@recurso/@id',
                action: 'obtener',
                description: 'Obtener elemento por ID'
            },
            {
                method: 'POST',
                path: '/@recurso',
                action: 'guardarnuevo',
                description: 'Crear nuevo elemento'
            },
            {
                method: 'PUT',
                path: '/@recurso/@id',
                action: 'guardar',
                description: 'Actualizar elemento existente'
            },
            {
                method: 'DELETE',
                path: '/@recurso/@id',
                action: 'borrar',
                description: 'Eliminar elemento'
            }
        ]
    }
});

const getMethodColor = (method) => {
    const colors = {
        'GET': 'bg-blue-100 text-blue-700',
        'POST': 'bg-green-100 text-green-700',
        'PUT': 'bg-orange-100 text-orange-700',
        'DELETE': 'bg-red-100 text-red-700'
    };
    return colors[method] || 'bg-gray-100 text-gray-700';
};
</script>

<template>
    <div class="grid">
        <div class="col-12">
            <div class="card">
                <h5>Documentación de API</h5>
                <p class="text-secondary mb-4">
                    Documentación completa de los endpoints disponibles en el sistema.
                </p>

                <TabView>
                    <!-- Rutas Públicas, Sistema y Backup -->
                    <TabPanel v-for="(section, key) in endpoints" 
                             :key="key" 
                             :header="section.title">
                        <div class="card mb-0">
                            <div class="flex align-items-center mb-4">
                                <i :class="[section.icon, 'text-xl mr-2']"></i>
                                <h6 class="m-0">{{ section.title }}</h6>
                            </div>

                            <div v-if="key !== 'crud'" class="surface-ground p-4 border-round">
                                <div v-for="route in section.routes" 
                                     :key="route.path"
                                     class="surface-card p-3 border-round mb-3 endpoint-card">
                                    <div class="flex align-items-center mb-2">
                                        <span :class="['px-2 py-1 border-round mr-2 font-medium', getMethodColor(route.method)]">
                                            {{ route.method }}
                                        </span>
                                        <code class="text-primary">{{ route.path }}</code>
                                    </div>
                                    <div class="text-600 mb-2">{{ route.description }}</div>
                                    <div class="text-500 text-sm">
                                        <i class="pi pi-code mr-2"></i>
                                        {{ route.controller }}
                                    </div>
                                </div>
                            </div>

                            <!-- Sección especial para CRUD -->
                            <div v-else class="surface-ground p-4 border-round">
                                <p class="text-600 mb-3">
                                    Recursos disponibles: 
                                    <span v-for="resource in section.resources" 
                                          :key="resource"
                                          class="mr-2 inline-block bg-primary-100 text-primary-700 px-2 py-1 border-round">
                                        {{ resource }}
                                    </span>
                                </p>

                                <div v-for="op in section.operations" 
                                     :key="op.path"
                                     class="surface-card p-3 border-round mb-3 endpoint-card">
                                    <div class="flex align-items-center mb-2">
                                        <span :class="['px-2 py-1 border-round mr-2 font-medium', getMethodColor(op.method)]">
                                            {{ op.method }}
                                        </span>
                                        <code class="text-primary">{{ op.path }}</code>
                                    </div>
                                    <div class="text-600 mb-2">{{ op.description }}</div>
                                    <div class="text-500 text-sm">
                                        <i class="pi pi-code mr-2"></i>
                                        Controller->{{ op.action }}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </TabPanel>
                </TabView>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>
.endpoint-card {
    transition: transform 0.2s, box-shadow 0.2s;
    
    &:hover {
        transform: translateY(-2px);
        box-shadow: var(--card-shadow);
    }
}

code {
    font-family: Monaco, Consolas, monospace;
    background: var(--surface-ground);
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
}

:deep(.p-tabview-panels) {
    padding: 1.5rem 0 0 0;
}

:deep(.p-tabview-nav) {
    border-bottom: 1px solid var(--surface-border);
}
</style>