<%-- 
    Document   : PerfilLaboratorista
    Created on : 1/10/2020, 12:38:19 AM
    Author     : yelbetto
--%>


<%@page import="POJO.PacienteDTO"%>
<%@page import="Base.PacienteDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<center>
    <div id="perfil">
        <%
            Conector cn = new Conector("encender");
            PacienteDAO pa = new PacienteDAO(cn);
            PacienteDTO paciente = pa.obtenerPaciente("118258");
        %>
        <form>
            <center>
                <h2>Tu perfil</h2>
                <div class="contenedor">
                    <center>
                        <div class="item">
                            <label for="codigo">CODIGO: </label>
                            <input type="text" id="codigo" value="" disabled required>
                        </div>
                        <div class="item">
                            <label for="nombre">NOMBRE: </label>
                            <input type="text" id="nombre" value="" disabled required>
                        </div>
                        <div class="item">
                            <label for="examen">EXAMEN: </label>
                            <select name="examen" id="examen" required disabled>
                                <option value=""></option>
                            </select>
                        </div>
                        <div class="item">
                            <label for="registro">REGISTRO: </label>
                            <input type="number" name="registro" id="registro" value="" step="1" min="1" required disabled>
                        </div>
                        <div class="item">
                            <label for="dpi">DPI: </label>
                            <input type="number" name="dpi" id="dpi" value="" step="1" min="1" required disabled>
                        </div>
                        <div class="item">
                            <label for="telefono">TELEFONO: </label>
                            <input type="number" name="telefono" id="telefono" value="" step="1" min="1" required disabled>
                        </div>
                        <div class="item">
                            <label for="fecha">FECHA NACIMIENTO: </label>
                            <input type="date" name="fecha" id="fecha" value="" required disabled>
                        </div>
                        <div class="item">
                            <label for="email">EMAIL: </label>
                            <input type="text"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" value="" name="email" id="email" required disabled>
                        </div>
                    </center>
                </div>
                <button id="guardarCambios" style="display:none;">GUARDAR CAMBIOS</button>
            </center>
        </form>
        <button>EDITAR INFORMACION</button>
    </div>
</center>
