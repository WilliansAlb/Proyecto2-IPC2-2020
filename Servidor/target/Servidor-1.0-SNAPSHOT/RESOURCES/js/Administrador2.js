/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formularioAdministrador").bind("submit", function () {
        var btnEnviar = $("#ingresar");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var dpi = $("#dpi").val();
        var password = $("#password").val();
        var nuevo = document.getElementById("codigo").disabled;
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "INGRESO ADMIN", codigo: codigo, nombre: nombre, password:password, nuevo: nuevo,dpi:dpi},
            beforeSend: function () {
                /*
                 * Esta función se ejecuta durante el envió de la petición al
                 * servidor.
                 * */
                btnEnviar.text("INGRESANDO"); //Para button 
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
                if (data === 'EXISTE') {
                    alert("Ya existe un registro con ese mismo codigo, ingresa uno nuevo");
                    $("#codigo").focus();
                } else if (data === 'ERRORBASE') {
                    alert("No fue posible concretar la acción, intenta de nuevo");
                } else {
                    alert(data);
                    window.location = "Administradores.jsp";
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

function editarActualAdmin(boton) {
    var td = boton.parentNode;
    var tr = td.parentNode;
    var columnas = tr.querySelectorAll("td");
    $("#codigo").val(columnas[0].textContent);
    document.getElementById("codigo").disabled = true;
    $("#nombre").val(columnas[1].textContent);
    $("#dpi").val(columnas[2].textContent);
    $("#contra").hide();
    $("#password").removeAttr("required");
    $("#contenedor1").css("grid-template-columns","auto");
    mostrarOculto(boton, $("#nuevoMedico"), $("#contenidoMedico"));
}
function mostrarOculto(boton, oculto, mensaje) {
    var mensajew = mensaje.width();
    var mensajeh = mensaje.height();

    var height = $(window).height();
    var width = $(window).width();

    var posx = (width / 2) - (mensajew / 2);
    var posy = (height / 2) - (mensajeh / 2);

    if (posy > 0) {
        mensaje.offset({top: 0});
    } else {
        mensaje.offset({top: 0});
    }

    oculto.width('100%');
    oculto.height('100%');
    oculto.fadeIn(1000);
}
function recargar(elemento) {
    window.location = "Administradores.jsp";
}
function mostrarNuevoAdmin(boton) {
    document.getElementById("codigo").disabled = false;
    $("#contenedor1").css("grid-template-columns","auto");
    mostrarOculto(boton, $("#nuevoMedico"), $("#contenidoMedico"));
}