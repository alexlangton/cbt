export function useIconUrl() {
    const baseUrl = import.meta.env.BASE_URL;

    const ICONOS = {
        parking: 'icono_parking.svg',
        cartel: 'icono_cartel.svg'
    };

    const obtenerUrlDeIcono = (tipoMarcador) => {
        const tipo = tipoMarcador?.toLowerCase();

        // Si el tipo no existe o no está en ICONOS, retorna cadena vacía
        if (!tipo || !ICONOS[tipo]) {
            return '';
        }

        // Retorna la URL del ícono correspondiente
        return `${baseUrl}static/images/${ICONOS[tipo]}`;
    };

    return { obtenerUrlDeIcono };
}
