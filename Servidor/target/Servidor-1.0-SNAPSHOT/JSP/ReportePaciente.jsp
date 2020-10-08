<%-- 
    Document   : ReportePaciente
    Created on : 7/10/2020, 09:29:59 PM
    Author     : yelbetto
--%>

<%@page import="Base.ResultadoDAO"%>
<%@page import="POJO.ResultadoDTO"%>
<%@page import="POJO.ReporteDTO"%>
<%@page import="Base.ReporteDAO"%>
<%@page import="POJO.ConsultaDTO"%>
<%@page import="Base.ConsultaDAO"%>
<%@page import="POJO.ExamenDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.ExamenDAO"%>
<%@page import="Base.Reporte"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes</title>
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <script type="text/javascript" src="../RESOURCES/js/Pendientes.js"></script>
        <link rel="stylesheet" href="../RESOURCES/css/Lab.css">
        <link rel="stylesheet" href="../RESOURCES/css/Reportes.css">
        <script src="../RESOURCES/js/ReportePaciente.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            //Clase que inicia y devuelve la conexión con la base de datos
            Conector cn = new Conector("encender");
            //Clase que devuelve los datos de los reportes que se esperan
            ReporteDAO reporte = new ReporteDAO(cn);
            ExamenDAO examen = new ExamenDAO(cn);
            ConsultaDAO consulta = new ConsultaDAO(cn);
            ResultadoDAO resultado = new ResultadoDAO(cn);
            //Clases contenedoras de los datos
            ArrayList<ExamenDTO> examenes = examen.obtenerExamenes();
            ArrayList<ConsultaDTO> consultas = consulta.obtenerConsultas();
            ArrayList<ReporteDTO> reportes = new ArrayList<>();
            ArrayList<ResultadoDTO> examenes2 = new ArrayList<>();
            HttpSession sReporte = request.getSession();
            String filtroTipo = "";
            if (sReporte.getAttribute("usuario") != null && sReporte.getAttribute("tipo") != null) {
                if (sReporte.getAttribute("tipo").toString().equalsIgnoreCase("PACIENTE")) {
                    if (sReporte.getAttribute("tipoFiltroPaciente") != null) {
                        filtroTipo = sReporte.getAttribute("tipoFiltroPaciente").toString();
                        String codigo = sReporte.getAttribute("usuario").toString();
                        if (filtroTipo.equalsIgnoreCase("1")) {
                            String examenTipo = sReporte.getAttribute("filtroPacienteExamen").toString();
                            String fecha1 = sReporte.getAttribute("filtroPacienteFecha1").toString();
                            String fecha2 = sReporte.getAttribute("filtroPacienteFecha2").toString();
                            examenes2 = resultado.obtenerResultadosDePacienteEspecificosRealizados(codigo, examenTipo, fecha1, fecha2);
                            sReporte.removeAttribute("filtroPacienteExamen");
                            sReporte.removeAttribute("filtroPacienteFecha1");
                            sReporte.removeAttribute("filtroPacienteFecha2");
                            sReporte.removeAttribute("tipoFiltroPaciente");
                        } else if (filtroTipo.equalsIgnoreCase("2")) {
                            String doctor = sReporte.getAttribute("filtroPacienteDoctor").toString();
                            String fecha1 = sReporte.getAttribute("filtroPacienteFecha1").toString();
                            String fecha2 = sReporte.getAttribute("filtroPacienteFecha2").toString();
                            reportes = reporte.obtenerConsultasRealizadas(codigo, doctor, fecha1, fecha2);
                            sReporte.removeAttribute("filtroPacienteDoctor");
                            sReporte.removeAttribute("filtroPacienteFecha1");
                            sReporte.removeAttribute("filtroPacienteFecha2");
                            sReporte.removeAttribute("tipoFiltroPaciente");
                        } else if (filtroTipo.equalsIgnoreCase("3")) {
                            examenes2 = resultado.obtenerUltimosResultadosDePacienteRealizado(codigo);
                            sReporte.removeAttribute("tipoFiltroPaciente");
                        } else if (filtroTipo.equalsIgnoreCase("4")) {
                            reportes = reporte.obtenerUltimasRealizadas(codigo);
                            sReporte.removeAttribute("tipoFiltroPaciente");
                        }
                    }
                } else {
                    response.sendRedirect("Perfil.jsp");
                } 
            } else {
                response.sendRedirect("/Servidor/index.jsp");
            }
        %>
        <%if (sReporte.getAttribute("usuario") != null && sReporte.getAttribute("tipo") != null){%>
        <%@include file="Sidebar.jsp"%>
        <%}%>
    <center>
        <div id="filtroReporte">
            <%if (!filtroTipo.isEmpty()) {%>
            <%if (filtroTipo.equalsIgnoreCase("1")) {%>
            <h4>Mostrando reporte examenes realizados de un tipo en especifico</h4>
            <%} else if (filtroTipo.equalsIgnoreCase("2")) {%>
            <h4>Mostrando reporte de consultas realizadas con un medico en especifico</h4>
            <%} else if (filtroTipo.equalsIgnoreCase("3")) {%>
            <h4>Mostrando reporte de ultimos 5 examenes de laboratorio realizados</h4>
            <%} else if (filtroTipo.equalsIgnoreCase("4")) {%>
            <h4>Mostrando reporte de ultimas 5 consultas realizadas</h4>
            <%}%>
            <%} else {%>
            <h4>Elige un tipo de reporte</h4>
            <%}%>
            <label for="tipoReporte">Tipo de reporte: </label>
            <select id="tipoReporte" name="tipoReporte" onchange="mostrarReportePaciente1(this)">
                <option value="5">SIN SELECCIONAR</option>
                <option value="1" onclick="mostrarTipos(this)">Últimos 5 exámenes de laboratorio realizados</option>
                <option value="2" onclick="mostrarFechas(this)">Exámenes realizados de un tipo en específico dentro de un intervalo de tiempo</option>
                <option value="3" onclick="mostrarTipos(this)">Últimas 5 consultas realizadas</option>
                <option value="4" onclick="mostrarFechas(this)">Consultas realizadas con un médico en específico dentro de un intervalo de tiempo</option>
            </select>
            <div id="fechas" style="display:none;">
                <form id="formReportePaciente1" method="GET" action="../Reportes">
                    <div id="selectExamenes">
                        <label for="examenes">Examen:</label>
                        <select id="examenes" name="examenes">
                            <%for (int i = 0; i < examenes.size(); i++) {%>
                            <option value="<%out.print(examenes.get(i).getCodigo());%>"><%out.print(examenes.get(i).getNombre());%></option>
                            <%}%>
                        </select>
                    </div>
                    <div id="selectExamenes2">
                        <label for="doctorEscrito">Doctor: </label>
                        <input type="text" id="doctorEscrito" onkeydown="existeMedico(this)" required>
                        <span id="pop" class="popuptext">No existe este medico!</span>
                        <p id="mensajeExistencia" style="display:inline;"></p>
                    </div>
                    <br>
                    <label for="fecha1">Desde: </label>
                    <input type="date" name="fecha1" id="fecha1" required>
                    <label for="fecha2">Hasta: </label>
                    <input type="date" name="fecha2" id="fecha2" required>
                    <button id="ingresar">Buscar según filtro</button>
                </form>
            </div>
        </div>
    </center>
    <center>
        <% if (!filtroTipo.isEmpty()) {%>
        <% if (filtroTipo.equalsIgnoreCase("4") || filtroTipo.equalsIgnoreCase("2")) {%>
        <%if (reportes.size() != 0) {%>
        <p>Se muestran todos los informes y resultados que te han realizado</p>
        <div id="citas">
            <h5>CITAS</h5>
            <div>
                <table id="tablasReportes">
                    <thead>
                        <tr>
                            <th>CODIGO</th>
                            <th>MEDICO</th>
                            <th>FECHA</th>
                            <th>HORA</th>
                            <th>INFORME</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%for (int i = 0; i < reportes.size(); i++) {%>
                        <tr>
                            <td><%out.print(reportes.get(i).getCodigo());%></td>
                            <td><%out.print(reportes.get(i).getMedico());%></td>
                            <td><%out.print(reportes.get(i).getFecha());%></td>
                            <td><%out.print(reportes.get(i).getHora());%></td>
                            <td><button value="<%out.print(reportes.get(i).getInforme());%>" onclick="mostrar2(this)">VER INFORME</td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
        <%} else {%>
        <h3>No has hecho ninguna consulta</h3>
        <%}%>
        <%} else if (filtroTipo.equalsIgnoreCase("3") || filtroTipo.equalsIgnoreCase("1")) {%>
        <%if (examenes2.size() != 0) {%>
        <div id="tablas2">
            <h5>EXAMENES</h5>
            <table id="tablaResultados">
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>EXAMEN</th>
                        <th>MEDICO</th>
                        <th>ORDEN</th>
                        <th>INFORME</th>
                        <th>HORA</th>
                        <th>FECHA</th>
                        <th>LABORATORISTA</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < examenes2.size(); i++) {%>
                    <tr id="filaexamen<%out.print(examenes2.get(i).getCodigo());%>">
                        <td><%out.print(examenes2.get(i).getCodigo());%></td>
                        <td><%out.print(examenes2.get(i).getExamen());%></td>
                        <%if (examenes2.get(i).getMedico() != null) {%>
                        <td><%out.print(examenes2.get(i).getMedico());%></td>
                        <%} else {%>
                        <td></td>
                        <%}%>
                        <%if (examenes2.get(i).getOrden() != null) {%>
                        <td><button value="<%out.print(examenes2.get(i).getCodigo());%>" name="orden" onclick="mostrar(this)">VER ORDEN</button></td>
                        <%} else {%>
                        <td></td>
                        <%}%>
                        <%if (examenes2.get(i).getInforme() != null) {%>
                        <td><button style="background-color: greenyellow;" value="<%out.print(examenes2.get(i).getCodigo());%>" name="informe" onclick="mostrar(this)">VER INFORME</button></td>
                        <%}%>
                        <td><%out.print(examenes2.get(i).getHora());%></td>
                        <td><%out.print(examenes2.get(i).getFecha());%></td>
                        <td><%out.print(examenes2.get(i).getLaboratorista());%></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </center>
    <%} else {%>
    <h3>No te han realizado un examen aun</h3>
    <%}%>
    <%}%>
    <%}%>
    <div id="descripcionE" class="oculto" style="display: none;">
        <center>
            <div id="mensajeE" class="mensaje2">
                <center>
                    <h1 style="margin-bottom: 5px;">RESULTADO</h1>
                    <h4 style="margin:0;" id="nombrecodigo">EJEMPLO EXAMEN</h4>
                    <embed src="../ControladorPDF?solicidatoPdf=" width="60%" height="400px" id="archivo1" />
                    <hr width="50%">
                    <button id="ocultar" onclick="ocultar(document.getElementById('descripcionE'))">OCULTAR</button>
                </center>
            </div>
        </center>
    </div>
    <div id="descripcion" class="oculto" style="display: none;">
        <center>
            <div id="mensajeInforme" class="mensaje2">
                <center>
                    <h1 style="margin-bottom: 5px;">INFORME</h1>
                    <h4 style="margin:0;" id="nombreC">EJEMPLO EXAMEN</h4>
                    <textarea name="des" id="des" cols="55" rows="19" readonly="readonly"></textarea>
                    <hr width="50%">
                    <button id="ocultar1" onclick="ocultar(document.getElementById('descripcion'))">OCULTAR</button>
                </center>
            </div>
        </center>
    </div>
</body>
</html>
