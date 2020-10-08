/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Base.AdministradorDAO;
import Base.CitaDAO;
import Base.Conector;
import Base.ConsultaDAO;
import Base.DoctorDAO;
import Base.ExamenDAO;
import Base.LaboratoristaDAO;
import Base.PacienteDAO;
import Base.ReporteDAO;
import Base.ResultadoDAO;
import Base.UsuarioDAO;
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
        if (request.getParameter("tipo") != null) {
            String tipo = request.getParameter("tipo");
            String s = request.getParameter("test");
            Gson gson = new Gson();
            JsonArray elements = gson.fromJson(s, JsonArray.class);
            String ingresados = "";
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
                        ingresados += "1,";
                    } else {
                        ingresados += "0,";
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
                UsuarioDAO us = new UsuarioDAO(cn);
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
                        if(us.ingresarUsuario(codigo, codigo, password, "ADMIN")){
                            ingresados += "1,";
                        } else {
                            ingresados += "0,";
                        }
                    } else {
                        ingresados += "0,";
                    }
                }
            } else if (tipo.equalsIgnoreCase("3")) {
                DoctorDAO ex = new DoctorDAO(cn);
                UsuarioDAO us = new UsuarioDAO(cn);
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
                    String especialidad = gsonObj.get("especialidades").getAsString();
                    String[] especialidades = especialidad.split(",");
                    String correo = gsonObj.get("correo").getAsString();
                    String horario = gsonObj.get("horario").getAsString();
                    String trabajo = gsonObj.get("trabajo").getAsString();
                    boolean ingreso = ex.ingresarDoctor(codigo, nombre, dpi, colegiado, horario, correo, trabajo, telefono);
                    if (ingreso) {
                        if(us.ingresarUsuario(codigo, codigo, password, "DOCTOR")){
                            boolean todos = false;
                            for (String especialidade : especialidades) {
                                todos = ex.ingresarEspecialidades(codigo, especialidade);
                            }
                            if (todos){
                                ingresados += "1,";
                            } else {
                                ingresados += "0,";
                            }
                        } else {
                            ingresados += "0,";
                        }
                    } else {
                        ingresados += "0,";
                    }
                }
            } else if (tipo.equalsIgnoreCase("4")) {
                LaboratoristaDAO ex = new LaboratoristaDAO(cn);
                UsuarioDAO us = new UsuarioDAO(cn);
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
                    String dia = gsonObj.get("dias").getAsString();
                    String[] dias = dia.split(",");
                    String inicio = gsonObj.get("inicio").getAsString();
                    boolean ingreso = ex.ingresarLaboratorista(codigo, examenCodigo, nombre, dpi, registro, correo, inicio, telefono);
                    if (ingreso) {
                        if(us.ingresarUsuario(codigo, codigo, password, "LABORATORISTA")){
                            boolean todos = false;
                            for (String dia1 : dias) {
                                todos = ex.ingresarDiasTrabajo(codigo, dia1);
                            }
                            if (todos){
                                ingresados += "1,";
                            } else {
                                ingresados += "0,";
                            }
                        } else {
                            ingresados += "0,";
                        }
                    } else {
                        ingresados += "0,";
                    }
                }
            } else if (tipo.equalsIgnoreCase("5")) {
                PacienteDAO ex = new PacienteDAO(cn);
                UsuarioDAO us = new UsuarioDAO(cn);
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
                    Double nuevoPeso = Double.parseDouble(peso);
                    String sangre = gsonObj.get("sangre").getAsString();
                    boolean ingreso = ex.ingresarPaciente(codigo, nombre, sexo, nacimiento, dpi, telefono, nuevoPeso, sangre, correo);
                    if (ingreso) {
                        if(us.ingresarUsuario(codigo, codigo, password, "PACIENTE")){
                            ingresados += "1,";
                        } else {
                            ingresados += "0,";
                        }
                    } else {
                        ingresados += "0,";
                    }
                }
            } else if (tipo.equalsIgnoreCase("6")) {
                ConsultaDAO ex = new ConsultaDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object}
                    String nombre = gsonObj.get("nombre").getAsString();
                    Double costo = gsonObj.get("costo").getAsDouble();
                    boolean ingreso = ex.ingresarConsulta(nombre, costo);
                    if (ingreso) {
                        ingresados += "1,";
                    } else {
                        ingresados += "0,";
                    }
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
                    String horaConPuntos = gsonObj.get("hora").getAsString().replaceFirst(":", "");
                    int hora = Integer.parseInt(horaConPuntos);
                    boolean ingreso = ex.ingresarReporte(codigo, paciente, medico, informe, fecha, hora);
                    if (ingreso) {
                        ingresados += "1,";
                    } else {
                        ingresados += "0,";
                    }
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
                    String horaConPuntos = gsonObj.get("hora").getAsString().replaceFirst(":", "");
                    int hora = Integer.parseInt(horaConPuntos);
                    String medico = gsonObj.get("medico").getAsString();
                    if(medico.equalsIgnoreCase("null") || medico.equalsIgnoreCase("")){
                        medico = null;
                    }
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
                    boolean ingreso = re.ingresarResultado(codigo,paciente,laboratorista,examen,archivoOrden,archivoInforme,fecha,hora,medico);
                    if (ingreso) {
                        ingresados += "1,";
                    } else {
                        ingresados += "0,";
                    }
                }
            } else if (tipo.equalsIgnoreCase("9")) {
                CitaDAO ex = new CitaDAO(cn);
                ConsultaDAO ex2 = new ConsultaDAO(cn);
                for (JsonElement obj : elements) {
                    // Object of array
                    JsonObject gsonObj = obj.getAsJsonObject();
                    // Primitives elements of object}
                    String codigo = gsonObj.get("codigo").getAsString();
                    String paciente = gsonObj.get("paciente").getAsString();
                    String medico = gsonObj.get("medico").getAsString();
                    String consultaNombre = gsonObj.get("consulta").getAsString();
                    int consulta = ex2.obtenerCodigoConsulta(consultaNombre);
                    String fecha = gsonObj.get("fecha").getAsString();
                    String horaConPuntos = gsonObj.get("hora").getAsString().replaceFirst(":", "");
                    int hora = Integer.parseInt(horaConPuntos);
                    boolean ingreso = ex.ingresarCita(codigo,paciente,medico,consulta,fecha,hora);
                    if (ingreso) {
                        ingresados += "1,";
                    } else {
                        ingresados += "0,";
                    }
                }
            } 
            response.getWriter().write(ingresados);
        } else {
            response.getWriter().write("");
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
