<template>
    <div class="marcador-contenedor">
        <img :src="iconUrl" alt="Icono" class="marcador-icono" />
        <div v-if="mostrarNombre" class="marcador-nombre">
            <strong>{{ marcador.name }}</strong>
        </div>
        <div v-if="mostrarRotativo" class="rotativo-contenedor">
            <div
                :class="{ marquee: animarRotativo }"
                :style="{ paddingLeft: !animarRotativo ? '10px' : undefined }"
            >
                <strong>{{ marcador.rotativo }}</strong>
            </div>
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
            validator: (value) => value.type === 'cartel'
        },
        mostrarNombre: {
            type: Boolean,
            default: false
        },
        mostrarRotativo: {
            type: Boolean,
            default: true
        },
        animarRotativo: {
            type: Boolean,
            default: true
        }
    });

    const { obtenerUrlDeIcono } = useIconUrl();
    const iconUrl = computed(() => obtenerUrlDeIcono(props.marcador.type));
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

    .rotativo-contenedor {
        width: 150px;
        overflow: hidden;
        white-space: nowrap;
        background-color: black;
        padding: 4px;
    }

    .rotativo-contenedor strong {
        color: white;
    }

    .marquee {
        display: inline-block;
        animation: marquee 15s linear infinite;
        padding-left: 100%;
    }

    @keyframes marquee {
        0% {
            transform: translateX(0);
        }
        100% {
            transform: translateX(-90%);
        }
    }

    .marquee strong::after {
        content: attr(data-content);
        margin-left: 50px;
    }
</style>
