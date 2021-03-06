<%-- 
    Document   : Medico
    Created on : 28/09/2020, 07:02:54 PM
    Author     : yelbetto
--%>

<%@page import="POJO.TrabajoDTO"%>
<%@page import="POJO.LaboratoristaDTO"%>
<%@page import="Base.LaboratoristaDAO"%>
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
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Paciente.css">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <script type="text/javascript" src="../RESOURCES/js/Informe.js"></script>
    </head>
    <body>
        <%SimpleDateFormat objSDF = new SimpleDateFormat("yyyy-MM-dd");
            Conector cn = new Conector("encender");
            CitaDAO cita = new CitaDAO(cn);
            ExamenDAO examen = new ExamenDAO(cn);
            DoctorDAO doctor = new DoctorDAO(cn);
            LaboratoristaDAO pa = new LaboratoristaDAO(cn);
            ArrayList<ExamenDTO> examenes = examen.obtenerExamenes();
            ArrayList<LaboratoristaDTO> laboratoristas = pa.obtenerTodosLaboratoristas();
            ArrayList<CitaDTO> citas = cita.obtenerCitas("MED-123", "2020-09-12");
            String[] horario = doctor.obtenerHorario("MED-123");
            String[] dias = {"Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"};
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
                </div>
                <button id="ingresarSiguiente" onclick="mostrarInforme()">INGRESAR SIGUIENTE</button>
            </center>
            <%} else {%>
            <h3>Cola de citas</h3>
            <p>No tienes citas para este dia, ingresa otra fecha</p>
            <label for="fechaHoy">Fecha </label>
            <input type="date" id="fechaHoy" value="<%=objSDF.format(new java.util.Date())%>" onchange="cambiandoFecha()">
            <button id="verCitas" onclick="mostrarHora()">VER CITAS</button>
            <%}%>
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
        <div id="examenes" class="ventana">
            <h3>AGENDAR EXAMEN</h3>
            <p>Selecciona un tipo de examen, luego presiona siguiente</p>
            <h5>EXAMENES</h5>
            <div id="tablas1">
                <table id="tablaExamenes">
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
                            <td><input type="checkbox" class="examenes" name="<%out.print(examenes.get(i).isOrden());%>" value="<%out.print(examenes.get(i).getCodigo());%>" onclick="marcado(this)"></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>    
            </div>
            <button id="siguiente" onclick="mostrarLaboratoristas(document.getElementById('examenes'), document.getElementById('ordenP'))" disabled>SIGUIENTE&rarr;</button>
        </div>
        <div id="ordenP" style="display:none;" class="ventana">
            <h3>INGRESAR ORDEN PARA EXAMEN</h3>
            <p>Para este tipo de examen es requerido una orden en formato pdf, ingresala, luego presiona siguiente</p>
            <label for="archivo" tabindex="0" class="input-file-trigger">Selecciona carpeta con datos a cargar...</label>
            <p id="ruta" class="file-return"></p>
            <br>
            <input type="file" id="archivo" onchange="verificar()" accept=".pdf">
            <embed src="" alt="Sin archivo" width="550" height="300" id="visualizacionArchivo2"/>
            <hr style="width: 50%;">
            <label for="codigoMedico1">CODIGO MEDICO QUE ORDENO EL EXAMEN: </label>
            <input type="text" id="codigoMedico1" onkeydown="existeMedico(this)"><p id="mensajeExistencia" style="display:inline-block"></p>
            <br>
            <button id="retroceso1" onclick="siguiente(document.getElementById('ordenP'), document.getElementById('examenes'))">&larr;ATRAS</button>
            <button id="siguiente4" onclick="mostrarLaboratoristasOrden(document.getElementById('ordenP'), document.getElementById('laboratoristasP'))" disabled>SIGUIENTE&rarr;</button>
        </div>
        <div id="laboratoristasP" class="ventana" style="display: none;">
            <h3>AGENDAR EXAMEN</h3>
            <p>Selecciona una fecha y se te mostraran los laboratoristas que trabajan en esa fecha</p>
            <label for="seleccionarFecha">FECHA: </label>
            <input type="date" id="seleccionarFecha">
            <button id="verDisponibles" onclick="disponibilidad()">VER DISPONIBLES</button>
            <h5>LABORATORISTAS</h5>
            <div id="tablas2">
                <table id="tablaLaboratoristas">
                    <thead>
                        <tr>
                            <th>CODIGO</th>
                            <th>NOMBRE</th>
                            <th>REGISTRO</th>
                            <th>DPI</th>
                            <th>CODIGO EXAMEN</th>
                            <th>EXAMEN</th>
                            <th>CORREO</th>
                            <th>DIAS TRABAJO</th>
                            <th>INICIO TRABAJO</th>
                            <th>AGENDAR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%for (int i = 0; i < laboratoristas.size(); i++) {%>
                        <tr style="display:none;" class="filasLab">
                            <td><%out.print(laboratoristas.get(i).getCodigo());%></td>
                            <td><%out.print(laboratoristas.get(i).getNombre());%></td>
                            <td><%out.print(laboratoristas.get(i).getNo_registro());%></td>
                            <td><%out.print(laboratoristas.get(i).getDpi());%></td>
                            <td class="codigosExamenes"><%out.print(laboratoristas.get(i).getExamen());%></td>
                            <td><%out.print(laboratoristas.get(i).getNombreExamen());%></td>
                            <td><%out.print(laboratoristas.get(i).getEmail());%></td>
                            <td class="diasExamenes"><%
                                ArrayList<TrabajoDTO> trabajos = laboratoristas.get(i).getTrabajos();
                                String diasT = "";
                                for (int o = 0; o < trabajos.size(); o++) {
                                    if (o != (trabajos.size() - 1)) {
                                        diasT += dias[trabajos.get(o).getDia() - 1] + "\n";
                                    } else {
                                        diasT += dias[trabajos.get(o).getDia() - 1];
                                    }
                                }
                                %><%out.print(diasT);%></td>
                            <td><%out.print(laboratoristas.get(i).getFecha());%></td>
                            <td><input type="checkbox" class="laboratoristas" name="<%out.print(laboratoristas.get(i).getNombreExamen());%>" value="<%out.print(laboratoristas.get(i).getCodigo());%>" onclick="marcadoLab(this)"></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
                <p id="mensajeSinDisponibles"></p>
            </div>
            <button id="atrasLab" onclick="siguienteOrden(document.getElementById('laboratoristasP'), document.getElementById('ordenP'))">&larr;ATRAS</button>
            <button id="siguiente2" onclick="mostrarDisponibilidad(document.getElementById('laboratoristasP'), document.getElementById('disponibilidadExa'))" disabled>SIGUIENTE&rarr;</button>
        </div>
        <div id="disponibilidadExa" class="ventana" style="display: none;">
            <h3>HORARIOS DISPONIBLES DEL LABORATORISTA</h3>
            <p>Se te muestran los horarios disponibles del laboratorista</p>
            <div id="tabla4">
                <table>
                    <thead>
                        <tr>
                            <td>HORA</td>
                            <td>DISPONIBILIDAD</td>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < 24; i++) {%>
                        <tr id="<%out.print("filadia" + i);%>" class="dias">
                            <td><%out.print(i);%></td>
                            <td class="capsulaHora"><input type="checkbox" class="marcadaHora" onclick="marcarUnaHora(this)" value="<%out.print(i);%>"></td>
                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
            <button id="atrasDisponibilidad" onclick="siguiente(document.getElementById('disponibilidadExa'), document.getElementById('laboratoristasP'))">&larr;ATRAS</button>
            <button id="siguienteDisponibilidad" onclick="confirmarExamen()" disabled>SIGUIENTE&rarr;</button>
        </div>
        <div id="confirmar" style="display: none;" class="ventana">
            <h3 id="mensajeCita">INGRESAR EXAMEN</h3>
            <p id="verificarCita">Verifica los datos luego presiona el boton ingresar</p>
            <table id="tablaConfirmar">
                <thead>
                    <tr>
                        <td>Examen</td>
                        <td>Laboratorista</td>
                        <td>Fecha</td>
                        <td>Costo</td>
                        <td>Orden</td>
                        <td>Hora</td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td id="examenTabla">Examen</td>
                        <td id="laboratoristaTabla">Laboratorista</td>
                        <td id="fechaTabla">Fecha</td>
                        <td id="costoTabla">Hora</td>
                        <td id="ordenTabla">Orden</td>
                        <td id="horaTabla">Hora</td>
                    </tr>
                </tbody>
            </table>
            <p id="mensajeConfirmacion" style="display:none;">El codigo de tu cita es<span id="spanCodigo"></span></p>
            <button id="regreso3" onclick="siguiente($('horario'), $('confirmar'))">&larr;ATRAS</button><button id="ingresarCita" onclick="ingresarExamen()">INGRESAR</button>
            <br>
            <a href="PacienteExamen.jsp" style="display: none;" id="otraConsulta">INGRESAR OTRA CONSULTA</a>
        </div>
    </center>
    <div id="descripcionE" class="oculto" style="display: none;">
        <center>
            <div id="mensajeE" class="mensaje2">
                <center>
                    <h1 style="margin-bottom: 5px;">DESCRIPCION</h1>
                    <h4 style="margin:0;" id="nombrecodigo">EJEMPLO EXAMEN</h4>
                    <textarea name="des" id="des" cols="55" rows="19" readonly="readonly"></textarea>
                    <hr width="50%">
                    <button id="ocultar" onclick="ocultar(document.getElementById('descripcionE'))">OCULTAR</button>
                </center>
            </div>
        </center>
    </div>
</center>
</div>
</body>
</html>
