/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.Conector;
import Base.ConsultaDAO;
import Base.DoctorDAO;
import Base.ExamenDAO;
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
public class Admin extends HttpServlet {

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
            out.println("<title>Servlet Admin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Admin at " + request.getContextPath() + "</h1>");
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
        if (request.getParameter("tipo") != null) {
            String tipo = request.getParameter("tipo");
            Conector cn = new Conector();
            if (tipo.equalsIgnoreCase("INGRESO EXAMEN")) {
                if (cn.conectar()) {
                    ExamenDAO examen = new ExamenDAO(cn);
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    Double costo = Double.parseDouble(request.getParameter("costo"));
                    String descripcion = request.getParameter("descripcion");
                    String informe = request.getParameter("informe");
                    boolean orden = request.getParameter("orden").equalsIgnoreCase("1");
                    String nuevo = request.getParameter("nuevo");
                    if (nuevo.equalsIgnoreCase("true")) {
                        if (examen.actualizarExamen(codigo, nombre, descripcion, costo, orden, informe)) {
                            response.getWriter().write("Actualizado correctamente");
                        } else {
                            response.getWriter().write("ERRORBASE");
                        }
                    } else {
                        if (!examen.isExistente(codigo)) {
                            if (examen.ingresarExamen(codigo, nombre, descripcion, costo, orden, informe)) {
                                response.getWriter().write("Ingresado correctamente");
                            } else {
                                response.getWriter().write("ERRORBASE");
                            }
                        } else {
                            response.getWriter().write("EXISTE");
                        }
                    }
                }
            } else if (tipo.equalsIgnoreCase("INGRESO CONSULTA")) {
                if (cn.conectar()) {
                    ConsultaDAO consulta = new ConsultaDAO(cn);
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    Double costo = Double.parseDouble(request.getParameter("costo"));
                    boolean nuevo = request.getParameter("nuevo").equalsIgnoreCase("1");
                    if (nuevo) {
                        boolean ingresado = consulta.ingresarConsulta(nombre, costo);
                        if (ingresado) {
                            response.getWriter().write("Ingresada correctamente");
                        } else {
                            response.getWriter().write("ERRORBASE");
                        }
                    } else {
                        boolean ingresado = consulta.actualizarConsulta(Integer.parseInt(codigo), nombre, costo);
                        if (ingresado) {
                            response.getWriter().write("Actualizada correctamente");
                        } else {
                            response.getWriter().write("ERRORBASE");
                        }
                    }
                } else {
                    response.getWriter().write("ERRORBASE");
                }
            } else if (tipo.equalsIgnoreCase("INGRESO LABORATORISTA")) {
                if (cn.conectar()) {
                    LaboratoristaDAO lab = new LaboratoristaDAO(cn);
                    String codigo = request.getParameter("codigo");
                    String nombre = request.getParameter("nombre");
                    String registro = request.getParameter("registro");
                    String dpi = request.getParameter("dpi");
                    String telefono = request.getParameter("telefono");
                    String dias = request.getParameter("dias");
                    String fecha = request.getParameter("fecha");
                    String email = request.getParameter("email");
                    String examen = request.getParameter("examen");
                    String nuevo = request.getParameter("nuevo");
                    if (nuevo.equalsIgnoreCase("true")) {
                        if (lab.actualizarLaboratorista(codigo, nombre, dpi, examen, email, registro, fecha, telefono)) {
                            boolean isActualizado = lab.actualizarTrabajo(codigo, dias);
                            if (isActualizado) {
                                response.getWriter().write("ACTUALIZADO LABORATORISTA " + codigo);
                            } else {
                                response.getWriter().write("SIN INGRESAR ESPECIALIDADES");
                            }
                        } else {
                            response.getWriter().write("ERRORBASE");
                        }
                    } else {
                        if (!lab.isExistente(codigo)) {
                            if (lab.ingresarLaboratorista(codigo, examen, nombre, dpi, registro, email, fecha, telefono)) {
                                boolean isActualizado = lab.actualizarTrabajo(codigo, dias);
                                if (isActualizado) {
                                    response.getWriter().write("ACTUALIZADO LABORATORISTA " + codigo);
                                } else {
                                    response.getWriter().write("SIN INGRESAR ESPECIALIDADES");
                                }
                            } else {
                                response.getWriter().write("ERRORBASE");
                            }
                        } else {
                            response.getWriter().write("EXISTE");
                        }
                    }
                } else {
                    response.getWriter().write("ERRORBASE");
                }
            } else if (tipo.equalsIgnoreCase("INGRESO MEDICO")) {
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
                    String nuevos = request.getParameter("nuevos");
                    String cambios = request.getParameter("cambios");
                    boolean nuevo = request.getParameter("nuevo").equalsIgnoreCase("true");
                    if (nuevo) {
                        if (doctor.actualizarDoctor(codigo, nombre, dpi, colegiado, fecha, inicio1 + "-" + final2, telefono, correo)) {
                            if (!cambios.isEmpty()) {
                                boolean isActualizado = doctor.actualizarEspecialidadSegunCodigo(codigo, cambios);
                            }
                            if (!nuevos.isEmpty()) {
                                boolean isNuevo = doctor.descomponerEIngresar(codigo, nuevos);
                            }
                            response.getWriter().write("ACTUALIZADO CORRECTAMENTE");
                        } else {
                            response.getWriter().write("ERRORBASE");
                        }
                    } else {
                        if (!doctor.isExistente(codigo)) {
                            if (doctor.ingresarDoctor(codigo, nombre, dpi, colegiado, inicio1 + "-" + final2, correo, fecha, telefono)) {
                                if (!nuevos.isEmpty()) {
                                    boolean isNuevo = doctor.descomponerEIngresar(codigo, nuevos);
                                    response.getWriter().write("INGRESADO CORRECTAMENTE");
                                } else {
                                    response.getWriter().write("INGRESADO PERO SIN ESPECIALIDADES");
                                }
                            } else {
                                response.getWriter().write("ERRORBASE");
                            }
                        } else {
                            response.getWriter().write("EXISTE");
                        }
                    }
                } else {
                    response.getWriter().write("ERROR: base de datos");
                }
            }
        } else {
            response.getWriter().write("NO SE ENVIO CORRECTAMENTE");
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
