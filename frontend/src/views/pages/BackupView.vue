<script setup>
import { ref, onMounted } from 'vue'
import { useBackup } from '@/composables/useBackup'
import { actions } from '@/constants/backupActions'
import DataTable from 'primevue/datatable'
import Column from 'primevue/column'
import Dialog from 'primevue/dialog'
import Button from 'primevue/button'
import Toast from 'primevue/toast'
import Message from 'primevue/message'

const isLoading = ref(true)
const error = ref(null)

const {
    downloading,
    backingUp,
    lastBackupDate,
    backupMetadata,
    hasBackup,
    formatearFecha,
    checkLastBackup,
    downloadDatabase,
    createBackup
} = useBackup()

const showInfoDialog = ref(false)
const selectedAction = ref(null)

const handleAction = async (action) => {
    switch (action) {
        case 'download':
            await downloadDatabase()
            break
        case 'backup':
            await createBackup()
            break
    }
}

const showInfo = (action) => {
    selectedAction.value = action
    showInfoDialog.value = true
}

const getButtonLabel = (action) => {
    return action === 'download' ? 'Descargar' : 'Crear Backup'
}

onMounted(async () => {
    try {
        isLoading.value = true
        await checkLastBackup()
    } catch (e) {
        error.value = 'Error al cargar los datos de la copia de seguridad'
        console.error('Error:', e)
    } finally {
        isLoading.value = false
    }
})
</script>

