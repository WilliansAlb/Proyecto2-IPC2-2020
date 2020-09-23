/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
let opciones = ['ADMINISTRADORES A INGRESAR', 'DOCTORES A INGRESAR', 'LABORATORISTAS A INGRESAR', 'PACIENTES A INGRESAR', 'EXAMENES A INGRESAR',
    'REPORTES A INGRESAR', 'RESULTADOS A INGRESAR', 'CONSULTAS A INGRESAR', 'CITAS A INGRESAR'];
let archivos = [];
let extensiones = [];
let posXml = 0;
let bases = [];
let fuentes = [];

function verificar() {
    const file1 = document.getElementById("archivo").files;
    for (let i = 0; i < file1.length; i++) {
        var actual = file1[i].webkitRelativePath;
        let pos = actual.indexOf('/');
        let pos2 = actual.indexOf('.');
        archivos.push(actual.substring(pos, actual.length));
        extensiones.push(actual.substring((pos2 + 1), actual.length));
        if (actual.substring((pos2 + 1), actual.length) === 'xml') {
            posXml = i;
        }
    }
    const file = document.getElementById("archivo").files[posXml];
    if (!file) {
        alert("NECESITAS SELECCIONAR UN ARCHIVO XML PRIMERO");
    } else {
        document.getElementById('ruta').innerText = ".." + archivos[posXml];
        $('#btn1').show();
        $('#ver').prop('disabled', false);
    }
}
function moverIzquierda() {
    var actual = document.getElementById('h-controlador').innerText;
    var posicion = opciones.indexOf(actual);
    if (opciones.indexOf(actual) == 1) {
        $('#btn-con-iz').prop('disabled', true);
    }
    document.getElementById('h-controlador').innerText = opciones[posicion - 1];
    mostrarTabla(posicion - 1);
    $('#btn-con-de').prop('disabled', false);
}

function moverDerecha() {
    var actual = document.getElementById('h-controlador').innerText;
    var posicion = opciones.indexOf(actual);
    if (opciones.indexOf(actual) == (opciones.length - 2)) {
        $('#btn-con-de').prop('disabled', true);
    }
    document.getElementById('h-controlador').innerText = opciones[posicion + 1];
    mostrarTabla(posicion + 1);
    $('#btn-con-iz').prop('disabled', false);
}

function mostrarTabla(posicion) {
    $('#doctores').hide();
    $('#admins').hide();
    $('#examenes').hide();
    $('#laboratoristas').hide();
    $('#pacientes').hide();
    $('#reportes').hide();
    $('#resultados').hide();
    $('#consultas').hide();
    $('#citas').hide();
    if (posicion == 0) {
        $('#admins').show(1000);
    } else if (posicion == 1) {
        $('#doctores').show(1000);
    } else if (posicion == 4) {
        $('#examenes').show(1000);
    } else if (posicion == 2) {
        $('#laboratoristas').show(1000);
    } else if (posicion == 3) {
        $('#pacientes').show(1000);
    } else if (posicion == 5) {
        $('#reportes').show(1000);
    } else if (posicion == 6) {
        $('#resultados').show(1000);
    } else if (posicion == 7) {
        $('#consultas').show(1000);
    } else if (posicion == 8) {
        $('#citas').show(1000);
    }

}

function loadDoc() {
    $('#carga').css('margin-top', '0');
    $('#carga').css('width', '40%');
    $('#carga').css('height', '30%');
    $('#carga').css('margin-left', '30%');
    $('#btn1').hide();
    $('.input-file-trigger').css('font-size', '1em');
    var visible = document.getElementById("visualizar").style.display === 'none';
    if (visible) {
        $('#visualizar').show();
    } else {
        $("table tbody tr").remove();
    }
    $('#btn-con-iz').prop('disabled', true);

    const file = document.getElementById("archivo").files[posXml];

    if (!file) {
        alert("NECESITAS SELECCIONAR UN ARCHIVO XML PRIMERO");
    } else {

        readDoc(file).then(parseDoc).then(showDocInTable).catch(onError)
    }
}

