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
        <link rel="shortcut icon" type="image/x-icon" href="RESOURCES/imagenes/saludico.ico"/>

        <link rel="stylesheet" href='RESOURCES/css/general.css' type="text/css">
        <link rel="stylesheet" href="RESOURCES/css/Boton.css" type="text/css">
        <link rel="stylesheet" href="RESOURCES/css/PopUp.css" type="text/css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="RESOURCES/js/login.js"></script>
    </head>
    <body>
        <div id='login'>
            <center>
                <div>
                    <img name="hospital-img" src='RESOURCES/imagenes/salud.png' alt="imagen de un hospital" width="10%" height="10%" id="logo">
                    <label for="hospital-img" id="nombre-hospital">Centro Medico del Sur</label>
                    <h4>Bienvenido</h4>
                </div>
                <div id="adentro">
                    
                    <div class="group">
                        <span class="popuptext" id="myPopup">Rellena este campo!</span>
                        <input type="text" required id="usuario">
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="usuario2">Usuario</label>
                    </div>
                    <div class="group"> 
                        <span class="popuptext" id="myPopup1">Rellena este campo!</span>
                        <input type="password" required id="password">
                        <span class="highlight"></span>
                        <span class="bar"></span>
                        <label for="password">Contraseña</label>
                    </div>
                </div>
                <div>
                    <hr width="25%">
                    <div class="buttons">
                    <div class="container">
                        <a class="effect01" target="_blank" onclick="metodo($(usuario).val(), $('#password').val())"><span>INGRESAR</span></a>
                    </div>
                  </div>
                </div>
            </center>
        </div>
    </body>
</html>
