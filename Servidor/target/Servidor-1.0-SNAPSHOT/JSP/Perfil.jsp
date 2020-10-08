<%-- 
    Document   : PerfilMedico
    Created on : 30/09/2020, 08:45:49 PM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil</title><link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script src="../RESOURCES/js/Perfil.js" type="text/javascript"></script>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="../RESOURCES/css/Sidebar.css">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <link rel="stylesheet" href="../RESOURCES/css/Perfil.css">
    </head>
    <body>
        <%if (request.getSession().getAttribute("usuario") != null && request.getSession().getAttribute("tipo") != null){%>
        <%@include file="Sidebar.jsp"%>
        <%}%>
        <%
            HttpSession s = request.getSession();
            if (s.getAttribute("usuario") != null && s.getAttribute("tipo") != null) {
                String tipo = s.getAttribute("tipo").toString();
                s.setAttribute("entrada", "correcta");
                if (tipo.equalsIgnoreCase("LABORATORISTA")) {
        %>
        <%@include file='PerfilLaboratorista.jsp'%>
        <%} else if (tipo.equalsIgnoreCase("PACIENTE")) {%>
        <%@include file='PerfilPaciente.jsp'%>
        <%} else if (tipo.equalsIgnoreCase("DOCTOR")) {%>
        <%@include file='PerfilMedico.jsp'%>
        <%} else if (tipo.equalsIgnoreCase("ADMIN")) {%>
        <%@include file='PerfilAdmin.jsp'%>
        <%}
            } else {
                response.sendRedirect("/Servidor/index.jsp");
            }%>
    </body>
</html>
