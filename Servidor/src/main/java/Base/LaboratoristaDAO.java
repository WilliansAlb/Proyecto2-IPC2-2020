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
public class LaboratoristaDAO {
    Connection cn;
    
    public LaboratoristaDAO(Conector con){
        cn = con.getConexion();
    }

    public String ingresarLaboratorista(String codigo, String examen, String nombre, String dpi, String registro, String correo, String inicio, String telefono) {
        String sql = "INSERT INTO Laboratorista(codigo,examen,nombre,no_registro,dpi,telefono,fecha_inicio,email) "
                + " SELECT ?, ?, ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Laboratorista WHERE codigo = ?);";
        String ingreso;
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, examen);
            ps.setString(3, nombre);
            ps.setString(4, registro);
            ps.setString(5, dpi);
            ps.setString(6, telefono);
            ps.setString(7, inicio);
            ps.setString(8, correo);
            ps.setString(9, codigo);
            ps.executeUpdate();
            ingreso = "ingresado";
        } catch(SQLException sqle){
            System.err.print("ERROR: "+sqle);
            ingreso = "ERROR: "+sqle;
        }
        return ingreso;
    }
}