<%-- 
    Document   : ReporteLaboratorista
    Created on : 8/10/2020, 04:58:36 AM
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
            SimpleDateFormat objSDF = new SimpleDateFormat("yyyy-MM-dd");
            String hoy = objSDF.format(new java.util.Date());
            String filtroTipo = "";
            String labora = "";
            String fechaImprimir1 = "";
            String fechaImprimir2 = "";
            sReporte.setAttribute("usuario", "LAB-948");
            sReporte.setAttribute("tipo", "LABORATORISTA");
            String[] columnas = {"VALOR POR DEFECTO", "VALOR POR DEFECTO"};
            if (sReporte.getAttribute("usuario") != null && sReporte.getAttribute("tipo") != null) {
                if (sReporte.getAttribute("tipo").toString().equalsIgnoreCase("LABORATORISTA")) {
                    if (sReporte.getAttribute("tipoFiltroLaboratorista") != null) {
                        labora = sReporte.getAttribute("usuario").toString();
                        filtroTipo = sReporte.getAttribute("tipoFiltroLaboratorista").toString();
                        if (filtroTipo.equalsIgnoreCase("3")) {
                            String fecha1 = sReporte.getAttribute("filtroLaboratoristaFecha1").toString();
                            String fecha2 = sReporte.getAttribute("filtroLaboratoristaFecha2").toString();
                            fechaImprimir1 = fecha1;
                            fechaImprimir2 = fecha2;
                            datos = reportes.obtenerPorcentajeDeUtilizacionHoras(labora, fecha1, fecha2);
                            sReporte.removeAttribute("filtroLaboratoristaFecha1");
                            sReporte.removeAttribute("filtroLaboratoristaFecha2");
                        } else {
                            if (filtroTipo.equalsIgnoreCase("2")) {
                                columnas = new String[]{"CODIGO", "PACIENTE", "EXAMEN", "HORA", "MEDICO"};
                                datos = reportes.obtenerExamenesARealizarseEnElDia(labora, hoy, true);
                            } else if (filtroTipo.equalsIgnoreCase("1")) {
                                columnas = new String[]{"CODIGO", "PACIENTE", "EXAMEN", "HORA", "MEDICO"};
                                datos = reportes.obtenerExamenesARealizarseEnElDia(labora, hoy, false);
                            } else {
                                columnas = new String[]{"TRABAJOS REALIZADOS", "FECHA"};
                                datos = reportes.obtener10FechasConMasTrabajoRealizado(labora);
                            }
                        }
                        sReporte.removeAttribute("tipoFiltroLaboratorista");
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
            <h2>Reportes laboratorista</h2>
            <label for="tipoReporte">Tipo de reporte: </label>
            <select id="tipoReporte" name="tipoReporte" onclick="mostrarFechasLaboratorista(this)">
                <option value="5">SIN SELECCIONAR</option>
                <option value="1">Reporte de exámenes a realizarse en su turno del día</option>
                <option value="2">Reporte de reporte de exámenes realizados en el día.</option>
                <option value="3">Reporte de utilización de cada día de trabajo, dentro de un intervalo de tiempo.</option>
                <option value="4">Reporte de las 10 fechas con más trabajo realizado.</option>
            </select>
            <div id="fechas" style="display:none;">
                <form id="formReporteLaboratorista" method="GET" action="../Reportes">
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
            <h4>Reporte de exámenes a realizarse en su turno del día de hoy <%out.print(hoy);%></h4>
            <%} else if (filtroTipo.equalsIgnoreCase("2")) {%>
            <h4>Reporte de exámenes realizados en el día de hoy <%out.print(hoy);%></h4>
            <%} else if (filtroTipo.equalsIgnoreCase("3")) {%>
            <h4>Reporte de utilización de cada día de trabajo entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
            <%} else if (filtroTipo.equalsIgnoreCase("4")) {%>
            <h4>Reporte de las 10 fechas con más trabajo realizado</h4>
            <%}%>
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
        <%} else {%>
        <%if (!filtroTipo.equalsIgnoreCase("NUEVECITO")) {%>
        <%if (filtroTipo.equalsIgnoreCase("1")) {%>
        <h4>No hay resultados para el reporte de exámenes a realizarse en su turno del día de hoy <%out.print(hoy);%></h4>
        <%} else if (filtroTipo.equalsIgnoreCase("2")) {%>
        <h4>No hay resultados para el reporte de exámenes realizados en el día de hoy <%out.print(hoy);%></h4>
        <%} else if (filtroTipo.equalsIgnoreCase("3")) {%>
        <h4>No hay resultados para el reporte de utilización de cada día de trabajo entre las fechas <%out.print(fechaImprimir1);%> y <%out.print(fechaImprimir2);%></h4>
        <%} else if (filtroTipo.equalsIgnoreCase("4")) {%>
        <h4>No hay resultados para el reporte de las 10 fechas con más trabajo realizado</h4>
        <%}%>
        <%}%>
        <%}%>
    </center>
</body>
</html>
