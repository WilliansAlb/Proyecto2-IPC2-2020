<%-- 
    Document   : AdminMedicos
    Created on : 2/10/2020, 09:31:22 PM
    Author     : yelbetto
--%>

<%@page import="POJO.ConsultaDTO"%>
<%@page import="POJO.EspecialidadDTO"%>
<%@page import="POJO.DoctorDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.DoctorDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medicos</title>
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
            <h4>MEDICOS</h4>
            <%
                Conector cn = new Conector("encender");
                DoctorDAO doctor = new DoctorDAO(cn);
                String[] dias = {"Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"};
                ArrayList<DoctorDTO> doctores = doctor.obtenerMedicos();
                ArrayList<ConsultaDTO> todasLasConsultas = doctor.obtenerConsultas();

            %>
            <button id="agregarNuevoLab" onclick="mostrarNuevoMedico(this)">AGREGAR NUEVO MEDICO</button>
            <table id="tablaLabora">
                <thead>
                    <tr>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>COLEGIADO</th>
                        <th>DPI</th>
                        <th>TELEFONO</th>
                        <th>ESPECIALIDADES</th>
                        <th>CORREO</th>
                        <th>HORARIO</th>
                        <th>INICIO TRABAJO</th>
                        <th>EDITAR</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < doctores.size(); i++) {%>
                    <tr>
                        <td><%out.print(doctores.get(i).getCodigo());%></td>
                        <td><%out.print(doctores.get(i).getNombre());%></td>
                        <td><%out.print(doctores.get(i).getNo_colegiado());%></td>
                        <td><%out.print(doctores.get(i).getDpi());%></td>
                        <td><%out.print(doctores.get(i).getTelefono());%></td>
                        <td><select name="especialidades" id="selectEspecialidades"><%
                            EspecialidadDTO especialidad = doctores.get(i).getEspecialidades();
                            ConsultaDTO[] consultas = especialidad.getConsulta();
                            for (int o = 0; o < consultas.length; o++) {
                                %>
                                <option value="<%out.print(consultas[o].getCodigo()+"/"+consultas[o].getCodigoEspecialidad());%>"><%out.print(consultas[o].getNombre());%></option>
                                <%}%></select></td>
                        <td><%out.print(doctores.get(i).getEmail());%></td>
                        <td><%out.print(doctores.get(i).getHorario()[0]+"-"+doctores.get(i).getHorario()[1]);%></td>
                        <td><%out.print(doctores.get(i).getFecha_inicio());%></td>
                        <td><button onclick="editarActualMedico(this)">EDITAR</button></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
        <div id="nuevoMedico" class="oculto" style="display: none;">
            <div id="contenidoMedico" class="mensaje">
                <center>
                    <h1>LABORATORISTA</h1>
                    <form id="formularioAdminMedico" method="POST" action="../Admin">
                        <div class="contenedor">
                            <center>
                                <div class="item">
                                    <label for="codigo">CODIGO: </label>
                                    <input type="text" id="codigo" pattern="^[M][E][D][-]+[0-9]*$" required>
                                </div>
                                <div class="item">
                                    <label for="nombre">NOMBRE: </label>
                                    <input type="text" id="nombre" required>
                                </div>
                                <div class="item">
                                    <label for="colegiado">COLEGIADO: </label>
                                    <input type="number" id="colegiado" step="1" required>
                                </div>
                                <div class="item">
                                    <label for="dpi">DPI: </label>
                                    <input type="number" id="dpi" required>
                                </div>
                                <div class="item">
                                    <label for="telefono">TELEFONO: </label>
                                    <input type="number" id="telefono" required>
                                </div>
                                <div class="item" id="especialidadesLista">
                                    <label for="especialidades">ESPECIALIDADES: </label>
                                    <div id="esp">
                                        <select class="especialidades" id="especialidades" name="0">
                                            <%for (int o = 0; o < todasLasConsultas.size(); o++) {%>
                                            <option value="<%out.print(todasLasConsultas.get(o).getCodigo());%>"><%out.print(todasLasConsultas.get(o).getNombre());%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <a onclick="agregarSelect()" id="paraEspecialidades">AGREGAR +</a>
                                </div>
                                <div class="item">
                                    <label for="correo">CORREO: </label>
                                    <input type="email" id="correo" required>
                                </div>
                                <div class="item">
                                    <label for="correo">HORARIO(formato 24hrs): </label>
                                    INICIO<input type="number" id="inicio" step="1" min="0" max="23" required>
                                    FINAL <input type="number" id="final" step="1" min="0" max="23" required>
                                </div>
                                <div class="item">
                                    <label for="fechaInicio">FECHA INICIO: </label>
                                    <input type="date" id="fechaInicio" required>
                                </div>
                                <div class="item" id="contra">
                                    <label for="password">PASSWORD: <label>
                                    <input type="password" id="password" required>
                                </div>
                            </center>
                        </div>
                        <button id="ingresar">INGRESAR</button>
                    </form>
                    <button id="ocultarMedico" onclick="recargar(document.getElementById('nuevoMedico'))">CANCELAR</button>
                </center>
            </div>
        </div>
    </center>
</body>
</html>