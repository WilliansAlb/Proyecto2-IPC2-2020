/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.*;
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
public class Reportes extends HttpServlet {

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
            out.println("<title>Servlet Reportes</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Reportes at " + request.getContextPath() + "</h1>");
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
        Conector cn = new Conector();
        Reporte report = new Reporte(cn);
        HttpSession s = request.getSession();
        if (request.getParameter("admin") != null) {
            if (request.getParameter("tipo") != null) {
                String tipo = request.getParameter("tipo");
                if (request.getParameter("sujeto") != null) {
                    String sujeto = request.getParameter("sujeto");
                    String fecha1 = request.getParameter("fecha1");
                    String fecha2 = request.getParameter("fecha2");
                    s.setAttribute("filtroAdminFecha1", fecha1);
                    s.setAttribute("filtroAdminSujeto", sujeto);
                    s.setAttribute("filtroAdminFecha2", fecha2);
                    s.setAttribute("tipoFiltroAdmin", tipo);
                    response.sendRedirect("JSP/ReporteAdmin.jsp");
                } else {
                    String fecha1 = request.getParameter("fecha1");
                    String fecha2 = request.getParameter("fecha2");
                    s.setAttribute("filtroAdminFecha1", fecha1);
                    s.setAttribute("filtroAdminFecha2", fecha2);
                    s.setAttribute("tipoFiltroAdmin", tipo);
                    response.sendRedirect("JSP/ReporteAdmin.jsp");
                }
            }
        } else if (request.getParameter("laboratorista") != null) {
            if (request.getParameter("tipo") != null) {
                String tipo = request.getParameter("tipo");
                if (tipo.equalsIgnoreCase("3")) {
                    String fecha1 = request.getParameter("fecha1");
                    String fecha2 = request.getParameter("fecha2");
                    s.setAttribute("filtroLaboratoristaFecha1", fecha1);
                    s.setAttribute("filtroLaboratoristaFecha2", fecha2);
                }
                s.setAttribute("tipoFiltroLaboratorista", tipo);
                response.sendRedirect("JSP/ReporteLaboratorista.jsp");
            }
        } else {
            if (request.getParameter("tipo") != null) {
                String tipo = request.getParameter("tipo");
                if (tipo.equalsIgnoreCase("1")) {
                    String examen = request.getParameter("examen");
                    String fecha1 = request.getParameter("fecha1");
                    String fecha2 = request.getParameter("fecha2");
                    s.setAttribute("filtroPacienteFecha1", fecha1);
                    s.setAttribute("filtroPacienteExamen", examen);
                    s.setAttribute("filtroPacienteFecha2", fecha2);
                    s.setAttribute("tipoFiltroPaciente", tipo);
                    response.sendRedirect("JSP/ReportePaciente.jsp");
                } else if (tipo.equalsIgnoreCase("2")) {
                    String doctor = request.getParameter("doctor");
                    String fecha1 = request.getParameter("fecha1");
                    String fecha2 = request.getParameter("fecha2");
                    s.setAttribute("filtroPacienteFecha1", fecha1);
                    s.setAttribute("filtroPacienteDoctor", doctor);
                    s.setAttribute("filtroPacienteFecha2", fecha2);
                    s.setAttribute("tipoFiltroPaciente", tipo);
                    response.sendRedirect("JSP/ReportePaciente.jsp");
                } else if (tipo.equalsIgnoreCase("3")) {
                    s.setAttribute("tipoFiltroPaciente", tipo);
                    response.sendRedirect("JSP/ReportePaciente.jsp");
                } else if (tipo.equalsIgnoreCase("4")) {
                    s.setAttribute("tipoFiltroPaciente", tipo);
                    response.sendRedirect("JSP/ReportePaciente.jsp");
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
        processRequest(request, response);
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
