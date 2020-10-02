/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formularioAdminExamen").bind("submit", function () {
        var btnEnviar = $("#ingresar");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var costo = $("#costo").val();
        var descripcion = $("#descripcionExamen").val();
        var informe = $("#informe").val();
        var orden = $("#orden").val();
        var nuevo = document.getElementById("codigo").disabled;
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "INGRESO EXAMEN", codigo: codigo, nombre: nombre, costo: costo, descripcion: descripcion, informe: informe, orden: orden, nuevo: nuevo},
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
                    window.location = "AdminExamenes.jsp";
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
    $("#formularioAdminConsulta").bind("submit", function () {
        var btnEnviar = $("#ingresar");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var costo = $("#costo").val();
        var nuevo = "";
        if (codigo === 'SIN'){
            nuevo = 1;
        } else {
            nuevo = 0;
        }
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "INGRESO CONSULTA", codigo: codigo, nombre: nombre, costo: costo, nuevo: nuevo},
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
                    window.location = "AdminConsultas.jsp";
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
function mostrar(boton) {
    $('#des').val(boton.value);
    var td = boton.parentNode;
    var tabla = td.parentNode;
    var codigo = tabla.getElementsByTagName("td")[0];
    var nombre = tabla.getElementsByTagName("td")[1];
    var co = codigo.textContent;
    var cono = "";
    cono = "EXAMEN " + co + " - " + nombre.textContent;
    document.getElementById('nombrecodigo').innerText = cono;
    var mensajew = $('#mensaje').width();
    var mensajeh = $('#mensaje').height();

    var height = $(window).height();
    var width = $(window).width();

    var posx = (width / 2) - (mensajew / 2);
    var posy = (height / 2) - (mensajeh / 2);

    if (posy > 0) {
        $('#mensaje').offset({top: 0,left:0});
    } else {
        $('#mensaje').offset({top: 0,left:0});
    }

    $('#descripcion').width(width);
    $('#descripcion').height(height);
    $('#descripcion').fadeIn(1000);
}
function mostrarNuevoExamen(boton) {
    $("#codigo").val("");
    $("#nombre").val("");
    $("#costo").val("");
    $("#descripcionExamen").val("");
    $("#informe").val("");
    $("#orden").val("");
    document.getElementById("codigo").disabled = false;
    mostrarOculto(boton,$("#nuevoExamen"),$("#contenidoExamen"));
}
function mostrarNuevaConsulta(boton) {
    $("#codigo").val("SIN");
    $("#nombre").val("");
    $("#costo").val("");
    $("#codigoDiv").hide();
    document.getElementById("codigo").disabled = false;
    mostrarOculto(boton,$("#nuevaConsulta"),$("#contenidoConsulta"));
}
function mostrarNuevoLab(boton) {
    $("#codigo").val("");
    $("#nombre").val("");
    $("#costo").val("");
    $("#descripcionExamen").val("");
    $("#informe").val("");
    $("#orden").val("");
    document.getElementById("codigo").disabled = false;
    mostrarOculto(boton,$("#nuevoExamen"),$("#contenidoExamen"));
}
function mostrarOculto(boton,oculto,mensaje) {
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
function ocultar(elemento){
    elemento.style.display = 'none';
}
function editarActualExamen(boton){
    var td = boton.parentNode;
    var tr = td.parentNode;
    var columnas = tr.querySelectorAll("td");
    $("#codigo").val(columnas[0].textContent);
    document.getElementById("codigo").disabled = true;
    $("#nombre").val(columnas[1].textContent);
    $("#costo").val(columnas[2].textContent);
    var botonInterior = columnas[3].querySelector("button");
    $("#descripcionExamen").val(botonInterior.value);
    $("#informe").val(columnas[4].textContent);
    var condicional = columnas[5].textContent;
    if (condicional === 'SI'){
        $("#orden").val("1");
    } else {
        $("#orden").val("0");
    }
    mostrarOculto(boton,$("#nuevoExamen"),$("#contenidoExamen"));
}
function editarActualConsulta(boton){
    var td = boton.parentNode;
    var tr = td.parentNode;
    var columnas = tr.querySelectorAll("td");
    $("#codigo").val(columnas[0].textContent);
    document.getElementById("codigo").disabled = true;
    $("#codigoDiv").show();
    $("#nombre").val(columnas[1].textContent);
    $("#costo").val(columnas[2].textContent);
    mostrarOculto(boton,$("#nuevaConsulta"),$("#contenidoConsulta"));
}
function editarActualLab(boton){
    var td = boton.parentNode;
    var tr = td.parentNode;
    var columnas = tr.querySelectorAll("td");
    $("#codigo").val(columnas[0].textContent);
    document.getElementById("codigo").disabled = true;
    $("#nombre").val(columnas[1].textContent);
    $("#costo").val(columnas[2].textContent);
    mostrarOculto(boton,$("#nuevaConsulta"),$("#contenidoConsulta"));
}

