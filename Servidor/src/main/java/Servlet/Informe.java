/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.CitaDAO;
import Base.Conector;
import Base.ConsultaDAO;
import Base.PacienteDAO;
import Base.ReporteDAO;
import Base.ResultadoDAO;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
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
public class Informe extends HttpServlet {

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
            out.println("<title>Servlet Informe</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Informe at " + request.getContextPath() + "</h1>");
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
            Conector cn = new Conector();
            String tipo = request.getParameter("tipo");
            if (tipo.equalsIgnoreCase("OBTENER OCUPADO")) {
                response.setContentType("text/plain;charset=UTF-8");
                String fecha = request.getParameter("fecha");
                String codigoMedico = "";
                if (s.getAttribute("usuario") != null && s.getAttribute("tipo").toString().equalsIgnoreCase("DOCTOR")) {
                    codigoMedico = s.getAttribute("usuario").toString();
                } else {
                    codigoMedico = "MED-123";
                }
                if (cn.conectar()) {
                    CitaDAO cita = new CitaDAO(cn);
                    ArrayList<String> citas = cita.obtenerCitasHora(codigoMedico, fecha);
                    String aEnviar = "";
                    for (int i = 0; i < citas.size(); i++) {
                        aEnviar += citas.get(i) + "/";
                    }
                    System.out.println(aEnviar);
                    if (aEnviar.isEmpty()) {
                        response.getWriter().write("LIBRE");
                    } else {
                        response.getWriter().write(aEnviar);
                    }
                } else {
                    response.getWriter().write("ERRORBASE");
                }
            } else if (tipo.equalsIgnoreCase("OBTENER COSTO")) {
                response.setContentType("text/plain;charset=UTF-8");
                String nombreConsulta = request.getParameter("consulta");
                if (cn.conectar()){
                    ConsultaDAO consulta = new ConsultaDAO(cn);
                    String costo = consulta.obtenerCostoConsulta(nombreConsulta);
                    response.getWriter().write(costo);
                } else {
                    response.getWriter().write("ERRORBASE");
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
        HttpSession s = request.getSession();
        if (request.getParameter("tipo") != null) {
            String tipo = request.getParameter("tipo");
            Conector cn = new Conector();
            if (tipo.equalsIgnoreCase("INGRESO CONSULTA")) {
                if (cn.conectar()) {
                    PacienteDAO pacienteD = new PacienteDAO(cn);
                    ReporteDAO reporte = new ReporteDAO(cn);
                    CitaDAO citas = new CitaDAO(cn);
                    String fecha = request.getParameter("fecha");
                    String cita = request.getParameter("cita");
                    String informe = request.getParameter("informe");
                    String paciente = request.getParameter("paciente");
                    String hora = request.getParameter("hora");
                    int nuevaHora = Integer.parseInt(hora) * 100;
                    String codigoMedico = "";
                    if (s.getAttribute("usuario") != null && s.getAttribute("tipo").toString().equalsIgnoreCase("DOCTOR")) {
                        codigoMedico = s.getAttribute("usuario").toString();
                    } else {
                        codigoMedico = "MED-123";
                    }
                    String codigoPaciente = pacienteD.obtenerCodigoPaciente(paciente);
                    String anteriorCodigo = reporte.obtenerUltimoCodigo();
                    int nuevoCodigo = Integer.parseInt(anteriorCodigo) + 1;
                    if (reporte.ingresarReporte(nuevoCodigo + "", codigoPaciente, codigoMedico, informe, fecha, nuevaHora)) {
                        if (citas.actualizarCita(cita)) {
                            response.getWriter().write(nuevoCodigo + "");
                            System.out.println("llego a Informe");
                        } else {
                            response.getWriter().write("ERRORBASE");
                        }
                    } else {
                        response.getWriter().write("ERRORBASE");
                    }
                } else {
                    response.getWriter().write("ERRORBASE");
                }
            } else if (tipo.equalsIgnoreCase("INGRESO CON EXAMEN")) {
                if (cn.conectar()) {
                    response.setContentType("text/plain;charset=UTF-8");
                    ResultadoDAO re = new ResultadoDAO(cn);
                    PacienteDAO pacienteD = new PacienteDAO(cn);
                    String medico = "";
                    if (s.getAttribute("usuario") != null && s.getAttribute("tipo").toString().equalsIgnoreCase("DOCTOR")) {
                        medico = s.getAttribute("usuario").toString();
                    } else {
                        medico = "MED-123";
                    }
                    String laboratorista = request.getParameter("laboratorista");
                    String examen = request.getParameter("examen");
                    String orden = request.getParameter("orden");
                    String fecha = request.getParameter("fecha");
                    String horaConPuntos = request.getParameter("hora");
                    int hora = Integer.parseInt(horaConPuntos);
                    String paciente = request.getParameter("paciente");
                    String codigoPaciente = pacienteD.obtenerCodigoPaciente(paciente);
                    String archivo = request.getParameter("archivo");
                    InputStream archivoOrden = null;
                    InputStream archivoInforme = null;
                    if (orden.equalsIgnoreCase("true")) {
                        byte[] decoder
                                = Base64.getDecoder().decode(archivo);
                        archivoOrden = new ByteArrayInputStream(decoder);
                    }
                    int newCodigo = Integer.parseInt(re.obtenerUltimo()) + 1;
                    String nuevoCodigo = newCodigo + "";
                    if (re.ingresarResultadoSinRealizar(nuevoCodigo, codigoPaciente, laboratorista, examen, archivoOrden, archivoInforme, fecha, hora, medico)) {
                        response.getWriter().write(nuevoCodigo);
                    } else {
                        response.getWriter().write("ERRORBASE");
                    }
                } else {
                    response.getWriter().write("ERRORBASE");
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
