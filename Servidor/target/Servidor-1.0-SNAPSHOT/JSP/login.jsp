<%-- 
    Document   : login
    Created on : 11/09/2020, 04:21:24 PM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="shortcut icon" type="image/x-icon" href="RESOURCES/imagenes/hospital.ico"/>
    </head>
    <body>
        <div id='login'>
            <center>
                <div>
                    <img name="hospital-img" src='RESOURCES/imagenes/hospital.png' alt="imagen de un hospital" width="10%" height="10%">
                    <label for="hospital-img" id="nombre-hospital">Hospital Fulanos</label>
                </div>
                <div>
                    <h1>Usuario</h1>
                    <input type="text" id="usuario" onkeydown="comprobar()">
                    <h1>Contraseña</h1>
                    <input type="password" id="contraseña" onkeydown="comprobar()">
                </div>
                <div>
                    <input type="checkbox" name="recordar" id="recordar" value="recordar">
                    <label for="recordar">Mantener la sesión</label>
                    <hr width="50%">
                    <button onclick="metodo($(usuario).val(), $(contraseña).val())" id="ingresar">Ingresar</button>
                </div>
            </center>
        </div>
    </body>
</html>
