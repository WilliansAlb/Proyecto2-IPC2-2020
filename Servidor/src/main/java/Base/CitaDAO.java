/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.CitaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class CitaDAO {
    
    Connection cn;
    
    public CitaDAO(Conector con){
        cn = con.getConexion();
    }
    
    public boolean ingresarCita(String codigo, String paciente, String medico, int consulta, String fecha, int hora){
        boolean ingreso;
        String sql = "INSERT INTO Cita(codigo,medico,paciente,fecha,consulta,hora)"
                + " SELECT ?, ?, ?, ?, ?, ? FROM dual WHERE NOT EXISTS (SELECT * FROM"
                + " Cita WHERE codigo = ? OR (hora = ? AND medico = ? AND fecha = ?))";
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, medico);
            ps.setString(3, paciente);
            ps.setString(4, fecha);
            ps.setInt(5, consulta);
            ps.setInt(6, hora);
            ps.setString(7, codigo);
            ps.setInt(8, hora);
            ps.setString(9, medico);
            ps.setString(10, fecha);
            ps.executeUpdate();
            ingreso = true;
        } catch (SQLException sqle){
            ingreso = false;
        }
        
        return ingreso;
    }
    
    public ArrayList<CitaDTO> obtenerCitas(String codigo, String fecha){
        ArrayList<CitaDTO> citas = new ArrayList<>();
        String sql = "SELECT c.codigo AS cod, c.medico AS med, p.nombre AS pac, "
                + "c.fecha AS fec, con.nombre AS cons, c.hora AS ho FROM Cita c, "
                + "Consulta con, Paciente p WHERE c.medico = ? AND c.fecha = ? AND c.realizada = ? AND con.codigo = c.consulta AND "
                + "p.codigo = c.paciente ORDER BY (c.hora) ASC";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, fecha);
            ps.setBoolean(3, false);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                CitaDTO cita = new CitaDTO();
                cita.setCodigo(rs.getString("cod"));
                cita.setFecha(fecha);
                cita.setMedico(codigo);
                cita.setRealizada(false);
                cita.setHora(rs.getInt("ho"));
                cita.setConsulta(rs.getString("cons"));
                cita.setPaciente(rs.getString("pac"));
                citas.add(cita);
            }
        } catch (SQLException sqle){
            System.out.println(sqle);
        }
        return citas;
    }
    
}
