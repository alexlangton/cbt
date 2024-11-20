<template>
    <div class="card">
        <div class="font-semibold text-2xl mb-4">Documentación de Rutas API</div>

        <div class="font-semibold text-xl mb-4">Inicio de Sesión</div>
        <p class="text-lg mb-4">
            <code>POST /api/login</code> = <strong>SesionController->login</strong>
        </p>

        <div class="font-semibold text-xl mb-4">C_APL</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /apl/guardarNuevo</code> = <strong>AplController->guardarNuevo</strong></li>
            <li><code>GET /apl/mostrar/@codapl</code> = <strong>AplController->mostrar</strong></li>
            <li><code>GET /apl/mostrar/todos</code> = <strong>AplController->mostrarTodos</strong></li>
            <li><code>PUT /apl/guardar/@codapl</code> = <strong>AplController->guardar</strong></li>
            <li><code>DELETE /apl/eliminar/@codapl</code> = <strong>AplController->eliminar</strong></li>
            <li><code>DELETE /apl/eliminarSeleccion</code> = <strong>AplController->eliminarSeleccion</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">C_SECCIONES</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /seccion/guardarNueva</code> = <strong>SecController->guardarNueva</strong></li>
            <li><code>GET /seccion/mostrar/@codsec</code> = <strong>SecController->mostrar</strong></li>
            <li><code>GET /seccion/mostrar/todas</code> = <strong>SecController->mostrarTodas</strong></li>
            <li><code>PUT /seccion/guardar/@codsec</code> = <strong>SecController->guardar</strong></li>
            <li><code>DELETE /seccion/eliminar/@codsec</code> = <strong>SecController->eliminar</strong></li>
            <li><code>DELETE /seccion/eliminarSeleccion</code> = <strong>SecController->eliminarSeleccion</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">C_CLAVES</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /clave/guardarNueva</code> = <strong>ClavesController->guardarNueva</strong></li>
            <li><code>GET /clave/mostrar/@codcla</code> = <strong>ClavesController->mostrar</strong></li>
            <li><code>GET /clave/mostrar/todas</code> = <strong>ClavesController->mostrarTodas</strong></li>
            <li><code>PUT /clave/guardar/@codcla</code> = <strong>ClavesController->guardar</strong></li>
            <li><code>DELETE /clave/eliminar/@codcla</code> = <strong>ClavesController->eliminar</strong></li>
            <li><code>DELETE /clave/eliminarSeleccion</code> = <strong>ClavesController->eliminarSeleccion</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">C_VALORES</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /valor/guardarNuevo</code> = <strong>ClavesController->guardarNuevo</strong></li>
            <li><code>GET /valor/mostrar/@codsec</code> = <strong>ClavesController->mostrar</strong></li>
            <li><code>GET /valor/mostrar/todos</code> = <strong>ClavesController->mostrarTodos</strong></li>
            <li><code>PUT /valor/guardar/@codsec</code> = <strong>ClavesController->guardar</strong></li>
            <li><code>DELETE /valor/eliminar/@codsec</code> = <strong>ClavesController->eliminar</strong></li>
            <li><code>DELETE /valor/eliminarSeleccion</code> = <strong>ClavesController->eliminarSeleccion</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">PLUGIN-PARKING</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /aplicacionPlugin/guardar/@idPlugin</code> = <strong>AplicacionPluginController->guardar</strong></li>
            <li><code>GET /aplicacionPlugin/obtener/@idPlugin</code> = <strong>AplicacionPluginController->obtener</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">C_TRA</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /tra/guardarNuevo</code> = <strong>TraController->guardarNuevo</strong></li>
            <li><code>GET /tra/mostrar/@codtra</code> = <strong>TraController->mostrar</strong></li>
            <li><code>GET /tra/mostrar/todos</code> = <strong>TraController->mostrarTodos</strong></li>
            <li><code>PUT /tra/guardar/@codtra</code> = <strong>TraController->guardar</strong></li>
            <li><code>DELETE /tra/eliminar/@codtra</code> = <strong>TraController->eliminar</strong></li>
            <li><code>DELETE /tra/eliminarSeleccion</code> = <strong>TraController->eliminarSeleccion</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">TRABAJOS-PLUGIN</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /trabajoPlugin/guardarNuevo</code> = <strong>TrabajoPluginController->guardarNuevo</strong></li>
            <li><code>GET /trabajoPlugin/mostrar/@idPlugin</code> = <strong>TrabajoPluginController->mostrar</strong></li>
            <li><code>GET /trabajoPlugin/mostrar/todos</code> = <strong>TrabajoPluginController->mostrarTodos</strong></li>
            <li><code>PUT /trabajoPlugin/guardar/@idPlugin</code> = <strong>TrabajoPluginController->guardar</strong></li>
            <li><code>DELETE /trabajoPlugin/eliminar/@idPlugin</code> = <strong>TrabajoPluginController->eliminar</strong></li>
            <li><code>DELETE /trabajoPlugin/eliminarSeleccion</code> = <strong>TrabajoPluginController->eliminarSeleccion</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">PLUGIN</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /plugin/guardarNuevo</code> = <strong>PluginController->guardarNuevo</strong></li>
            <li><code>GET /plugin/mostrar/@idPlugin</code> = <strong>PluginController->mostrar</strong></li>
            <li><code>GET /plugin/mostrar/todos</code> = <strong>PluginController->mostrarTodos</strong></li>
            <li><code>PUT /plugin/guardar/@idPlugin</code> = <strong>PluginController->guardar</strong></li>
            <li><code>DELETE /plugin/eliminar/@idPlugin</code> = <strong>PluginController->eliminar</strong></li>
            <li><code>DELETE /plugin/eliminarSeleccion</code> = <strong>PluginController->eliminarSeleccion</strong></li>
            <li><code>GET /plugin/trabajo/obtener/@idPlugin</code> = <strong>PluginController->obtenerTrabajosSeleccionadosDisponibles</strong></li>
            <li><code>GET /plugin/aplicacion/obtener/@idPlugin</code> = <strong>PluginController->obtenerAplicacionesSeleccionadasDisponibles</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">PARKING</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /parking/guardarNuevo</code> = <strong>ParkingController->guardarNuevo</strong></li>
            <li><code>GET /parking/mostrar/@codinsclo</code> = <strong>ParkingController->mostrar</strong></li>
            <li><code>GET /parking/mostrar/todos</code> = <strong>ParkingController->mostrarTodos</strong></li>
            <li><code>PUT /parking/guardar/@codinsclo</code> = <strong>ParkingController->guardar</strong></li>
            <li><code>DELETE /parking/eliminar/@codinsclo</code> = <strong>ParkingController->eliminar</strong></li>
            <li><code>DELETE /parking/eliminarSeleccion</code> = <strong>ParkingController->eliminarSeleccion</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">PLUGIN-PARKING</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>GET /pluginsParking/obtener/todos</code> = <strong>PluginsParkingController->obtenerTodos</strong></li>
            <li><code>GET /pluginsParking/obtener/@codinsclo</code> = <strong>PluginsParkingController->obtener</strong></li>
            <li><code>POST /pluginsParking/guardar/@codinsclo</code> = <strong>PluginsParkingController->guardar</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">OPERADOR</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /operador/guardarNuevo</code> = <strong>OperadorController->guardarNuevo</strong></li>
            <li><code>GET /operador/mostrar/@cod</code> = <strong>OperadorController->mostrar</strong></li>
            <li><code>GET /operador/mostrar/todos</code> = <strong>OperadorController->mostrarTodos</strong></li>
            <li><code>PUT /operador/guardar/@cod</code> = <strong>OperadorController->guardar</strong></li>
            <li><code>DELETE /operador/eliminar/@cod</code> = <strong>OperadorController->eliminar</strong></li>
            <li><code>DELETE /operador/eliminarSeleccion</code> = <strong>OperadorController->eliminarSeleccion</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">RESETEAR CONTRASEÑA</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /enviarEnlaceRecuperacion</code> = <strong>CorreoController->enviarEnlaceRecuperacion</strong></li>
            <li><code>PUT /guardarNuevaContrasenia</code> = <strong>NuevaContraseniaController->guardarNuevaContrasenia</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">ARCHIVO INI DEL PLUG-IN</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /campos_ini/guardar/@idPlugin</code> = <strong>CamposIniController->guardar</strong></li>
            <li><code>GET /campos_ini/obtener/@idPlugin</code> = <strong>CamposIniController->obtener</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">ENT SAL</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /entsal/obtener</code> = <strong>EntSalController->obtener</strong></li>
        </ul>

        <div class="font-semibold text-xl mb-4">RESERVAS</div>
        <ul class="leading-normal list-disc pl-8 text-lg mb-4">
            <li><code>POST /reservas/obtener</code> = <strong>ReservasController->obtener</strong></li>
        </ul>
    </div>
</template>

<style lang="scss" scoped>
@media screen and (max-width: 991px) {
    .video-container {
        position: relative;
        width: 100%;
        height: 0;
        padding-bottom: 56.25%;

        iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
        }
    }
}
</style>
