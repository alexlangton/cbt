import { createPinia } from 'pinia';
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';

import Nora from '@primevue/themes/nora';
import Card from 'primevue/card';
import PrimeVue from 'primevue/config';
import ConfirmationService from 'primevue/confirmationservice';
import ToastService from 'primevue/toastservice';

import '@/assets/styles.scss';
import '@/assets/tailwind.css';

const app = createApp(App);

app.use(router);
app.use(PrimeVue, {
    locale: {
        startsWith: 'Empieza con',
        contains: 'Contiene',
        notContains: 'No contiene',
        endsWith: 'Termina con',
        equals: 'Igual a',
        notEquals: 'No es igual a',
        noFilter: 'Sin filtro',
        lt: 'Menor que',
        lte: 'Menor o igual que',
        gt: 'Mayor que',
        gte: 'Mayor o igual que',
        dateIs: 'Fecha es',
        dateIsNot: 'Fecha no es',
        dateBefore: 'Fecha es antes de',
        dateAfter: 'Fecha es después de',
        clear: 'Limpiar',
        apply: 'Aplicar',
        matchAll: 'Coincidir todo',
        matchAny: 'Coincidir cualquiera',
        addRule: 'Añadir regla',
        removeRule: 'Eliminar regla',
        accept: 'Aceptar',
        reject: 'Rechazar',
        choose: 'Elegir',
        upload: 'Subir',
        cancel: 'Cancelar',
        completed: 'Completado',
        pending: 'Pendiente',
        fileSizeTypes: ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        dayNames: [
            'Domingo',
            'Lunes',
            'Martes',
            'Miércoles',
            'Jueves',
            'Viernes',
            'Sábado'
        ],
        dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'],
        dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
        monthNames: [
            'Enero',
            'Febrero',
            'Marzo',
            'Abril',
            'Mayo',
            'Junio',
            'Julio',
            'Agosto',
            'Septiembre',
            'Octubre',
            'Noviembre',
            'Diciembre'
        ],
        monthNamesShort: [
            'Ene',
            'Feb',
            'Mar',
            'Abr',
            'May',
            'Jun',
            'Jul',
            'Ago',
            'Sep',
            'Oct',
            'Nov',
            'Dic'
        ],
        chooseYear: 'Elegir año',
        chooseMonth: 'Elegir mes',
        chooseDate: 'Elegir fecha',
        prevDecade: 'Década anterior',
        nextDecade: 'Próxima década',
        prevYear: 'Año anterior',
        nextYear: 'Próximo año',
        prevMonth: 'Mes anterior',
        nextMonth: 'Próximo mes',
        prevHour: 'Hora anterior',
        nextHour: 'Próxima hora',
        prevMinute: 'Minuto anterior',
        nextMinute: 'Próximo minuto',
        prevSecond: 'Segundo anterior',
        nextSecond: 'Próximo segundo',
        am: 'a.m.',
        pm: 'p.m.',
        today: 'Hoy',
        weekHeader: 'Sem',
        firstDayOfWeek: 0,
        showMonthAfterYear: false,
        dateFormat: 'dd/mm/yy',
        weak: 'Débil',
        medium: 'Media',
        strong: 'Fuerte',
        passwordPrompt: 'Introduce una contraseña',
        searchMessage: '{0} resultados disponibles',
        selectionMessage: '{0} elementos seleccionados',
        emptySelectionMessage: 'No hay elementos seleccionados',
        emptySearchMessage: 'No se encontraron resultados',
        fileChosenMessage: '{0} archivos',
        noFileChosenMessage: 'No se eligió ningún archivo',
        emptyMessage: 'No hay opciones disponibles'
    },
    theme: {
        preset: Nora,

        options: {
            darkModeSelector: '.app-dark'
        }
    }
});
app.use(ToastService);
app.component('p-card', Card);
app.use(ConfirmationService);
app.use(createPinia());

app.mount('#app');
