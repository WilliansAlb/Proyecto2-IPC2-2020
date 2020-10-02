<%-- 
    Document   : AdminConsultas
    Created on : 2/10/2020, 02:17:32 PM
    Author     : yelbetto
--%>

<%@page import="POJO.ConsultaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.ConsultaDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consultas</title><link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <script type="text/javascript" src="../RESOURCES/js/Administrador.js"></script>
    </head>
    <body>
        <%@include file="Sidebar.jsp"%>
    <center>
        <div id="examenes">
            <h4>CONSULTAS</h4>
            <%
                Conector cn = new Conector("encender");
                ConsultaDAO consulta = new ConsultaDAO(cn);
                ArrayList<ConsultaDTO> consultas = consulta.obtenerConsultas();
            %>
            <button id="agregarNuevoExamen" onclick="mostrarNuevaConsulta(this)">AGREGAR NUEVO EXAMEN</button>
            <table>
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>COSTO</th>
                        <th>EDITAR</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < consultas.size(); i++) {%>
                    <tr>
                        <td><%out.print(consultas.get(i).getCodigo());%></td>
                        <td><%out.print(consultas.get(i).getNombre());%></td>
                        <td><%out.print(consultas.get(i).getCosto());%></td>
                        <td><button onclick="editarActualConsulta(this)">EDITAR</button></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
        <div id="nuevaConsulta" class="oculto" style="display: none;">
            <div id="contenidoConsulta" class="mensaje">
                <center>
                    <h1>Consulta</h1>
                    <form id="formularioAdminConsulta" method="POST" action="../Admin">
                        <div class="contenedor" id="contenedor1">
                            <div class="item" id="codigoDiv">
                                <label for="codigo">CODIGO:</label>
                                <input type="text" id="codigo" required>
                            </div>
                            <div class="item">
                                <label for="nombre">NOMBRE:</label>
                                <input type="text" id="nombre" required>
                            </div>
                            <div class="item">
                                <label for="costo">COSTO:</label>
                                <input type="number" id="costo" min="0.01" step="0.01" required>
                            </div>
                        </div>
                        <button id="ingresar">INGRESAR</button>
                    </form>
                    <button id="ocultarConsulta" onclick="ocultar(document.getElementById('nuevaConsulta'))">CANCELAR</button>
                </center>
            </div>
        </div>
    </center>
</body>
</html>
