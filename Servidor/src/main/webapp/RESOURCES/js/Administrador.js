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
        if (codigo === 'SIN') {
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

    $("#formularioAdminLaboratorista").bind("submit", function () {
        var btnEnviar = $("#ingresar");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var registro = $("#registro").val();
        var dpi = $("#dpi").val();
        var telefono = $("#telefono").val();
        var nuevo = document.getElementById("codigo").disabled;
        var coleccion = "";
        var especial = document.getElementsByName("dias");
        for (let i = 0; i < especial.length; i++) {
            if (especial[i].checked) {
                var valor = especial[i].value;
                coleccion += valor + "-" + (i + 1) + "/";
            } else {
                if (especial[i].value === '1') {
                    coleccion += "2-" + (i + 1) + "/";
                }
            }
        }
        coleccion = coleccion.slice(0, -1);
        var fecha = $("#fecha").val();
        var email = $("#email").val();
        var examen = $("#examen").val();
        var password = $("#password").val();
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "INGRESO LABORATORISTA", codigo: codigo, nombre: nombre, registro:registro, dpi: dpi, telefono: telefono, dias: coleccion,
            fecha:fecha,email:email,examen:examen, nuevo:nuevo, password:password},
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
                    window.location = "AdminLaboratoristas.jsp";
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
    $("#formularioAdminMedico").bind("submit", function () {
        var btnEnviar = $("#ingresar");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var colegiado = $("#colegiado").val();
        var dpi = $("#dpi").val();
        var correo = $("#correo").val();
        var inicio = $("#inicio").val();
        var final = $("#final").val();
        var telefono = $("#telefono").val();
        var fecha = $("#fechaInicio").val();
        var div = document.getElementById("esp");
        var nuevo = document.getElementById("codigo").disabled;
        var selects = div.querySelectorAll("select");
        var nuevos = "";
        var cambios = "";
        var password = $("#password").val();
        for (let i = 0; i < selects.length; i++){
            if (selects[i].name==='0'){
                nuevos += selects[i].value+"/";
            } else {
                cambios += selects[i].name +"-"+selects[i].value+"/";
            }
        }
        if (nuevos !== ''){
            nuevos = nuevos.slice(0,-1);
        }
        if (cambios!== ''){
            cambios = cambios.slice(0,-1);
        }
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "INGRESO MEDICO", codigo: codigo, nombre: nombre, colegiado:colegiado, dpi: dpi, telefono: telefono, correo: correo,
            fecha:fecha,inicio:inicio,final:final, nuevos:nuevos,cambios:cambios,nuevo:nuevo,password:password},
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
                    window.location = "AdminMedicos.jsp";
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
        $('#mensaje').offset({top: 0, left: 0});
    } else {
        $('#mensaje').offset({top: 0, left: 0});
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
    mostrarOculto(boton, $("#nuevoExamen"), $("#contenidoExamen"));
}
function mostrarNuevaConsulta(boton) {
    $("#codigo").val("SIN");
    $("#nombre").val("");
    $("#costo").val("");
    $("#codigoDiv").hide();
    document.getElementById("codigo").disabled = false;
    mostrarOculto(boton, $("#nuevaConsulta"), $("#contenidoConsulta"));
}
function mostrarNuevoLab(boton) {
    $("#codigo").val("");
    $("#nombre").val("");
    $("#registro").val("");
    $("#dpi").val("");
    $("#telefono").val("");
    $("#Lunes").removeAttr("checked");
    $("#Martes").removeAttr("checked");
    $("#Miercoles").removeAttr("checked");
    $("#Jueves").removeAttr("checked");
    $("#Viernes").removeAttr("checked");
    $("#Sabado").removeAttr("checked");
    $("#Domingo").removeAttr("checked");
    var especial = document.getElementsByName("dias");
    for (let i = 0; i < especial.length; i++) {
        especial[i].value = "0";
    }
    $("#fecha").val("");
    $("#email").val("");
    $("#contra").show();
    $("#password").val("");
    $("#password").attr("required","required");
    document.getElementById("codigo").disabled = false;
    mostrarOculto(boton, $("#nuevoLaboratorista"), $("#contenidoLaboratorista"));
}
function mostrarNuevoMedico(boton) {
    document.getElementById("codigo").disabled = false;
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
function ocultar(elemento) {
    elemento.style.display = 'none';
}

function recargar(elemento) {
    window.location = "AdminMedicos.jsp";
}
function editarActualExamen(boton) {
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
    if (condicional === 'SI') {
        $("#orden").val("1");
    } else {
        $("#orden").val("0");
    }
    mostrarOculto(boton, $("#nuevoExamen"), $("#contenidoExamen"));
}
function editarActualConsulta(boton) {
    var td = boton.parentNode;
    var tr = td.parentNode;
    var columnas = tr.querySelectorAll("td");
    $("#codigo").val(columnas[0].textContent);
    document.getElementById("codigo").disabled = true;
    $("#codigoDiv").show();
    $("#nombre").val(columnas[1].textContent);
    $("#costo").val(columnas[2].textContent);
    mostrarOculto(boton, $("#nuevaConsulta"), $("#contenidoConsulta"));
}
function editarActualLab(boton) {
    var dias = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"];
    var td = boton.parentNode;
    var tr = td.parentNode;
    var columnas = tr.querySelectorAll("td");
    var examenesSelect = document.getElementById("examen");
    var codigos = examenesSelect.querySelectorAll("option");
    for (let i = 0; i < codigos.length; i++){
        if (codigos[i].textContent === columnas[5].textContent){
            codigos[i].selected = true;
        }
    }
    $("#codigo").val(columnas[0].textContent);
    document.getElementById("codigo").disabled = true;
    $("#nombre").val(columnas[1].textContent);
    $("#registro").val(columnas[2].textContent);
    $("#dpi").val(columnas[3].textContent);
    $("#telefono").val(columnas[4].textContent);
    $("#Lunes").removeAttr("checked");
    $("#Martes").removeAttr("checked");
    $("#Miercoles").removeAttr("checked");
    $("#Jueves").removeAttr("checked");
    $("#Viernes").removeAttr("checked");
    $("#Sabado").removeAttr("checked");
    $("#Domingo").removeAttr("checked");
    var select = columnas[7].querySelectorAll("select")[0];
    var opciones = select.querySelectorAll("option");
    for (let i = 0; i < opciones.length; i++) {
        let valor = opciones[i].value;
        $("#" + dias[valor - 1]).attr("checked", true);
        $("#" + dias[valor - 1]).val("1");
    }
    $("#contra").hide();
    $("#password").val("");
    $("#password").removeAttr("required");
    $("#fecha").val(columnas[8].textContent);
    $("#email").val(columnas[6].textContent);
    mostrarOculto(boton, $("#nuevoLaboratorista"), $("#contenidoLaboratorista"));
}
function editarActualMedico(boton) {
    var dias = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo"];
    var td = boton.parentNode;
    var tr = td.parentNode;
    var columnas = tr.querySelectorAll("td");
    $("#codigo").val(columnas[0].textContent);
    document.getElementById("codigo").disabled = true;
    $("#nombre").val(columnas[1].textContent);
    $("#colegiado").val(columnas[2].textContent);
    $("#dpi").val(columnas[3].textContent);
    $("#telefono").val(columnas[4].textContent);
    var select = columnas[5].querySelectorAll("select")[0];
    var opciones = select.querySelectorAll("option");
    for (let i = 0; i < opciones.length; i++) {
        let valor = opciones[i].value;
        let partes = valor.split("/");
        if (i === 0){
            document.getElementById("especialidades").value = partes[0];
            document.getElementById("especialidades").name = partes[1];
        } else {
            agregarExistente(valor);
        }
    }
    $("#fechaInicio").val(columnas[8].textContent);
    var horas = columnas[7].textContent.split("-");
    $("#inicio").val(horas[0]);
    $("#final").val(horas[1]);
    $("#correo").val(columnas[6].textContent);
    $("#contra").hide();
    $("#password").val("");
    $("#password").removeAttr("required");
    mostrarOculto(boton, $("#nuevoMedico"), $("#contenidoMedico"));
}

function agregarSelect(){
    var div = document.getElementById("esp");
    var selects = div.querySelectorAll("select");
    let numero = selects.length;
    var nuevo = document.createElement("select");
    nuevo.innerHTML = document.getElementById("especialidades").innerHTML;
    nuevo.id = "nuevo/"+numero;
    nuevo.name = "0";
    div.appendChild(nuevo); 
}
function agregarExistente(valor){
    var partes = valor.split("/");
    var div = document.getElementById("esp");
    var selects = div.querySelectorAll("select");
    let numero = selects.length;
    var nuevo = document.createElement("select");
    nuevo.innerHTML = document.getElementById("especialidades").innerHTML;
    nuevo.value = partes[0];
    nuevo.name = partes[1];
    nuevo.id = "existente/"+partes[1];
    div.appendChild(nuevo); 
}

