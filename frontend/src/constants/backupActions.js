export const actions = [
    {
        title: 'Descargar Base de Datos',
        description: 'Descarga una copia completa de la base de datos actual en formato SQL',
        action: 'download',
        icon: 'pi pi-download',
        severity: 'primary',
        detailedInfo: {
            title: 'Descargar Base de Datos',
            description: `Esta acción te permite descargar una copia completa de la base de datos en formato SQL.

El archivo descargado contendrá:
• Estructura completa de la base de datos
• Todos los datos actuales
• Procedimientos almacenados y triggers
• Configuraciones específicas

Uso recomendado:
• Crear copias de seguridad locales
• Migrar datos a otro servidor
• Análisis de datos offline`
        }
    },
    {
        title: 'Crear Copia de Seguridad',
        description: 'Genera y almacena una nueva copia de seguridad en el servidor',
        action: 'backup',
        icon: 'pi pi-save',
        severity: 'help',
        detailedInfo: {
            title: 'Crear Copia de Seguridad',
            description: `Esta acción crea una copia de seguridad completa en el servidor.

El proceso incluye:
• Generación de backup completo
• Almacenamiento en la carpeta /database
• Nombre del archivo: backup_ddMMyyHHmm.sql
• Verificación de integridad

Ubicación:
• Los backups se guardan en la carpeta /database
• Formato de nombre incluye fecha y hora
• Acceso directo desde el servidor`
        }
    }
] 