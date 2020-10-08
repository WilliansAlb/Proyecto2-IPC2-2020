/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function buscarPaciente(paciente) {
    var pacienteMayusculas = paciente.toUpperCase();
    if (paciente.length > 0) {
        var pacientes = document.getElementsByClassName("nombresPacientes");
        var numeros = [];
        for (let i = 0; i < pacientes.length; i++) {
            var pacienteActual = pacientes[i].textContent.toUpperCase();
            if (pacienteActual.includes(pacienteMayusculas)) {
                numeros.push(i);
            }
        }
        var filasPacientes = document.getElementsByClassName("filasPacientes");
        if (numeros.length > 0) {
            for (let i = 0; i < filasPacientes.length; i++) {
                if (numeros.includes(i)) {
                    filasPacientes[i].style.display = "";
                } else {
                    filasPacientes[i].style.display = "none";
                }
            }
        } else {
            for (let i = 0; i < filasPacientes.length; i++) {
                filasPacientes[i].style.display = "";
            }
            $('#myPopup1').text("No existe paciente con ese nombre");
            $('#myPopup1').fadeIn(1000);
            $('#myPopup1').fadeOut(3000);
        }
    } else {
        $('#myPopup1').text("Rellena el campo requerido");
        $('#myPopup1').fadeIn(1000);
        $('#myPopup1').fadeOut(3000);
    }
}

