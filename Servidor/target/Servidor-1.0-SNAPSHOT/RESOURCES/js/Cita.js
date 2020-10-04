/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var codigoMedicoGlobal = "";
var codigoConsultaGlobal = "";
var costoConsultaGlobal = "";
var codigoConsultaInvididual ="";
var horarioElegido = "";
window.onload = function () {
    $("#formularioFiltros").bind("submit", function () {

        var btnEnviar = $("#buscarMedico");
        var valor = document.getElementById("filtroMedicos").value;
        var div = "";
        if (valor === 'filtro1') {
            div = 1;
        } else if (valor === 'filtro2') {
            div = 2;
        } else if (valor === 'filtro3') {
            div = 3;
        } else if (valor === 'filtro4') {
            div = 4;
        }
        var nombre = $("#texto").val();
        var especialidades = $("#especialidadesFiltro").val();
        var desde = $("#desde").val();
        var hasta = $("#hasta").val();
        var hora = $("#hora").val();

        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: div, nombre: nombre, especial: especialidades, desde: desde, hasta: hasta, hora: hora},
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
                    window.location = "PacienteAgendar.jsp";
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
function cambiar(checkbox) {
    var elementos = document.getElementsByClassName("seleccionar");
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i] === checkbox) {
            costoConsultaGlobal = elementos[i].name;
            codigoConsultaInvididual = elementos[i].value;
            console.log(codigoConsultaInvididual);
            $("#siguiente").removeAttr("disabled");
        } else {
            elementos[i].checked = false;
        }
    }
}
function mostrarHorarios(div1, div2) {
    siguiente(div1, div2);
}
function seleccionandoFecha() {
    var btnEnviar = $("#fechaSeleccion");
    var fechaElegida = document.getElementById('fechaElegida').value;
    var medico = codigoMedicoGlobal;
    $.ajax({
        type: 'GET',
        url: '../Cita',
        data: {pedido: 5, medico: medico, fecha: fechaElegida},
        beforeSend: function () {
            btnEnviar.attr("disabled", "disabled");
        },
        complete: function (data) {
            btnEnviar.removeAttr("disabled");
        },
        success: function (data) {
            if (data === 'EXISTE') {
                alert("Ya existe un registro con ese mismo codigo, ingresa uno nuevo");
                $("#codigo").focus();
            } else if (data === 'ERRORBASE') {
                alert("No fue posible concretar la acción, intenta de nuevo");
            } else if (data === 'LIBRE') {
                rellenarTabla();
            } else {
                rellenarTablaHorarios(data);
            }
        },
        error: function (data) {
            alert("Problemas al tratar de enviar el formulario");
        }
    });

}
function cambiarDatos(checkbox) {
    var elementos = document.getElementsByClassName("seleccionarDatos");
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i] === checkbox) {
            $("#siguiente2").removeAttr("disabled");
            codigoMedicoGlobal = elementos[i].name;
            codigoConsultaGlobal = elementos[i].value;
            console.log(codigoMedicoGlobal + "  " + codigoConsultaGlobal);
        } else {
            elementos[i].checked = false;
        }
    }
}
function mostrarUnicasEspecialidades(div1, div2) {
    var tabla = document.querySelector("#consultas > tbody");
    var trs = tabla.querySelectorAll("tr");

    for (let i = 0; i < trs.length; i++) {
        var td = trs[i].querySelectorAll("td");
        if (!codigoConsultaGlobal.includes(td[1].textContent)) {
            trs[i].style.display = 'none';
        } else {
            trs[i].style.display = '';
        }
    }
    siguiente(div1, div2);
}
function siguiente(div1, div2) {
    div1.show();
    div2.hide();
}
function retroceder(div1,div2){
    var tabla = document.querySelector("#horarios > tbody");
    tabla.innerHTML = "<td><p>Acá apareceran las horas en las que trabaja el medico</p></td><td><p>Acá aparecera la disponibilidad</p></td>";
    siguiente(div1,div2);
}
function cambiandoFiltros(select) {
    var div = select.value;
    var options = select.querySelectorAll("option");
    console.log(options.length);
    for (let i = 1; i < options.length; i++) {
        var div2 = options[i].value;
        if (div2 != div) {
            var divs = document.querySelector("#" + div2);
            var input = divs.querySelectorAll(".filtros");
            for (let o = 0; o < input.length; o++) {
                input[o].required = false;
            }
            $("#" + div2).hide();
        } else {
            var divs = document.querySelector("#" + div2);
            var input = divs.querySelectorAll(".filtros");
            for (let o = 0; o < input.length; o++) {
                input[o].required = true;
            }
        }
    }
    if (div !== "1") {
        $("#" + div).show();
        $("#buscarMedico").show();
    } else {
        $("#buscarMedico").hide();
    }
}
function rellenarTabla() {
    var elementos = document.getElementsByClassName("seleccionarDatos");
    var inicio = "";
    var final1 = "";
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i].checked) {
            var td = elementos[i].parentNode;
            var tr = td.parentNode;
            var celdas = tr.querySelectorAll("td");
            inicio = celdas[4].textContent;
            final1 = celdas[5].textContent;
        }
    }
    inicio = parseInt(inicio);
    final1 = parseInt(final1);
    var tabla = document.querySelector("#horarios > tbody");
    tabla.innerHTML = "";
    while (inicio < final1) {
        const FILA = document.createElement("tr");
        const CELDA1 = document.createElement("td");
        const CELDA2 = document.createElement("td");
        CELDA1.textContent = inicio;
        CELDA2.innerHTML = "<input type='checkbox' class='marcarHorarios' onclick='marcarHorario(this)' value='" + inicio + "'>";
        FILA.append(CELDA1, CELDA2);
        tabla.appendChild(FILA);
        inicio++;
    }

}

