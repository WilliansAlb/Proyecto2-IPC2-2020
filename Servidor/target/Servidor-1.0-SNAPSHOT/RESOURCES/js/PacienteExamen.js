/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var codigoExamen = "";
var codigoLaboratorista = "";
var isRequeridaOrden = "";
var hora = "";
var base = "";
var fuente = "";
var trabajos = "";
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
    $('#descripcionE').fadeIn(1000);
}

function ocultar(elemento) {
    elemento.style.display = 'none';
}

function marcado(checkbox) {
    var elementos = document.getElementsByClassName("examenes");
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i] === checkbox) {
            isRequeridaOrden = elementos[i].name;
            codigoExamen = elementos[i].value;
            console.log(codigoExamen + "-" + isRequeridaOrden);
            $("#siguiente").removeAttr("disabled");
        } else {
            elementos[i].checked = false;
        }
    }
}
function siguiente(div, div2) {
    div.style.display = 'none';
    div2.style.display = '';
}
function mostrarLaboratoristas(div, div2) {
    if (isRequeridaOrden !== 'true') {
        disponibilidad();
        siguiente(div, document.getElementById("laboratoristasP"));

    } else {
        siguiente(div, div2);
    }
}
function siguienteOrden(div, div2) {
    if (isRequeridaOrden !== 'true') {
        disponibilidad();
        siguiente(div, document.getElementById("examenes"));
    } else {
        siguiente(div, div2);
    }
}
function mostrarLaboratoristasOrden(div, div2) {
    siguiente(div, div2);
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
        document.getElementById("visualizacionArchivo2").src = fuente;
        var filename = $("input[type=file]").val().replace("C:\\fakepath\\", "");
        document.getElementById("ruta").innerText = ".." + filename;
        $("#ordenP").css("margin-top", "0");
        verificarDatosCorrectos();
    };
    reader2.onerror = function (error) {
        console.log('Error: ', error);
    };
}
function disponibilidad() {
    let dias = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"];
    let date = new Date(document.getElementById("seleccionarFecha").value);
    let fecha = document.getElementById("seleccionarFecha").value;
    var dia = dias[date.getDay()];
    let contador = 0;
    var filas = document.querySelectorAll(".filasLab");
    for (let i = 0; i < filas.length; i++) {
        var codigos = filas[i].querySelectorAll(".codigosExamenes")[0].textContent;
        var diasExamenes = filas[i].querySelectorAll(".diasExamenes")[0].textContent;
        if (codigos == codigoExamen && diasExamenes.includes(dia)) {
            filas[i].style.display = "";
            contador++;
            var celdas = filas[i].querySelectorAll("td")[0].textContent;
            $.ajax({
                type: 'GET', // it's easier to read GET request parameters
                url: '../Paciente',
                data: {
                    tipo: 2,
                    laboratorista: celdas,
                    fecha: fecha
                },
                success: function (data) {
                    if (data === 'TRUE') {
                        filas[i].style = "";

                    } else if (data === 'FALSE') {
                        filas[i].style = "none";
                    }
                    console.log(data);
                },
                error: function (data) {
                    alert('Fallo al ingresar citas');
                }
            });
        } else {
            filas[i].style.display = "none";
        }
    }
    if (contador > 0) {
        document.getElementById("mensajeSinDisponibles").innerText = "";
    } else {
        document.getElementById("siguiente2").disabled = true;
        document.getElementById("mensajeSinDisponibles").innerText = "No hay laboratoristas disponibles para este día, selecciona un dia diferente";
    }
}

function mostrarDisponibilidad(div, div2) {
    let fecha = document.getElementById("seleccionarFecha").value;
    let labora = codigoLaboratorista;
    $.ajax({
        type: 'GET', // it's easier to read GET request parameters
        url: '../Paciente',
        data: {
            tipo: 1,
            laboratorista: labora,
            fecha: fecha
        },
        success: function (data) {
            if (data === '/') {
                limpiarTabla();
            } else {
                limpiarTabla();
                marcarExistente(data);
            }
            console.log(data);
        },
        error: function (data) {
            alert('Fallo al ingresar citas');
        }
    });
    siguiente(div, div2);
}

function marcadoLab(checkbox) {
    var elementos = document.getElementsByClassName("laboratoristas");
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i] === checkbox) {
            codigoLaboratorista = elementos[i].value;
            console.log(codigoLaboratorista);
            $("#siguiente2").removeAttr("disabled");
        } else {
            elementos[i].checked = false;
        }
    }
}

