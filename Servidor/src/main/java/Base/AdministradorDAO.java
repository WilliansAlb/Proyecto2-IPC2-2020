/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.AdministradorDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class AdministradorDAO {
    Connection cn;

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
    
    public AdministradorDTO obtenerAdmin(String codigo){
        AdministradorDTO admin = new AdministradorDTO();
        String sql = "SELECT * FROM Administrador WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                admin.setCodigo(codigo);
                admin.setDpi(rs.getString("dpi"));
                admin.setNombre(rs.getString("nombre"));
            }
        } catch ( SQLException sqle )
        {
        
        }
        
        return admin;
    }
    
    public boolean actualizarAdmin(String codigo, String nombre, String dpi){
        boolean actualizado = false;
        String sql = "UPDATE Administrador SET nombre = ?, dpi = ? WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, nombre);
            ps.setString(2, dpi);
            ps.setString(3, codigo);
            ps.executeUpdate();
            actualizado = true;
        } catch ( SQLException sqle )
        {
            
        }
        return actualizado;    
    }
}
