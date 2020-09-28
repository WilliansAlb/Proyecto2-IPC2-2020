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
public class ReporteDAO {
    
    Connection cn;
    
    public ReporteDAO(Conector con){
        cn = con.getConexion();
    }
    

    public boolean ingresarReporte(String codigo, String paciente, String medico, String informe, String fecha, String hora) {
        boolean ingreso;
        String sql = "INSERT INTO Reporte(codigo, medico, paciente, fecha, "
                + "informe, hora) SELECT ?, ?, ?, ?, ?, ? FROM dual "
                + "WHERE NOT EXISTS (SELECT * FROM Reporte WHERE codigo = ? "
                + "AND medico = ? AND hora = ?)";
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, medico);
            ps.setString(3, paciente);
            ps.setString(4, fecha);
            ps.setString(5, informe);
            ps.setString(6, hora);
            ps.setString(7, codigo);
            ps.setString(8, medico);
            ps.setString(9, hora);
            ps.executeUpdate();
            ingreso = true;
        } catch ( SQLException sqle ) {
            ingreso = false;
        }
        return ingreso;
    }
    
}
