<%-- 
    Document   : Sidebar
    Created on : 28/09/2020, 09:22:56 PM
    Author     : yelbetto
--%>
<%
    HttpSession sInicio = request.getSession();
    if (sInicio.getAttribute("usuario")!=null && sInicio.getAttribute("tipo")!=null){
%>
<div class="page-bg"></div>
<div class="w3-sidebar w3-bar-block w3-border-right" style="display:none" id="menuBar">
    <button onclick="w3_close()" class="boton">CERRAR &times;</button>
    <%
        
        if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("PACIENTE")) {
    %>
    <a href="Pendientes.jsp" class="w3-bar-item">Citas y examenes pendientes</a>
    <a href="Historial.jsp" class="w3-bar-item">Historial médico</a>
    <a href="PacienteAgendar.jsp" class="w3-bar-item">Agendar cita</a>
    <a href="PacienteExamen.jsp" class="w3-bar-item">Agendar examen</a>
    <a href="ReportePaciente.jsp" class="w3-bar-item">Reportes</a>
    <a href="Perfil.jsp" class="w3-bar-item">Ver perfil</a>
    <%} else if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("DOCTOR")) {%>
    <a href="Informe.jsp" class="w3-bar-item">Ingresar informe</a>
    <a href="HistorialMedico.jsp" class="w3-bar-item">Ver historial de paciente</a>
    <a href="Perfil.jsp" class="w3-bar-item">Ver perfil</a>
    <%} else if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("ADMIN")) {%>
    <a href="AdminConsultas.jsp" class="w3-bar-item">Editar/crear tipos consultas</a>
    <a href="AdminExamenes.jsp" class="w3-bar-item">Editar/crear tipos examen</a>
    <a href="AdminMedicos.jsp" class="w3-bar-item">Editar/crear medico</a>
    <a href="AdminLaboratoristas.jsp" class="w3-bar-item">Editar/crear laboratorista</a>
    <a href="ReporteAdmin.jsp" class="w3-bar-item">Reportes</a>
    <a href="Perfil.jsp" class="w3-bar-item">Ver perfil</a>
    <%} else if (sInicio.getAttribute("tipo").toString().equalsIgnoreCase("LABORATORISTA")) {%>
    <a href="Laboratorista.jsp" class="w3-bar-item">Ingresar resultado</a>
    <a href="ReporteLaboratorista.jsp" class="w3-bar-item">Reportes</a>
    <a href="Perfil.jsp" class="w3-bar-item">Ver perfil</a>
    <%}%>
    <a href="/Servidor/Perfil?tipo=123" class="w3-bar-item">Cerrar sesión</a>
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
                    <button class="boton1" id="boton1" onclick="mandarAPerfil()">
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
    function mandarAPerfil(){
        window.location = "Perfil.jsp";
    }
</script>
<%} else{
    response.sendRedirect("/Servidor/index.jsp");
}
%>