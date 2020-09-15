<%-- 
    Document   : Carga
    Created on : 14/09/2020, 03:34:23 PM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital</title>
    <link rel="stylesheet" href="RESOURCES/css/Carga.css" type="text/css">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="RESOURCES/js/Circulos.js"></script>
    <script type="text/javascript" src="RESOURCES/js/Carga.js"></script>
</head>

<body>
    <div id="carga">
        <center>
            <img src="RESOURCES/imagenes/hospital.png" width="10%" height="10%">
            <hr width="50%">
            <label for="archivo">Selecciona un archivo con los datos que quieras cargar</label>
            <input type="file" id="archivo" accept=".xml" onchange="verificar()">
            <br>
            <button id="ver" onclick="loadDoc()" disabled="true">VER</button>
        </center>

    </div>
    <div id="visualizar" style="display: none;">
        <div id='controladores'>
            <center>
                <button class='btn-controlador' id="btn-con-iz" onclick="moverIzquierda()">
                    <</button><h1 id="h-controlador">ADMINISTRADORES A INGRESAR</h1><button class="btn-controlador"id="btn-con-de" onclick="moverDerecha()">></button>
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
                        <th>FECHA INICIO TRABAJO</th>
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
                        <th>FECHA INICIO TRABAJO</th>
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
                <table id="consultas" cellpadding="10px" style="text-align: center;display: none;">
                    <thead>
                        <th>CODIGO</th>
                        <th>PACIENTE</th>
                        <th>MEDICO</th>
                        <th>FECHA</th>
                        <th>HORA</th>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </center>
        </div>
        <hr width="30%">
        <center><button id="ingresar-todo" onclick="ingresarTodo(this)">INGRESAR TODO</button></center>
        <div id="cargando">
            <center>
                <div class="progress" id="pro"></div>
                <h5 id="actualSubiendo">ejemplo</h5>
            </center> 
        </div> 
    </div>
    <div id="descripcion" style="display: none;">
        <div id="mensaje">
            <center>
                <h1 style="margin-bottom: 5px;">DESCRIPCION</h1>
                <h4 style="margin:0;" id="nombrecodigo">EJEMPLO EXAMEN</h4>
                <textarea name="des" id="des" cols="40" rows="30" readonly="readonly"></textarea>
                <hr width="50%">
                <button id="ocultar" onclick="ocultar(document.getElementById('descripcion'))">OCULTAR</button>  
            </center>
        </div>
    </div>
</body>

</html>