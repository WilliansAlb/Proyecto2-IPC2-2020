/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formReporteAdmin").bind("submit", function () {
        var valor = $("#tipoReporte").val();
        var mensaje = $("#mensajeExistencia").text();
        var doctor = $("#doctorEscrito").val();
        var fecha1 = $("#fecha1").val();
        var fecha2 = $("#fecha2").val();
        if (valor !== "7") {
            if (valor === "1" || valor === "3" || valor === "4" || valor === "5") {
                window.location = "/Servidor/Reportes?admin=true&tipo=" + valor + "&fecha1=" + fecha1 + "&fecha2=" + fecha2;
            } else {
                if (mensaje === "✔") {
                    window.location = "/Servidor/Reportes?admin=true&tipo=" + valor + "&sujeto=" + doctor + "&fecha1=" + fecha1 + "&fecha2=" + fecha2;
                } else {
                    $("#pop").fadeIn(500);
                    $("#pop").fadeOut(3000);
                }
            }
        }
        return false;
    });
    $("#formReporteLaboratorista").bind("submit", function () {
        var valor = $("#tipoReporte").val();
        var mensaje = $("#mensajeExistencia").text();
        var fecha1 = $("#fecha1").val();
        var fecha2 = $("#fecha2").val();
        if (valor !== "5") {
            if (valor === "3") {
                window.location = "/Servidor/Reportes?laboratorista=true&tipo=" + valor + "&fecha1=" + fecha1 + "&fecha2=" + fecha2;
            }
        }
        return false;
    });
};

function mostrarFechasAdmin(option) {
    var valor = option.value;
    if (valor === "1" || valor === "3" || valor === "4" || valor === "5") {
        $("#selectAdmin").hide();
        $("#doctorEscrito").removeAttr("required");
        $("#fechas").fadeIn(1000);
    } else {
        if (valor !== "7") {
            if (valor === "2") {
                $("#cambiante").text("Medico:");
            } else {
                $("#cambiante").text("Paciente:");
            }
            $("#selectAdmin").show();
            $("#doctorEscrito").attr("required", "required");
            $("#fechas").fadeIn(1000);
        } else {
            $("#fechas").fadeOut(1000);
        }
    }
}

function mostrarFechasLaboratorista(option) {
    var valor = option.value;
    if (valor === "3") {
        $("#fechas").fadeIn(1000);
    } else {
        if (valor !== "5") {
            window.location = "/Servidor/Reportes?laboratorista=true&tipo="+valor;
        } else {
            $("#fechas").fadeOut(1000);
        }
    }
}

let timeout;
function existeMedico(input) {
    var isCorrecto = document.getElementById("mensajeExistencia");
    clearTimeout(timeout);
    timeout = setTimeout(() => {
        $.ajax({
            type: 'GET', // it's easier to read GET request parameters
            url: '../Paciente',
            data: {
                tipo: 4,
                codigo: input.value
            },
            success: function (data) {
                if (data.length > 0) {
                    if (data === 'true') {
                        isCorrecto.textContent = '✔';
                    } else {
                        isCorrecto.textContent = '✖';
                        $("#pop").fadeIn(500);
                        $("#pop").fadeOut(3000);
                    }
                }
            },
            error: function (data) {
                alert('Fallo al ingresar citas');
            }
        });
    }, 800);
}
