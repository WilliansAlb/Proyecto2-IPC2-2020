<%-- 
    Document   : Medico
    Created on : 28/09/2020, 07:02:54 PM
    Author     : yelbetto
--%>

<%@page import="POJO.CitaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.CitaDAO"%>
<%@page import="Base.Conector"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medico</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script src="../RESOURCES/js/IngresarInforme.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Paciente.css">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
    </head>
    <body>
        <%SimpleDateFormat objSDF = new SimpleDateFormat("yyyy-MM-dd");
            Conector cn = new Conector("encender");
            CitaDAO cita = new CitaDAO(cn);
            ArrayList<CitaDTO> citas = cita.obtenerCitas("MED-123", "2020-09-12");
        %>
        <%@include file="Sidebar.jsp"%>
        <div id="ingresoInforme">
            <%if (citas.size() > 0) {%>
            <center>
                <div id="tablaCitas">
                    <h3>Cola de citas</h3>
                    <label for="fechaHoy">Fecha actual</label>
                    <input type="date" id="fechaHoy" value="<%=objSDF.format(new java.util.Date())%>" onchange="cambiandoFecha()">
                    <button id="verCitas" onclick="mostrarHora()">VER CITAS</button>
                    <table>
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>PACIENTE</th>
                                <th>CONSULTA</th>
                                <th>HORA</th>
                            </tr> 
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < citas.size(); i++) {%>
                            <tr>
                                <td><%out.println(citas.get(i).getCodigo());%></td>
                                <td><%out.println(citas.get(i).getPaciente());%></td>
                                <td><%out.println(citas.get(i).getConsulta());%></td>
                                <td><%out.println(citas.get(i).getHora());%></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                    <button id="ingresarSiguiente">INGRESAR SIGUIENTE</button>
            </center>
        </div>
    <center>
        <div id="agregarInforme">
            <center>
                <div class="contenedor2">
                    <div class="item">
                        <label for="codigoInforme">CODIGO12: </label>
                        <input type="text" id="codigoInforme">
                    </div>
                    <div class="item">
                        <label for="pacienteNombre">PACIENTE: </label>
                        <input type="text" id="pacienteNombre">
                    </div>
                    <div class="item">
                        <label for="fechaInforme">FECHA: </label>
                        <input type="date" id="fechaInforme">
                    </div>
                </div>
                <br>
                <label for="informe">INFORME: </label>
                <br>
                <textarea id="informe" cols="100" rows="5"></textarea>
                <br>
                <button>TERMINAR</button>
                <button>AGREGAR EXAMEN</button>
            </center>
        </div>
    </center>
    <%}%>
</div>
</body>
</html>