<template>
    <div class="grid">
        <!-- Loader y error mantienen su propia card -->
        <div v-if="isLoading" class="col-12">
            <div class="card">
                <div class="flex justify-content-center">
                    <i class="pi pi-spin pi-spinner" style="font-size: 2rem"></i>
                </div>
            </div>
        </div>

        <div v-else-if="error" class="col-12">
            <div class="card">
                <div class="flex align-items-center p-3 border-1 surface-border border-round bg-red-50">
                    <i class="pi pi-exclamation-circle mr-3 text-red-500 text-2xl"></i>
                    <div class="text-red-700">{{ error }}</div>
                </div>
            </div>
        </div>

        <!-- Todo el contenido en una sola card -->
        <template v-else>
            <div class="col-12">
                <div class="card">
                    <!-- Header mejorado -->
                    <div class="flex flex-column mb-4">
                        <div class="flex align-items-center">
                            <i class="pi pi-database mr-3 text-primary text-2xl"></i>
                            <div>
                                <div class="text-900 text-2xl font-medium">Configuración de la Copia de Seguridad</div>
                                <span class="text-500">Gestión de Base de Datos</span>
                            </div>
                        </div>
                    </div>

                    <!-- Información de última copia con mejor diseño -->
                    <div class="surface-card border-1 surface-border border-round p-4 mb-4">
                        <!-- Título -->
                        <div class="flex align-items-center mb-3">
                            <i class="pi pi-database mr-3 text-primary text-2xl"></i>
                            <span class="text-xl font-medium">Estado del Backup</span>
                        </div>

                        <!-- Información de Backup -->
                        <div class="pl-12">
                            <div class="flex align-items-start">
                                <div class="flex">
                                    <template v-if="hasBackup">
                                        <div
                                            style="background-color: black; color: white; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                                            <div style="margin-bottom: 0.5rem;"><i class="pi pi-clock mr-2"></i>
                                                <span class="font-medium">Última Actualización:</span>
                                                <span class="ml-2">{{ formatearFecha(lastBackupDate) }}</span>
                                            </div>
                                            <div style="margin-bottom: 0.5rem;"><i class="pi pi-file mr-2"></i>
                                                <span class="font-medium">Archivo:</span>
                                                <span class="ml-2">{{ backupMetadata.archivo }}</span>
                                            </div>
                                            <div><i class="pi pi-database mr-2"></i>
                                                <span class="font-medium">Tamaño:</span>
                                                <span class="ml-2">{{ backupMetadata.tamaño_formateado }}</span>
                                            </div>
                                        </div>
                                    </template>
                                    <template v-else>
                                        <div class="text-600">No se ha realizado ninguna copia de seguridad</div>
                                        <div class="text-500 text-sm mt-2 flex align-items-center">
                                            <i class="pi pi-info-circle mr-2"></i>
                                            Se recomienda crear una copia de seguridad inicial
                                        </div>
                                    </template>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Tabla de Acciones mejorada -->
                    <div class="surface-card border-1 surface-border border-round p-4">
                        <div class="flex align-items-center mb-3">
                            <i class="pi pi-cog mr-3 text-primary text-2xl"></i>
                            <span class="text-xl font-medium">Acciones Disponibles</span>
                        </div>
                        <DataTable :value="actions" class="p-datatable-sm" responsiveLayout="scroll"
                            :showHeaders="false" stripedRows>
                            <Column field="title" style="width: 20%">
                                <template #body="slotProps">
                                    <div class="font-medium text-900">{{ slotProps.data.title }}</div>
                                </template>
                            </Column>

                            <Column field="description" style="width: 45%">
                                <template #body="slotProps">
                                    <div class="text-600 line-height-3">{{ slotProps.data.description }}</div>
                                </template>
                            </Column>

                            <Column style="width: 25%">
                                <template #body="slotProps">
                                    <Button :label="getButtonLabel(slotProps.data.action)" :icon="slotProps.data.icon"
                                        severity="primary" :loading="(slotProps.data.action === 'download' && downloading) ||
                                            (slotProps.data.action === 'backup' && backingUp)"
                                        @click="handleAction(slotProps.data.action)"
                                        class="action-button p-button-raised" rounded />
                                </template>
                            </Column>

                            <Column style="width: 10%">
                                <template #body="slotProps">
                                    <Button icon="pi pi-info-circle" text rounded severity="primary"
                                        class="p-button-outlined" @click="showInfo(slotProps.data)"
                                        v-tooltip.top="'Más información'" />
                                </template>
                            </Column>
                        </DataTable>
                    </div>
                </div>
            </div>

            <!-- Dialog mejorado -->
            <Dialog v-model:visible="showInfoDialog" :modal="true" :header="selectedAction?.detailedInfo.title"
                :style="{ width: '50vw' }" :breakpoints="{ '960px': '75vw', '641px': '90vw' }" class="p-dialog-custom">
                <div class="flex flex-column gap-4 p-4">
                    <div class="surface-card border-1 surface-border border-round p-3">
                        <div class="flex align-items-center gap-2 mb-3">
                            <i :class="selectedAction?.icon" class="text-2xl text-primary"></i>
                            <span class="font-medium text-xl">Información Detallada</span>
                        </div>
                        <div class="text-600 line-height-3 pl-2">
                            <p v-for="item in selectedAction?.detailedInfo.description.split('\n').filter(line => line.trim())" 
                                :key="item"
                                class="mb-2"
                            >
                                {{ item }}
                            </p>
                        </div>
                    </div>
                </div>
                <template #footer>
                    <Button label="Cerrar" icon="pi pi-times" @click="showInfoDialog = false" text />
                </template>
            </Dialog>
        </template>
    </div>

    <Toast />
</template>

<style lang="scss" scoped>
:deep(.card) {
    padding: 1.5rem;
}

:deep(.p-datatable) {
    .p-datatable-wrapper {
        border-radius: var(--border-radius);
    }

    .p-datatable-tbody>tr>td {
        padding: 1rem;
    }

    .p-datatable-tbody>tr {
        border-bottom: 1px solid var(--surface-border);

        &:last-child {
            border-bottom: none;
        }
    }
}

:deep(.action-button) {
    width: 180px;
    justify-content: center;

    .p-button-label {
        flex: none;
    }
}

:deep(.p-dialog-custom) {
    .p-dialog-content {
        padding: 0;
    }
}

.information-pre {
    white-space: pre-wrap;
    font-family: var(--font-family);
    margin: 0;
    padding: 0;
    background: transparent;
    border: none;
    color: var(--text-color-secondary);
    line-height: 1.8;
    width: 100%;
}

:deep(.p-message) {
    margin: 0;

    .p-message-wrapper {
        padding: 1rem;
        white-space: pre-line;
    }
}

.custom-card {
    background-color: rgb(255, 0, 0);
    color: white;
    border-radius: 8px;
    padding: 1rem;
}

.elemento {
    margin-bottom: 0.5rem;
}
</style>