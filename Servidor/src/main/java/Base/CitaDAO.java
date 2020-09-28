/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class CitaDAO {
    
    Connection cn;
    
    public CitaDAO(Conector con){
        cn = con.getConexion();
    }
    
    public boolean ingresarCita(String codigo, String paciente, String medico, int consulta, String fecha, String hora){
        boolean ingreso;
        String sql = "INSERT INTO Cita(codigo,medico,paciente,fecha,consulta,hora)"
                + " SELECT ?, ?, ?, ?, ?, ? FROM dual WHERE NOT EXISTS (SELECT * FROM"
                + " Cita WHERE codigo = ?)";
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, medico);
            ps.setString(3, paciente);
            ps.setString(4, fecha);
            ps.setInt(5, consulta);
            ps.setString(6, hora);
            ps.setString(7, codigo);
            ps.executeUpdate();
            ingreso = true;
        } catch (SQLException sqle){
            ingreso = false;
        }
        
        return ingreso;
    }
    
}
