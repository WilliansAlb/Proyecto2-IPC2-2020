<%-- 
    Document   : Medico
    Created on : 28/09/2020, 07:02:54 PM
    Author     : yelbetto
--%>

<%@page import="Base.DoctorDAO"%>
<%@page import="POJO.ExamenDTO"%>
<%@page import="Base.ExamenDAO"%>
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
            ExamenDAO examen = new ExamenDAO(cn);
            DoctorDAO doctor = new DoctorDAO(cn);
            ArrayList<CitaDTO> citas = cita.obtenerCitas("MED-123", "2020-09-12");
            ArrayList<ExamenDTO> examenes = examen.obtenerExamenes();
            String[] horario = doctor.obtenerHorario("MED-123");
        %>
        <%@include file="Sidebar.jsp"%>
        <div id="ingresoInforme" class="centrado">
            <%if (citas.size() > 0) {%>
            <center>
                <div id="tablaCitas">
                    <h3>Cola de citas</h3>
                    <label for="fechaHoy">Fecha actual</label>
                    <input type="date" id="fechaHoy" value="<%=objSDF.format(new java.util.Date())%>" onchange="cambiandoFecha()">
                    <button id="verCitas" onclick="mostrarHora()">VER CITAS</button>
                    <table id="colaCitas">
                        <thead>
                            <tr>
                                <th>CODIGO</th>
                                <th>PACIENTE</th>
                                <th>CONSULTA</th>
                                <th>HORA</th>
                            </tr> 
                        </thead>
                        <tbody>
                            <%for (int i = 0; i < citas.size(); i++) {
                                    Double hora = (double) citas.get(i).getHora() / 100;
                                    String horaTipo = hora.toString().replace(".", ":");
                            %>
                            <tr>
                                <td><%out.println(citas.get(i).getCodigo());%></td>
                                <td><%out.println(citas.get(i).getPaciente());%></td>
                                <td><%out.println(citas.get(i).getConsulta());%></td>
                                <td><%out.println(horaTipo);%></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                    <button id="ingresarSiguiente" onclick="mostrarInforme()">INGRESAR SIGUIENTE</button>
            </center>
        </div>
    <center>
        <div id="agregarInforme" style="display:none;" class="center">
            <center>
                <h3>REPORTE</h3>
                <div class="contenedor2">
                    <div class="item">
                        <label for="codigoInforme">CODIGO: </label>
                        <div>
                            <input type="text" id="codigoInforme" onkeydown="verificarCodigo(this)" required>
                            <p id="codigoCorrecto"></p>
                        </div>
                    </div>
                    <div class="item">
                        <label for="codigoCita">CITA: </label>
                        <input type="text" id="codigoCita" disabled required>
                    </div>
                    <div class="item">
                        <label for="pacienteNombre">PACIENTE: </label>
                        <input type="text" id="pacienteNombre" disabled required>
                    </div>
                    <div class="item">
                        <label for="fechaInforme1">FECHA: </label>
                        <input type="date" id="fechaInforme1" value="<%=objSDF.format(new java.util.Date())%>">
                    </div>
                    <div class="item">
                        <label for="horaInforme">HORA: </label>
                        <select name="horas" id="horaInforme">
                            <%  if (horario[2].equalsIgnoreCase("INT")) {
                                    int inicio = Integer.parseInt(horario[0]);
                                    int fin = Integer.parseInt(horario[1]);
                                    while (inicio < fin) {%>
                            <option value="<%out.print(inicio + 1);%>"><%out.print((inicio + 1) + ":00");%></option>
                            <%
                                    inicio++;
                                }
                            } else {
                                Double inicio = Double.parseDouble(horario[0]);
                                Double fin = Double.parseDouble(horario[1]);
                                while (inicio < fin) {
                                    String inicioHora = inicio + "";
                                    String inicioHoraCorrecta = inicioHora.replace('.', ':');
                            %>
                            <option value="<%out.print(inicio + 1.00);%>"><%out.print(inicioHoraCorrecta);%></option>
                            <%
                                        inicio += 1.00;
                                    }
                                }%>
                        </select>
                    </div>

                </div>
                <br>
                <label for="informe">INFORME: </label>
                <br>
                <textarea id="informe" cols="100" rows="10" required></textarea>
                <br>
                <button id="ingresarReporte" onclick="ingresarReporte()">INGRESAR REPORTE</button>
                <button id="generarReporte" onclick="ingresarExamen()">INGRESAR REPORTE Y GENERAR EXAMEN</button>
            </center>
        </div>
        <div id="agregarExamen" style="display:none;" class="">
            <center>
                <h3>EXAMEN</h3>
                <div class="contenedor2">
                    <div class="item">
                        <label for="codigoResultado">CODIGO: </label>
                        <input type="text" id="codigoResultado">
                    </div>
                    <div class="item">
                        <label for="examenes">EXAMEN: </label>
                        <select name="examenes" onchange="cambiarExamen(this)" id="opcionExamen">
                            <%for (int i = 0; i < examenes.size(); i++) {%>
                            <option value="<%out.print(examenes.get(i).getCodigo());%>"><%out.print(examenes.get(i).getNombre());%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="item">
                        <label for="fechaInforme">FECHA: </label>
                        <input type="date" id="fechaInforme" onchange="cambiarFecha(this)" value="">
                    </div>
                    <%if (examenes.get(0).isOrden()) {%>
                    <div class="item" id="ordenArchivo">
                        <%} else {%>
                        <div class="item" id="ordenArchivo" style="display: none;">
                            <%}%>
                            <label for="examenArchivo" tabindex="0" class="input-file-trigger">INGRESA ORDEN(PDF): </label>
                            <input type="file" id="examenArchivo" accept=".pdf" onchange="cambiarArchivo(this)">
                            <p id="ruta" class="file-return"></p>
                        </div>
                        <div class="item" id="selectLabo" style="display: none;">
                            <label for="laboratoristas">LABORATORISTA: </label>
                            <select name="laboratoristas" id="laboratoristas">
                                <option value="SIN">SELECCIONA UNA FECHA PRIMERO</option>
                            </select>
                        </div>
                        <div class="item" id="selectHorario">
                            <label for="ingresoHorario">HORA(formato 24hrs): </label>
                            <select name="horariosLab" id ="ingresoHorario">
                                <%for (int i = 0; i < 23; i++) {%>
                                <option value="<%out.print(i);%>"><%out.print(i + ":00");%></option>
                                <%}%>
                            </select>
                        </div>
                    </div>
                    <table id="horariosOcupados" style="display:none;">
                        <thead>
                            <tr>
                                <th>HORARIOS OCUPADOS</th>
                            </tr>
                        </thead>
                    </table>
                    <p id="mensajeHorario"></p>
                    <h4>PROXIMA CONSULTA</h4>
                    <div class="contenedor2" id="proximaConsulta">
                        <div class="item">
                            <label for="fechaProximaConsulta">Ingresa fecha proxima consulta: </label>
                            <input type="date" id="fechaProximaConsulta">
                        </div>
                        <table id="horariosOcupadosMedico" style="display:none;">
                            <thead>
                                <tr>
                                    <th>HORARIOS OCUPADOS</th>
                                </tr>
                            </thead>
                        </table>
                        <div class="item">
                            <label for="ingresoHorarioMedico">Ingresa la hora(formato 24hrs): </label>
                            <select name="horas" id="ingresoHorarioMedico">
                                <%  if (horario[2].equalsIgnoreCase("INT")) {
                                        int inicio = Integer.parseInt(horario[0]);
                                        int fin = Integer.parseInt(horario[1]);
                                        while (inicio < fin) {%>
                                <option value="<%out.print(inicio + 1);%>" disabled><%out.print((inicio + 1) + ":00");%></option>
                                <%
                                        inicio++;
                                    }
                                } else {
                                    Double inicio = Double.parseDouble(horario[0]);
                                    Double fin = Double.parseDouble(horario[1]);
                                    while (inicio < fin) {
                                        String inicioHora = inicio + "";
                                        String inicioHoraCorrecta = inicioHora.replace('.', ':');
                                %>
                                <option value="<%out.print(inicio + 1.00);%>" disabled><%out.print(inicioHoraCorrecta);%></option>
                                <%
                                            inicio += 1.00;
                                        }
                                    }%>
                                <option>prueba</option>
                            </select>
                        </div>
                    </div>
                    <button id="guardarCambiosExamen">INGRESAR EXAMEN</button>
            </center>
        </div>
    </center>
    <%}%>
</div>
</body>
</html>
