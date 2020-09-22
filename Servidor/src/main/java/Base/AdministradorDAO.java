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
public class AdministradorDAO {
    Connection cn;
    PreparedStatement ps;

    public AdministradorDAO(Conector con) {
        cn = con.getConexion();
    }
    
    public String ingresarAdmin(String codigo, String nombre, String dpi) {
        String sql = "INSERT INTO Administrador(codigo,nombre,dpi) "
                + " SELECT ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Administrador WHERE codigo = ?);";
        String ingresado = "sin ingresar";
        try (PreparedStatement ps1 = cn.prepareStatement(sql);) {
            ps1.setString(1, codigo);
            ps1.setString(2, nombre);
            ps1.setString(3, dpi);
            ps1.setString(4, codigo);
            ps1.executeUpdate();
            ingresado = "ingresado";
        } catch (SQLException sqle) {
            System.err.print("ERROR: " + sqle);
            ingresado = sqle.toString();
        }
        return ingresado;
    }
}
