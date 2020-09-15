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
        <%if (s.getAttribute("usuario") != null){%>
        <%@include file='JSP/login.jsp' %>
        <%}else{%>
        <%@include file='JSP/Carga.jsp' %>
        <%}%>
    </body>
</html>
