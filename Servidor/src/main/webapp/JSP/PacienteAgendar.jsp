<%-- 
    Document   : PacienteAgendar
    Created on : 3/10/2020, 12:59:44 AM
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
        <title>Agendar Consulta</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <link rel="stylesheet" href="../RESOURCES/css/Cita.css">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <script type="text/javascript" src="../RESOURCES/js/Cita.js"></script>
    </head>
    <body>
        <%
            Conector cn = new Conector("encender");
            DoctorDAO doctor = new DoctorDAO(cn);
            String[] dias = {"Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"};
            ArrayList<DoctorDTO> doctores = new ArrayList<>();
            HttpSession s = request.getSession();
            ArrayList<ConsultaDTO> todasLasConsultas = new ArrayList<>();
            todasLasConsultas = doctor.obtenerConsultas();
            String filtro = "";
            if (s.getAttribute("tipoConsulta") == null) {
                doctores = doctor.obtenerMedicos();
            } else {
                String tipoco = s.getAttribute("tipoConsulta").toString();
                if (tipoco.equalsIgnoreCase("1")) {
                    doctores = doctor.obtenerMedicosLike(s.getAttribute("filtroMedico").toString());
                    filtro = s.getAttribute("filtroMedico").toString();
                } else if (tipoco.equalsIgnoreCase("2")) {
                    doctores = doctor.obtenerMedicosPorEspecialidad(s.getAttribute("filtroMedico").toString());
                    filtro = s.getAttribute("filtroMedico").toString();
                } else if (tipoco.equalsIgnoreCase("3")) {
                    doctores = doctor.obtenerMedicosPorFecha(s.getAttribute("filtroMedico").toString(), s.getAttribute("filtroMedico1").toString());
                    filtro = s.getAttribute("filtroMedico").toString() + " " + s.getAttribute("filtroMedico1").toString();
                } else if (tipoco.equalsIgnoreCase("4")) {
                    doctores = doctor.obtenerMedicosPorHora(s.getAttribute("filtroMedico").toString());
                    filtro = s.getAttribute("filtroMedico").toString();
                } else {
                    doctores = doctor.obtenerMedicos();
                }
                s.setAttribute("tipoConsulta", null);
            }
        %>
        <%@include file='Sidebar.jsp' %>
    <center>
        <div id="inicio" style="display: none;">
            <h3>AGENDAR CITA</h3>
            <p>Bienvenido al portal para agendar citas, a continuación ingresa los datos requeridos</p>
            <label for="consultas">Tipo de consulta: </label>
            <table id="consultas">
                <thead>
                    <tr>
                        <td>Codigo</td>
                        <td>Consulta</td>
                        <td>Costo</td>
                        <td>Seleccionar</td>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < todasLasConsultas.size(); i++) {
                    %>
                    <tr>
                        <td><%out.print(todasLasConsultas.get(i).getCodigo());%></td>
                        <td><%out.print(todasLasConsultas.get(i).getNombre());%></td>
                        <td><%out.print(todasLasConsultas.get(i).getCosto());%></td>
                        <td><input type="checkbox" onchange="cambiar(this)" class="seleccionar" name="<%out.print(todasLasConsultas.get(i).getCosto());%>" value="<%out.print(todasLasConsultas.get(i).getCodigo());%>"></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
            <button id="atras" onclick="siguiente($('#medico'), $('#inicio'))">&larr;ATRAS</button>
            <button id="siguiente" onclick="mostrarHorarios($('#horario'), $('#inicio'))" disabled>SIGUIENTE&rarr;</button>
        </div>
    </center>
    <center>
        <div id="medico">
            <h3>AGENDAR CITA</h3>
            <p>Bienvenido al portal para agendar citas, ingresa los datos solicitados luego presiona siguiente</p>
            <form id="formularioFiltros" method="GET" action="../Cita">
                <label for="filtroMedicos">Tipo de filtro: </label>
                <select class="filtros" name="filtros" id="filtroMedicos" onchange="cambiandoFiltros(this)">
                    <option value="1">SIN FILTROS</option>
                    <option value="filtro1">POR NOMBRE</option>
                    <option value="filtro2">POR ESPECIALIDAD</option>
                    <option value="filtro3">POR RANGO DE FECHA</option>
                    <option value="filtro4">POR HORARIO</option>
                </select>
                <div id="filtro1" style="display: none;">
                    <label for="texto">Nombre:</label><br>
                    <input type="text" class="filtros" name="nombre" id="texto" required>
                </div>
                <div id="filtro2" style="display:none;">
                    <label for="especialidadesFiltro">Especialidad: </label><br>
                    <select name="especialidades" id="especialidadesFiltro" class="filtros">
                        <%
                            for (int i = 0; i < todasLasConsultas.size(); i++) {
                        %>
                        <option value="<%out.print(todasLasConsultas.get(i).getCodigo());%>"><%out.print(todasLasConsultas.get(i).getNombre());%></option>
                        <%}%>
                    </select>
                </div>
                <div id="filtro3" style="display:none;">
                    <label for="desde">Desde:</label>
                    <input type="date" id="desde" name="desde" class="filtros" required>
                    <label for="hasta">Hasta:</label>
                    <input type="date" id="hasta" name="hasta" class="filtros" required>
                </div>
                <div id="filtro4" style="display:none;">
                    <label for="hora">Hora: </label><br>
                    <input id="hora" type="number" name="hora" step="1" min="0" max="23" class="filtros" required>
                </div>
                <button id="buscarMedico" style="display: none;">BUSCAR</button>
            </form>
            <label for="medicos">Medicos: </label>
            <table id="medicos">
                <thead>
                    <tr>
                        <td>Codigo</td>
                        <td>Nombre</td>
                        <td>Colegiado</td>
                        <td>DPI</td>
                        <td>Hora entrada</td>
                        <td>Hora salida</td>
                        <td>Especialidades</td>
                        <td>Email</td>
                        <td>Fecha Inicio</td>
                        <td>Seleccionar</td>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (int i = 0; i < doctores.size(); i++) {
                            EspecialidadDTO especialidades = doctores.get(i).getEspecialidades();
                            ConsultaDTO[] consultas = especialidades.getConsulta();
                            String consultasT = "";
                            for (int o = 0; o < consultas.length; o++) {
                                consultasT += consultas[o].getNombre() + "\n";
                            }
                    %>
                    <tr>
                        <td><%out.print(doctores.get(i).getCodigo());%></td>
                        <td><%out.print(doctores.get(i).getNombre());%></td>
                        <td><%out.print(doctores.get(i).getNo_colegiado());%></td>
                        <td><%out.print(doctores.get(i).getDpi());%></td>
                        <td><%out.print(doctores.get(i).getHorario()[0]);%></td>
                        <td><%out.print(doctores.get(i).getHorario()[1]);%></td>
                        <td><%out.print(consultasT);%></td>
                        <td><%out.print(doctores.get(i).getEmail());%></td>
                        <td><%out.print(doctores.get(i).getFecha_inicio());%></td>
                        <td><input type="checkbox" onchange="cambiarDatos(this)" class="seleccionarDatos" name="<%out.print(doctores.get(i).getCodigo());%>" value="<%out.print(consultasT);%>"></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
            <button id="siguiente2" onclick="mostrarUnicasEspecialidades($('#inicio'), $('#medico'))" disabled>SIGUIENTE&rarr;</button>
        </div>
        <div id="horario" style="display:none;">
            <h3>Elige una fecha y un horario</h3>
            <p>Selecciona una fecha y se te mostrará la disponibildad del médico según su horario</p>
            <p>*Nota:seleccionas la hora que quieres al marcar el cuadro de la tabla</p>
            <input type="date" id="fechaElegida">
            <button id="fechaSeleccion" onclick="seleccionandoFecha()">BUSCAR</button>
            <table id="horarios">
                <thead>
                    <tr>
                        <td>HORA</td>
                        <td>ESTADO</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><p>Acá apareceran las horas en las que trabaja el medico</p></td>
                        <td><p>Acá aparecera la disponibilidad</p></td>
                    </tr>
                </tbody>
            </table>
            <button onclick="retroceder($('#inicio'),$('#horario'))">&larr;ATRAS</button><button id="siguiente3" disabled>SIGUIENTE&rarr;</button>
        </div>
    </center>
</body>
</html>
