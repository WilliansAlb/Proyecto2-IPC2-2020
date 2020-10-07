<%-- 
    Document   : PerfilAdmin
    Created on : 1/10/2020, 12:37:58 AM
    Author     : yelbetto
--%>

<%@page import="POJO.AdministradorDTO"%>
<%@page import="Base.AdministradorDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //Clase que conecta con la base de datos
    Conector cn = new Conector("encender");
    //Clase que obtiene los datos de la base de datos
    AdministradorDAO admin = new AdministradorDAO(cn);
    //Contenedor de los datos del administrador
    AdministradorDTO administrador = new AdministradorDTO();
    //HttpSession que verifica que sea un usuario de tipo administrador quien esté en la página
    HttpSession s2 = request.getSession();
    if (s2.getAttribute("usuario") != null && s2.getAttribute("tipo") != null) {
        if (s2.getAttribute("tipo").toString().equalsIgnoreCase("ADMIN")) {
            if (s2.getAttribute("entrada") != null) {
                String codigoAdmin = s2.getAttribute("usuario").toString();
                administrador = admin.obtenerAdmin(codigoAdmin);
                s2.setAttribute("entrada", null);
%>
<center>
    <div id="perfil">
        <center>
            <h2>Tu perfil</h2>
            <form id="formularioAdmin" action="../Perfil" method="POST">
                <div class="contenedor">
                    <center>
                        <div class="item">
                            <label for="codigo">CODIGO: </label>
                            <input type="text" id="codigo" value="<%out.print(administrador.getCodigo());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="nombre">NOMBRE: </label>
                            <input type="text" id="nombre" value="<%out.print(administrador.getNombre());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="dpi">DPI: </label>
                            <input type="number" id="dpi" value="<%out.print(administrador.getDpi());%>" step="1" disabled required>
                        </div>
                    </center>
                </div>
                <button style="display:none;" id="ingreso">GUARDAR CAMBIOS</button>
            </form>
            <button onclick="editarAdmin(this)" id="editarAdmin">EDITAR INFORMACION</button>
        </center>
    </div>
</center>
<%
            } else {
                response.sendRedirect("Perfil.jsp");
            }
        } else {
            response.sendRedirect("Perfil.jsp");
        }
    } else {
        response.sendRedirect("/Servidor/index.jsp");
    }
%>

