/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

import java.io.InputStream;

/**
 *
 * @author yelbetto
 */
public class ResultadoDTO {
    private String codigo;
    private String paciente;
    private String examen;
    private String laboratorista;
    private String fecha;
    private InputStream orden;
    private InputStream informe;
    private int hora;
    private boolean realizado;
    private String medico;
    
    public ResultadoDTO(){
    
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getPaciente() {
        return paciente;
    }

    public void setPaciente(String paciente) {
        this.paciente = paciente;
    }

    public String getExamen() {
        return examen;
    }

    public void setExamen(String examen) {
        this.examen = examen;
    }

    public String getLaboratorista() {
        return laboratorista;
    }

    public void setLaboratorista(String laboratorista) {
        this.laboratorista = laboratorista;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public InputStream getOrden() {
        return orden;
    }

    public void setOrden(InputStream orden) {
        this.orden = orden;
    }

    public InputStream getInforme() {
        return informe;
    }

    public void setInforme(InputStream informe) {
        this.informe = informe;
    }

    public int getHora() {
        return hora;
    }

    public void setHora(int hora) {
        this.hora = hora;
    }

    public boolean isRealizado() {
        return realizado;
    }

    public void setRealizado(boolean realizado) {
        this.realizado = realizado;
    }

    public String getMedico() {
        return medico;
    }

    public void setMedico(String medico) {
        this.medico = medico;
    }
}