function limpiarTabla() {
    var elementos = document.getElementsByClassName("capsulaHora");
    for (let i = 0; i < elementos.length; i++) {
        elementos.innerHTML = '<input type="checkbox" class="marcadaHora" onclick="marcarUnaHora(this)" value="' + i + '">';
    }
}

function marcarExistente(data) {
    data = data.slice(0, -2);
    var datos = data.split(",");
    for (let i = 0; i < datos.length; i++) {
        var dia = parseFloat(datos[i]) / 100;
        var fila = document.getElementById("filadia" + dia).querySelectorAll("td")[1];
        fila.innerHTML = "<h4>OCUPADO</h4>";
    }
}

function marcarUnaHora(checkbox) {
    var elementos = document.getElementsByClassName("marcadaHora");
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i] === checkbox) {
            hora = elementos[i].value;
            console.log(hora);
            $("#siguienteDisponibilidad").removeAttr("disabled");
        } else {
            elementos[i].checked = false;
        }
    }
}

function confirmarExamen() {
    var elementos = document.getElementsByClassName("examenes");
    var costo = 0.0;
    for (let i = 0; i < elementos.length; i++) {
        if (elementos[i].checked) {
            var celda = elementos[i].parentNode;
            var fila = celda.parentNode;
            var costos = fila.querySelectorAll("td")[2];
            costo = parseFloat(costos.textContent);
        }
    }
    $('#examenTabla').text(codigoExamen);
    $("#fechaTabla").text($('#seleccionarFecha').val());
    $("#laboratoristaTabla").text(codigoLaboratorista);
    $("#costoTabla").text(costo);
    $("#horaTabla").text(hora);
    if (isRequeridaOrden === 'true') {
        $("#ordenTabla").text("SI");
    } else {
        $("#ordenTabla").text("NO");
    }
    siguiente(document.getElementById("disponibilidadExa"), document.getElementById("confirmar"));
}

function ingresarExamen() {
    var btnEnviar = $('#ingresarCita');
    var fecha = $("#seleccionarFecha").val();
    var medico = $("#codigoMedico1").val();
    var laboratorista = codigoLaboratorista;
    var examen = codigoExamen;
    var archivo = base;
    var hora1 = parseInt(hora)*100;
    var orden = "";
    if (isRequeridaOrden==='true'){
        orden = "true";
    } else {
        orden = "false";
    }
    console.log(fecha+medico+laboratorista+examen+hora1+orden);
    $.ajax({
        type: 'POST',
        url: '../Paciente',
        data: {tipo: "INGRESO EXAMEN", fecha:fecha,medico:medico,laboratorista:laboratorista,examen:examen,archivo:archivo,hora:hora1,orden:orden},
        beforeSend: function () {
            btnEnviar.attr("disabled", "disabled");
        },
        complete: function (data) {
            btnEnviar.removeAttr("disabled");
        },
        success: function (data) {
            if (data === 'EXISTE') {
                alert("Ya existe un registro con ese mismo codigo, ingresa uno nuevo");
            } else if (data === 'ERRORBASE') {
                alert("ERROR al ingresar la consulta");
            } else {
                $("#mensajeCita").text("EXAMEN CONFIRMADO");
                $("#verificarCita").hide();
                document.getElementById("spanCodigo").innerText = data;
                document.getElementById("spanCodigo").style.color = "green";
                $("#spanCodigo").css("font-size", "3em");
                $("#spanCodigo").css("font-weight", "bold");
                $("#mensajeConfirmacion").show();
                btnEnviar.hide();
                $("#regreso3").hide();
                $("#otraConsulta").show();
            }
        }, error: function (data) {
            alert("Problemas al tratar de enviar el formulario");
        }
    });
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
                tipo: 3,
                codigo: input.value
            },
            success: function (data) {
                if (data.length > 0) {
                    if (data === 'true') {
                        isCorrecto.textContent = '✔';
                        document.getElementById("siguiente4").disabled = false;
                        verificarDatosCorrectos();
                    } else {
                        isCorrecto.textContent = '✖';
                        document.getElementById("siguiente4").disabled = true;
                    }
                }
            },
            error: function (data) {
                alert('Fallo al ingresar citas');
            }
        });
    }, 800);
}
function verificarDatosCorrectos() {
    var isCorrecto = document.getElementById("mensajeExistencia").textContent;
    var file = document.getElementById("ruta").textContent;

    if (isCorrecto === '✔' && file.length > 0) {
        document.getElementById("siguiente4").disabled = false;
    } else {
        document.getElementById("siguiente4").disabled = true;
    }
}