/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.Conector;
import Base.ExamenDAO;
import Base.LaboratoristaDAO;
import Base.ReporteDAO;
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
public class IngresoInforme extends HttpServlet {

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
            out.println("<title>Servlet IngresoInforme</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet IngresoInforme at " + request.getContextPath() + "</h1>");
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
        String examen = request.getParameter("examen");
        String tipo = request.getParameter("tipo");
        Conector cn = new Conector();
        if (tipo != null) {
            if (tipo.equalsIgnoreCase("1")) {
                if (cn.conectar()) {
                    LaboratoristaDAO lab = new LaboratoristaDAO(cn);
                    String diaS = request.getParameter("dia");
                    String laboratoristas = lab.obtenerLaboratoristas(examen, Integer.parseInt(diaS));
                    response.getWriter().write(laboratoristas);
                } else {
                    response.getWriter().write("fallo");
                }
            } else if (tipo.equalsIgnoreCase("2")) {
                if (cn.conectar()) {
                    ExamenDAO exa = new ExamenDAO(cn);
                    boolean orden = exa.isOrdenRequerida(examen);
                    response.getWriter().write(orden + "");
                } else {
                    response.getWriter().write("fallo");
                }
            } else if (tipo.equalsIgnoreCase("3")){
                if (cn.conectar()) {
                    String fecha = request.getParameter("fecha");
                    String laboratorista = request.getParameter("laboratorista");
                    LaboratoristaDAO lab = new LaboratoristaDAO(cn);
                    String la = lab.obtenerHorarios(laboratorista, fecha);
                    response.getWriter().write(la + "");
                } else {
                    response.getWriter().write("fallo");
                }
            } else if (tipo.equalsIgnoreCase("4")){
                if (cn.conectar()) {
                    String codigo = request.getParameter("codigo");
                    ReporteDAO lab = new ReporteDAO(cn);
                    boolean existente = lab.isCodigoExistente(codigo);
                    System.out.println(existente);
                    response.getWriter().write(existente+"");
                } else {
                    response.getWriter().write("fallo");
                }
            }
        } else {
            response.getWriter().write("incorrecto");
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
        String mensaje = request.getParameter("examen");
        response.getWriter().write(mensaje);
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
