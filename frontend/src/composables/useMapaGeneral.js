import { ref } from 'vue';

export function useMapaGeneral(centroInicial) {
    const mapRef = ref(null);
    const zoom = ref(14);
    const centroMapa = ref(centroInicial);
    const limitesMapa = ref(null);

    // Ajustar el mapa a los límites recibidos (solo se llamará explícitamente)
    const ajustarALimites = (nuevosLimites) => {
        if (!mapRef.value || !nuevosLimites?.length === 2) return;

        try {
            const leafletMap = mapRef.value.leafletObject;
            if (leafletMap) {
                leafletMap.fitBounds(nuevosLimites, {
                    padding: [50, 50],
                    maxZoom: 18,
                    animate: true
                });
            }
        } catch (error) {
            console.error('Error al ajustar límites:', error);
        }
    };

    // Centrar el mapa en las coordenadas iniciales
    const btnCentrarMapaClick = () => {
        if (!mapRef.value) return;

        const leafletMap = mapRef.value.leafletObject;
        if (leafletMap) {
            leafletMap.setView(centroInicial, zoom.value, {
                animate: true
            });
        }
    };

    // Solo invalidar el tamaño
    const invalidateMapSize = () => {
        if (!mapRef.value) return;
        const leafletMap = mapRef.value.leafletObject;
        if (leafletMap) {
            leafletMap.invalidateSize();
        }
    };

    return {
        mapRef,
        zoom,
        centroMapa,
        limitesMapa,
        invalidateMapSize,
        btnCentrarMapaClick,
        ajustarALimites
    };
}
