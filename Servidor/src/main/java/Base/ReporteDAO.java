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
    

    public String ingresarReporte(String codigo, String paciente, String medico, String informe, String fecha, String hora) {
        String ingreso = "";
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
            ingreso = "Reporte ingresado "+codigo;
        } catch ( SQLException sqle ) {
            ingreso = "ERROR: "+sqle;
        }
        return ingreso;
    }
    
}
