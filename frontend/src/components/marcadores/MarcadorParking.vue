<template>
    <div class="marcador-contenedor">
        <img :src="iconUrl" alt="Icono" class="marcador-icono" />
        <div v-if="mostrarNombre" class="marcador-nombre">
            <strong>{{ marcador.name }}</strong>
        </div>
        <div v-if="mostrarOcupacion" class="ocupacion-badge">
            <span :class="{ completo: estaCompleto, libre: !estaCompleto }">
                {{ estaCompleto ? 'COMPLETO' : 'LIBRE' }}
            </span>
        </div>
    </div>
</template>

<script setup>
    import { useIconUrl } from '@/composables/useIconUrl';
    import { computed } from 'vue';

    const props = defineProps({
        marcador: {
            type: Object,
            required: true,
            validator: (value) => value.type === 'parking'
        },
        mostrarOcupacion: {
            type: Boolean,
            default: false
        },
        mostrarNombre: {
            type: Boolean,
            default: false
        }
    });

    const { obtenerUrlDeIcono } = useIconUrl();
    const iconUrl = computed(() => obtenerUrlDeIcono(props.marcador.type));
    const estaCompleto = computed(
        () => props.marcador.atributos?.signs?.[0]?.activated === 1
    );
</script>

<style scoped>
    .marcador-contenedor {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .marcador-icono {
        width: 35px;
        height: 35px;
        margin-bottom: 8px;
    }

    .marcador-nombre {
        margin-bottom: 5px;
    }

    .ocupacion-badge {
        font-size: 12px;
        font-weight: bold;
        margin-top: 5px;
        padding: 2px 6px;
        background-color: black;
        text-align: center;
        width: 100%;
    }

    .completo {
        color: red;
    }

    .libre {
        color: #00ff00;
    }
</style>
