<%-- 
    Document   : Informe
    Created on : 4/10/2020, 11:25:07 PM
    Author     : yelbetto
--%>

<%@page import="POJO.EspecialidadDTO"%>
<%@page import="POJO.DoctorDTO"%>
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
        <link rel="stylesheet" href="../RESOURCES/css/Cita.css">
        <link rel="stylesheet" href="../RESOURCES/css/PacienteExamen.css">
        <link rel="stylesheet" href="../RESOURCES/css/Informe.css">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <script type="text/javascript" src="../RESOURCES/js/Informe.js"></script>
    </head>
    <body>
        <%SimpleDateFormat objSDF = new SimpleDateFormat("yyyy-MM-dd");
            Conector cn = new Conector("encender");
            CitaDAO cita = new CitaDAO(cn);
            ExamenDAO examen = new ExamenDAO(cn);
            DoctorDAO doctor = new DoctorDAO(cn);
            DoctorDTO datosDoctor = doctor.obtenerMedico("MED-123");
            LaboratoristaDAO pa = new LaboratoristaDAO(cn);
            ArrayList<ExamenDTO> examenes = examen.obtenerExamenes();
            ArrayList<LaboratoristaDTO> laboratoristas = pa.obtenerTodosLaboratoristas();
            ArrayList<CitaDTO> citas = cita.obtenerCitas("MED-123", "2020-09-12");
            String[] dias = {"Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"};
        %>
        <%@include file="Sidebar.jsp"%>
    <center>
        <div id="ingresoInforme">
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
                                <th>FECHA</th>
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
                                <td><%out.println(citas.get(i).getFecha());%></td>
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
    </center>
    <center>
        <div id="agregarInforme" style="display:none;" class="center">
            <center>
                <h3>REPORTE</h3>
                <div class="contenedor2">
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
                        <input type="date" id="fechaInforme1" value="<%=objSDF.format(new java.util.Date())%>" disabled>
                    </div>
                    <div class="item">
                        <label for="consultaTipo">CONSULTA: </label>
                        <input type="text" id="consultaTipo" value="" disabled>
                    </div>
                    <div class="item">
                        <label for="horaInforme">HORA: </label>
                        <input type="text" id="horaInforme" value="" disabled>
                    </div>
                </div>
                <br>
                <label for="informe">INFORME: </label>
                <br>
                <textarea id="informe" cols="100" rows="10" required></textarea>
                <br>
                <button id="ingresarReporte" onclick="ingresarYExamen(this, 0)">INGRESAR REPORTE</button>
                <button id="generarReporte" onclick="ingresarYExamen(this, 1)">INGRESAR REPORTE Y GENERAR EXAMEN</button>
            </center>
        </div>

        <div id="examenes" class="ventana" style="display:none;">
            <p>El codigo del reporte ingresado es <span id="spanCodigo1" style="color:green;font-size: 2em;"></span></p>
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
            <h1>DATOS PARA PROXIMA CONSULTA</h1>
            <p id="verificarCita">Verifica los datos luego presiona el boton ingresar</p>
            <h3 id="mensajeCita">EXAMEN</h3>
            <table id="tablaConfirmar">
                <thead>
                    <tr>
                        <th>Examen</th>
                        <th>Laboratorista</th>
                        <th>Fecha</th>
                        <th>Costo</th>
                        <th>Orden</th>
                        <th>Hora</th>
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
            <h3 id="mensajeCita2">CITA</h3>
            <table id="tablaConfirmar2">
                <thead>
                    <tr>
                        <th>Paciente</th>
                        <th>Consulta</th>
                        <th>Fecha</th>
                        <th>Costo</th>
                        <th>Hora</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td id="pacienteTabla">Paciente</td>
                        <td id="consultaTabla">Consulta</td>
                        <td id="fechaTabla2">Fecha</td>
                        <td id="costoTabla2">Hora</td>
                        <td id="horaTabla2">Hora</td>
                    </tr>
                </tbody>
            </table>
            <div id="mensajesDeConfirmacion" class="contenedor2" style="display:none">
                <div class="item">
                    <p id="mensajeConfirmacion">El codigo de tu examen es<span id="spanCodigo"></span></p>
                </div>
                <div class="item">
                    <p id="mensajeConfirmacion2">El codigo de tu cita es<span id="codigosito"></span></p></span></p>
                </div>
            </div>
            <button id="regreso3" onclick="siguiente(document.getElementById('confirmar'), document.getElementById('horario'))">&larr;ATRAS</button>
            <button id="ingresarCita" onclick="ingresarExamen()">INGRESAR</button>
            <br>
            <a href="Informe.jsp" style="display: none;" id="otraConsulta">VER SIGUIENTES CITAS</a>
        </div>

        <div id="horario" style="display:none;" class="ventana">
            <h3>ELIGE UNA FECHA Y HORA PARA LA PROXIMA CONSULTA</h3>
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
                    <%
                        String[] horas = datosDoctor.getHorario();
                        int inicio = Integer.parseInt(horas[0]);
                        int final1 = Integer.parseInt(horas[1]);
                    %>
                    <% while (inicio < final1) {%>
                    <tr id="filaHorario<%out.print(inicio);%>">
                        <td><%out.print(inicio);%></td>
                        <td><input type='checkbox' class='marcarHorarios' onclick='marcarHorario(this)' value='<%out.print(inicio);%>'></td>
                    </tr>
                    <%
                            inicio++;
                        }%>
                </tbody>
            </table>
            <button onclick="siguiente(document.getElementById('horario'), document.getElementById('disponibilidadExa'))">&larr;ATRAS</button>
            <button id="siguiente3" onclick="rellenarDatosCita(document.getElementById('horario'), document.getElementById('confirmar'))" disabled>SIGUIENTE&rarr;</button>
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
</body>
</html>

