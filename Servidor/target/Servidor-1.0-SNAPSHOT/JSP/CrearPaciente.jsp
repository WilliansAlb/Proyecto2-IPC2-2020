<%-- 
    Document   : CrearPaciente
    Created on : 7/10/2020, 01:08:05 AM
    Author     : yelbetto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear nueva cuenta</title>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans+Condensed:ital,wght@0,300;0,700;1,300&display=swap" rel="stylesheet">
        <link rel="shortcut icon" type="image/x-icon" href="../RESOURCES/imagenes/saludico.ico"/>
        <link rel="stylesheet" href="../RESOURCES/css/CrearPaciente.css" type="text/css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

    </head>
    <body>
        <div class="page-bg"></div>
    <center>
        <div id="primeraVentana">
            <img name="hospital-img" src='../RESOURCES/imagenes/salud.png' alt="imagen de un hospital" width="10%" height="10%" id="logo">
            <label for="hospital-img" id="nombre-hospital">Centro Medico del Sur</label>
            <h3>Ingresa los datos para tu cuenta</h3>
            <form id="formularioPaciente" method="POST" action="../Perfil">
                <div class="contenedor">
                    <center>
                        <div class="item">
                            <label for="nombre">NOMBRE: </label>
                            <input type="text" id="nombre" required>
                        </div>
                        <div class="item">
                            <label for="sexo">SEXO: </label>
                            <select name="sexo" id="sexo">
                                <option value="Mujer">MUJER</option>
                                <option value="Hombre">HOMBRE</option>
                            </select>
                        </div>
                        <div class="item">
                            <label for="peso">PESO: </label>
                            <input type="number" name="peso" id="peso" step="0.01" min="0.01" required>
                        </div>
                        <div class="item">
                            <label for="sangre">SANGRE: </label>
                            <select name="sangre" id="sangre">
                                <option value="O-">O negativo</option>
                                <option value="O+">O positivo</option>
                                <option value="A-">A negativo</option>
                                <option value="A+">A positivo</option>
                                <option value="B-">B negativo</option>
                                <option value="B+">B positivo</option>
                                <option value="AB-">AB negativo</option>
                                <option value="AB+">AB positivo</option>
                            </select>
                        </div>
                        <div class="item">
                            <label for="dpi">DPI: </label>
                            <input type="number" name="dpi" id="dpi" step="1" min="1" max="9999999999999" required>
                        </div>
                        <div class="item">
                            <label for="telefono">TELEFONO: </label>
                            <input type="number" name="telefono" id="telefono" step="1" min="1" max="99999999" required>
                        </div>
                        <div class="item">
                            <label for="fecha">FECHA NACIMIENTO: </label>
                            <input type="date" name="fecha" id="fecha" required>
                        </div>
                        <div class="item">
                            <label for="email">EMAIL: </label>
                            <input type="text"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" name="email" id="email" required>
                        </div>
                        <div class="item">
                            <label for="password">CONTRASEÑA: </label>
                            <input type="password" name="password" id="password" required>
                        </div>
                    </center>
                </div>
                <button id="guardarCambios">Crear cuenta</button>
            </form>
        </div>
    </center>
    <center>
        <div id="creadoCorrectamente" class="oculto" style="display: none;">
            <div class="mensaje2">
                <h4>Tu ID para logearte en la pagina es <span id="tuId"></span></h4>
                <button id="aceptar" onclick="verPerfil()">IR A PERFIL</button>
            </div>
        </div>
    </center>
    <script>
        window.onload = function () {
            $("#formularioPaciente").bind("submit", function () {
                var btnEnviar = $("#guardarCambios");
                var sexo = $("#sexo").val();
                var peso = $("#peso").val();
                var sangre = $("#sangre").val();
                var telefono = $("#telefono").val();
                var nombre = $("#nombre").val();
                var dpi = $("#dpi").val();
                var fecha = $("#fecha").val();
                var email = $("#email").val();
                var password = $("#password").val();
                $.ajax({
                    type: $(this).attr("method"),
                    url: $(this).attr("action"),
                    data: {tipo: "PACIENTE NUEVO", nombre: nombre, dpi: dpi, sexo: sexo, peso: peso,
                        sangre: sangre, telefono: telefono, fecha: fecha, email: email, password: password},
                    beforeSend: function () {
                        /*
                         * Esta función se ejecuta durante el envió de la petición al
                         * servidor.
                         * */
                        btnEnviar.text("GUARDANDO"); //Para button 
                        //btnEnviar.val("Enviando"); // Para input de tipo button
                        btnEnviar.attr("disabled", "disabled");
                    },
                    complete: function (data) {
                        /*
                         * Se ejecuta al termino de la petición
                         * */
                        btnEnviar.text("GUARDAR CAMBIOS");
                        btnEnviar.removeAttr("disabled");
                    },
                    success: function (data) {
                        /*
                         * Se ejecuta cuando termina la petición y esta ha sido
                         * correcta
                         * */
                        if (data === 'ERRORBASE') {
                            alert("No fue posible actualizar los datos");
                        } else {
                            alert(data);
                            $("#tuId").text(data);
                            $("#primeraVentana").hide();
                            $("#creadoCorrectamente").show();
                        }
                    },
                    error: function (data) {
                        /*
                         * Se ejecuta si la peticón ha sido erronea
                         * */
                        alert("Problemas al tratar de enviar el formulario");
                    }
                });
                // Nos permite cancelar el envio del formulario
                return false;
            });
        };
        function verPerfil() {
            window.location = "Perfil.jsp";
        }
    </script>
</body>
</html>
