<%-- 
    Document   : Administradores
    Created on : 7/10/2020, 11:30:18 AM
    Author     : yelbetto
--%>

<%@page import="POJO.AdministradorDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.AdministradorDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <script type="text/javascript" src="../RESOURCES/js/Administrador2.js"></script>
    </head>
    <body>
        <%@include file='Sidebar.jsp'%>
    <center>
        <div id="examenes">
            <h4>ADMINISTRADORES</h4>
            <%  Conector cn = new Conector("encender");
                AdministradorDAO admin = new AdministradorDAO(cn);
                ArrayList<AdministradorDTO> administradores = admin.obtenerAdministradores();
            %>
            <button id="agregarNuevoExamen" onclick="mostrarNuevoAdmin(this)">AGREGAR NUEVO ADMINISTRADOR</button>
            <table>
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>DPI</th>
                        <th>EDITAR</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < administradores.size(); i++) {%>
                    <tr>
                        <td><%out.print(administradores.get(i).getCodigo());%></td>
                        <td><%out.print(administradores.get(i).getNombre());%></td>
                        <td><%out.print(administradores.get(i).getDpi());%></td>
                        <td><button onclick="editarActualAdmin(this)">EDITAR</button></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
        <div id="nuevoMedico" class="oculto" style="display: none;">
            <div id="contenidoMedico" class="mensaje">
                <center>
                    <h1>EXAMEN</h1>
                    <form id="formularioAdministrador" method="POST" action="../Admin">
                        <div class="contenedor" id="contenedor1">
                            <div class="item">
                                <label for="codigo">CODIGO:</label>
                                <input type="text" id="codigo" pattern="^[A][D][M][I][N]+[0-9]*$" required>
                            </div>
                            <div class="item">
                                <label for="nombre">NOMBRE:</label>
                                <input type="text" id="nombre" required>
                            </div>
                            <div class="item">
                                <label for="dpi">DPI: </label>
                                <input type="number" id="dpi" required>
                            </div>
                            <div class="item" id="contra">
                                <label for="password">PASSWORD: </label>
                                <input type="password" id="password" required>
                            </div>
                        </div>
                        <button id="ingresar">INGRESAR</button>
                    </form>
                    <button id="ocultarExamen" onclick="recargar(document.getElementById('nuevoExamen'))">CANCELAR</button>
                </center>
            </div>
        </div>
    </center>
</body>
</html>
