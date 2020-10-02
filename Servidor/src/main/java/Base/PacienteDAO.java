/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.PacienteDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class PacienteDAO {
    Connection cn;
    
    public PacienteDAO(Conector con){
        cn = con.getConexion();
    }

    public boolean ingresarPaciente(String codigo, String nombre, String sexo, String nacimiento, String dpi, String telefono, 
            String peso, String sangre, String correo) {
        String sql = "INSERT INTO Paciente(codigo,nombre,sexo,peso,dpi,sangre,"
                + "fecha_nacimiento,email,telefono) SELECT ?,?,?,?,?,?,?,?,? "
                + "FROM dual WHERE NOT EXISTS (SELECT * FROM Paciente WHERE "
                + "codigo = ?)";
        boolean ingresado;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, nombre);
            ps.setString(3, sexo);
            ps.setString(4, peso);
            ps.setString(5, dpi);
            ps.setString(6, sangre);
            ps.setString(7, nacimiento);
            ps.setString(8, correo);
            ps.setString(9, telefono);
            ps.setString(10, codigo);
            ps.executeUpdate();
            ingresado = true;
        }catch(SQLException sqle){
            System.err.print("ERROR: "+sqle);
            ingresado = false;
        }
        return ingresado;
    }
    
    public PacienteDTO obtenerPaciente(String codigo){
        PacienteDTO paciente = new PacienteDTO();
        String sql = "SELECT * FROM Paciente WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                paciente.setCodigo(codigo);
                paciente.setDpi(rs.getString("dpi"));
                paciente.setEmail(rs.getString("email"));
                paciente.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                paciente.setNombre(rs.getString("nombre"));
                paciente.setPeso(rs.getDouble("peso"));
                paciente.setSangre(rs.getString("sangre"));
                paciente.setSexo(rs.getString("sexo"));
                paciente.setTelefono(rs.getString("telefono"));
            }
        } catch ( SQLException sqle )
        {
        
        }
        return paciente;
    }

    public boolean actualizarPaciente(String codigo, String nombre, String sexo, Double peso, String dpi, String sangre, String fecha_nacimiento, String email, String telefono) {
        boolean actualizado = false;
        String sql = "UPDATE Paciente SET nombre = ?, sexo = ?, peso = ?, dpi = ?, sangre = ?, fecha_nacimiento = ?, "
                + "email = ?, telefono = ? WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, nombre);
            ps.setString(2, sexo);
            ps.setDouble(3, peso);
            ps.setString(4, dpi);
            ps.setString(5, sangre);
            ps.setString(6, fecha_nacimiento);
            ps.setString(7, email);
            ps.setString(8, telefono);
            ps.setString(9, codigo);
            ps.executeUpdate();
            actualizado = true;
        } catch ( SQLException sqle )
        {
            
        }
        return actualizado;    
    }
}
