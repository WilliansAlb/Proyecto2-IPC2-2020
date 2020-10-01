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
public class EspecialidadDTO {
    
    private int codigo;
    private ConsultaDTO[] consulta;
    private String medico;
    
    public EspecialidadDTO(){
        
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public ConsultaDTO[] getConsulta() {
        return consulta;
    }

    public void setConsulta(ConsultaDTO[] consulta) {
        this.consulta = consulta;
    }

    public String getMedico() {
        return medico;
    }

    public void setMedico(String medico) {
        this.medico = medico;
    }
    
}
