<%-- 
    Document   : PerfilLaboratorista
    Created on : 1/10/2020, 12:38:19 AM
    Author     : yelbetto
--%>


<%@page import="POJO.TrabajoDTO"%>
<%@page import="POJO.ExamenDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Base.ExamenDAO"%>
<%@page import="POJO.LaboratoristaDTO"%>
<%@page import="Base.LaboratoristaDAO"%>
<%@page import="POJO.PacienteDTO"%>
<%@page import="Base.PacienteDAO"%>
<%@page import="Base.Conector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<center>
    <div id="perfil">
        <%
            Conector cn = new Conector("encender");
            LaboratoristaDAO pa = new LaboratoristaDAO(cn);
            ExamenDAO examen = new ExamenDAO(cn);
            ArrayList<ExamenDTO> examenes = examen.obtenerExamenes();
            String[] semana = {"Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"};
            LaboratoristaDTO laboratorista = pa.obtenerLaboratorista("LAB-123");
            ArrayList<TrabajoDTO> trabajos = laboratorista.getTrabajos();
        %>
        <form id="formularioLaboratorista" method="POST" action="../Perfil">
            <center>
                <h2>Tu perfil</h2>
                <div class="contenedor">
                    <center>
                        <div class="item">
                            <label for="codigo">CODIGO: </label>
                            <input type="text" id="codigo" value="<%out.print(laboratorista.getCodigo());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="nombre">NOMBRE: </label>
                            <input type="text" id="nombre" value="<%out.print(laboratorista.getNombre());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="examen">EXAMEN: </label>
                            <select name="examen" id="examen" required disabled>
                                <%for (int i = 0; i < examenes.size(); i++) {%>
                                <%if (examenes.get(i).getCodigo().equalsIgnoreCase(laboratorista.getExamen())) {%>
                                <option value="<%out.print(examenes.get(i).getCodigo());%>" selected><%out.print(examenes.get(i).getNombre());%></option>
                                <%} else {%>
                                <option value="<%out.print(examenes.get(i).getCodigo());%>"><%out.print(examenes.get(i).getNombre());%></option>
                                <%}
                                    }%>
                            </select>
                        </div>
                        <div class="item">
                            <label for="registro">REGISTRO: </label>
                            <input type="text" name="registro" id="registro" value="<%out.print(laboratorista.getNo_registro());%>" required disabled>
                        </div>
                        <div class="item">
                            <label for="dpi">DPI: </label>
                            <input type="number" name="dpi" id="dpi" value="<%out.print(laboratorista.getDpi());%>" step="1" min="1" required disabled>
                        </div>
                        <div class="item">
                            <label for="telefono">TELEFONO: </label>
                            <input type="number" name="telefono" id="telefono" value="<%out.print(laboratorista.getTelefono());%>" step="1" min="1" required disabled>
                        </div>
                        <div class="item">
                            <label>DIAS DE TRABAJO: </label>
                            <%for(int i = 0; i < semana.length; i++){
                                boolean existe = false;%>
                            <%for(int u = 0; u < trabajos.size(); u++){
                                if ((i+1) == trabajos.get(u).getDia()){
                                    existe = true;
                                }
                            }
                            %>
                            <%if(existe){%>
                            <div>
                            <input type="checkbox" class="trabajos" id="<%out.print(semana[i]);%>" name="dias" value="1" disabled checked><label for="<%out.print(semana[i]);%>" class="dias"><%out.print(semana[i]);%></label>
                            </div>
                            <%} else {%>
                            <div>
                            <input type="checkbox" class="trabajos" id="<%out.print(semana[i]);%>" name="dias" value="0" disabled><label for="<%out.print(semana[i]);%>" class="dias"><%out.print(semana[i]);%></label>
                            </div>
                            <%}%>
                            <%}%>
                            
                        </div>
                        <div class="item">
                            <label for="fecha">FECHA NACIMIENTO: </label>
                            <input type="date" name="fecha" id="fecha" value="<%out.print(laboratorista.getFecha());%>" required disabled>
                        </div>
                        <div class="item">
                            <label for="email">EMAIL: </label>
                            <input type="text"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" value="<%out.print(laboratorista.getEmail());%>" name="email" id="email" required disabled>
                        </div>
                    </center>
                </div>
                <button id="guardarCambios" style="display:none;">GUARDAR CAMBIOS</button>
            </center>
        </form>
        <button id="editarLaboratorista" onclick="editarLaboratorista(this);">EDITAR INFORMACION</button>
    </div>
</center>
