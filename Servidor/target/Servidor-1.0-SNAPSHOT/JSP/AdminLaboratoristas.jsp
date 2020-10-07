<%-- 
    Document   : AdminLaboratorista
    Created on : 2/10/2020, 04:24:08 PM
    Author     : yelbetto
--%>

<%@page import="Base.ExamenDAO"%>
<%@page import="POJO.ExamenDTO"%>
<%@page import="POJO.TrabajoDTO"%>
<%@page import="POJO.LaboratoristaDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.LaboratoristaDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Laboratoristas</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <script type="text/javascript" src="../RESOURCES/js/Administrador.js"></script>
    </head>
    <body>
        <%@include file='Sidebar.jsp'%>
    <center>
        <div id="tablaLab">
            <h4>LABORATORISTAS</h4>
            <%
                Conector cn = new Conector("encender");
                LaboratoristaDAO laboratorista = new LaboratoristaDAO(cn);
                ExamenDAO examen = new ExamenDAO(cn);
                ArrayList<ExamenDTO> examenes = examen.obtenerExamenes();
                ArrayList<LaboratoristaDTO> laboratoristas = laboratorista.obtenerTodosLaboratoristas();
                String[] dias = {"Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"};
            %>
            <button id="agregarNuevoLab" onclick="mostrarNuevoLab(this)">AGREGAR NUEVO LABORATORISTA</button>
            <table id="tablaLabora">
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>REGISTRO</th>
                        <th>DPI</th>
                        <th>TELEFONO</th>
                        <th>EXAMEN</th>
                        <th>CORREO</th>
                        <th>DIAS TRABAJO</th>
                        <th>INICIO TRABAJO</th>
                        <th>EDITAR</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < laboratoristas.size(); i++) {%>
                    <tr>
                        <td><%out.print(laboratoristas.get(i).getCodigo());%></td>
                        <td><%out.print(laboratoristas.get(i).getNombre());%></td>
                        <td><%out.print(laboratoristas.get(i).getNo_registro());%></td>
                        <td><%out.print(laboratoristas.get(i).getDpi());%></td>
                        <td><%out.print(laboratoristas.get(i).getTelefono());%></td>
                        <td><%out.print(laboratoristas.get(i).getNombreExamen());%></td>
                        <td><%out.print(laboratoristas.get(i).getEmail());%></td>
                        <td><select name="trabajos"><%
                            ArrayList<TrabajoDTO> trabajos = laboratoristas.get(i).getTrabajos();
                            for (int u = 0; u < trabajos.size(); u++) {
                                %>
                                <option value="<%out.print(trabajos.get(u).getDia());%>"><%out.print(dias[trabajos.get(u).getDia() - 1]);%></option>
                                <%}%></select></td>
                        <td><%out.print(laboratoristas.get(i).getFecha());%></td>
                        <td><button onclick="editarActualLab(this)">EDITAR</button></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
        <div id="nuevoLaboratorista" class="oculto" style="display: none;">
            <div id="contenidoLaboratorista" class="mensaje">
                <center>
                    <h1>LABORATORISTA</h1>
                    <form id="formularioAdminLaboratorista" method="POST" action="../Admin">
                        <div class="contenedor">
                        <div class="item">
                            <label for="codigo">CODIGO: </label>
                            <input type="text" id="codigo" pattern="^[L][A][B][-]+[0-9]*$" required>
                        </div>
                        <div class="item">
                            <label for="nombre">NOMBRE: </label>
                            <input type="text" id="nombre" required>
                        </div>
                        <div class="item">
                            <label for="examen">EXAMEN: </label>
                            <select name="examen" id="examen" required>
                                <%for (int i = 0; i < examenes.size(); i++) {%>
                                <option value="<%out.print(examenes.get(i).getCodigo());%>"><%out.print(examenes.get(i).getNombre());%></option>
                                <%}%>
                            </select>
                        </div>
                        <div class="item">
                            <label for="registro">REGISTRO: </label>
                            <input type="text" name="registro" id="registro" required>
                        </div>
                        <div class="item">
                            <label for="dpi">DPI: </label>
                            <input type="number" name="dpi" id="dpi" step="1" min="1" required>
                        </div>
                        <div class="item">
                            <label for="telefono">TELEFONO: </label>
                            <input type="number" name="telefono" id="telefono" step="1" min="1" required>
                        </div>
                        <div class="item">
                            <label>DIAS DE TRABAJO: </label>
                            <div id="diasDeTrabajo">
                            <%for (int i = 0; i < dias.length; i++) {
                            %>
                            <div class="item">
                                <input type="checkbox" class="trabajos" id="<%out.print(dias[i]);%>" name="dias" value="0" ><label for="<%out.print(dias[i]);%>" class="dias"><%out.print(dias[i]);%></label>
                            </div>
                            <%}%>
                            </div>
                        </div>
                        <div class="item">
                            <label for="fecha">FECHA NACIMIENTO: </label>
                            <input type="date" name="fecha" id="fecha" required>
                        </div>
                        <div class="item">
                            <label for="email">EMAIL: </label>
                            <input type="text"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" name="email" id="email" required>
                        </div>
                            <div class="item" style="display:none;" id="contra">
                            <label for="password">PASSWORD: </label>
                            <input type="password"  name="password" id="password" required>
                        </div>
                        </div>
                        <button id="ingresar">INGRESAR</button>
                    </form>
                    <button id="ocultarLaboratorista" onclick="ocultar(document.getElementById('nuevoLaboratorista'))">CANCELAR</button>
                </center>
            </div>
        </div>
    </center>
</body>
</html>
