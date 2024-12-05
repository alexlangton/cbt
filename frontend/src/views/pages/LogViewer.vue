<template>
    <div class="card">
        <div class="surface-section p-4">
            <!-- Título -->
            <div class="flex justify-content-between align-items-center mb-3">
                <h5 class="m-0">Registro de Actividad</h5>
            </div>

            <!-- Toolbar con botones y búsqueda -->
            <Toolbar class="mb-4">
                <template #start>
                    <div class="flex gap-2">
                        <Button 
                            type="button" 
                            icon="pi pi-filter-slash" 
                            label="Limpiar filtros" 
                            severity="secondary"
                            outlined 
                            @click="clearFilter()" 
                        />
                        <Button
                            type="button"
                            icon="pi pi-trash"
                            label="Borrar logs"
                            severity="danger"
                            outlined
                            @click="confirmarBorradoLogs"
                        />
                    </div>
                </template>

                <template #end>
                    <IconField>
                        <InputIcon>
                            <i class="pi pi-search" />
                        </InputIcon>
                        <InputText 
                            v-model="filters['global'].value" 
                            placeholder="Buscar..." 
                            class="p-inputtext-sm"
                        />
                    </IconField>
                </template>
            </Toolbar>

            <!-- DataTable -->
            <DataTable 
                v-model:filters="filters"
                :value="logs"
                paginator
                :rows="15"
                dataKey="id"
                filterDisplay="menu"
                :loading="loading"
                :globalFilterFields="['contenido', 'tipo', 'metadata']"
                class="p-datatable-sm"
                :rowHover="true"
                responsiveLayout="scroll"
                stripedRows
                :scrollable="true"
                scrollHeight="flex"
                size="small"
            >
                <Column field="fecha" header="Fecha" dataType="date" :sortable="true" style="min-width: 10rem">
                    <template #body="{ data }">
                        {{ formatearFecha(data.fecha) }}
                    </template>
                    <template #filter="{ filterModel }">
                        <Calendar 
                            v-model="filterModel.value"
                            :showTime="true"
                            :showSeconds="true"
                            placeholder="Seleccionar fecha"
                        />
                    </template>
                </Column>

            <Column 
                field="tipo" 
                header="Tipo" 
                :sortable="true"
                style="width: 15%"
            >
                <template #body="{ data }">
                    <Tag :value="getTipoLabel(data.tipo)" 
                         :severity="getSeverity(data.tipo)"
                    >
                        <template #icon>
                            <i :class="getIconoTipo(data.tipo)"></i>
                        </template>
                    </Tag>
                </template>
                <template #filter="{ filterModel }">
                    <Dropdown
                        v-model="filterModel.value"
                        :options="tiposLog"
                        optionLabel="label"
                        optionValue="value"
                        placeholder="Seleccionar tipo"
                        class="w-full"
                    />
                </template>
            </Column>

            <Column field="contenido" header="Contenido" :sortable="true" style="min-width: 12rem">
                <template #filter="{ filterModel }">
                    <InputText 
                        v-model="filterModel.value" 
                        type="text" 
                        class="w-full"
                        placeholder="Buscar en contenido" 
                    />
                </template>
            </Column>

            <Column field="metadata" header="Metadata" :sortable="true" style="min-width: 12rem">
                <template #body="{ data }">
                    <Button
                        v-if="data.metadata"
                        icon="pi pi-eye"
                        text
                        rounded
                        @click="mostrarMetadata(data)"
                    />
                </template>
                <template #filter="{ filterModel }">
                    <InputText 
                        v-model="filterModel.value" 
                        type="text" 
                        class="w-full"
                        placeholder="Buscar en metadata" 
                    />
                </template>
            </Column>

                <Column field="id_usuario" header="Usuario" :sortable="true" style="min-width: 12rem">
                    <template #body="{ data }">
                        <div class="flex align-items-center gap-2">
                            <Tag 
                                :value="data.id_usuario ? 'Usuario' : 'Sistema'"
                                :severity="data.id_usuario ? 'info' : 'warning'"
                            />
                            <span v-if="data.id_usuario">
                                ID: {{ data.id_usuario }}
                                <span v-if="data.usuario" class="text-sm text-500">
                                    ({{ data.usuario }})
                                </span>
                            </span>
                        </div>
                    </template>
                    <template #filter="{ filterModel }">
                        <InputText 
                            v-model="filterModel.value" 
                            type="text" 
                            class="w-full"
                            placeholder="Buscar por ID o nombre" 
                        />
                    </template>
                </Column>
            </DataTable>
        </div>

        <!-- Diálogo para mostrar metadata -->
        <Dialog 
            v-model:visible="metadataDialog" 
            modal 
            header="Detalles de Metadata"
            :style="{ width: '50vw' }"
            :maximizable="true"
            :dismissableMask="true"
        >
            <div class="metadata-content">
                <div class="metadata-body">
                    <pre class="metadata-json">{{ formatearMetadata(logSeleccionado?.metadata) }}</pre>
                </div>
            </div>
        </Dialog>

        <!-- Diálogo de confirmación de borrado -->
        <Dialog
            v-model:visible="borrarLogsDialog"
            :style="{ width: '450px' }"
            header="Confirmar borrado"
            :modal="true"
        >
            <div class="confirmation-content">
                <i class="pi pi-exclamation-triangle mr-3" style="font-size: 2rem; color: var(--orange-500)" />
                <span>¿Está seguro de que desea borrar todos los logs?</span>
            </div>
            <template #footer>
                <Button
                    label="No"
                    icon="pi pi-times"
                    outlined
                    @click="borrarLogsDialog = false"
                />
                <Button
                    label="Sí"
                    icon="pi pi-check"
                    severity="danger"
                    @click="handleBorrarLogs"
                    autofocus
                />
            </template>
        </Dialog>
    </div>
