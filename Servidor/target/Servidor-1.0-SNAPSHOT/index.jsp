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
        <link rel="stylesheet" href='RESOURCES/css/general.css' type="text/css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="RESOURCES/js/login.js"></script>
    </head>
    <body>
        <%HttpSession s = request.getSession();%>
        <%if (s.getAttribute("usuario") == null){%>
        <%@include file='JSP/login.jsp' %>
        <%}else{%>
        <h1>Existe usuario</h1>
        <%}%>
    </body>
</html>
