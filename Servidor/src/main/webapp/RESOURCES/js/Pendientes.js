/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function mostrar(boton) {
    $('#des').val(boton.value);
    var name = boton.name;
    var td = boton.parentNode;
    var tabla = td.parentNode;
    var nombre = tabla.getElementsByTagName("td")[0];
    var cono = "";
    if (name === 'orden') {
        document.getElementById("archivo1").src = "../ControladorPDF?solicitadoPDF=" + boton.value;
    } else {
        document.getElementById("archivo1").src = "../ControladorIMG?solicitadoIMG=" + boton.value;
    }
    cono = "ORDEN " + nombre.textContent;
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

function mostrar2(boton) {
    $('#des').val(boton.value);
    var td = boton.parentNode;
    var tabla = td.parentNode;
    var codigo = tabla.getElementsByTagName("td")[0];
    var nombre = tabla.getElementsByTagName("td")[1];
    var co = codigo.textContent;
    var cono = "";
    cono = co + " REALIZADO POR " + nombre.textContent;
    document.getElementById('nombreC').innerText = cono;
    $("#descripcion").css("position","fixed");
    $('#descripcion').fadeIn(1000);
}
