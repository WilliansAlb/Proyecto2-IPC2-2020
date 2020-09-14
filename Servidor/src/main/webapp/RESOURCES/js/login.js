/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function metodo(x, y) {
    var re = $(recordar).prop('checked');
    alert(re);
    $.ajax({
        type: 'GET',
        data: {usuario: x, contraseña: y},
        url: 'Login',
        success: function (result) {
            if (result=='mal'){
                $(contraseña).val("");
                $(contraseña).css('border-bottom','2px solid red');
                alert('Credenciales incorrectas');
            } else if (result=='fallo conexion') {
                $(contraseña).val("");
                alert("ERROR: fallo al conectar con la base de datos");
            }
        }
    });
}

function comprobar() {
    dejarDeEscribir();
}

let timeout;
function dejarDeEscribir() {
    clearTimeout(timeout)
    timeout = setTimeout(() => {
        var usuario1 = $(usuario).val();
        var contraseña1 = $(contraseña).val();
        var deshabilitar = usuario1.length == 0 || contraseña1.length == 0;
        $(ingresar).prop('disabled', deshabilitar);
        console.log("dejo de escribir");
        clearTimeout(timeout)
    }, 800)
}

