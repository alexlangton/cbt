import { defineStore } from 'pinia';

export const useMapStore = defineStore('map', {
    state: () => ({
        showLegend: true
    }),
    
    actions: {
        setShowLegend(value) {
            this.showLegend = value;
        },
        toggleLegend() {
            this.showLegend = !this.showLegend;
            console.log('Estado leyenda:', this.showLegend);
        }
    }
}); 