<%-- 
    Document   : Historial
    Created on : 4/10/2020, 06:38:45 PM
    Author     : yelbetto
--%>

<%@page import="POJO.ReporteDTO"%>
<%@page import="Base.ReporteDAO"%>
<%@page import="POJO.ResultadoDTO"%>
<%@page import="Base.ResultadoDAO"%>
<%@page import="POJO.CitaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.CitaDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Historial</title>
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <script type="text/javascript" src="../RESOURCES/js/Pendientes.js"></script>
        <link rel="stylesheet" href="../RESOURCES/css/Lab.css">
    </head>
    <body>
        <%@include file="Sidebar.jsp" %>
        <%
            Conector cn = new Conector("encender");
            //Cases de obtención de datos
            CitaDAO cita = new CitaDAO(cn);
            ReporteDAO reporte = new ReporteDAO(cn);
            ResultadoDAO resultado = new ResultadoDAO(cn);
            //Variable del paciente que está buscando el historial
            String pacienteActual = "";
            //Verificar que exista un HttpSession
            HttpSession s = request.getSession();
            if (s.getAttribute("usuario")!=null && s.getAttribute("tipo")!=null) {
                if (s.getAttribute("tipo").toString().equalsIgnoreCase("PACIENTE")){
                    pacienteActual = s.getAttribute("usuario").toString();
                } else {
                    response.sendRedirect("Perfil.jsp");
                }
            } else {
                //response.sendRedirect("/Servidor/index.jsp");
                pacienteActual = "118258";
            }
            //Contenedores de datos para mostrar en la pagina
            ArrayList<ReporteDTO> reportes = reporte.obtenerReportePaciente(pacienteActual);
            ArrayList<ResultadoDTO> examenes = resultado.obtenerResultadosDePacienteRealizado(pacienteActual);
        %>
    <center>
        <div id="historial">
            <h5>TU HISTORIAL MEDICO</h5>
            <%if (reportes.size() != 0) {%>
            <p>Se muestran todas las citas y examenes que tienes pendientes</p>
            <div id="citas"  class="ventana">
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
                            <td><%out.print(reportes.get(i).getHora() / 100);%></td>
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

            <%if (examenes.size() != 0) {%>
            <div id="tablas2" class="ventana">
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
                        <%for (int i = 0; i < examenes.size(); i++) {%>
                        <tr id="filaexamen<%out.print(examenes.get(i).getCodigo());%>">
                            <td><%out.print(examenes.get(i).getCodigo());%></td>
                            <td><%out.print(examenes.get(i).getExamen());%></td>
                            <%if (examenes.get(i).getMedico() != null) {%>
                            <td><%out.print(examenes.get(i).getMedico());%></td>
                            <%} else {%>
                            <td></td>
                            <%}%>
                            <%if (examenes.get(i).getOrden() != null) {%>
                            <td><button value="<%out.print(examenes.get(i).getCodigo());%>" name="orden" onclick="mostrar(this)">VER ORDEN</button></td>
                            <%} else {%>
                            <td></td>
                            <%}%>
                            <%if (examenes.get(i).getInforme() != null) {%>
                            <td><button style="background-color: greenyellow;" value="<%out.print(examenes.get(i).getCodigo());%>" name="informe" onclick="mostrar(this)">VER INFORME</button></td>
                            <%} else {%>
                            <td><button style="background-color: red;" value="<%out.print(examenes.get(i).getCodigo());%>" onclick="agregarResultado(this)">AGREGAR RESULTADO</button></td>
                            <%}%>
                            <td><%out.print(examenes.get(i).getHora());%></td>
                            <td><%out.print(examenes.get(i).getFecha());%></td>
                            <td><%out.print(examenes.get(i).getLaboratorista());%></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
            <%} else {%>
            <h3>No te han realizado un examen aun</h3>
            <%}%>
        </div>
    </center>
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

