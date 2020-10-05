/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.Conector;
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
public class Laboratorista extends HttpServlet {

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
            out.println("<title>Servlet Laboratorista</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Laboratorista at " + request.getContextPath() + "</h1>");
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
        if (request.getParameter("tipo") != null)
        {
            String tipo = request.getParameter("tipo");
            if (tipo.equalsIgnoreCase("2")){
                s.setAttribute("filtroLaboratorista", "1");
            } else if (tipo.equalsIgnoreCase("3")){
                String fechaInicio = request.getParameter("fecha1");
                String fechaFinal = request.getParameter("fecha2");
                s.setAttribute("filtroLaboratorista", "2");
                s.setAttribute("filtroLabFecha1", fechaInicio);
                s.setAttribute("filtroLabFecha2", fechaFinal);
            }
        }
        else 
        {
            response.getWriter().write("SIN DATOS");
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
        if (tipo != null) {
            Conector cn = new Conector();
            if (tipo.equalsIgnoreCase("INGRESO EXAMEN")) {
                if (cn.conectar()) {
                    ResultadoDAO result = new ResultadoDAO(cn);
                    String archivo = request.getParameter("archivo");
                    String codigo = request.getParameter("codigo");
                    InputStream archivoInforme = null;
                    byte[] decoder
                            = Base64.getDecoder().decode(archivo);
                    archivoInforme = new ByteArrayInputStream(decoder);
                    if (result.isRealizado(archivoInforme, codigo)){
                        response.getWriter().write("INGRESADO CORRECTAMENTE");
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
