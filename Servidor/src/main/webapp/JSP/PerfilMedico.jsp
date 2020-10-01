<%-- 
    Document   : PerfilMedico
    Created on : 30/09/2020, 10:42:28 PM
    Author     : yelbetto
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.ConsultaDTO"%>
<%@page import="POJO.EspecialidadDTO"%>
<%@page import="POJO.DoctorDTO"%>
<%@page import="Base.DoctorDAO"%>
<%@page import="Base.Conector"%>
<center>
    <div id="perfil">
        <%
            Conector cn = new Conector("encender");
            DoctorDAO doc = new DoctorDAO(cn);
            DoctorDTO doctor = new DoctorDTO();
            doctor = doc.obtenerMedico("MED-123");
            EspecialidadDTO esp = new EspecialidadDTO();
            ConsultaDTO consulta = new ConsultaDTO();
            esp = doc.obtenerEspecialidades("MED-123");
            ConsultaDTO[] consultas = esp.getConsulta();
            ArrayList<ConsultaDTO> todasLasConsultas = doc.obtenerConsultas();
        %>
        <center>
            <h2>Tu perfil</h2>
            <div class="contenedor">
                <center>
                    <div class="item">
                        <label for="codigo">CODIGO: </label>
                        <input type="text" id="codigo" value="<%out.print(doctor.getCodigo());%>" disabled>
                    </div>
                    <div class="item">
                        <label for="nombre">NOMBRE: </label>
                        <input type="text" id="nombre" value="<%out.print(doctor.getNombre());%>" disabled>
                    </div>
                    <div class="item">
                        <label for="colegiado">COLEGIADO: </label>
                        <input type="number" id="colegiado" value="<%out.print(doctor.getNo_colegiado());%>" step="1" disabled>
                    </div>
                    <div class="item">
                        <label for="dpi">DPI: </label>
                        <input type="number" id="dpi" value="<%out.print(doctor.getDpi());%>" disabled>
                    </div>
                    <div class="item">
                        <label for="telefono">TELEFONO: </label>
                        <input type="number" id="telefono" value="<%out.print(doctor.getTelefono());%>" disabled>
                    </div>
                    <div class="item">
                        <label for="especialidades">ESPECIALIDADES: </label>
                        <ul id="especialidades">
                            <%for (int i = 0; i < consultas.length; i++) {%>
                            <li><input type="text" list="consultas" value="<%out.print(consultas[i].getNombre());%>"></li>
                                <%}%>
                        </ul>
                    </div>
                    <datalist id="consultas">
                        <%for (int i = 0; i < todasLasConsultas.size(); i++){%>
                        <option value="<%out.print(todasLasConsultas.get(i).getNombre());%>">
                        <%}%>
                    </datalist>
                    <div class="item">
                        <label for="correo">CORREO: </label>
                        <input type="text" id="correo" value="<%out.print(doctor.getEmail());%>" disabled>
                    </div>
                    <div class="item">
                        <label for="correo">HORARIO: </label>
                        <ul id="horario">
                            <li>INICIO<input type="number" value="<%out.print(doctor.getHorario()[0]);%>" step="1" min="0" max="23"></li>
                            <li>FINAL <input type="number" value="<%out.print(doctor.getHorario()[1]);%>" step="1" min="0" max="23"></li>
                        </ul>
                    </div>
                    <div class="item">
                        <label for="fecha">FECHA INICIO: </label>
                        <input type="date" id="fechaInicio" value="<%out.print(doctor.getFecha_inicio());%>">
                    </div>
                </center>
            </div>
            <button onclick="editar()">EDITAR INFORMACION</button>
        </center>
    </div>
</center>