function readDoc(file) {
    const reader = new FileReader()

    return new Promise((ok) => {
        reader.readAsText(file)
        reader.onload = function () {
            ok(reader.result)
        }
    })
}

function parseDoc(rawXML) {
    const parser = new DOMParser()
    const xml = parser.parseFromString(rawXML, 'text/xml')
    return xml;
}

function showDocInTable(xml) {
    const table = document.querySelector('#admins > tbody');
    const table1 = document.querySelector('#doctores > tbody');
    const table2 = document.querySelector('#laboratoristas > tbody');
    const table3 = document.querySelector('#pacientes > tbody');
    const table4 = document.querySelector('#examenes > tbody');
    const table5 = document.querySelector('#reportes > tbody');
    const table6 = document.querySelector('#resultados > tbody');
    const table7 = document.querySelector('#citas > tbody');
    const table8 = document.querySelector('#consultas > tbody');

    const datasource = xml.querySelector('hospital');

    const books = datasource.querySelectorAll('admin');
    const doctores = datasource.querySelectorAll('doctor');
    const laboratoristas = datasource.querySelectorAll('laboratorista');
    const pacientes = datasource.querySelectorAll('paciente');
    const examenes = datasource.querySelectorAll('examen');
    const reportes = datasource.querySelectorAll('reporte');
    const resultados = datasource.querySelectorAll('resultado');
    const citas = datasource.querySelectorAll('cita');
    const consultas = datasource.querySelectorAll('consulta');

    Array.from(books).map((book, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(book.querySelector('CODIGO'));
        const DPI = tagToData(book.querySelector('DPI'));
        const NOMBRE = tagToData(book.querySelector('NOMBRE'));
        const PASSWORD = tagToData(book.querySelector('PASSWORD'));
        tr.append(CODIGO, DPI, NOMBRE, PASSWORD);
        table.appendChild(tr);
    });

    Array.from(doctores).map((doctor, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(doctor.querySelector('CODIGO'));
        const NOMBRE = tagToData(doctor.querySelector('NOMBRE'));
        const COLEGIADO = tagToData(doctor.querySelector('COLEGIADO'));
        const DPI = tagToData(doctor.querySelector('DPI'));
        const TELEFONO = tagToData(doctor.querySelector('TELEFONO'));
        const CORREO = tagToData(doctor.querySelector('CORREO'));
        const INICIO = tagToData(doctor.querySelector('TRABAJO'));
        const especialidades = doctor.querySelectorAll('TITULO');
        var especialidades1 = '';
        Array.from(especialidades).map((titulos, o) => {
            especialidades1 += titulos.textContent + ',';
        });
        const ESPECIALIDAD = document.createElement('td');
        ESPECIALIDAD.textContent = especialidades1.slice(0, -1);
        const HORARIO = document.createElement('td');
        HORARIO.textContent = doctor.querySelector('INICIO').textContent + "-" + doctor.querySelector('FIN').textContent;
        const PASSWORD = tagToData(doctor.querySelector('PASSWORD'));
        tr.append(CODIGO, NOMBRE, COLEGIADO, DPI, TELEFONO, ESPECIALIDAD, CORREO, HORARIO, INICIO, PASSWORD);
        table1.appendChild(tr);
    });

    Array.from(laboratoristas).map((laboratorista, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(laboratorista.querySelector('CODIGO'));
        const NOMBRE = tagToData(laboratorista.querySelector('NOMBRE'));
        const REGISTRO = tagToData(laboratorista.querySelector('REGISTRO'));
        const DPI = tagToData(laboratorista.querySelector('DPI'));
        const TELEFONO = tagToData(laboratorista.querySelector('TELEFONO'));
        const EXAMEN = tagToData(laboratorista.querySelector('EXAMEN'));
        const CORREO = tagToData(laboratorista.querySelector('CORREO'));
        const dias = laboratorista.querySelectorAll('DIA');
        var dias1 = '';
        Array.from(dias).map((dia, o) => {
            dias1 += dia.textContent + ',';
        })
        const TRABAJO = document.createElement('td');
        TRABAJO.textContent = dias1;
        const INICIO = tagToData(laboratorista.querySelectorAll('TRABAJO')[1]);
        const PASSWORD = tagToData(laboratorista.querySelector('PASSWORD'));
        tr.append(CODIGO, NOMBRE, REGISTRO, DPI, TELEFONO, EXAMEN, CORREO, TRABAJO, INICIO, PASSWORD);
        table2.appendChild(tr)
    })
    Array.from(pacientes).map((paciente, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(paciente.querySelector('CODIGO'));
        const NOMBRE = tagToData(paciente.querySelector('NOMBRE'));
        const SEXO = tagToData(paciente.querySelector('SEXO'));
        const NACIMIENTO = tagToData(paciente.querySelector('BIRTH'));
        const TELEFONO = tagToData(paciente.querySelector('TELEFONO'));
        const PESO = tagToData(paciente.querySelector('PESO'));
        const SANGRE = tagToData(paciente.querySelector('SANGRE'));
        const CORREO = tagToData(paciente.querySelector('CORREO'))
        const DPI = tagToData(paciente.querySelector('DPI'));
        const PASSWORD = tagToData(paciente.querySelector('PASSWORD'));
        tr.append(CODIGO, NOMBRE, SEXO, NACIMIENTO, DPI, TELEFONO, PESO, SANGRE, CORREO, PASSWORD);
        table3.appendChild(tr)
    })
    Array.from(examenes).map((examen, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(examen.querySelector('CODIGO'));
        const NOMBRE = tagToData(examen.querySelector('NOMBRE'));
        const ORDEN = tagToData(examen.querySelector('ORDEN'));
        const DESCRIPCION = tagToData(examen.querySelector('DESCRIPCION'));
        const DES = document.createElement('td');
        DES.innerHTML = '<button id="exa' + i + '" value="' + examen.querySelector('DESCRIPCION').textContent + '" onclick="mostrar(this)">VER</button>';
        const COSTO = tagToData(examen.querySelector('COSTO'));
        const INFORME = tagToData(examen.querySelector('INFORME'));
        tr.append(CODIGO, NOMBRE, ORDEN, DES, COSTO, INFORME);
        table4.appendChild(tr)
    })

    Array.from(reportes).map((reporte, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(reporte.querySelector('CODIGO'));
        const PACIENTE = tagToData(reporte.querySelector('PACIENTE'));
        const MEDICO = tagToData(reporte.querySelector('MEDICO'));
        const INFORME = document.createElement('td');
        INFORME.innerHTML = '<button id="rep' + i + '" value="' + reporte.querySelector('INFORME').textContent + '" onclick="mostrar(this)">VER</button>';
        const FECHA = tagToData(reporte.querySelector('FECHA'));
        const HORA = tagToData(reporte.querySelector('HORA'));
        tr.append(CODIGO, PACIENTE, MEDICO, INFORME, FECHA, HORA);
        table5.appendChild(tr)
    })

    Array.from(resultados).map((resultado, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(resultado.querySelector('CODIGO'));
        const PACIENTE = tagToData(resultado.querySelector('PACIENTE'));
        const EXAMEN = tagToData(resultado.querySelector('EXAMEN'));
        const LABORATORISTA = tagToData(resultado.querySelector('LABORATORISTA'));
        const ORDEN = tagToData(resultado.querySelector('ORDEN'));
        if (archivos.indexOf(resultado.querySelector('ORDEN').textContent) !== -1) {
            var actualArchivo = document.getElementById("archivo").files[archivos.indexOf(resultado.querySelector('ORDEN').textContent)];
            var reader = new FileReader();
            reader.readAsDataURL(actualArchivo);
            reader.onload = function () {
                fuentes.push(reader.result);
                const base64String = reader.result
                        .replace('data:', '')
                        .replace(/^.+,/, '');
                bases.push(base64String);
                ORDEN.innerHTML = "<button id='" + resultado.querySelector('ORDEN').textContent + "' value='" + (bases.length - 1) + "' onclick='mostrarOrden(this)'>VER " + resultado.querySelector('ORDEN').textContent + "</button>";
            };
            reader.onerror = function (error) {
                console.log('Error: ', error);
            };
        }
        const rutaInforme = resultado.querySelector('INFORME').textContent;
        const INFORME = tagToData(resultado.querySelector('INFORME'));
        if (archivos.indexOf(rutaInforme) !== -1) {
            var actualArchivo2 = document.getElementById("archivo").files[archivos.indexOf(rutaInforme)];
            var reader2 = new FileReader();
            reader2.readAsDataURL(actualArchivo2);
            reader2.onload = function () {
                fuentes.push(reader2.result);
                const base64String2 = reader2.result
                        .replace('data:', '')
                        .replace(/^.+,/, '');
                bases.push(base64String2);
                INFORME.innerHTML = "<button id='" + rutaInforme + "' value='" + (bases.length - 1) + "' onclick='mostrarOrden(this)'>VER " + rutaInforme + "</button>";
            };
            reader2.onerror = function (error) {
                console.log('Error: ', error);
            };
        }
        const FECHA = tagToData(resultado.querySelector('FECHA'));
        const HORA = tagToData(resultado.querySelector('HORA'));
        tr.append(CODIGO, PACIENTE, EXAMEN, LABORATORISTA, ORDEN, INFORME, FECHA, HORA);
        table6.appendChild(tr);
    });
    Array.from(citas).map((cita, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(cita.querySelector('CODIGO'));
        const PACIENTE = tagToData(cita.querySelector('PACIENTE'));
        const MEDICO = tagToData(cita.querySelector('MEDICO'));
        const FECHA = tagToData(cita.querySelector('FECHA'));
        const HORA = tagToData(cita.querySelector('HORA'));
        tr.append(CODIGO, PACIENTE, MEDICO, FECHA, HORA);
        table7.appendChild(tr);
    });
    Array.from(consultas).map((consulta, i) => {
        const tr = document.createElement('tr');
        const TIPO = tagToData(consulta.querySelector('TIPO'));
        const COSTO = tagToData(consulta.querySelector('COSTO'));
        tr.append(TIPO, COSTO);
        table8.appendChild(tr);
    });
}
function mostrarOrden(boton) {
    let pos = archivos.indexOf(boton.id);
    document.getElementById('visualizacionArchivo').src = fuentes[boton.value];
    var mensajew = $('#archivos').width();
    var mensajeh = $('#archivos').height();

    var height = $(window).height();
    var width = $(window).width();

    var posx = (width / 2) - (mensajew / 2);
    var posy = (height / 2) - (mensajeh / 2);

    if (posy > 0) {
        $('#archivos').offset({top: 0});
    } else {
        $('#archivos').offset({top: 0});
    }
    $('#contenedorArchivos').width(width);
    $('#contenedorArchivos').height(height);
    $('#contenedorArchivos').fadeIn(2000);
}

