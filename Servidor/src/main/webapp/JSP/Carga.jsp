<%-- 
    Document   : Carga
    Created on : 14/09/2020, 03:34:23 PM
    Author     : yelbetto
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hospital</title>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="RESOURCES/css/Carga.css" type="text/css">
        <link rel="stylesheet" href="RESOURCES/css/Boton.css" type="text/css">
        <link rel="shortcut icon" type="image/x-icon" href="RESOURCES/imagenes/saludico.ico"/>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="RESOURCES/js/Circulos.js"></script>
        <script type="text/javascript" src="RESOURCES/js/Carga.js"></script>
    </head>

    <body>
        <div id="carga">
            <center>
                <img src="RESOURCES/imagenes/salud.png" width="7%" height="auto" id="logo">
                <label for="logo">Centro Medico del Sur</label>
                <hr width="50%">
                <label for="archivo" tabindex="0" class="input-file-trigger">Selecciona carpeta con datos a cargar...</label>
                <p id="ruta" class="file-return"></p>
                <input type="file" id="archivo" onchange="verificar()" webkitdirectory directory multiple>
                <button id="ver" onclick="loadDoc()"
                        value=""
                        disabled="true" style="display: none;">VER</button>
                <div class="buttons" style="display: none;" id="btn1">
                    <div class="container">
                        <a onclick="loadDoc()" class="effect01" target="_blank"><span>VER</span></a>
                    </div>
                </div>
            </center>

        </div>
        <div id="visualizar" style="display: none;">
            <div id='controladores'>
                <center>
                    <button class='btn-controlador' id="btn-con-iz" onclick="moverIzquierda()">
                        <img src="RESOURCES/imagenes/arrow.png" width="10%" height="auto"></button>
                    <h1 id="h-controlador">ADMINISTRADORES A INGRESAR</h1>
                    <button class="btn-controlador" id="btn-con-de" onclick="moverDerecha()"><img src="RESOURCES/imagenes/arrowi.png" width="10%" height="auto"></button>
                </center>
            </div>
            <div id="tablas">
                <center>
                    <table id="admins" cellpadding="10px" style="text-align: center;">
                        <thead>
                        <th>CODIGO</th>
                        <th>DPI</th>
                        <th>NOMBRE</th>
                        <th>PASSWORD</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table id="doctores" cellpadding="1px" style="text-align: center;display: none;">
                        <thead>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>COLEGIADO</th>
                        <th>DPI</th>
                        <th>TELEFONO</th>
                        <th>ESPECIALIDADES</th>
                        <th>CORREO</th>
                        <th>HORARIO</th>
                        <th>INICIO TRABAJO</th>
                        <th>PASSWORD</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table id="laboratoristas" cellpadding="10px" style="text-align: center;display: none;">
                        <thead>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>REGISTRO</th>
                        <th>DPI</th>
                        <th>TELEFONO</th>
                        <th>EXAMEN</th>
                        <th>CORREO</th>
                        <th>DIAS TRABAJO</th>
                        <th>INICIO TRABAJO</th>
                        <th>PASSWORD</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table id="pacientes" cellpadding="10px" style="text-align: center;display: none;">
                        <thead>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>SEXO</th>
                        <th>NACIMIENTO</th>
                        <th>DPI</th>
                        <th>TELEFONO</th>
                        <th>PESO</th>
                        <th>SANGRE</th>
                        <th>CORREO</th>
                        <th>PASSWORD</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table id="examenes" cellpadding="10px" style="text-align: center;display: none;">
                        <thead>
                        <th>CODIGO</th>
                        <th>NOMBRE</th>
                        <th>ORDEN</th>
                        <th>DESCRIPCION</th>
                        <th>COSTO</th>
                        <th>INFORME</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table id="reportes" cellpadding="10px" style="text-align: center;display: none;">
                        <thead>
                        <th>CODIGO</th>
                        <th>PACIENTE</th>
                        <th>MEDICO</th>
                        <th>INFORME</th>
                        <th>FECHA</th>
                        <th>HORA</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table id="resultados" cellpadding="10px" style="text-align: center;display: none;">
                        <thead>
                        <th>CODIGO</th>
                        <th>PACIENTE</th>
                        <th>EXAMEN</th>
                        <th>LABORATORISTA</th>
                        <th>ORDEN</th>
                        <th>INFORME</th>
                        <th>FECHA</th>
                        <th>HORA</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table id="citas" cellpadding="10px" style="text-align: center;display: none;">
                        <thead>
                        <th>CODIGO</th>
                        <th>PACIENTE</th>
                        <th>TIPO CONSULTA</th>
                        <th>MEDICO</th>
                        <th>FECHA</th>
                        <th>HORA</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <table id="consultas" cellpadding="10px" style="text-align: center;display: none;">
                        <thead>
                        <th>TIPO</th>
                        <th>COSTO</th>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </center>
            </div>
            <hr width="30%">
            <div class="buttons" id="btn2">
                <div class="container">
                    <a onclick="ingresarTodo(this)" class="effect01" target="_blank"><span>INGRESAR TODO</span></a>
                </div>
            </div>
            <center>
                <div id="botonsote">
                    <center>
                        <div id="cargando" style="display: none;">
                            <div class="progress" id="pro"></div>
                            <label for="pro" id="actualSubiendo">Hola</label>
                        </div> 
                    </center>
                    <button id="ingresar-todo" onclick="ingresarTodo(this)" style="display: none;" >INGRESAR TODO</button>
                </div>
            </center>
        </div>
        <div id="descripcion" style="display: none;">
            <div id="mensaje">
                <center>
                    <h1 style="margin-bottom: 5px;">DESCRIPCION</h1>
                    <h4 style="margin:0;" id="nombrecodigo">EJEMPLO EXAMEN</h4>
                    <textarea name="des" id="des" cols="40" rows="20" readonly="readonly"></textarea>
                    <hr width="50%">
                    <button id="ocultar" onclick="ocultar(document.getElementById('descripcion'))" style="display:none;">OCULTAR</button>
                    <div class="buttons" id="btn3">
                        <div class="container">
                            <a onclick="ocultar(document.getElementById('descripcion'))" class="effect01" target="_blank"><span>OCULTAR</span></a>
                        </div>
                    </div>
                </center>
            </div>
        </div>
        <div id ="contenedorArchivos"  style="display: none;">
            <div id="archivos">
                <center>
                    <h1 id="nombreArchivo">ORDEN</h1>
                    <embed src="" width="500" height="460" id="visualizacionArchivo">
                    <div class="buttons" id="btn4">
                        <div class="container">
                            <a onclick="ocultar(document.getElementById('contenedorArchivos'))" class="effect01" target="_blank"><span>OCULTAR</span></a>
                        </div>
                    </div>
                </center>
            </div>
        </div>
    </body>
</html>