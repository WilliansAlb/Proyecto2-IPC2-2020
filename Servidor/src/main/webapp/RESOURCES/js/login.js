/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function metodo(x, y) {
    if (x!=='' && y!==''){
        $.ajax({
        type: 'GET',
        data: {usuario: x, password: y},
        url: 'Login',
        success: function (result) {
            if (result==='mal'){
                $('#password').val("");
                alert('Credenciales incorrectas');
            } else if (result==='fallo conexion') {
                $('#password').val("");
                alert("ERROR: fallo al conectar con la base de datos");
            } else if (result === 'bien'){
                alert("bien");
                window.location = "JSP/Carga.jsp";
            }
        }
    });
    } else {
        if (x===''){
            $('#usuario').focus();
            var popup = document.getElementById("myPopup");
            $('#myPopup').fadeIn(1000);
            $('#myPopup').fadeOut(3000);
        } else {
            $('#password').focus();
            var popup = document.getElementById("myPopup1");
            $('#myPopup1').fadeIn(1000);
            $('#myPopup1').fadeOut(3000);
        }
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

