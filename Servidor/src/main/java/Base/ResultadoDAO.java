/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class ResultadoDAO {
    
    Connection cn;
    
    public ResultadoDAO(Conector con){
        cn = con.getConexion();
    }

    public boolean ingresarResultado(String codigo, String paciente, String laboratorista, String examen, InputStream archivoOrden, InputStream archivoInforme, String fecha, int hora, String medico) {
        boolean ingreso;
        String sql = "INSERT INTO Resultado(codigo,paciente,examen,"
                + "laboratorista,fecha,orden,hora,informe,realizado,medico) "
                + "SELECT ?, ?, ?, ?, ?, ?, ?, ?, ?, ? FROM dual "
                + "WHERE NOT EXISTS (SELECT * FROM Resultado WHERE "
                + "codigo = ? )";
        try(PreparedStatement ps = cn.prepareStatement(sql);){
            ps.setString(1, codigo);
            ps.setString(2, paciente);
            ps.setString(3, examen);
            ps.setString(4, laboratorista);
            ps.setString(5, fecha);
            ps.setBlob(6, archivoOrden);
            ps.setInt(7, hora);
            ps.setBlob(8, archivoInforme);
            ps.setBoolean(9, true);
            ps.setString(10, medico);
            ps.setString(11, codigo);
            ps.executeUpdate();
            ingreso = true;
        } catch ( SQLException ex ){
            ingreso = false;
        }
        return ingreso;
    }
    
    
}
