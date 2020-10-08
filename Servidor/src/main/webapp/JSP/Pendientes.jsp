<%-- 
    Document   : Historial
    Created on : 4/10/2020, 04:51:40 PM
    Author     : yelbetto
--%>

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
        <%
            //Conexion con la base de datos
            Conector cn = new Conector("encender");
            //Clases que devuelven los datos requeridos para llenar esta pagina
            CitaDAO cita = new CitaDAO(cn);
            ResultadoDAO resultado = new ResultadoDAO(cn);
            //Contenedores de los datos
            ArrayList<CitaDTO> citas = new ArrayList<>();
            ArrayList<ResultadoDTO> examenes = new ArrayList<>();
            //Variable HttpSession que nos dice si el usuario es un Paciente o no
            HttpSession s = request.getSession();
            if (s.getAttribute("usuario") != null && s.getAttribute("tipo") != null) {
                if (s.getAttribute("tipo").toString().equalsIgnoreCase("PACIENTE")) {
                    String paciente = s.getAttribute("usuario").toString();
                    citas = cita.obtenerCitasDePacientePendientes(paciente);
                    examenes = resultado.obtenerResultadosDePacientePendientes(paciente);
                } else {
                    response.sendRedirect("Perfil.jsp");
                }
            } else {
                response.sendRedirect("/Servidor/index.jsp");
            }
        %>
    <center>
        <%if (s.getAttribute("usuario") != null && s.getAttribute("tipo") != null) {%>
        <%@include file="Sidebar.jsp"%>
        <%}%>
        <div id="historial">
            <h5>CITAS Y EXAMENES PENDIENTES</h5>
            <%if (citas.size() != 0) {%>
            <p>Se muestran todas las citas y examenes que tienes pendientes</p>
            <div id="citas"  class="ventana">
                <h5>CITAS</h5> 
                <table id="tablaCitas1">
                    <thead>
                        <tr>
                            <th>CODIGO</th>
                            <th>MEDICO</th>
                            <th>CONSULTA</th>
                            <th>FECHA</th>
                            <th>HORA</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%for (int i = 0; i < citas.size(); i++) {%>
                        <tr>
                            <td><%out.print(citas.get(i).getCodigo());%></td>
                            <td><%out.print(citas.get(i).getMedico());%></td>
                            <td><%out.print(citas.get(i).getConsulta());%></td>
                            <td><%out.print(citas.get(i).getFecha());%></td>
                            <td><%out.print(citas.get(i).getHora() / 100);%></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
            <%} else {%>
            <h3>No tienes citas pendientes</h3>
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
                            <td><%out.print(examenes.get(i).getHora() / 100);%></td>
                            <td><%out.print(examenes.get(i).getFecha());%></td>
                            <td><%out.print(examenes.get(i).getLaboratorista());%></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
            <%} else {%>
            <h3>No tienes examenes pendientes</h3>
            <%}%>
        </div>
    </center>
    <div id="descripcionE" class="oculto" style="display: none;">
        <center>
            <div id="mensajeE" class="mensaje2">
                <center>
                    <h1 style="margin-bottom: 5px;">DESCRIPCION</h1>
                    <h4 style="margin:0;" id="nombrecodigo">EJEMPLO EXAMEN</h4>
                    <embed src="../ControladorPDF?solicidatoPdf=" width="60%" height="400px" id="archivo1" />
                    <hr width="50%">
                    <button id="ocultar" onclick="ocultar(document.getElementById('descripcionE'))">OCULTAR</button>
                </center>
            </div>
        </center>
    </div>
</body>
</html>
