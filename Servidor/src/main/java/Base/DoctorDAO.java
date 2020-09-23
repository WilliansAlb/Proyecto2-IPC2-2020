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
public class DoctorDAO {
    Connection cn;
    
    public DoctorDAO(Conector con){
        cn = con.getConexion();
    }
    
    public String ingresarDoctor(String codigo, String nombre, String dpi, String no_colegiado
            , String horario, String email, String fecha_inicio, String telefono) {
        String sql = "INSERT INTO Medico(codigo,nombre,no_colegiado,dpi,horario,email,fecha_inicio,telefono) "
                + " SELECT ?, ?, ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Medico WHERE codigo = ?);";
        String ingresado;
        try (PreparedStatement ps1 = cn.prepareStatement(sql);) {
            ps1.setString(1, codigo);
            ps1.setString(2, nombre);
            ps1.setString(3, no_colegiado);
            ps1.setString(4, dpi);
            ps1.setString(5, horario);
            ps1.setString(6, email);
            ps1.setString(7, fecha_inicio);
            ps1.setString(8,telefono);
            ps1.setString(9,codigo);
            ps1.executeUpdate();
            ingresado = "ingresado";
        } catch (SQLException sqle) {
            System.err.print("ERROR: " + sqle);
            ingresado = sqle.toString();
        }
        return ingresado;
    }
}
