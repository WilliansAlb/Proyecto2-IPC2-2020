<%-- 
    Document   : Laboratorista
    Created on : 4/10/2020, 03:21:38 AM
    Author     : yelbetto
--%>

<%@page import="POJO.ResultadoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.ResultadoDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Examenes</title>
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <script type="text/javascript" src="../RESOURCES/js/Laboratorista.js"></script>
        <link rel="stylesheet" href="../RESOURCES/css/Lab.css">
    </head>
    <body>
        <%@include file="Sidebar.jsp" %>
        <%
            Conector cn = new Conector("encender");
            ResultadoDAO resultado = new ResultadoDAO(cn);
            ArrayList<ResultadoDTO> examenes = resultado.obtenerResultados();
        %>
    <center>
        <div id="examenesPendientes" class="ventana">
            <h4>TUS EXAMENES</h4>
            <select name="filtros">
                <option>MOSTRAR TODOS</option>
                <option>MOSTRAR HOY SIN REALIZAR</option>
                <option>MOSTRAR SEGUN FECHA</option>
            </select>
            <div id="tablas1">
                <table id="tablaExamenes">
                    <thead>
                        <tr>
                            <th>CODIGO</th>
                            <th>EXAMEN</th>
                            <th>PACIENTE</th>
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
                            <td><%out.print(examenes.get(i).getPaciente());%></td>
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
            <hr>        
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
    <div id="agregarResultado" class="oculto" style="display: none;">
        <center>
            <div id="mensajeE" class="mensaje2">
                <center>
                    <h3>INGRESAR RESULTADOS</h3>
                    <p>Ingresa el siguiente reporte, con datos:</p>
                    <div class="contenedor">
                        <div class="item"><label for="reporteDato">Reporte:</label>
                            <input type="text" id="reporteDato" disabled></div>
                        <div class="item"><label for="pacienteDato">Paciente:</label>
                            <input type="text" id="pacienteDato" disabled></div>
                        <div class="item"><label for="examenDato">Examen: </label>
                            <input type="text" id="examenDato" disabled></div>
                    </div>
                    <p>Ingresa un archivo del tipo requerido</p>
                    <label for="archivo" tabindex="0" class="input-file-trigger">Selecciona el archivo con los resultados...</label>
                    <p id="ruta" class="file-return"></p>
                    <br>
                    <input type="file" id="archivo" onchange="verificar()" accept=".pdf">
                    <embed src="" width="60%" height="400px" id="visualizarArchivo" />
                    <div class="contenedor">
                        <div class="item">
                            <button id="ocultar" onclick="ocultar(document.getElementById('agregarResultado'))">OCULTAR</button></div>
                        <div class="item">
                            <button id="ingresarExa" onclick="ingresarExamenLaboratorista()">INGRESAR</button></div>
                    </div>
                </center>
            </div>
        </center>
    </div>
</body>
</html>
