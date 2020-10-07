<%-- 
    Document   : index
    Created on : 11/09/2020, 03:30:35 PM
    Author     : yelbetto
--%>

<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hospital</title>
    </head>
    <body>
        <%HttpSession s = request.getSession();%>
        <%Conector cn = new Conector("encender");%>
        <%  if (cn.existeUsuario()) {
                if (s.getAttribute("usuario") == null) {%>
        <%@include file='JSP/Login.jsp' %>
        <%} else {%>
        <% response.sendRedirect("JSP/Perfil.jsp");
         %>
        <%}
        } else {%>
        <%@include file='JSP/Carga.jsp' %>
        <%}%>
    </body>
</html>
