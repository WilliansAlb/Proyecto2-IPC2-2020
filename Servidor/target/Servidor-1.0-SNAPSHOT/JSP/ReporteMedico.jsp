<%-- 
    Document   : ReporteMedico
    Created on : 8/10/2020, 07:22:31 AM
    Author     : yelbetto
--%>

<%@page import="java.text.SimpleDateFormat"%>
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
            SimpleDateFormat objSDF = new SimpleDateFormat("yyyy-MM-dd");
            String hoy = objSDF.format(new java.util.Date());
            String[] columnas = {"VALOR POR DEFECTO", "VALOR POR DEFECTO"};
            if (sReporte.getAttribute("usuario") != null && sReporte.getAttribute("tipo") != null) {
                if (sReporte.getAttribute("tipo").toString().equalsIgnoreCase("DOCTOR")) {
                    if (sReporte.getAttribute("tipoFiltroMedico") != null) {
                        filtroTipo = sReporte.getAttribute("tipoFiltroMedico").toString();
                        String doctor = sReporte.getAttribute("usuario").toString();
                        if (filtroTipo.equalsIgnoreCase("1") || filtroTipo.equalsIgnoreCase("3")) {
                            String fecha1 = sReporte.getAttribute("filtroMedicoFecha1").toString();
                            String fecha2 = sReporte.getAttribute("filtroMedicoFecha2").toString();
                            fechaImprimir1 = fecha1;
                            fechaImprimir2 = fecha2;
                            if (filtroTipo.equalsIgnoreCase("1")) {
                                columnas = new String[]{"CODIGO CITA", "EXAMEN", "NOMBRE MEDICO", "FECHA", "HORA"};
                                datos = reportes.obtenerCitasAgendadasIntervaloTiempo(doctor, fecha1, fecha2);
                            } else if (filtroTipo.equalsIgnoreCase("3")) {
                                columnas = new String[]{"CANTIDAD DE INFORMES", "CODIGO PACIENTE", "NOMBRE PACIENTE"};
                                datos = reportes.obtenerMayorCantidadDeInformes(fecha1, fecha2);
                            }
                            sReporte.removeAttribute("filtroMedicoFecha1");
                            sReporte.removeAttribute("filtroMedicoFecha2");
                        } else {
                            columnas = new String[]{"CODIGO CITA", "EXAMEN", "NOMBRE MEDICO", "FECHA", "HORA"};
                            datos = reportes.obtenerCitasAgendadasHoy(doctor, hoy);
                        }
                        sReporte.removeAttribute("tipoFiltroMedico");
                    } else {
                        filtroTipo = "NUEVECITO";
                    }
                } else {
                    response.sendRedirect("Perfil.jsp");
                }
            } else {
                response.sendRedirect("/Servidor/index.jsp");
            }
        %>
        <%if (sReporte.getAttribute("usuario") != null && sReporte.getAttribute("tipo") != null) {%>
        <%@include file="Sidebar.jsp"%>
        <%}%>
    <center>
        <div id="filtroReporte">
            <h2>Reportes medico</h2>
            <label for="tipoReporte">Tipo de reporte: </label>
            <select id="tipoReporte" name="tipoReporte" onclick="mostrarFechasMedico(this)">
                <option value="4">SIN SELECCIONAR</option>
                <option value="1">Reporte de citas agendadas en un intervalo de tiempo.</option>
                <option value="2">Reporte de citas para el día en curso.</option>
                <option value="3">Los pacientes con mayor cantidad de informes médicos dentro de un intervalo de tiempo</option>
            </select>
            <div id="fechas" style="display:none;">
                <form id="formReporteMedico" method="GET" action="../Reportes">
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
        <%if (datos.size() > 0) {%>
        <div id="datosReporte">
            <%if (!filtroTipo.isEmpty()) {%>
            <%if (filtroTipo.equalsIgnoreCase("1")) {%>
            <h4>Mostrando el reporte de citas agendadas entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%} else if (filtroTipo.equalsIgnoreCase("2")) {%>
            <h4>Mostrando el reporte de citas para el día de hoy <%out.print(hoy);%></h4>
            <%} else if (filtroTipo.equalsIgnoreCase("3")) {%>
            <h4>Mostrando el reporte de los pacientes con mayor cantidad de informes médicos entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%}%>
            <%} else {%>
            <h4>Reportes medico</h4>
            <%}%>
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
        <%}

            
                else {%>
        <%if (!filtroTipo.equalsIgnoreCase("NUEVECITO")) {%>
        <%if (filtroTipo.equalsIgnoreCase("1")) {%>
        <h4>No hay resultados para el reporte de citas agendadas entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
        <%} else if (filtroTipo.equalsIgnoreCase("2")) {%>
        <h4>No hay resultados para el Reporte de citas para el día de hoy <%out.print(hoy);%></h4>
        <%} else if (filtroTipo.equalsIgnoreCase("3")) {%>
        <h4>No hay resultados para el reporte de los pacientes con mayor cantidad de informes médicos entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
        <%}%>
        <%}%>
        <%}%>
    </center> 
</body>
</html>
