<%-- 
    Document   : AdminExamenes
    Created on : 1/10/2020, 11:52:54 PM
    Author     : yelbetto
--%>

<%@page import="POJO.ExamenDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.ExamenDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Examenes</title><link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
            <h4>EXAMENES</h4>
            <%
                Conector cn = new Conector("encender");
                ExamenDAO examen = new ExamenDAO(cn);
                ArrayList<ExamenDTO> examenes = examen.obtenerExamenes();
            %>
            <button id="agregarNuevoExamen" onclick="mostrarNuevoExamen(this)">AGREGAR NUEVO EXAMEN</button>
            <table>
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>COSTO</th>
                        <th>DESCRIPCION</th>
                        <th>INFORME</th>
                        <th>ORDEN</th>
                        <th>EDITAR</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < examenes.size(); i++) {%>
                    <tr>
                        <td><%out.print(examenes.get(i).getCodigo());%></td>
                        <td><%out.print(examenes.get(i).getNombre());%></td>
                        <td><%out.print(examenes.get(i).getCosto());%></td>
                        <td><button value="<%out.print(examenes.get(i).getDescripcion());%>" onclick="mostrar(this)">VER DESCRIPCION</button></td>
                        <td><%out.print(examenes.get(i).getInforme());%></td>
                        <%if (examenes.get(i).isOrden()) {%>
                        <td>SI</td>
                        <%} else {%>
                        <td>NO</td>
                        <%}%>
                        <td><button onclick="editarActualExamen(this)">EDITAR</button></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
        <div id="descripcion" style="display: none;">
            <div id="mensaje">
                <center>
                    <h1 style="margin-bottom: 5px;">DESCRIPCION</h1>
                    <h4 style="margin:0;" id="nombrecodigo">EJEMPLO EXAMEN</h4>
                    <textarea name="des" id="des" cols="55" rows="19" readonly="readonly"></textarea>
                    <hr width="50%">
                    <button id="ocultar" onclick="ocultar(document.getElementById('descripcion'))">OCULTAR</button>
                </center>
            </div>
        </div>
        <div id="nuevoExamen" class="oculto" style="display: none;">
            <div id="contenidoExamen" class="mensaje">
                <center>
                    <h1>EXAMEN</h1>
                    <form id="formularioAdminExamen" method="POST" action="../Admin">
                        <div class="contenedor" id="contenedor1">
                            <div class="item">
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
                        <div class="contenedor" id="contenedor2">
                            <div class="item">
                                <label for="descripcionExamen">DESCRIPCION</label>
                                <textarea cols="30" rows="13" id="descripcionExamen" required></textarea>
                            </div>
                        </div>
                        <div class="contenedor" id="contenedor3">
                            <div class="item">
                                <label for="informe">INFORME:</label>
                                <select name="informes" id="informe">
                                    <option value="IMG">IMAGEN</option>
                                    <option value="PDF">PDF</option>
                                </select>
                            </div>
                            <div class="item">
                                <label for="orden">ORDEN REQUERIDA:</label>
                                <select name="ordenes" id="orden">
                                    <option value="1">SI</option>
                                    <option value="0">NO</option>
                                </select>
                            </div>
                        </div>
                        <button id="ingresar">INGRESAR</button>
                    </form>
                    <button id="ocultarExamen" onclick="ocultar(document.getElementById('nuevoExamen'))">CANCELAR</button>
                </center>
            </div>
        </div>
    </center>
</body>
</html>
