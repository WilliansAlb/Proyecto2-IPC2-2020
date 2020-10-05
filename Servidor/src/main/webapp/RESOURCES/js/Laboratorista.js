/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var base = "";
var fuente = "";

window.onload = function () {
    $("#formularioFiltroSeleccion").bind("submit", function () {
        var btnEnviar = $("#ingresarFiltroFecha");
        var fecha1 = $("#desde").val();
        var fecha2 = $("#hasta").val();
        console.log(fecha1+"/"+fecha2);
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: 3, fecha1: fecha1, fecha2: fecha2},
            beforeSend: function () {
                btnEnviar.text("INGRESANDO"); //Para button 
                //btnEnviar.val("Enviando"); // Para input de tipo button
                btnEnviar.attr("disabled", "disabled");
            },
            complete: function (data) {
                btnEnviar.text("GUARDAR CAMBIOS");
                btnEnviar.removeAttr("disabled");
            },
            success: function (data) {
                if (data === 'EXISTE') {
                    alert("Ya existe un registro con ese mismo codigo, ingresa uno nuevo");
                } else if (data === 'ERRORBASE') {
                    alert("No fue posible concretar la acción, intenta de nuevo");
                } else {
                    alert("fechas");
                    window.location = "Laboratorista.jsp";
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });
};
function mostrar(boton) {
    $('#des').val(boton.value);
    var name = boton.name;
    var td = boton.parentNode;
    var tabla = td.parentNode;
    var nombre = tabla.getElementsByTagName("td")[2];
    var cono = "";
    if (name === 'orden') {
        document.getElementById("archivo1").src = "../ControladorPDF?solicitadoPDF=" + boton.value;
    } else {
        document.getElementById("archivo1").src = "../ControladorIMG?solicitadoIMG=" + boton.value;
    }
    cono = "ORDEN DE PACIENTE " + nombre.textContent;
    document.getElementById('nombrecodigo').innerText = cono;
    $('#descripcionE').fadeIn(1000);
}

function ocultar(elemento) {
    elemento.style.display = 'none';
}

function agregarResultado(boton) {
    var tr = document.getElementById("filaexamen" + boton.value);
    var celdas = tr.querySelectorAll("td");
    $("#reporteDato").val(boton.value);
    $("#pacienteDato").val(celdas[2].textContent);
    $("#examenDato").val(celdas[1].textContent);
    $('#agregarResultado').fadeIn(1000);
}

function verificar() {
    var actualArchivo2 = document.getElementById("archivo").files[0];
    var reader2 = new FileReader();
    reader2.readAsDataURL(actualArchivo2);
    reader2.onload = function () {
        fuente = reader2.result;
        const base64String2 = reader2.result
                .replace('data:', '')
                .replace(/^.+,/, '');
        base = base64String2;
        document.getElementById("visualizarArchivo").src = fuente;
        var filename = $("input[type=file]").val().replace("C:\\fakepath\\", "");
        document.getElementById("ruta").innerText = ".." + filename;

    };
    reader2.onerror = function (error) {
        console.log('Error: ', error);
    };
}
function ingresarExamenLaboratorista() {
    var btnEnviar = $("#ingresarExa");
    $.ajax({
        type: "POST",
        url: "../Laboratorista",
        data: {tipo: "INGRESO EXAMEN", archivo: base, codigo: $("#reporteDato").val()},
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
                window.location = "Laboratorista.jsp";
            }
        },
        error: function (data) {
            /*
             * Se ejecuta si la peticón ha sido erronea
             * */
            alert("Problemas al tratar de enviar el formulario");
        }
    });
}
function mandar(select) {
    var valor = select.value;
    if (valor === '1') {
        window.location = "Laboratorista.jsp";
    } else if (valor === '2') {
        $("#fechas").hide();
        $.ajax({
            type: "GET",
            url: "../Laboratorista",
            data: {tipo: 2},
            success: function (data) {
                if (data === 'ERRORBASE') {
                    alert("No fue posible concretar la acción, intenta de nuevo");
                } else {
                    window.location = "Laboratorista.jsp";
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
    } else if (valor === '3') {
        $("#fechas").show();
    }

}