<%-- 
    Document   : Sidebar
    Created on : 28/09/2020, 09:22:56 PM
    Author     : yelbetto
--%>
<div class="page-bg"></div>
<div class="w3-sidebar w3-bar-block w3-border-right" style="display:none" id="menuBar">
    <button onclick="w3_close()" class="boton">CERRAR &times;</button>
    <a href="Medico.jsp" class="w3-bar-item">Citas</a>
    <a href="Perfil.jsp" class="w3-bar-item">Perfil</a>
    <a href="#" class="w3-bar-item">Ver historial de paciente</a>
</div>

<div class="nav">
    <div class="w3-container">
        <div id="contenedor">
            <div id="izquierda">
                <button class="" id="menu" onclick="w3_open()">MENU<img src="../RESOURCES/imagenes/salud.png" width="45em" height="auto" id="imagenHospital"></button>
                <label for="menu" id="nombreHospital">Centro Medico del Sur</label>
            </div>
            <div id="derecha">
                <div id="informacionPerfil">
                    <button class="boton1" id="boton1">
                        <img src="../RESOURCES/imagenes/usuario.png" id="imagenUsuario" width="32em" height="auto">
                        <label for="imagenUsuario">PERFIL</label>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function w3_open() {
        $("#menuBar").fadeIn(500);
    }

    function w3_close() {
        $("#menuBar").fadeOut(500);
    }
</script>