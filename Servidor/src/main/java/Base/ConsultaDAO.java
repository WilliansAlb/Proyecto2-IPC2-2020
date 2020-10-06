/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.ConsultaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
    
    public String obtenerCostoConsulta(String nombre){
        String retorno = "0.00";
        String sql = "SELECT costo FROM Consulta WHERE nombre = ?";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, nombre);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                retorno = rs.getDouble("costo")+"";
            }
        } catch (SQLException sqle){
            
        }
        return retorno;
    }
    
    public ArrayList<ConsultaDTO> obtenerConsultas(){
        ArrayList<ConsultaDTO> consultas = new ArrayList<>();
        String sql = "SELECT * FROM Consulta";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ConsultaDTO nueva = new ConsultaDTO();
                nueva.setCodigo(rs.getInt("codigo"));
                nueva.setCosto(rs.getDouble("costo"));
                nueva.setNombre(rs.getString("nombre"));
                consultas.add(nueva);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return consultas;
    } 

    public boolean actualizarConsulta(int codigo, String nombre, Double costo) {
        boolean actualizado = false;
        String sql = "UPDATE Consulta SET nombre = ?, costo = ? WHERE codigo = ?";
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, nombre);
            ps.setDouble(2, costo);
            ps.setInt(3, codigo);
            ps.executeUpdate();
            actualizado = true;
        } catch ( SQLException sqle )
        {
            
        }
        return actualizado;    
    }
    
}
