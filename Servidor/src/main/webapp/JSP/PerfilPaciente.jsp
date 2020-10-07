<%-- 
    Document   : PerfilPaciente
    Created on : 1/10/2020, 12:37:41 AM
    Author     : yelbetto
--%>

<%@page import="POJO.PacienteDTO"%>
<%@page import="Base.PacienteDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    //Conexion con la base de datos
    Conector cn = new Conector("encender");
    //Clase que obtiene los datos del paciente
    PacienteDAO pa = new PacienteDAO(cn);
    //Contenedor de los datos del paciente
    PacienteDTO paciente = new PacienteDTO();
    //Variable HttpSession que verifica que el usuario sea un paciente
    HttpSession s2 = request.getSession();
    if (s2.getAttribute("usuario") != null && s2.getAttribute("tipo") != null) {
        if (s2.getAttribute("tipo").toString().equalsIgnoreCase("PACIENTE")) {
            if (s2.getAttribute("entrada") != null) {
                String codigoPaciente = s2.getAttribute("usuario").toString();
                paciente = pa.obtenerPaciente(codigoPaciente);
                s2.setAttribute("entrada", null);
%>
<center>
    <div id="perfil">
        <center>
            <h2>Tu perfil</h2>
            <form id="formularioPaciente" method="POST" action="../Perfil">
                <div class="contenedor">
                    <center>
                        <div class="item">
                            <label for="codigo">CODIGO: </label>
                            <input type="text" id="codigo" value="<%out.print(paciente.getCodigo());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="nombre">NOMBRE: </label>
                            <input type="text" id="nombre" value="<%out.print(paciente.getNombre());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="sexo">SEXO: </label>
                            <select name="sexo" id="sexo" required disabled>
                                <%if (paciente.getSexo().equalsIgnoreCase("hombre")) {%>
                                <option value="<%out.print(paciente.getSexo());%>" selected><%out.print(paciente.getSexo().toUpperCase());%></option>
                                <option value="Mujer">MUJER</option>
                                <%} else {%>
                                <option value="<%out.print(paciente.getSexo());%>" selected><%out.print(paciente.getSexo().toUpperCase());%></option>
                                <option value="Hombre">HOMBRE</option>
                                <%}%>
                            </select>
                        </div>
                        <div class="item">
                            <label for="peso">PESO: </label>
                            <input type="number" name="peso" id="peso" value="<%out.print(paciente.getPeso());%>" step="0.01" min="0.01" required disabled>
                        </div>
                        <div class="item">
                            <label for="sangre">SANGRE: </label>
                            <input type="text" id="sangre" value="<%out.print(paciente.getSangre());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="dpi">DPI: </label>
                            <input type="number" name="dpi" id="dpi" value="<%out.print(paciente.getDpi());%>" step="1" min="1" required disabled>
                        </div>
                        <div class="item">
                            <label for="telefono">TELEFONO: </label>
                            <input type="number" name="telefono" id="telefono" value="<%out.print(paciente.getTelefono());%>" step="1" min="1" required disabled>
                        </div>
                        <div class="item">
                            <label for="fecha">FECHA NACIMIENTO: </label>
                            <input type="date" name="fecha" id="fecha" value="<%out.print(paciente.getFecha_nacimiento());%>" required disabled>
                        </div>
                        <div class="item">
                            <label for="email">EMAIL: </label>
                            <input type="text"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" value="<%out.print(paciente.getEmail());%>" name="email" id="email" required disabled>
                        </div>
                    </center>
                </div>
                <button id="guardarCambios" style="display:none;">GUARDAR CAMBIOS</button>
            </form>
        </center>
        <button onclick="editarPaciente(this)">EDITAR INFORMACION</button>
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

