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
import java.util.ArrayList;

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
            Double peso, String sangre, String correo) {
        String sql = "INSERT INTO Paciente(codigo,nombre,sexo,peso,dpi,sangre,"
                + "fecha_nacimiento,email,telefono) SELECT ?,?,?,?,?,?,?,?,? "
                + "FROM dual WHERE NOT EXISTS (SELECT * FROM Paciente WHERE "
                + "codigo = ?)";
        boolean ingresado;
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, nombre);
            ps.setString(3, sexo);
            ps.setDouble(4, peso);
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
    public String obtenerCodigoPaciente(String nombre){
        String codigo = "";
        String sql = "SELECT codigo FROM Paciente WHERE nombre = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, nombre);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                codigo = rs.getString("codigo");
            }
        } catch ( SQLException sqle )
        {
            System.out.println("ERROR en metodo obtenerCodigoPaciente en PacienteDAO-ERROR: "+sqle);
        }
        return codigo;
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
    
    public String obtenerUltimo(){
        String codigo = "";
        String sql = "SELECT codigo FROM Paciente ORDER BY codigo DESC LIMIT 1;";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ResultSet rs = ps.executeQuery();
            while ( rs.next() ){
                codigo = rs.getString("codigo");
            }
        } catch ( SQLException sqle ){
            System.out.println(sqle);
        }
        return codigo;
    }
    public ArrayList<PacienteDTO> obtenerPacientes(){
        ArrayList<PacienteDTO> pacientes = new ArrayList<>();
        String sql = "SELECT * FROM Paciente";
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ResultSet rs = ps.executeQuery();
            while ( rs.next() ){
                PacienteDTO paciente = new PacienteDTO();
                paciente.setCodigo(rs.getString("codigo"));
                paciente.setDpi(rs.getString("dpi"));
                paciente.setEmail(rs.getString("email"));
                paciente.setFecha_nacimiento(rs.getString("fecha_nacimiento"));
                paciente.setNombre(rs.getString("nombre"));
                paciente.setPeso(rs.getDouble("peso"));
                paciente.setSangre(rs.getString("sangre"));
                paciente.setSexo(rs.getString("sexo"));
                paciente.setTelefono(rs.getString("telefono"));
                pacientes.add(paciente);
            }
        } catch ( SQLException sqle ){
            System.out.println(sqle);
        }
        return pacientes;
    }
}
