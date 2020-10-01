/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJO;

/**
 *
 * @author yelbetto
 */
public class DoctorDTO {
    
    private String codigo;
    private String nombre;
    private int no_colegiado;
    private String dpi;
    private String[] horario;
    private String email;
    private String fecha_inicio;
    private int telefono;
    private EspecialidadDTO especialidades;
    
    public DoctorDTO(){
    
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

    public int getNo_colegiado() {
        return no_colegiado;
    }

    public void setNo_colegiado(int no_colegiado) {
        this.no_colegiado = no_colegiado;
    }

    public String getDpi() {
        return dpi;
    }

    public void setDpi(String dpi) {
        this.dpi = dpi;
    }

    public String[] getHorario() {
        return horario;
    }

    public void setHorario(String[] horario) {
        this.horario = horario;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFecha_inicio() {
        return fecha_inicio;
    }

    public void setFecha_inicio(String fecha_inicio) {
        this.fecha_inicio = fecha_inicio;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    public EspecialidadDTO getEspecialidades() {
        return especialidades;
    }

    public void setEspecialidades(EspecialidadDTO especialidades) {
        this.especialidades = especialidades;
    }
    
    
}
