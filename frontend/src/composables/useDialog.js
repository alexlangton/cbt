import { useIconUrl } from '@/composables/useIconUrl';
import { computed, ref } from 'vue';

const { obtenerUrlDeIcono } = useIconUrl();

const visible = ref(false);
const tipoMarcador = ref('');
const datosMarcador = ref({
    name: '',
    type: '',
    atributos: []
});
const dialogName = computed(() => datosMarcador.value.name);
const isCartel = computed(() => tipoMarcador.value === 'cartel');
const isParking = computed(() => tipoMarcador.value === 'parking');
const dialogIcono = computed(() => obtenerUrlDeIcono(datosMarcador.value.type));
const dialogHeader = computed(() =>
    isParking.value ? 'Editando parking' : 'Editando cartel'
);

// Función para mostrar el diálogo
function showDialog(data) {
    console.log('Datos recibidos en showDialog:', data);
    tipoMarcador.value = data.type || '';
    datosMarcador.value = {
        name: data.name || '',
        type: data.type || '',
        atributos: data.atributos || []
    };
    visible.value = true;
}

// Función para guardar cambios
function saveChanges() {
    visible.value = false;
}

// Exportamos el uso del diálogo
export function useDialog() {
    return {
        visible,
        isParking,
        isCartel,
        dialogHeader,
        dialogIcono,
        dialogName,
        showDialog,
        saveChanges
    };
}
