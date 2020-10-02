/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class LaboratoristaDTO {
    
    private String codigo;
    private String nombre;
    private String no_registro;
    private String examen;
    private String nombreExamen;
    private String dpi;
    private String telefono;
    private String email;
    private String fecha;
    private ArrayList<TrabajoDTO> trabajos;
    
    public LaboratoristaDTO(){
        
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNo_registro() {
        return no_registro;
    }

    public void setNo_registro(String no_registro) {
        this.no_registro = no_registro;
    }

    public String getExamen() {
        return examen;
    }

    public void setExamen(String examen) {
        this.examen = examen;
    }

    public String getDpi() {
        return dpi;
    }

    public void setDpi(String dpi) {
        this.dpi = dpi;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNombreExamen() {
        return nombreExamen;
    }

    public void setNombreExamen(String nombreExamen) {
        this.nombreExamen = nombreExamen;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public ArrayList<TrabajoDTO> getTrabajos() {
        return trabajos;
    }

    public void setTrabajos(ArrayList<TrabajoDTO> trabajos) {
        this.trabajos = trabajos;
    }
    
    
}
