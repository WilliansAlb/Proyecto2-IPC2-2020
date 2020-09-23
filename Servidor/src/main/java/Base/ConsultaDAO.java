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
public class ConsultaDAO {
    
    Connection cn;
    
    public ConsultaDAO(Conector con){
        cn = con.getConexion();
    }

    public String ingresarConsulta(String nombre, Double costo) {
        String ingreso = "";
        String sql = "INSERT INTO Consulta(nombre,costo) SELECT ?, ? "
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Consulta"
                + " WHERE nombre = ?)";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, nombre);
            ps.setDouble(2, costo);
            ps.setString(3, nombre);
            ps.executeUpdate();
            ingreso = "ingresado "+nombre;
        }catch (SQLException sqle){
            ingreso = "ERROR "+sqle;
        }
        return ingreso;
    }
    
}
