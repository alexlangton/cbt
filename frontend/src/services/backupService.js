import axios from './axios'

const BASE_URL = '/api/backup'
const DATABASE_URL = '/api/database'

export const obtenerUltimoBackup = async () => {
    try {
        const { data } = await axios.get(`${BASE_URL}/ultimo`)
        return data
    } catch (error) {
        console.error('Error al obtener último backup:', error)
        throw error
    }
}

export const crearBackup = async () => {
    try {
        const { data } = await axios.post(`${BASE_URL}/create`)
        return data
    } catch (error) {
        console.error('Error al crear backup:', error)
        throw error
    }
}

export const descargarBackup = async () => {
    try {
        const response = await axios.get(`${DATABASE_URL}/download`, {
            responseType: 'blob'
        })
        
        const blob = new Blob([response.data], { type: 'application/sql' })
        const url = window.URL.createObjectURL(blob)
        const timestamp = new Date().toISOString().replace(/[:.]/g, '-')
        const filename = `torrejon_backup_${timestamp}.sql`
        
        const link = document.createElement('a')
        link.href = url
        link.setAttribute('download', filename)
        document.body.appendChild(link)
        link.click()
        
        window.URL.revokeObjectURL(url)
        document.body.removeChild(link)
        
        return {
            estado: 'exito',
            mensaje: 'Base de datos descargada correctamente'
        }
    } catch (error) {
        console.error('Error al descargar backup:', error)
        throw error
    }
}

export const validarRespuestaBackup = (data) => {
    if (!data) {
        throw new Error('Respuesta vacía del servidor')
    }

    if (typeof data !== 'object') {
        throw new Error('Formato de respuesta inválido')
    }

    if (!data.estado) {
        throw new Error('Respuesta sin estado')
    }

    if (!['exito', 'error'].includes(data.estado)) {
        throw new Error('Estado de respuesta inválido')
    }

    return true
}

export default {
    obtenerUltimoBackup,
    crearBackup,
    descargarBackup,
    validarRespuestaBackup
} 