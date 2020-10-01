<%-- 
    Document   : PerfilAdmin
    Created on : 1/10/2020, 12:37:58 AM
    Author     : yelbetto
--%>

<%@page import="POJO.AdministradorDTO"%>
<%@page import="Base.AdministradorDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<center>
    <div id="perfil">
        <%
            Conector cn = new Conector("encender");
            AdministradorDAO admin = new AdministradorDAO(cn);
            AdministradorDTO administrador = admin.obtenerAdmin("ADMIN1");
        %>
        <center>
            <h2>Tu perfil</h2>
            <div class="contenedor">
                <center>
                    <div class="item">
                        <label for="codigo">CODIGO: </label>
                        <input type="text" id="codigo" value="<%out.print(administrador.getCodigo());%>" disabled>
                    </div>
                    <div class="item">
                        <label for="nombre">NOMBRE: </label>
                        <input type="text" id="nombre" value="<%out.print(administrador.getNombre());%>" disabled>
                    </div>
                    <div class="item">
                        <label for="dpi">DPI: </label>
                        <input type="number" id="dpi" value="<%out.print(administrador.getDpi());%>" step="1" disabled>
                    </div>
                </center>
            </div>
            <button onclick="editar()">EDITAR INFORMACION</button>
        </center>
    </div>
</center>
