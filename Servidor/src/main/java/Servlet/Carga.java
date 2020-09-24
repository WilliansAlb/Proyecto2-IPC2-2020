/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.AdministradorDAO;
import Base.Conector;
import Base.ConsultaDAO;
import Base.DoctorDAO;
import Base.ExamenDAO;
import Base.LaboratoristaDAO;
import Base.PacienteDAO;
import Base.ReporteDAO;
import Base.ResultadoDAO;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.Base64;
import java.util.List;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yelbetto
 */
public class Carga extends HttpServlet {

    Conector cn = new Conector("conectar");

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
            out.println("<title>Servlet Carga</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Carga at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/plain; charset=ISO-8859-2");

        if (request.getParameter("tipo") != null) {
            String tipo = request.getParameter("tipo");
            String s = request.getParameter("test");
            Gson gson = new Gson();
            JsonArray elements = gson.fromJson(s, JsonArray.class);
            if (tipo.equalsIgnoreCase("1")) {
                ExamenDAO ex = new ExamenDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    String codigo = gsonObj.get("codigo").getAsString();
                    String nombre = gsonObj.get("nombre").getAsString();
                    String orden = gsonObj.get("orden").getAsString();
                    boolean orden1 = orden.equalsIgnoreCase("false");
                    String descripcion = gsonObj.get("descripcion").getAsString();
                    Double costo = gsonObj.get("costo").getAsDouble();
                    String informe = gsonObj.get("informe").getAsString();
                    if (ex.ingresarExamen(codigo, nombre, descripcion, costo, orden1, informe)) {
                        System.out.println("ingresado " + codigo);
                    } else {
                        System.out.println("algo falló");
                    }
                    /**
                     * File file = new File("./sesupone3.xml");
                     *
                     * try (FileOutputStream fos = new FileOutputStream(file);)
                     * { String b64 = res; byte[] decoder =
                     * Base64.getDecoder().decode(b64); fos.write(decoder);
                     * System.out.println("PDF File Saved"); } catch (Exception
                     * e) { e.printStackTrace(); }*
                     */
                }
            } else if (tipo.equalsIgnoreCase("2")) {
                AdministradorDAO ex = new AdministradorDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    String codigo = gsonObj.get("codigo").getAsString();
                    String nombre = gsonObj.get("nombre").getAsString();
                    String dpi = gsonObj.get("dpi").getAsString();
                    String password = gsonObj.get("password").getAsString();
                    String ingreso = ex.ingresarAdmin(codigo, nombre, dpi);
                    if (ingreso.equalsIgnoreCase("ingresado")) {
                        System.out.println("ingresado " + codigo);
                    } else {
                        System.out.println(ingreso);
                    }
                }
            } else if (tipo.equalsIgnoreCase("3")) {
                DoctorDAO ex = new DoctorDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    String codigo = gsonObj.get("codigo").getAsString();
                    String nombre = gsonObj.get("nombre").getAsString();
                    String dpi = gsonObj.get("dpi").getAsString();
                    String password = gsonObj.get("password").getAsString();
                    String colegiado = gsonObj.get("colegiado").getAsString();
                    String telefono = gsonObj.get("telefono").getAsString();
                    String especialidades = gsonObj.get("especialidades").getAsString();
                    String correo = gsonObj.get("correo").getAsString();
                    String horario = gsonObj.get("horario").getAsString();
                    String trabajo = gsonObj.get("trabajo").getAsString();
                    String ingreso = ex.ingresarDoctor(codigo, nombre, dpi, colegiado, horario, correo, trabajo, telefono);
                    System.out.println(ingreso);
                }
            } else if (tipo.equalsIgnoreCase("4")) {
                LaboratoristaDAO ex = new LaboratoristaDAO(cn);
                ExamenDAO exa = new ExamenDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    String codigo = gsonObj.get("codigo").getAsString();
                    String nombre = gsonObj.get("nombre").getAsString();
                    String dpi = gsonObj.get("dpi").getAsString();
                    String password = gsonObj.get("password").getAsString();
                    String registro = gsonObj.get("registro").getAsString();
                    String telefono = gsonObj.get("telefono").getAsString();
                    String examenNombre = gsonObj.get("examen").getAsString();
                    String examenCodigo = exa.obtenerCodigo(examenNombre);
                    String correo = gsonObj.get("correo").getAsString();
                    String dias = gsonObj.get("dias").getAsString();
                    String inicio = gsonObj.get("inicio").getAsString();
                    String ingreso = ex.ingresarLaboratorista(codigo, examenCodigo, nombre, dpi, registro, correo, inicio, telefono);
                    System.out.println(ingreso);
                }
            } else if (tipo.equalsIgnoreCase("5")) {
                PacienteDAO ex = new PacienteDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object
                    String codigo = gsonObj.get("codigo").getAsString();
                    String nombre = gsonObj.get("nombre").getAsString();
                    String dpi = gsonObj.get("dpi").getAsString();
                    String password = gsonObj.get("password").getAsString();
                    String sexo = gsonObj.get("sexo").getAsString();
                    String telefono = gsonObj.get("telefono").getAsString();
                    String nacimiento = gsonObj.get("nacimiento").getAsString();
                    String correo = gsonObj.get("correo").getAsString();
                    String peso = gsonObj.get("peso").getAsString();
                    String sangre = gsonObj.get("sangre").getAsString();
                    String ingreso = ex.ingresarPaciente(codigo, nombre, sexo, nacimiento, dpi, telefono, peso, sangre, correo);
                    System.out.println(ingreso);
                }
            } else if (tipo.equalsIgnoreCase("6")) {
                ConsultaDAO ex = new ConsultaDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object}
                    String nombre = gsonObj.get("nombre").getAsString();
                    Double costo = gsonObj.get("costo").getAsDouble();
                    String ingreso = ex.ingresarConsulta(nombre, costo);
                    System.out.println(ingreso);
                }
            } else if (tipo.equalsIgnoreCase("7")) {
                ReporteDAO ex = new ReporteDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object}
                    String codigo = gsonObj.get("codigo").getAsString();
                    String paciente = gsonObj.get("paciente").getAsString();
                    String medico = gsonObj.get("medico").getAsString();
                    String informe = gsonObj.get("informe").getAsString();
                    String fecha = gsonObj.get("fecha").getAsString();
                    String hora = gsonObj.get("hora").getAsString();
                    String ingreso = ex.ingresarReporte(codigo, paciente, medico, informe, fecha, hora);
                    System.out.println(ingreso);
                }
            } else if (tipo.equalsIgnoreCase("8")) {
                ResultadoDAO re = new ResultadoDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object}
                    String codigo = gsonObj.get("codigo").getAsString();
                    String paciente = gsonObj.get("paciente").getAsString();
                    String laboratorista = gsonObj.get("laboratorista").getAsString();
                    String examen = gsonObj.get("examen").getAsString();
                    String orden = gsonObj.get("orden").getAsString();
                    String informe = gsonObj.get("informe").getAsString();
                    String fecha = gsonObj.get("fecha").getAsString();
                    String hora = gsonObj.get("hora").getAsString();
                    InputStream archivoOrden = null;
                    InputStream archivoInforme = null;
                    if (!orden.equalsIgnoreCase("sin")) {
                        byte[] decoder
                                    = Base64.getDecoder().decode(orden);
                        archivoOrden = new ByteArrayInputStream(decoder);
                    } else {

                    }
                    if (!informe.equalsIgnoreCase("sin")) {
                        byte[] decoder
                                    = Base64.getDecoder().decode(informe);
                        archivoInforme = new ByteArrayInputStream(decoder);
                    } else {

                    }
                    String ingreso = re.ingresarResultado(codigo,paciente,laboratorista,examen,archivoOrden,archivoInforme,fecha,hora);
                    System.out.println(ingreso);
                }
            }
            response.getWriter().write("mandato");
        } else {
            response.getWriter().write("nel");
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
