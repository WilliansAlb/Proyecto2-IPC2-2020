<%-- 
    Document   : PerfilMedico
    Created on : 30/09/2020, 10:42:28 PM
    Author     : yelbetto
--%>
<%@page import="POJO.ExamenDTO"%>
<%@page import="Base.ExamenDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.ConsultaDTO"%>
<%@page import="POJO.EspecialidadDTO"%>
<%@page import="POJO.DoctorDTO"%>
<%@page import="Base.DoctorDAO"%>
<%@page import="Base.Conector"%>
<center>
    <div id="perfil">
        <%
            //Conexion con la base de datos
            Conector cn = new Conector("encender");
            //Metodos que obtienen los datos de la base de datos
            DoctorDAO doc = new DoctorDAO(cn);
            //Metodos que contendr�n los datos requeridos para la pagina
            DoctorDTO doctor = new DoctorDTO();
            EspecialidadDTO esp = new EspecialidadDTO();
            ConsultaDTO[] consultas = new ConsultaDTO[1];
            ArrayList<ConsultaDTO> todasLasConsultas = new ArrayList<>();
            //HttpSession que verificar� que el usuario que entre ac� sea un Medico
            HttpSession s2 = request.getSession();
            boolean entra = false;
            if (s2.getAttribute("usuario") != null && s2.getAttribute("tipo") != null) {
                if (s2.getAttribute("tipo").toString().equalsIgnoreCase("DOCTOR")) {
                    if (s2.getAttribute("entrada") != null) {
                        String codigoDoctor = s2.getAttribute("usuario").toString();
                        doctor = doc.obtenerMedico(codigoDoctor);
                        esp = doc.obtenerEspecialidades(codigoDoctor);
                        consultas = esp.getConsulta();
                        todasLasConsultas = doc.obtenerConsultas();
                        entra = true;
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
        <%if (entra) {%>
        <center>
            <h2>Tu perfil</h2>
            <form id="formularioMedico" action="../Perfil" method="POST">
                <div class="contenedor">
                    <center>
                        <div class="item">
                            <label for="codigo">CODIGO: </label>
                            <input type="text" id="codigo" value="<%out.print(doctor.getCodigo());%>" disabled>
                        </div>
                        <div class="item">
                            <label for="nombre">NOMBRE: </label>
                            <input type="text" id="nombre" value="<%out.print(doctor.getNombre());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="colegiado">COLEGIADO: </label>
                            <input type="number" id="colegiado" value="<%out.print(doctor.getNo_colegiado());%>" step="1" required disabled>
                        </div>
                        <div class="item">
                            <label for="dpi">DPI: </label>
                            <input type="number" id="dpi" value="<%out.print(doctor.getDpi());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="telefono">TELEFONO: </label>
                            <input type="number" id="telefono" value="<%out.print(doctor.getTelefono());%>" disabled required>
                        </div>
                        <div class="item">
                            <label for="especialidades">ESPECIALIDADES: </label>
                            <ol>
                                <%for (int i = 0; i < consultas.length; i++) {%>
                                <li><select class="especialidades" name="<%out.print(consultas[i].getCodigoEspecialidad());%>" id="opcionEspecialidad<%out.print(i);%>" disabled>
                                        <%for (int o = 0; o < todasLasConsultas.size(); o++) {
                                                if (consultas[i].getCodigo() == todasLasConsultas.get(o).getCodigo()) {
                                        %>
                                        <option value="<%out.print(todasLasConsultas.get(o).getCodigo());%>" selected><%out.print(todasLasConsultas.get(o).getNombre());%></option>
                                        <%} else {%>
                                        <option value="<%out.print(todasLasConsultas.get(o).getCodigo());%>"><%out.print(todasLasConsultas.get(o).getNombre());%></option>
                                        <%}
                                            }%>
                                    </select></li>
                                    <%}%>
                            </ol>
                        </div>
                        <div class="item">
                            <label for="correo">CORREO: </label>
                            <input type="text" id="correo" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" value="<%out.print(doctor.getEmail());%>" required disabled>
                        </div>
                        <div class="item">
                            <label for="correo">HORARIO(formato 24hrs): </label>
                            <ul id="horario">
                                <li>INICIO<input type="number" id="inicio" value="<%out.print(doctor.getHorario()[0]);%>" step="1" min="0" max="23" required disabled></li>
                                <li>FINAL <input type="number" id="final" value="<%out.print(doctor.getHorario()[1]);%>" step="1" min="0" max="23" required disabled></li>
                            </ul>
                        </div>
                        <div class="item">
                            <label for="fecha">FECHA INICIO: </label>
                            <input type="date" id="fechaInicio" value="<%out.print(doctor.getFecha_inicio());%>" required disabled>
                        </div>
                    </center>
                </div>
                <button id="guardarCambios" style="display:none;">EDITAR INFORMACION</button>
            </form>
            <button onclick="editarMedico(this)">EDITAR INFORMACION</button>
        </center>
        <%}%>
    </div>
</center>
