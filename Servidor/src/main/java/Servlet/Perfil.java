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
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        processRequest(request, response);
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
                        response.getWriter().write("Actualizado datos de Administrador " + codigo);
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
                        response.getWriter().write("Actualizado datos de Administrador " + codigo);
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
                            response.getWriter().write("ACTUALIZADO DOCTOR " + codigo);
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
                    boolean actualizado = lab.actualizarLaboratorista(codigo,nombre,dpi,examen,email,registro,fecha,telefono);
                    if (actualizado) {
                        System.out.println(dias);
                        boolean isActualizado = lab.actualizarTrabajo(codigo, dias);
                        if (isActualizado) {
                            response.getWriter().write("ACTUALIZADO LABORATORISTA " + codigo);
                        } else {
                            response.getWriter().write("SIN INGRESAR ESPECIALIDADES");
                        }
                    } else {
                        response.getWriter().write("no");
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
