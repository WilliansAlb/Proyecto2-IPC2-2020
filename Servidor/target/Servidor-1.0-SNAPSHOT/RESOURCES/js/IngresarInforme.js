/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function mostrarHora() {
    var hora = document.getElementById("fechaHoy").value;
}
function cambiandoFecha() {
    var hora = document.getElementById("fechaHoy").value;
}

function mostrarInforme() {
    var element = document.getElementById("ingresoInforme");
    element.style.display = 'none';
    document.getElementById("agregarInforme").style.display = "inline-block";
    document.getElementById("agregarInforme").style.margin = "3em";
    var tabla = document.getElementById("colaCitas");
    var tbody = tabla.querySelector("tbody");
    var filaSiguiente = tbody.querySelectorAll("tr")[0];
    var paciente = filaSiguiente.querySelectorAll("td")[1];
    var hora = filaSiguiente.querySelectorAll("td")[3];
    var codigoCita = filaSiguiente.querySelectorAll("td")[0];
    var horaCorrecta = hora.textContent.replace(":", ".");
    $("#pacienteNombre").val(paciente.textContent);
    $("#codigoCita").val(codigoCita.textContent);
    document.getElementById("horaInforme").value = parseFloat(horaCorrecta);
}

function mostrarExamen() {
    var element = document.getElementById("agregarInforme");
    var codigoResultado = document.getElementById("codigoResultado");
    element.classList.remove("centrado");
    element.classList.add("left");
    $("#agregarExamen").show();
    document.getElementById("agregarExamen").style.margin = "0";
    alert(codigoResultado.value + "-");
}

function mostrarHorarios() {
    var select = document.getElementById("laboratoristas");
    var laboratorista = select.value;
    var fecha = document.getElementById("fechaInforme").value;
    $.ajax({
        type: 'GET', // it's easier to read GET request parameters
        url: '../IngresoInforme',
        data: {
            tipo: 3,
            laboratorista: laboratorista,
            fecha: fecha
        },
        success: function (data) {
            if (data.length > 0) {
                agregarHorariosATabla(data);
            } else {
                document.getElementById("mensajeHorario").innerText = "No tiene reportes en cola, esta disponible todo el día, ingresa la hora que desees";
            }
        },
        error: function (data) {
            alert('Fallo al ingresar citas');
        }
    });
}

function cambiarArchivo(input) {
    var ruta = input.value;
    var rutas = ruta.split("\\");
    document.getElementById("ruta").innerText = rutas[rutas.length - 1];
    alert(ruta);
}

function cambiarFecha(inputDate) {
    let dias = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"];
    let date = new Date(inputDate.value);
    let examen = document.getElementById("opcionExamen").value;
    $.ajax({
        type: 'GET', // it's easier to read GET request parameters
        url: '../IngresoInforme',
        data: {
            tipo: 1,
            dia: date.getDay() + 1,
            examen: examen
        },
        success: function (data) {
            if (data.length > 0) {
                agregarLaboratoristasATabla(data);
            } else {
                $("#selectLabo").hide();
                alert("No hay ningún laboratorista disponible para ese examen, intenta otra fecha");
            }
        },
        error: function (data) {
            alert('Fallo al ingresar citas');
        }
    });
}
function cambiarExamen(inputExamen) {
    let examen = inputExamen.value;

    $.ajax({
        type: 'GET', // it's easier to read GET request parameters
        url: '../IngresoInforme',
        data: {
            tipo: 2,
            examen: examen
        },
        success: function (data) {
            if (data.length > 0) {
                if (data === 'true') {
                    $("#ordenArchivo").show();
                } else {
                    $("#ordenArchivo").hide();
                }
            }
        },
        error: function (data) {
            alert('Fallo al ingresar citas');
        }
    });
}

function agregarLaboratoristasATabla(laboratoristas) {
    var select = document.getElementById("laboratoristas");
    select.innerHTML = '';
    var arrayLaboratoristas = laboratoristas.slice(0, -1).split("|");
    for (let i = 0; i < arrayLaboratoristas.length; i++) {
        var lab = arrayLaboratoristas[i].split(",");
        var option = document.createElement("option");
        option.value = lab[0];
        option.textContent = lab[1];
        select.appendChild(option);
    }
    $("#selectLabo").show();
}

function ingresarReporte() {
    var hora = document.getElementById("horaInforme");
    var codigo = document.getElementById("codigoInforme");
    var codigoP = document.getElementById("codigoCorrecto");
    var descripcion = document.getElementById("informe");

    if (codigo.value !== '' && codigoP.textContent === '✔' && descripcion.value !== '') {
        alert("todo correcto");
    } else {
        if (codigoP.textContent === '✖') {
            $("codigoInforme").focus();
            alert("El codigo que ingresaste ya existe, ingresa uno nuevo");
        } else {
            if (codigoP.textContent === '') {
                $("#codigoInforme").focus();
                alert("Tienes que llenar el campo de codigo");
            } else {
                $("#informe").focus();
                alert("Tienes que llenar la descripcion de la consulta");
            }
        }
    }
}

function ingresarExamen() {
    var hora = document.getElementById("horaInforme");
    var codigo = document.getElementById("codigoInforme");
    var codigoP = document.getElementById("codigoCorrecto");
    var descripcion = document.getElementById("informe");

    if (codigo.value !== '' && codigoP.textContent === '✔' && descripcion.value !== '') {
        var element = document.getElementById("agregarInforme");
        var codigoResultado = document.getElementById("codigoResultado");
        element.style.display = 'none';
        $("#agregarExamen").show();
        document.getElementById("agregarExamen").style.margin = "0";
    } else {
        if (codigoP.textContent === '✖') {
            $("codigoInforme").focus();
            alert("El codigo que ingresaste ya existe, ingresa uno nuevo");
        } else {
            if (codigoP.textContent === '') {
                $("#codigoInforme").focus();
                alert("Tienes que llenar el campo de codigo");
            } else {
                $("#informe").focus();
                alert("Tienes que llenar la descripcion de la consulta");
            }
        }
    }
}

let timeout;

function verificarCodigo(input) {
    var isCorrecto = document.getElementById("codigoCorrecto");
    clearTimeout(timeout);
    timeout = setTimeout(() => {
        $.ajax({
            type: 'GET', // it's easier to read GET request parameters
            url: '../IngresoInforme',
            data: {
                tipo: 4,
                codigo: input.value
            },
            success: function (data) {
                if (data.length > 0) {
                    input.style.width = '85%';
                    if (data === 'true') {
                        isCorrecto.textContent = '✖';
                    } else {
                        isCorrecto.textContent = '✔';
                    }
                }
            },
            error: function (data) {
                alert('Fallo al ingresar citas');
            }
        });
    }, 800);
}