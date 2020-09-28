/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class ConsultaDAO {
    
    Connection cn;
    
    public ConsultaDAO(Conector con){
        cn = con.getConexion();
    }

    public boolean ingresarConsulta(String nombre, Double costo) {
        boolean ingreso;
        String sql = "INSERT INTO Consulta(nombre,costo) SELECT ?, ? "
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Consulta"
                + " WHERE nombre = ?)";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, nombre);
            ps.setDouble(2, costo);
            ps.setString(3, nombre);
            ps.executeUpdate();
            ingreso = true;
        }catch (SQLException sqle){
            ingreso = true;
        }
        return ingreso;
    }
    
    public int obtenerCodigoConsulta(String nombre){
        int retorno = -1;
        String sql = "SELECT codigo FROM Consulta WHERE nombre = ?";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, nombre);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                retorno = rs.getInt("codigo");
            }
        } catch (SQLException sqle){
            
        }
        return retorno;
    }
    
}
