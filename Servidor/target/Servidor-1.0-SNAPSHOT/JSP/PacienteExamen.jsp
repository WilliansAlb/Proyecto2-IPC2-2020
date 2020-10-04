<%-- 
    Document   : PacienteExamen
    Created on : 3/10/2020, 06:10:55 PM
    Author     : yelbetto
--%>

<%@page import="POJO.TrabajoDTO"%>
<%@page import="POJO.LaboratoristaDTO"%>
<%@page import="POJO.ExamenDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.ExamenDAO"%>
<%@page import="Base.LaboratoristaDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Agendar examen</title>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <link rel="stylesheet" href="../RESOURCES/css/Cita.css">
        <link rel="stylesheet" href="../RESOURCES/css/PacienteExamen.css">
        <script type="text/javascript" src="../RESOURCES/js/PacienteExamen.js"></script>
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
    </head>
    <body>
        <%@include file='Sidebar.jsp' %>

        <%
            Conector cn = new Conector("encender");
            LaboratoristaDAO pa = new LaboratoristaDAO(cn);
            ExamenDAO examen = new ExamenDAO(cn);
            ArrayList<ExamenDTO> examenes = examen.obtenerExamenes();
            ArrayList<LaboratoristaDTO> laboratoristas = pa.obtenerTodosLaboratoristas();
            String[] dias = {"Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"};
        %>

    <center>
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
            <button id="atrasLab" onclick="siguienteOrden(document.getElementById('laboratoristasP'),document.getElementById('ordenP'))">&larr;ATRAS</button>
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
</body>
</html>
