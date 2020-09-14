/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function metodo(x, y) {
    if (x === 'willians' && y === '12345') {
        alert("correcto");
    } else {
        alert("credenciales incorrectas");
        $(contraseña).val("");
    }
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

