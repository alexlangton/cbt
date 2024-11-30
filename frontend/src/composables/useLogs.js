import { ref, watch, nextTick, onMounted } from 'vue'
import { useToast } from 'primevue/usetoast'
import { format, parseISO } from 'date-fns'
import { es } from 'date-fns/locale'
import axios from '@/services/axios'
import logService from '@/services/logService'

export function useLogs() {
    const logs = ref([])
    const loading = ref(true)
    const toast = useToast()
    const fechaBusqueda = ref(null)
    const fechaHasta = ref(null)
    const borrarLogsDialog = ref(false)

    const FilterMatchMode = {
        STARTS_WITH: 'startsWith',
        CONTAINS: 'contains',
        NOT_CONTAINS: 'notContains',
        ENDS_WITH: 'endsWith',
        EQUALS: 'equals',
        NOT_EQUALS: 'notEquals',
        IN: 'in',
        LESS_THAN: 'lt',
        LESS_THAN_OR_EQUAL_TO: 'lte',
        GREATER_THAN: 'gt',
        GREATER_THAN_OR_EQUAL_TO: 'gte',
        BETWEEN: 'between',
        DATE_IS: 'dateIs',
        DATE_IS_NOT: 'dateIsNot',
        DATE_BEFORE: 'dateBefore',
        DATE_AFTER: 'dateAfter'
    }

    const FilterOperator = {
        AND: 'and',
        OR: 'or'
    }

    // Tipos de log con sus configuraciones
    const tiposLog = [
        { label: 'Errores', value: 'error', severity: 'danger', icon: 'pi pi-exclamation-circle' },
        { label: 'Depuración', value: 'debug', severity: 'info', icon: 'pi pi-code' },
        { label: 'Información', value: 'info', severity: 'success', icon: 'pi pi-info-circle' },
        { label: 'Consultas', value: 'sql', severity: 'warning', icon: 'pi pi-database' },
        { label: 'Validación', value: 'validador', severity: 'help', icon: 'pi pi-check-circle' }
    ]

    // Opciones de origen
    const opcionesOrigen = [
        { label: 'Usuarios', value: 'usuario' },
        { label: 'Sistema', value: 'sistema' }
    ]

    const filters = ref({
        global: { value: null, matchMode: 'contains' },
        tipo: { value: null, matchMode: 'equals' },
        contenido: { 
            operator: 'and',
            constraints: [{ value: null, matchMode: 'contains' }]
        },
        metadata: { 
            operator: 'and',
            constraints: [{ value: null, matchMode: 'contains' }]
        },
        fecha: { 
            operator: 'and',
            constraints: [{ value: null, matchMode: 'dateIs' }]
        },
        id_usuario: { value: null, matchMode: 'equals' }
    })

    const initFilters = () => {
        filters.value = {
            global: { value: null, matchMode: FilterMatchMode.CONTAINS },
            tipo: { value: null, matchMode: FilterMatchMode.EQUALS },
            contenido: { 
                operator: FilterOperator.AND,
                constraints: [{ value: null, matchMode: FilterMatchMode.CONTAINS }]
            },
            metadata: { 
                operator: FilterOperator.AND,
                constraints: [{ value: null, matchMode: FilterMatchMode.CONTAINS }]
            },
            fecha: { 
                operator: FilterOperator.AND,
                constraints: [{ value: null, matchMode: FilterMatchMode.DATE_IS }]
            },
            id_usuario: { value: null, matchMode: FilterMatchMode.EQUALS }
        }
    }

    const buildFilterParams = () => {
        let params = {}

        // Filtros globales
        if (filters.value?.global?.value) {
            params['contenido='] = filters.value.global.value
        }

        // Filtro por tipo
        if (filters.value?.tipo?.value) {
            params['tipo='] = filters.value.tipo.value
        }

        // Filtros de contenido
        if (filters.value?.contenido?.constraints[0]?.value) {
            params['contenido='] = filters.value.contenido.constraints[0].value
        }

        // Filtros de metadata
        if (filters.value?.metadata?.constraints[0]?.value) {
            params['metadata='] = filters.value.metadata.constraints[0].value
        }

        // Filtros de fecha
        if (filters.value?.fecha?.constraints[0]?.value) {
            params['fecha>='] = format(filters.value.fecha.constraints[0].value, 'yyyy-MM-dd HH:mm:ss')
        }
        if (filters.value?.fecha?.constraints[1]?.value) {
            params['fecha<='] = format(filters.value.fecha.constraints[1].value, 'yyyy-MM-dd HH:mm:ss')
        }

        // Filtro de usuario
        if (filters.value?.id_usuario?.value === 'sistema') {
            params['id_usuario='] = 'null'
        } else if (filters.value?.id_usuario?.value === 'usuario') {
            params['id_usuario>'] = '0'
        }

        return params
    }

    const getSeverity = (tipo) => {
        const severities = {
            error: 'danger',
            debug: 'info',
            info: 'success',
            sql: 'warning',
            validador: 'help'
        }
        return severities[tipo] || 'secondary'
    }

    const clearFilter = () => {
        filters.value = {
            global: { value: null, matchMode: 'contains' },
            tipo: { value: null, matchMode: 'equals' },
            contenido: { 
                operator: 'and',
                constraints: [{ value: null, matchMode: 'contains' }]
            },
            metadata: { 
                operator: 'and',
                constraints: [{ value: null, matchMode: 'contains' }]
            },
            fecha: { 
                operator: 'and',
                constraints: [{ value: null, matchMode: 'dateIs' }]
            },
            id_usuario: { value: null, matchMode: 'equals' }
        }
        cargarLogs()
    }

    const cargarLogs = async () => {
        loading.value = true
        logs.value = []
        
        try {
            const params = buildFilterParams()
            const response = await axios.get('/api/logs', { params })

            if (response.data?.estado === 'exito') {
                logs.value = response.data.datos?.datos.map(log => ({
                    ...log,
                    fecha: parseISO(log.fecha)
                })) || []
                
                toast.add({
                    severity: 'success',
                    summary: 'Logs actualizados',
                    detail: `Se cargaron ${logs.value.length} registros`,
                    life: 3000
                })
            }
        } catch (error) {
            toast.add({
                severity: 'error',
                summary: 'Error',
                detail: 'Error al cargar los logs',
                life: 3000
            })
        } finally {
            loading.value = false
        }
    }

    const formatearFecha = (fecha) => {
        try {
            if (typeof fecha === 'string') {
                fecha = parseISO(fecha)
            }
            return format(fecha, 'dd/MM/yy HH:mm:ss', { locale: es })
        } catch (e) {
            return fecha
        }
    }

    const aplicarFiltros = () => {
        cargarLogs()
    }

    // Watch para detectar cambios en los filtros
    watch(filters, () => {
        cargarLogs()
    }, { deep: true })

    // Inicializar filtros al montar
    onMounted(() => {
        initFilters()
        cargarLogs()
    })

    const borrarLogs = async () => {
        loading.value = true
        try {
            console.log('Iniciando borrado de logs')
            const response = await logService.borrarLogs()
            console.log('Respuesta del servidor:', response)
            
            if (response?.estado === 'exito') {
                toast.add({
                    severity: 'success',
                    summary: 'Éxito',
                    detail: response.mensaje || 'Logs borrados correctamente',
                    life: 3000
                })
                logs.value = []
                
                // Aplicar filtro para mostrar solo logs de tipo 'info'
                filters.value.tipo = { value: 'info', matchMode: FilterMatchMode.EQUALS }
                
                console.log('Logs limpiados, recargando con filtro info...')
                await cargarLogs()
            } else {
                console.log('Respuesta no exitosa:', response)
                throw new Error(response?.mensaje || 'Error al borrar los logs')
            }
        } catch (error) {
            console.error('Error detallado al borrar logs:', error)
            console.log('Error response:', error.response)
            toast.add({
                severity: 'error',
                summary: 'Error',
                detail: error.message || 'Error al borrar los logs',
                life: 5000
            })
        } finally {
            loading.value = false
            borrarLogsDialog.value = false
        }
    }

    return {
        logs,
        loading,
        filters,
        tiposLog,
        opcionesOrigen,
        fechaBusqueda,
        fechaHasta,
        cargarLogs,
        formatearFecha,
        getSeverity,
        clearFilter,
        aplicarFiltros,
        FilterMatchMode,
        FilterOperator,
        borrarLogs,
        borrarLogsDialog
    }
} 