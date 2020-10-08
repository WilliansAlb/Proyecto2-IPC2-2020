<%-- 
    Document   : ReporteAdmin
    Created on : 7/10/2020, 09:27:10 PM
    Author     : yelbetto
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="Base.Reporte"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes</title>
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="stylesheet" href="../RESOURCES/css/Tabla.css">
        <script type="text/javascript" src="../RESOURCES/js/Pendientes.js"></script>
        <link rel="stylesheet" href="../RESOURCES/css/Lab.css">
        <link rel="stylesheet" href="../RESOURCES/css/Reportes.css">
        <script src="../RESOURCES/js/Reporte.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            Conector cn = new Conector("encender");
            Reporte reportes = new Reporte(cn);
            HttpSession sReporte = request.getSession();
            ArrayList<String[]> datos = new ArrayList<>();
            String filtroTipo = "";
            String fechaImprimir1 = "";
            String fechaImprimir2 = "";
            String[] columnas = {"VALOR POR DEFECTO", "VALOR POR DEFECTO"};
            if (sReporte.getAttribute("usuario") != null && sReporte.getAttribute("tipo") != null) {
                if (sReporte.getAttribute("tipo").toString().equalsIgnoreCase("ADMIN")) {
                    if (sReporte.getAttribute("tipoFiltroAdmin") != null) {
                        filtroTipo = sReporte.getAttribute("tipoFiltroAdmin").toString();
                        if (filtroTipo.equalsIgnoreCase("1") || filtroTipo.equalsIgnoreCase("3") || filtroTipo.equalsIgnoreCase("4")
                                || filtroTipo.equalsIgnoreCase("5")) {
                            String fecha1 = sReporte.getAttribute("filtroAdminFecha1").toString();
                            String fecha2 = sReporte.getAttribute("filtroAdminFecha2").toString();
                            fechaImprimir1 = fecha1;
                            fechaImprimir2 = fecha2;
                            if (filtroTipo.equalsIgnoreCase("1")) {
                                columnas = new String[]{"NO. INFORMES", "CODIGO MEDICO", "NOMBRE MEDICO"};
                                datos = reportes.obtener10MedicosMasInformes(fecha1, fecha2);
                            } else if (filtroTipo.equalsIgnoreCase("3")) {
                                columnas = new String[]{"CANTIDAD DE CITAS", "CODIGO MEDICO", "NOMBRE MEDICO"};
                                datos = reportes.obtener5MedicosConMenorCantidadCitas(fecha1, fecha2);
                            } else if (filtroTipo.equalsIgnoreCase("4")) {
                                columnas = new String[]{"DEMANDA", "CODIGO EXAMEN", "NOMBRE EXAMEN"};
                                datos = reportes.obtenerExamenesLaboratorioMasDemandados(fecha1, fecha2);
                            } else {
                                columnas = new String[]{"NO. DE EXAMENES REQUERIDOS", "CODIGO MEDICO", "NOMBRE MEDICO", "EXAMENES MAS REQUERIDOS"};
                                datos = reportes.obtenerResultadosRequeridosPorMedico(fecha1, fecha2);  
                            }
                            sReporte.removeAttribute("filtroAdminFecha1");
                            sReporte.removeAttribute("filtroAdminFecha2");
                        } else {
                            String medico = sReporte.getAttribute("filtroAdminSujeto").toString();
                            String fecha1 = sReporte.getAttribute("filtroAdminFecha1").toString();
                            String fecha2 = sReporte.getAttribute("filtroAdminFecha2").toString();
                            fechaImprimir1 = fecha1;
                            fechaImprimir2 = fecha2;
                            if (filtroTipo.equalsIgnoreCase("2")) {
                                columnas = new String[]{"INGRESO TOTAL", "CODIGO MEDICO", "NOMBRE MEDICO"};
                                datos = reportes.obtenerIngresosObtenidosPorMedico(medico, fecha1, fecha2);
                            } else {
                                columnas = new String[]{"INGRESO TOTAL", "CODIGO PACIENTE", "NOMBRE PACIENTE"};
                                datos = reportes.obtenerIngresoPorPaciente(medico, fecha1, fecha2);
                            }
                            sReporte.removeAttribute("filtroAdminSujeto");
                            sReporte.removeAttribute("filtroAdminFecha1");
                            sReporte.removeAttribute("filtroAdminFecha2");
                        }
                        sReporte.removeAttribute("tipoFiltroAdmin");
                    }
                } else {
                    response.sendRedirect("Perfil.jsp");
                }
            } else {
                response.sendRedirect("/Servidor/index.jsp");
            }

        %>
        <%if (sReporte.getAttribute("usuario") != null && sReporte.getAttribute("tipo") != null){%>
        <%@include file="Sidebar.jsp"%>
        <%}%>
    <center>
        <div id="filtroReporte">
            <h2>Reportes administrador</h2>
            <%if (!filtroTipo.isEmpty()) {%>
            <%if (filtroTipo.equalsIgnoreCase("1")) {%>
            <h4>Mostrando reporte 10 médicos que más informes han realizado entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%} else if (filtroTipo.equalsIgnoreCase("2")) {%>
            <h4>Mostrando reporte ingresos obtenidos por médico entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%} else if (filtroTipo.equalsIgnoreCase("3")) {%>
            <h4>Mostrando reporte de 5 médicos con menor cantidad de citas entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%} else if (filtroTipo.equalsIgnoreCase("4")) {%>
            <h4>Mostrando reporte de los examenes de laboratorio más demandados entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%}else if (filtroTipo.equalsIgnoreCase("5")) {%>
            <h4>Mostrando reporte de los médicos con mayor cantidad de exámenes de laboratorio requeridos, incluyendo los 3 examenes que más ha requerido entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%}else if (filtroTipo.equalsIgnoreCase("6")) {%>
            <h4>Mostrando reporte de ingresos obtenidos por paciente entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%}%>
            <%} else {%>
            <h4>Elige un tipo de reporte</h4>
            <%}%>
            <label for="tipoReporte">Tipo de reporte: </label>
            <select id="tipoReporte" name="tipoReporte" onclick="mostrarFechasAdmin(this)">
                <option value="7">SIN SELECCIONAR</option>
                <option value="1">Los 10 médicos que más informes han realizado dentro de un intervalo de tiempo.</option>
                <option value="2">Ingresos obtenidos por médico en un intervalo de tiempo.</option>
                <option value="3">Los 5 médicos con menor cantidad de citas dentro de un intervalo de tiempo.</option>
                <option value="4">Los exámenes de laboratorio más demandados en un intervalo de tiempo.</option>
                <option value="5">Los médicos con mayor cantidad de exámenes de laboratorio requeridos, incluyendo los 3 exámenes que más ha requerido en un intervalo de tiempo.</option>
                <option value="6">Ingresos generados por paciente en un intervalo de tiempo</option>
            </select>
            <div id="fechas" style="display:none;">
                <form id="formReporteAdmin" method="GET" action="../Reportes">
                    <div id="selectAdmin">
                        <label for="doctorEscrito" id="cambiante">Doctor: </label>
                        <input type="text" id="doctorEscrito" onkeydown="existeMedico(this)" required>
                        <span id="pop" class="popuptext">No existe!</span>
                        <p id="mensajeExistencia" style="display:inline;"></p>
                    </div>
                    <br>
                    <label for="fecha1">Desde: </label>
                    <input type="date" name="fecha1" id="fecha1" required>
                    <label for="fecha2">Hasta: </label>
                    <input type="date" name="fecha2" id="fecha2" required>
                    <button id="ingresar">Buscar según filtro</button>
                </form>
            </div>
        </div>
    </center>
    <center>
        <div id="datosReporte">
            <h4>SE MUESTRAN LOS RESULTADOS DEL REPORTE</h4>
            <table>
                <thead>
                    <tr>
                        <%for (int i = 0; i < columnas.length; i++) {%>
                        <th><%out.print(columnas[i]);%></th>
                            <%}%>
                    </tr>
                </thead>
                <tbody>
                    <%for (int i = 0; i < datos.size(); i++) {%>
                    <tr>
                        <%
                            String[] temporal = datos.get(i);
                            for (int o = 0; o < temporal.length; o++) {
                        %>
                        <td><%out.print(temporal[o]);%></td>
                        <%}%>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
    </center>
</body>
</html>
