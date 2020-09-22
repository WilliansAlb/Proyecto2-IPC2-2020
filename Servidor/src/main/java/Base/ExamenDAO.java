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
public class ExamenDAO {

    Connection cn;
    PreparedStatement ps;

    public ExamenDAO(Conector con) {
        cn = con.getConexion();
    }

    public boolean ingresarExamen(String codigo, String nombre, String descripcion, Double costo, boolean orden, String informe) {
        String sql = "INSERT INTO Examen(codigo, nombre,orden,costo,informe,descripcion) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Examen WHERE codigo = ?);";
        boolean ingresado = false;
        try (PreparedStatement ps1 = cn.prepareStatement(sql);) {
            ps1.setString(1, codigo);
            ps1.setString(2, nombre);
            ps1.setBoolean(3, orden);
            ps1.setDouble(4, costo);
            ps1.setString(5, informe);
            ps1.setString(6, descripcion);
            ps1.setString(7, codigo);
            ps1.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle) {
            System.err.print("ERROR: " + sqle);
        }
        return ingresado;
    }

}
