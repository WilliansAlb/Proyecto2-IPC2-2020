/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
window.onload = function () {

    $("#formularioAdmin").bind("submit", function () {
        var btnEnviar = $("#ingreso");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var dpi = $("#dpi").val();
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "ADMIN", codigo: codigo, nombre: nombre, dpi: dpi},
            beforeSend: function () {
                /*
                 * Esta función se ejecuta durante el envió de la petición al
                 * servidor.
                 * */
                btnEnviar.text("GUARDANDO"); //Para button 
                //btnEnviar.val("Enviando"); // Para input de tipo button
                btnEnviar.attr("disabled", "disabled");
            },
            complete: function (data) {
                /*
                 * Se ejecuta al termino de la petición
                 * */
                btnEnviar.text("GUARDAR CAMBIOS");
                btnEnviar.removeAttr("disabled");
                btnEnviar.hide();
                document.getElementById("nombre").disabled = true;
                document.getElementById("dpi").disabled = true;
                $("#editarAdmin").show();
            },
            success: function (data) {
                /*
                 * Se ejecuta cuando termina la petición y esta ha sido
                 * correcta
                 * */
                if (data === 'no') {
                    alert("No fue posible actualizar los datos");
                } else {
                    alert(data);
                    window.location = "Perfil.jsp";
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

    $("#formularioPaciente").bind("submit", function () {
        var btnEnviar = $("#guardarCambios");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var sexo = $("#sexo").val();
        var peso = $("#peso").val();
        var sangre = $("#sangre").val();
        var telefono = $("#telefono").val();
        var fecha = $("#fecha").val();
        var dpi = $("#dpi").val();
        var email = $("#email").val();
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "PACIENTE", codigo: codigo, nombre: nombre, dpi: dpi, sexo: sexo,
                peso: peso, sangre: sangre, telefono: telefono, fecha: fecha, email: email},
            beforeSend: function () {
                /*
                 * Esta función se ejecuta durante el envió de la petición al
                 * servidor.
                 * */
                btnEnviar.text("GUARDANDO"); //Para button 
                //btnEnviar.val("Enviando"); // Para input de tipo button
                btnEnviar.attr("disabled", "disabled");
            },
            complete: function (data) {
                /*
                 * Se ejecuta al termino de la petición
                 * */
                btnEnviar.text("GUARDAR CAMBIOS");
                btnEnviar.removeAttr("disabled");
                btnEnviar.hide();
                document.getElementById("nombre").disabled = true;
                document.getElementById("dpi").disabled = true;
                $("#editarAdmin").show();
            },
            success: function (data) {
                /*
                 * Se ejecuta cuando termina la petición y esta ha sido
                 * correcta
                 * */
                if (data === 'no') {
                    alert("No fue posible actualizar los datos" + data);
                } else {
                    alert(data);
                    window.location = "Perfil.jsp";
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

    $("#formularioMedico").bind("submit", function () {
        var btnEnviar = $("#guardarCambios");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var colegiado = $("#colegiado").val();
        var dpi = $("#dpi").val();
        var correo = $("#correo").val();
        var inicio = $("#inicio").val();
        var final = $("#final").val();
        var telefono = $("#telefono").val();
        var fecha = $("#fechaInicio").val();
        var coleccion = "";
        var especialidades = document.querySelectorAll("ol")[0];
        var especial = especialidades.querySelectorAll("li");
        for (let i = 0; i < especial.length; i++) {
            var input = especial[i].querySelector("select");
            coleccion += input.name + "-" + input.value + "/";
        }
        coleccion = coleccion.slice(0, -1);

        console.log(coleccion);
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "MEDICO", codigo: codigo, nombre: nombre, dpi: dpi, colegiado: colegiado,
                correo: correo, inicio: inicio, final: final, fecha: fecha, telefono: telefono, especialidades: coleccion},
            beforeSend: function () {
                /*
                 * Esta función se ejecuta durante el envió de la petición al
                 * servidor.
                 * */
                btnEnviar.text("GUARDANDO"); //Para button 
                //btnEnviar.val("Enviando"); // Para input de tipo button
                btnEnviar.attr("disabled", "disabled");
            },
            complete: function (data) {
                /*
                 * Se ejecuta al termino de la petición
                 * */
                btnEnviar.text("GUARDAR CAMBIOS");
                btnEnviar.removeAttr("disabled");
                btnEnviar.hide();
            },
            success: function (data) {
                /*
                 * Se ejecuta cuando termina la petición y esta ha sido
                 * correcta
                 * */
                if (data === 'no') {
                    alert("No fue posible actualizar los datos" + data);
                } else {
                    alert(data);
                    window.location = "Perfil.jsp";
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

    $("#formularioLaboratorista").bind("submit", function () {
        var btnEnviar = $("#guardarCambios");
        var codigo = $("#codigo").val();
        var nombre = $("#nombre").val();
        var examen = $("#examen").val();
        var registro = $("#registro").val();
        var dpi = $("#dpi").val();
        var email = $("#email").val();
        var telefono = $("#telefono").val();
        var fecha = $("#fecha").val();
        var coleccion = "";
        var especial = document.getElementsByName("dias");
        for (let i = 0; i < especial.length; i++) {
            if (especial[i].checked){
                var valor = especial[i].value;
                coleccion += valor+"-"+(i+1)+"/";
            } else {
                if (especial[i].value === '1'){
                    coleccion += "2-"+(i+1)+"/";
                }
            }
        }
        coleccion = coleccion.slice(0, -1);

        console.log(coleccion);
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: {tipo: "LABORATORISTA", codigo: codigo, nombre: nombre, dpi: dpi, examen: examen,
                correo: email, registro:registro, fecha: fecha, telefono: telefono, dias: coleccion},
            beforeSend: function () {
                /*
                 * Esta función se ejecuta durante el envió de la petición al
                 * servidor.
                 * */
                btnEnviar.text("GUARDANDO"); //Para button 
                //btnEnviar.val("Enviando"); // Para input de tipo button
                btnEnviar.attr("disabled", "disabled");
            },
            complete: function (data) {
                /*
                 * Se ejecuta al termino de la petición
                 * */
                btnEnviar.text("GUARDAR CAMBIOS");
                btnEnviar.removeAttr("disabled");
                btnEnviar.hide();
            },
            success: function (data) {
                /*
                 * Se ejecuta cuando termina la petición y esta ha sido
                 * correcta
                 * */
                if (data === 'no') {
                    alert("No fue posible actualizar los datos" + data);
                } else {
                    alert(data);
                    window.location = "Perfil.jsp";
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

function editarMedico(boton) {
    boton.style.display = 'none';
    var elementos = [document.querySelector("#nombre"), document.querySelector("#colegiado"), document.querySelector("#dpi"),
        document.querySelector("#telefono"), document.querySelector("#correo"), document.querySelector("#inicio"), document.querySelector("#final"), document.querySelector("#fechaInicio")];
    var especialidades = document.querySelectorAll("ol")[0];
    var especial = especialidades.querySelectorAll("li");
    for (let i = 0; i < especial.length; i++) {
        var input = especial[i].querySelector("select");
        input.disabled = false;
    }
    $("#guardarCambios").show();
    habilitarCampos(elementos);
}

function editarAdmin(boton) {
    boton.style.display = 'none';
    var nombre = document.getElementById("nombre");
    var dpi = document.getElementById("dpi");
    nombre.disabled = false;
    dpi.disabled = false;
    $("#ingreso").show();
}


function editarLaboratorista(boton) {
    boton.style.display = 'none';
    var elementos = [document.querySelector("#nombre"), document.querySelector("#examen"), document.querySelector("#registro"),
        document.querySelector("#dpi"), document.querySelector("#telefono"), document.querySelector("#fecha"), document.querySelector("#email")];
    var especial = document.getElementsByName("dias");
    for (let i = 0; i < especial.length; i++) {
        especial[i].disabled = false;
    }
    $("#guardarCambios").show();
    habilitarCampos(elementos);
}


function editarPaciente(boton) {
    boton.style.display = 'none';
    var nombre = document.getElementById("nombre");
    var dpi = document.getElementById("dpi");
    var sexo = document.getElementById("sexo");
    var peso = document.getElementById("peso");
    var sangre = document.getElementById("sangre");
    var telefono = document.getElementById("telefono");
    var fecha = document.getElementById("fecha");
    var email = document.getElementById("email");
    var elementos = [nombre, dpi, sexo, peso, sangre, telefono, fecha, email, elementos];
    $("#guardarCambios").show();
    habilitarCampos(elementos);
}

function habilitarCampos(elementos) {
    for (let i = 0; i < elementos.length; i++)
    {
        elementos[i].disabled = false;
    }
}