function mostrar(boton) {
    $('#des').val(boton.value);
    var td = boton.parentNode;
    var tabla = td.parentNode;
    var codigo = tabla.getElementsByTagName("td")[0];
    var nombre = tabla.getElementsByTagName("td")[1];
    var co = codigo.textContent;
    var nom = nombre.textContent;
    var cono = "";
    if (nom > 0) {
        cono = "REPORTE " + co;
    } else {
        cono = "EXAMEN " + co + " - " + nom;
    }
    document.getElementById('nombrecodigo').innerText = cono;
    var mensajew = $('#mensaje').width();
    var mensajeh = $('#mensaje').height();

    var height = $(window).height();
    var width = $(window).width();

    var posx = (width / 2) - (mensajew / 2);
    var posy = (height / 2) - (mensajeh / 2);

    if (posy > 0) {
        $('#mensaje').offset({top: 0});
    } else {
        $('#mensaje').offset({top: 0});
    }

    $('#descripcion').width(width);
    $('#descripcion').height(height);

    $('#descripcion').fadeIn(1000);
}
function ocultar(div) {
    div.style.display = 'none';
}

function tagToData(tag) {
    const td = document.createElement('td')
    if (tag != null) {
        td.textContent = tag.textContent
    } else {
        td.textContent = 'null'
    }
    return td;
}

