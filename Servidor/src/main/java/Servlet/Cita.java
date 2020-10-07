/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.CitaDAO;
import Base.Conector;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yelbetto
 */
public class Cita extends HttpServlet {

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
            out.println("<title>Servlet Cita</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Cita at " + request.getContextPath() + "</h1>");
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
            String tipo = request.getParameter("tipo");
            if (tipo.equalsIgnoreCase("1")) {
                s.setAttribute("filtroMedico", request.getParameter("nombre"));
            } else if (tipo.equalsIgnoreCase("2")) {
                s.setAttribute("filtroMedico", request.getParameter("especial"));
            } else if (tipo.equalsIgnoreCase("3")) {
                s.setAttribute("filtroMedico", request.getParameter("desde"));
                s.setAttribute("filtroMedico1", request.getParameter("hasta"));
            } else if (tipo.equalsIgnoreCase("4")) {
                s.setAttribute("filtroMedico", request.getParameter("hora"));
            }
            s.setAttribute("tipoConsulta", tipo);
            response.getWriter().write("TIPO CONSULTA " + tipo);
        } else {
            if (request.getParameter("pedido") != null) {
                response.setContentType("text/plain;charset=UTF-8");
                String codigoMedico = request.getParameter("medico");
                String fecha = request.getParameter("fecha");
                Conector cn = new Conector();
                if (cn.conectar()) {
                    CitaDAO cita = new CitaDAO(cn);
                    ArrayList<String> citas = cita.obtenerCitasHora(codigoMedico, fecha);
                    String aEnviar = "";
                    for (int i = 0; i < citas.size(); i++) {
                        aEnviar += citas.get(i) + "/";
                    }
                    if (aEnviar.isEmpty()) {
                        response.getWriter().write("LIBRE");
                    } else {
                        response.getWriter().write(aEnviar);
                    }
                } else {
                    response.getWriter().write("ERRORBASE");
                }
            } else {
                response.getWriter().write("ERRORBASE");
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
            Conector cn = new Conector();
            String tipo = request.getParameter("tipo");
            if (tipo.equalsIgnoreCase("INGRESO CITA")) {
                response.setContentType("text/plain;charset=UTF-8");
                if (cn.conectar()) {
                    CitaDAO cita = new CitaDAO(cn);
                    String codigo = request.getParameter("medico");
                    String consulta = request.getParameter("consulta");
                    int newConsulta = Integer.parseInt(consulta);
                    String hora = request.getParameter("horario");
                    int newHora = Integer.parseInt(hora) * 100;
                    String fecha = request.getParameter("fecha");
                    String nuevoCodigo = cita.obtenerUltimo();
                    int nuevoCod = Integer.parseInt(nuevoCodigo)+1;
                    String newCodigo = nuevoCod+"";
                    String paciente = s.getAttribute("usuario").toString();
                    boolean ingreso = cita.ingresarCita(newCodigo, paciente, codigo, newConsulta, fecha, newHora);
                    if (ingreso){
                        response.getWriter().write(newCodigo+"");
                    } else {
                        response.getWriter().write("Ingresa de nuevo");
                    }
                } else {
                    response.getWriter().write("ERRORBASE");
                }
            } else {
                response.getWriter().write("OTRO TIPO");
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
