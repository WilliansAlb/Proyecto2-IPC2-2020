/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.Conector;
import Base.DoctorDAO;
import Base.LaboratoristaDAO;
import Base.PacienteDAO;
import Base.ResultadoDAO;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yelbetto
 */
public class Paciente extends HttpServlet {

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
            out.println("<title>Servlet Paciente</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Paciente at " + request.getContextPath() + "</h1>");
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
        String tipo = request.getParameter("tipo");
        Conector cn = new Conector();
        if (tipo != null) {
            if (tipo.equalsIgnoreCase("1")) {
                response.setContentType("text/plain;charset=UTF-8");
                if (cn.conectar()) {
                    String fecha = request.getParameter("fecha");
                    String laboratorista = request.getParameter("laboratorista");
                    LaboratoristaDAO lab = new LaboratoristaDAO(cn);
                    String la = lab.obtenerHorariosLimite(laboratorista, fecha);
                    response.getWriter().write(la + "/");
                } else {
                    response.getWriter().write("FALLO");
                }
            } else if (tipo.equalsIgnoreCase("2")) {
                response.setContentType("text/plain;charset=UTF-8");
                if (cn.conectar()) {
                    String fecha = request.getParameter("fecha");
                    String laboratorista = request.getParameter("laboratorista");
                    LaboratoristaDAO lab = new LaboratoristaDAO(cn);
                    if (lab.obtenerHorariosDia(laboratorista, fecha)) {
                        response.getWriter().write("TRUE");
                    } else {
                        response.getWriter().write("FALSE");
                    }
                } else {
                    response.getWriter().write("FALLO");
                }
            } else if (tipo.equalsIgnoreCase("3")) {
                response.setContentType("text/plain;charset=UTF-8");
                if (cn.conectar()) {
                    DoctorDAO doctor = new DoctorDAO(cn);
                    String codigo = request.getParameter("codigo");
                    if (doctor.isExistente(codigo)) {
                        response.getWriter().write("true");
                    } else {
                        response.getWriter().write("false");
                    }
                } else {
                    response.getWriter().write("FALLO");
                }
            } else if (tipo.equalsIgnoreCase("4")) {
                response.setContentType("text/plain;charset=UTF-8");
                if (cn.conectar()) {
                    DoctorDAO doctor = new DoctorDAO(cn);
                    PacienteDAO paciente = new PacienteDAO(cn);
                    String codigo = request.getParameter("codigo");
                    if (doctor.isExistente(codigo) || paciente.isExistente(codigo)) {
                        response.getWriter().write("true");
                    } else {
                        response.getWriter().write("false");
                    }
                } else {
                    response.getWriter().write("FALLO");
                }
            }
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
        HttpSession s = request.getSession();
        Conector cn = new Conector();
        if (tipo != null) {
            if (tipo.equalsIgnoreCase("INGRESO EXAMEN")) {
                if (cn.conectar()) {
                    response.setContentType("text/plain;charset=UTF-8");
                    ResultadoDAO re = new ResultadoDAO(cn);
                    String paciente = "";
                    if (s.getAttribute("usuario") != null && s.getAttribute("tipo").toString().equalsIgnoreCase("PACIENTE")) {
                        paciente = s.getAttribute("usuario").toString();
                    } else {
                        paciente = "118258";
                    }
                    String laboratorista = request.getParameter("laboratorista");
                    String examen = request.getParameter("examen");
                    String orden = request.getParameter("orden");
                    String fecha = request.getParameter("fecha");
                    String horaConPuntos = request.getParameter("hora");
                    int hora = Integer.parseInt(horaConPuntos);
                    String medico = request.getParameter("medico");
                    if (medico.isEmpty()){
                        medico = null;
                    }
                    String archivo = request.getParameter("archivo");
                    InputStream archivoOrden = null;
                    InputStream archivoInforme = null;
                    if (orden.equalsIgnoreCase("true")) {
                        byte[] decoder
                                = Base64.getDecoder().decode(archivo);
                        archivoOrden = new ByteArrayInputStream(decoder);
                    }
                    int newCodigo = Integer.parseInt(re.obtenerUltimo()) + 1;
                    String nuevoCodigo = newCodigo+"";
                    if (re.ingresarResultadoSinRealizar(nuevoCodigo, paciente, laboratorista, examen, archivoOrden, archivoInforme, fecha, hora, medico)) {
                        response.getWriter().write(nuevoCodigo);
                    } else {
                        response.getWriter().write("ERRORBASE");
                    }
                } else {
                    response.getWriter().write("ERRORBASE");
                }
            } else {
                response.getWriter().write("ERRORBASE");
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