function rellenarTablaHorarios(data) {
    var partido = data.split("/");
    var elementos = document.getElementsByClassName("seleccionarDatos");
    var inicio = "";
    var final1 = "";
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i].checked) {
            var td = elementos[i].parentNode;
            var tr = td.parentNode;
            var celdas = tr.querySelectorAll("td");
            inicio = celdas[4].textContent;
            final1 = celdas[5].textContent;
        }
    }
    inicio = parseInt(inicio);
    final1 = parseInt(final1);
    var tabla = document.querySelector("#horarios > tbody");
    tabla.innerHTML = "";
    while (inicio < final1) {
        const FILA = document.createElement("tr");
        const CELDA1 = document.createElement("td");
        const CELDA2 = document.createElement("td");
        CELDA1.textContent = inicio;
        var booleano = false;
        for (let i = 0; i < partido.length; i++) {
            if (parseInt(partido[i]) === inicio) {
                booleano = true;
            }
        }
        if (booleano) {
            CELDA2.innerHTML = "<h3 style='color:red'>OCUPADO</h3>";
        } else {
            CELDA2.innerHTML = "<input type='checkbox' class='marcarHorarios' onclick='marcarHorario(this)' value='" + inicio + "'>";
        }
        FILA.append(CELDA1, CELDA2);
        tabla.appendChild(FILA);
        inicio++;
    }

}

function marcarHorario(checkbox) {
    var elementos = document.getElementsByClassName("marcarHorarios");
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i] === checkbox) {
            $("#siguiente3").removeAttr("disabled");
            horarioElegido = elementos[i].value;
        } else {
            elementos[i].checked = false;
        }
    }
}

function irAConfirmar(div1,div2){
    var elementos = document.getElementsByClassName("seleccionarDatos");
    var nombre  = "";
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i].checked) {
            var td = elementos[i].parentNode;
            var tr = td.parentNode;
            var celdas = tr.querySelectorAll("td");
            nombre = celdas[1].textContent;
        }
    }
    var elementos2 = document.getElementsByClassName("seleccionar");
    var nombreConsulta  = "";
    var costo = "";
    for (let i = 0; i < elementos2.length; i++) {
        if (elementos2[i].checked) {
            var td = elementos2[i].parentNode;
            var tr = td.parentNode;
            var celdas = tr.querySelectorAll("td");
            nombreConsulta = celdas[1].textContent;
            costo = celdas[2].textContent;
        }
    }
    $('#medicoTabla').text(nombre);
    $("#fechaTabla").text($('#fechaElegida').val());
    $("#consultaTabla").text(nombreConsulta);
    $("#costoTabla").text(costo);
    $("#horaTabla").text(horarioElegido);
    siguiente(div1,div2);
}

function ingresarCita(){
    var btnEnviar = $('#ingresarCita');
    var fecha = $("#fechaElegida").val();
    var tipo1 = codigoConsultaInvididual;
     $.ajax({
        type: 'POST',
        url: '../Cita',
        data: {tipo: "INGRESO CITA", medico:codigoMedicoGlobal,consulta:tipo1,horario:horarioElegido,fecha:fecha},
        beforeSend: function () {
            btnEnviar.attr("disabled", "disabled");
        },
        complete: function (data) {
            btnEnviar.removeAttr("disabled");
        },
        success: function (data) {
            if (data === 'EXISTE') {
                alert("Ya existe un registro con ese mismo codigo, ingresa uno nuevo");
            } else if( data === 'ERRORBASE') {
                alert("ERROR al ingresar la consulta");
            } else {
                $("#mensajeCita").text("CITA CONFIRMADA");
                $("#verificarCita").hide();
                document.getElementById("spanCodigo").innerText = data;
                document.getElementById("spanCodigo").style.color = "green";
                $("#spanCodigo").css("font-size","3em");
                $("#spanCodigo").css("font-weight","bold");
                $("#mensajeConfirmacion").show();
                btnEnviar.hide();
                $("#regreso3").hide();
                $("#otraConsulta").show();
            }
        },error: function (data) {
            alert("Problemas al tratar de enviar el formulario");
        }
    });
}