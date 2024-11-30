import { ref, computed, toRefs, reactive } from 'vue'
import { useToast } from 'primevue/usetoast'
import backupService from '@/services/backupService'

const TOAST_DURATION = 3000
const DATE_FORMAT_OPTIONS = {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
}

// Separar notificaciones
const useBackupNotifications = () => {
    const toast = useToast()
    
    return {
        notifySuccess: (summary, detail) => {
            toast.add({
                severity: 'success',
                summary,
                detail,
                life: TOAST_DURATION
            })
        },
        notifyError: (summary, detail) => {
            toast.add({
                severity: 'error',
                summary,
                detail,
                life: TOAST_DURATION
            })
        }
    }
}

export function useBackup() {
    // Cambio: Usar reactive en lugar de ref para el estado
    const state = reactive({
        downloading: false,
        backingUp: false,
        lastBackupDate: null,
        backupMetadata: null
    })

    const { notifySuccess, notifyError } = useBackupNotifications()

    // Computed properties
    const hasBackup = computed(() => 
        !!state.lastBackupDate && !!state.backupMetadata
    )

    const tiempoTranscurrido = computed(() => {
        if (!state.lastBackupDate) return 'tiempo desconocido'
        
        try {
            const ahora = new Date()
            const ultimo = new Date(state.lastBackupDate)
            const diferencia = ahora - ultimo

            const minutos = Math.floor(diferencia / 60000)
            const horas = Math.floor(minutos / 60)
            const dias = Math.floor(horas / 24)

            if (dias > 0) return `${dias} día${dias !== 1 ? 's' : ''}`
            if (horas > 0) return `${horas} hora${horas !== 1 ? 's' : ''}`
            if (minutos > 0) return `${minutos} minuto${minutos !== 1 ? 's' : ''}`
            return 'menos de un minuto'
        } catch (e) {
            console.error('Error al calcular tiempo transcurrido:', e)
            return 'tiempo desconocido'
        }
    })

    // Métodos
    const formatearFecha = (fecha) => {
        try {
            const date = new Date(fecha)
            if (isNaN(date.getTime())) throw new Error('Fecha no válida')
            return new Intl.DateTimeFormat('es-ES', DATE_FORMAT_OPTIONS).format(date)
        } catch (e) {
            console.error('Error al formatear fecha:', e)
            return 'Fecha no válida'
        }
    }

    const checkLastBackup = async () => {
        try {
            const response = await backupService.obtenerUltimoBackup()

            if (!response || response.estado !== 'exito') {
                state.lastBackupDate = null
                state.backupMetadata = null
                return
            }

            const { datos } = response
            if (!datos || datos.estado !== 'con_backup') {
                state.lastBackupDate = null
                state.backupMetadata = null
                return
            }

            state.lastBackupDate = datos.metadata.fecha_formateada || datos.fecha
            state.backupMetadata = {
                fecha_formateada: datos.metadata.fecha_formateada,
                tamaño_formateado: datos.metadata.tamaño_formateado,
                archivo: datos.metadata.archivo,
                tamaño: datos.metadata.tamaño,
                fecha_original: datos.fecha,
                estado: datos.estado
            }

            notifySuccess(
                'Backup encontrado',
                `Último backup: ${state.backupMetadata.fecha_formateada}`
            )
        } catch (error) {
            console.error('Error al verificar backup:', error)
            state.lastBackupDate = null
            state.backupMetadata = null
            notifyError('Error', 'No se pudo obtener la información del backup')
            throw error
        }
    }

    const downloadDatabase = async () => {
        try {
            state.downloading = true
            const result = await backupService.descargarBackup()
            
            if (result.estado === 'exito') {
                notifySuccess('Éxito', result.mensaje)
            }
        } catch (error) {
            console.error('Error al descargar la base de datos:', error)
            notifyError('Error', 'No se pudo descargar la base de datos')
            throw error
        } finally {
            state.downloading = false
        }
    }

    const createBackup = async () => {
        try {
            state.backingUp = true
            const result = await backupService.crearBackup()
            
            if (backupService.validarRespuestaBackup(result)) {
                await checkLastBackup()
                notifySuccess('Éxito', 'Backup creado correctamente')
            }
        } catch (error) {
            console.error('Error al crear backup:', error)
            notifyError('Error', 'No se pudo crear el backup')
            throw error
        } finally {
            state.backingUp = false
        }
    }

    return {
        // Retornar el estado reactivo directamente
        downloading: computed(() => state.downloading),
        backingUp: computed(() => state.backingUp),
        lastBackupDate: computed(() => state.lastBackupDate),
        backupMetadata: computed(() => state.backupMetadata),
        hasBackup,
        tiempoTranscurrido,
        formatearFecha,
        checkLastBackup,
        downloadDatabase,
        createBackup
    }
} 