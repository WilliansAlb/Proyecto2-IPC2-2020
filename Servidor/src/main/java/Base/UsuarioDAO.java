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
public class UsuarioDAO {
    
    Connection cn;
    
    public UsuarioDAO(Conector con){
        cn = con.getConexion();
    }
    
    public boolean ingresarUsuario(String id, String codigo, String password, String tipo){
        boolean ingreso = false;
        String sql = "INSERT INTO Usuario(id,codigo,password,tipo) SELECT ?,?,md5(?),? FROM dual WHERE NOT EXISTS "
                + "(SELECT * FROM Usuario WHERE id = ?)";
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, id);
            ps.setString(2, codigo);
            ps.setString(3, password);
            ps.setString(4, tipo);
            ps.setString(5, id);
            ps.executeUpdate();
            ingreso = true;
            System.out.println("Ingresado usuario de "+tipo+" id: "+id);
        } catch (SQLException sqle){
            System.out.println(sqle+" ERROR: en metodo ingresarUsuario clase UsuarioDAO");
        }
        return ingreso;
    }
    public String obtenerTipo(String id){
        String cod = "";
        String sql = "SELECT tipo FROM Usuario WHERE id = ?";
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                cod = rs.getString("tipo");
            }
        }catch (SQLException es){
        
        }
        return cod;
    }
    
}
