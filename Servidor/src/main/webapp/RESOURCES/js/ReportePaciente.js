/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {
    $("#formReportePaciente1").bind("submit", function () {
        var filtro = $("#tipoReporte").val();
        var mensaje = $("#mensajeExistencia").text();
        var examen = $("#examenes").val();
        var doctor = $("#doctorEscrito").val();
        var fecha1 = $("#fecha1").val();
        var fecha2 = $("#fecha2").val();
        if (filtro === "2") {
            window.location = "/Servidor/Reportes?examen=" + examen + "&tipo=1&fecha1=" + fecha1 + "&fecha2=" + fecha2;
        } else {
            if (mensaje === "✔") {
                window.location = "/Servidor/Reportes?doctor=" + doctor + "&tipo=2&fecha1=" + fecha1 + "&fecha2=" + fecha2;
            } else {
                $("#pop").fadeIn(500);
                $("#pop").fadeOut(3000);
            }
        }
        return false;
    });
};

let timeout;

function existeMedico(input) {
    var isCorrecto = document.getElementById("mensajeExistencia");
    clearTimeout(timeout);
    timeout = setTimeout(() => {
        $.ajax({
            type: 'GET', // it's easier to read GET request parameters
            url: '../Paciente',
            data: {
                tipo: 3,
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

function mostrarFechas(option) {
    var valor = option.value;
    if (valor === "2") {
        $("#selectExamenes").show(1000);
        $("#selectExamenes2").hide();
        $("#doctorEscrito").removeAttr("required");
    } else {
        $("#selectExamenes").hide();
        $("#selectExamenes2").show();
        $("#doctorEscrito").attr("required", "required");
    }
    $("#fechas").fadeIn(1000);
}
function mostrarTipos(option) {
    var valor = option.value;
    if (valor === "1") {
        window.location = "/Servidor/Reportes?tipo=3";
    } else {
        window.location = "/Servidor/Reportes?tipo=4";
    }
}