function onError(reason) {
    console.error(reason)
}

jQuery(function ($) {
    $('.progress').circleProgress();
    $('.progress').circleProgress({
        max: 100,
        value: 0,
        textFormat: 'percent',
    });
});

function subir(range) {
    const val = range.value;
    var cp = document.getElementById('pro');
    cp.value = val;
    $('.progress').circleProgress({value: val, });
    cp.style.setProperty('--progress-value', val / 100);
}

function ingresarTodo(boton) {
    boton.style.display = 'none';
    $('#cargando').fadeIn(500);
    const file = document.getElementById("archivo").files[0];
    var examenes = [];
    var admin = [];
    var doctores = [];
    var laboratoristas = [];
    var pacientes = [];
    var consultas = [];

    tablaExamen = document.getElementById('examenes');
    datosExamen = tablaExamen.getElementsByTagName("tbody")[0];
    filasExamen = datosExamen.getElementsByTagName("tr");
    Array.from(filasExamen).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            if (o === 3) {
                miButton = celda.getElementsByTagName('button')[0];
                unArray.push(miButton.value);
            } else
                unArray.push(celda.textContent);
        });
        var moment = {codigo: unArray[0], nombre: unArray[1], orden: unArray[2], descripcion: unArray[3], costo: unArray[4], informe: unArray[5]};
        examenes.push(moment);
    });

    tablaAdmin = document.getElementById('admins');
    datosAdmin = tablaAdmin.getElementsByTagName("tbody")[0];
    filasAdmin = datosAdmin.getElementsByTagName("tr");
    Array.from(filasAdmin).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            unArray.push(celda.textContent);
        });
        var moment = {codigo: unArray[0], nombre: unArray[2], dpi: unArray[1], password: unArray[3]};
        admin.push(moment);
    });

    tablaDoctor = document.getElementById('doctores');
    datosDoctor = tablaDoctor.getElementsByTagName("tbody")[0];
    filasDoctor = datosDoctor.getElementsByTagName("tr");
    Array.from(filasDoctor).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            unArray.push(celda.textContent);
        });
        var moment = {codigo: unArray[0], nombre: unArray[1], colegiado: unArray[2], dpi: unArray[3], telefono: unArray[4], especialidades: unArray[5], correo: unArray[6], horario: unArray[7], trabajo: unArray[8], password: unArray[9]};
        doctores.push(moment);
    });

    tablaLaboratoristas = document.getElementById('laboratoristas');
    datosLaboratoristas = tablaLaboratoristas.getElementsByTagName("tbody")[0];
    filasLaboratoristas = datosLaboratoristas.getElementsByTagName("tr");
    Array.from(filasLaboratoristas).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            unArray.push(celda.textContent);
        });
        var moment = {codigo: unArray[0], nombre: unArray[1], registro: unArray[2],
            dpi: unArray[3], telefono: unArray[4], examen: unArray[5],
            correo: unArray[6], dias: unArray[7], inicio: unArray[8],
            password: unArray[9]};
        laboratoristas.push(moment);
    });

    tablaPacientes = document.getElementById('pacientes');
    datosPacientes = tablaPacientes.getElementsByTagName("tbody")[0];
    filasPacientes = datosPacientes.getElementsByTagName("tr");
    Array.from(filasPacientes).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            unArray.push(celda.textContent);
        });
        var moment = {codigo: unArray[0], nombre: unArray[1], sexo: unArray[2],
            nacimiento: unArray[3], dpi: unArray[4], telefono: unArray[5],
            peso: unArray[6], sangre: unArray[7], correo: unArray[8],
            password: unArray[9]};
        pacientes.push(moment);
    });

    tablaConsultas = document.getElementById('consultas');
    datosConsultas = tablaConsultas.getElementsByTagName("tbody")[0];
    filasConsultas = datosConsultas.getElementsByTagName("tr");
    Array.from(filasConsultas).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            unArray.push(celda.textContent);
        });
        var moment = {nombre: unArray[0], costo: unArray[1]};
        consultas.push(moment);
    });


    $("#actualSubiendo").text("Subiendo examenes...");
    $.ajax({
        type: 'POST', // it's easier to read GET request parameters
        url: 'Carga',
        data: {
            tipo: 1,
            test: JSON.stringify(examenes)
        },
        success: function (data) {

            if (data === 'mandato')
            {
                $("#actualSubiendo").text("Subiendo administradores...");
                $('.progress').circleProgress({
                    value: (100 / 9)
                });
                $.ajax({
                    type: 'POST', // it's easier to read GET request parameters
                    url: 'Carga',
                    data: {
                        tipo: 2,
                        test: JSON.stringify(admin)
                    },
                    success: function (data) {
                        if (data === 'mandato') {
                            $("#actualSubiendo").text("Subiendo consultas...");
                            $('.progress').circleProgress({
                                value: (200 / 9)
                            });
                            $.ajax({
                                type: 'POST', // it's easier to read GET request parameters
                                url: 'Carga',
                                data: {
                                    tipo: 6,
                                    test: JSON.stringify(consultas)
                                },
                                success: function (data) {
                                    if (data === 'mandato') {
                                        $("#actualSubiendo").text("Subiendo laboratoristas...");
                                        $('.progress').circleProgress({
                                            value: 300 / 9
                                        });
                                        $.ajax({
                                            type: 'POST', // it's easier to read GET request parameters
                                            url: 'Carga',
                                            data: {
                                                tipo: 4,
                                                test: JSON.stringify(laboratoristas)
                                            },
                                            success: function (data) {
                                                if (data === 'mandato')
                                                {
                                                    $("#actualSubiendo").text("Subiendo pacientes...");
                                                    $('.progress').circleProgress({
                                                        value: 400 / 9
                                                    });
                                                    $.ajax({
                                                        type: 'POST', // it's easier to read GET request parameters
                                                        url: 'Carga',
                                                        data: {
                                                            tipo: 5,
                                                            test: JSON.stringify(pacientes)
                                                        },
                                                        success: function (data) {
                                                            if (data === 'mandato') {
                                                                $("#actualSubiendo").text("Subiendo doctores...");
                                                                $('.progress').circleProgress({
                                                                    value: 500 / 9
                                                                });


                                                                $.ajax({
                                                                    type: 'POST', // it's easier to read GET request parameters
                                                                    url: 'Carga',
                                                                    data: {
                                                                        tipo: 3,
                                                                        test: JSON.stringify(doctores)
                                                                    },
                                                                    success: function (data) {
                                                                        if (data === 'mandato') {
                                                                            $("#actualSubiendo").text("Subiendo reportes...");
                                                                            $('.progress').circleProgress({
                                                                                value: 600 / 9
                                                                            });
                                                                        } else {
                                                                            alert("no hola");
                                                                        }
                                                                    },
                                                                    error: function (data) {
                                                                        alert('fail');
                                                                    }
                                                                });


                                                            } else {
                                                                alert("no hola");
                                                            }
                                                        },
                                                        error: function (data) {
                                                            alert('fail');
                                                        }
                                                    });
                                                } else {
                                                    alert("no hola");
                                                }
                                            },
                                            error: function (data) {
                                                alert('fail');
                                            }
                                        });
                                    } else {
                                        alert("no hola");
                                    }
                                },
                                error: function (data) {
                                    alert('fail');
                                }
                            });
                        } else {
                            alert("no hola");
                        }
                    },
                    error: function (data) {
                        alert('fail');
                    }
                });
            } else {
                alert("no hola");
            }
        },
        error: function (data) {
            alert('fail en examenes');
        }
    });
}

function getBase64(file) {
    var reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = function () {
        const base64String = reader.result
                .replace('data:', '')
                .replace(/^.+,/, '');

    };
    reader.onerror = function (error) {
        console.log('Error: ', error);
    };
}