</template>

<script setup>
import { ref } from 'vue'
import { useLogs } from '@/composables/useLogs'
import DataTable from 'primevue/datatable'
import Column from 'primevue/column'
import Button from 'primevue/button'
import Dialog from 'primevue/dialog'
import Tag from 'primevue/tag'
import Calendar from 'primevue/calendar'
import InputText from 'primevue/inputtext'
import Dropdown from 'primevue/dropdown'
import Toolbar from 'primevue/toolbar'
import IconField from 'primevue/iconfield'
import InputIcon from 'primevue/inputicon'

// Usar el composable
const {
    logs,
    loading,
    filters,
    tiposLog,
    opcionesOrigen,
    borrarLogsDialog,
    cargarLogs,
    formatearFecha,
    getSeverity,
    clearFilter,
    borrarLogs
} = useLogs()

// Estados locales del componente
const metadataDialog = ref(false)
const logSeleccionado = ref(null)

// Handlers
const mostrarMetadata = (log) => {
    logSeleccionado.value = log
    metadataDialog.value = true
}

const formatearMetadata = (metadata) => {
    try {
        return typeof metadata === 'string' 
            ? JSON.stringify(JSON.parse(metadata), null, 2) 
            : JSON.stringify(metadata, null, 2)
    } catch (e) {
        return metadata
    }
}

// Handler para borrar logs
const handleBorrarLogs = async () => {
    console.log('Iniciando proceso de borrado')
    try {
        await borrarLogs()
        console.log('Borrado completado')
    } catch (error) {
        console.error('Error en handleBorrarLogs:', error)
    }
}

// Handler para confirmar borrado
const confirmarBorradoLogs = () => {
    console.log('Abriendo diálogo de confirmación')
    borrarLogsDialog.value = true
}

// Funciones para manejar los iconos y labels de tipo
const LOG_TYPES = {
    ERROR: {
        value: 'error',
        label: 'Error',
        icon: 'pi pi-exclamation-circle',
        severity: 'danger'
    },
    DEBUG: {
        value: 'debug',
        label: 'Debug',
        icon: 'pi pi-code',
        severity: 'info'
    },
    INFO: {
        value: 'info',
        label: 'Info',
        icon: 'pi pi-info-circle',
        severity: 'success'
    },
    SQL: {
        value: 'sql',
        label: 'SQL',
        icon: 'pi pi-database',
        severity: 'warning'
    },
    VALIDADOR: {
        value: 'validador',
        label: 'Validación',
        icon: 'pi pi-check-circle',
        severity: 'success'
    }
};

const getIconoTipo = (tipo) => LOG_TYPES[tipo.toUpperCase()]?.icon ?? 'pi pi-info-circle';
const getTipoLabel = (tipo) => LOG_TYPES[tipo.toUpperCase()]?.label ?? tipo;
</script>

<style lang="scss" scoped>
.card {
    margin: 0;
    height: calc(100vh - 9rem);
    display: flex;
    flex-direction: column;
    background: var(--surface-card);
    border-radius: var(--border-radius);
    padding: 1.5rem;
}

:deep(.p-datatable) {
    .p-datatable-wrapper {
        border-radius: var(--border-radius);
    }

    .p-datatable-header {
        background: transparent;
        padding: 1rem;
        
        h5 {
            color: var(--surface-900);
            font-weight: 600;
        }
    }

    .p-datatable-thead > tr > th {
        background: var(--surface-section);
        padding: 0.5rem;
        border: none;
        font-weight: 600;
        color: var(--surface-900);
    }

    .p-datatable-tbody > tr {
        background: transparent;
        
        > td {
            padding: 0.5rem;
            border: none;
            border-bottom: 1px solid var(--surface-border);
        }

        &:last-child > td {
            border-bottom: none;
        }

        &.p-highlight {
            background: var(--primary-50);
        }

        &:hover {
            background: var(--surface-hover);
        }
    }

    .p-column-filter {
        min-width: 200px;
    }

    .p-dropdown, .p-calendar .p-inputtext {
        min-width: 200px;
    }
}

/* Estilos para los Tags y botones */
:deep {
    .p-tag {
        padding: 0.25rem 0.5rem;
        font-size: 0.75rem;
        
        &.p-tag-info {
            background: var(--primary-color);
        }
        
        &.p-tag-warning {
            background: var(--orange-500);
        }
    }

    .p-button.p-button-text {
        padding: 0.25rem;
        
        &:hover {
            background: var(--surface-hover);
        }
        
        .p-button-icon {
            font-size: 1rem;
        }
    }
}

/* Estilos para el diálogo de metadata */
.metadata-content {
    .metadata-body {
        .metadata-json {
            background: var(--surface-ground);
            padding: 1rem;
            border-radius: var(--border-radius);
            font-family: monospace;
            font-size: 0.875rem;
            white-space: pre-wrap;
            word-break: break-word;
            margin: 0;
            max-height: 60vh;
            overflow: auto;
        }
    }
}

:deep(.p-toolbar) {
    background: transparent;
    border: none;
    padding: 0;
    
    .p-toolbar-group-start,
    .p-toolbar-group-end {
        @media screen and (max-width: 480px) {
            justify-content: space-between;
        }
    }
}

.p-tag {
    min-width: 90px;
    justify-content: center;
    
    :deep(.p-tag-icon) {
        margin-right: 0.5rem;
    }
}

:deep(.p-input-icon-left) {
    position: relative;
    display: inline-block;

    i {
        position: absolute;
        left: 0.75rem;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-color-secondary);
        z-index: 1;
    }

    .p-inputtext {
        padding-left: 2.5rem;
    }
}
</style>


