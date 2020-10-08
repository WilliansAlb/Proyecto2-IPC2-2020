/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.AdministradorDAO;
import Base.Conector;
import Base.DoctorDAO;
import Base.PacienteDAO;
import Base.LaboratoristaDAO;
import Base.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yelbetto
 */
public class Perfil extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Perfil</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Perfil at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession s = request.getSession();
        if (request.getParameter("tipo") != null) {
            if (s.getAttribute("usuario") != null && s.getAttribute("tipo") != null) {
                s.removeAttribute("usuario");
                s.removeAttribute("tipo");
                s.invalidate();
                response.sendRedirect("/Servidor/index.jsp");
            } else {
                response.getWriter().write("Perfil.jsp");
            }
        } else {
            response.sendRedirect("Perfil.jsp");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        Conector cn = new Conector();
        if (tipo != null) {
            if (tipo.equalsIgnoreCase("ADMIN")) {
                if (cn.conectar()) {
                    AdministradorDAO admin = new AdministradorDAO(cn);
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String dpi = request.getParameter("dpi");
                    boolean actualizado = admin.actualizarAdmin(codigo, nombre, dpi);
                    if (actualizado) {
                        response.getWriter().write("Tus datos fueron actualizados exitosamente");
                    } else {
                        response.getWriter().write("no");
                    }
                } else {
                    response.getWriter().write("ERROR: base de datos");
                }
            } else if (tipo.equalsIgnoreCase("PACIENTE")) {
                if (cn.conectar()) {
                    PacienteDAO paciente = new PacienteDAO(cn);
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String dpi = request.getParameter("dpi");
                    String sexo = request.getParameter("sexo");
                    Double peso = Double.parseDouble(request.getParameter("peso"));
                    String sangre = request.getParameter("sangre");
                    String telefono = request.getParameter("telefono");
                    String fecha_nacimiento = request.getParameter("fecha");
                    String email = request.getParameter("email");
                    boolean actualizado = paciente.actualizarPaciente(codigo, nombre, sexo, peso, dpi, sangre, fecha_nacimiento, email, telefono);
                    if (actualizado) {
                        response.getWriter().write("Tus datos fueron actualizados exitosamente");
                    } else {
                        response.getWriter().write("no");
                    }
                } else {
                    response.getWriter().write("ERROR: base de datos");
                }
            } else if (tipo.equalsIgnoreCase("MEDICO")) {
                if (cn.conectar()) {
                    DoctorDAO doctor = new DoctorDAO(cn);
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String dpi = request.getParameter("dpi");
                    String colegiado = request.getParameter("colegiado");
                    String final1 = request.getParameter("final");
                    String final2 = final1 + ":00";
                    String inicio = request.getParameter("inicio");
                    String inicio1 = inicio + ":00";
                    String telefono = request.getParameter("telefono");
                    String fecha = request.getParameter("fecha");
                    String correo = request.getParameter("correo");
                    String especialidades = request.getParameter("especialidades");
                    boolean actualizado = doctor.actualizarDoctor(codigo, nombre, dpi, colegiado, fecha, inicio1 + "-" + final2, telefono, correo);
                    if (actualizado) {
                        boolean isActualizado = doctor.actualizarEspecialidad(codigo, especialidades);
                        if (isActualizado) {
                            response.getWriter().write("Tus datos fueron actualizados exitosamente");
                        } else {
                            response.getWriter().write("SIN INGRESAR ESPECIALIDADES");
                        }
                    } else {
                        response.getWriter().write("no");
                    }
                } else {
                    response.getWriter().write("ERROR: base de datos");
                }
            } else if (tipo.equalsIgnoreCase("LABORATORISTA")) {
                if (cn.conectar()) {
                    LaboratoristaDAO lab = new LaboratoristaDAO(cn);
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String dpi = request.getParameter("dpi");
                    String examen = request.getParameter("examen");
                    String email = request.getParameter("correo");
                    String registro = request.getParameter("registro");
                    String fecha = request.getParameter("fecha");
                    String telefono = request.getParameter("telefono");
                    String dias = request.getParameter("dias");
                    boolean actualizado = lab.actualizarLaboratorista(codigo, nombre, dpi, examen, email, registro, fecha, telefono);
                    if (actualizado) {
                        boolean isActualizado = lab.actualizarTrabajo(codigo, dias);
                        if (isActualizado) {
                            response.getWriter().write("Tus datos fueron actualizados correctamente");
                        } else {
                            response.getWriter().write("SIN INGRESAR ESPECIALIDADES");
                        }
                    } else {
                        response.getWriter().write("no");
                    }
                } else {
                    response.getWriter().write("ERROR: base de datos");
                }
            } else if (tipo.equalsIgnoreCase("PACIENTE NUEVO")) {
                if (cn.conectar()) {
                    response.setContentType("text/plain;charset=UTF-8");
                    PacienteDAO paciente = new PacienteDAO(cn);
                    UsuarioDAO usuario = new UsuarioDAO(cn);
                    String codigo = paciente.obtenerUltimo();
                    int nuevoCodigo = Integer.parseInt(codigo) + 1;
                    String nombre = request.getParameter("nombre");
                    String dpi = request.getParameter("dpi");
                    String sexo = request.getParameter("sexo");
                    Double peso = Double.parseDouble(request.getParameter("peso"));
                    String sangre = request.getParameter("sangre");
                    String telefono = request.getParameter("telefono");
                    String fecha_nacimiento = request.getParameter("fecha");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    if (paciente.ingresarPaciente(nuevoCodigo + "", nombre, sexo, fecha_nacimiento, dpi, telefono, peso, sangre, email)) {
                        if (usuario.ingresarUsuario(nuevoCodigo + "", nuevoCodigo + "", password, "PACIENTE")) {
                            HttpSession s = request.getSession();
                            s.setAttribute("usuario", nuevoCodigo+"");
                            s.setAttribute("tipo", "PACIENTE");
                            response.getWriter().write(nuevoCodigo+"");
                        } else {
                            response.getWriter().write("ERRORBASE");
                        }
                    } else {
                        response.getWriter().write("ERRORBASE");
                    }
                } else {
                    response.getWriter().write("ERROR: base de datos");
                }
            }
        } else {
            response.getWriter().write("SIN DATOS");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
