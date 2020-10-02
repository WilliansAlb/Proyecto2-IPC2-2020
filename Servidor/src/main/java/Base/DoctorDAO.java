/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.ConsultaDTO;
import POJO.DoctorDTO;
import POJO.EspecialidadDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author yelbetto
 */
public class DoctorDAO {
    Connection cn;
    
    public DoctorDAO(Conector con){
        cn = con.getConexion();
    }
    
    public boolean ingresarDoctor(String codigo, String nombre, String dpi, String no_colegiado
            , String horario, String email, String fecha_inicio, String telefono) {
        String sql = "INSERT INTO Medico(codigo,nombre,no_colegiado,dpi,horario,email,fecha_inicio,telefono) "
                + " SELECT ?, ?, ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Medico WHERE codigo = ?);";
        boolean ingresado;
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
            ingresado = true;
        } catch (SQLException sqle) {
            System.err.print("ERROR: " + sqle);
            ingresado = false;
        }
        return ingresado;
    }
    
    public boolean ingresarEspecialidades(String codigo, String nombre){
        String sql = "INSERT INTO Especialidad(consulta,medico) SELECT codigo, ? FROM Consulta WHERE nombre = ?";
        boolean ingreso = false;
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, nombre);
            ps.executeUpdate();
            ingreso = true;
            System.out.println("Ingresada Especialidad "+ nombre);
        } catch (SQLException sqle){
            System.out.println(sqle);
        }
        return ingreso;
    }
    
    public String obtenerHorarioMedico(String codigo){
        String horario = "";
        String sql = "SELECT horario FROM Medico WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql))
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                horario = rs.getString("horario");
            }
        }
        catch ( SQLException sqle )
        {
        
        }
        
        return horario;
    }
    
    public String[] obtenerHorario(String codigo){
        String[] horario = new String[3];
        String aDescomponer = obtenerHorarioMedico(codigo).replaceAll(":", "");
        if (!aDescomponer.isEmpty())
        {
            String[] tal = aDescomponer.split("-");
            int inicio = Integer.parseInt(tal[0]);
            int fin = Integer.parseInt(tal[1]);
            if (inicio%100 == 0 && fin%100==0)
            {
                horario[2] = "INT";
                horario[0] = (inicio/100) +"";
                horario[1] = (fin/100) + "";
            }
            else
            {
                horario[2] = "DOUBLE";
                Double inicioD = Double.parseDouble(tal[0]);
                Double finD = Double.parseDouble(tal[1]);
                horario[0] = (inicioD/100)+"";
                horario[1] = (finD/100)+"";
            }
        }
        return horario;
    }
    
    public String[] obtenerHorarioTrabajo(String horarioTrabajo){
        String[] horario = new String[3];
        String aDescomponer = horarioTrabajo.replaceAll(":", "");
        if (!aDescomponer.isEmpty())
        {
            String[] tal = aDescomponer.split("-");
            int inicio = Integer.parseInt(tal[0]);
            int fin = Integer.parseInt(tal[1]);
            if (inicio%100 == 0 && fin%100==0)
            {
                horario[2] = "INT";
                horario[0] = (inicio/100) +"";
                horario[1] = (fin/100) + "";
            }
            else
            {
                horario[2] = "DOUBLE";
                Double inicioD = Double.parseDouble(tal[0]);
                Double finD = Double.parseDouble(tal[1]);
                horario[0] = (inicioD/100)+"";
                horario[1] = (finD/100)+"";
            }
        }
        return horario;
    }
    
    
    /**
     *
     * @param codigo
     * @return
     */
    public DoctorDTO obtenerMedico( String codigo ){
        DoctorDTO doctor = new DoctorDTO();
        String sql = "SELECT * FROM Medico WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                doctor.setCodigo(codigo);
                doctor.setDpi(rs.getString("dpi"));
                doctor.setEmail(rs.getString("email"));
                doctor.setEspecialidades(obtenerEspecialidades(codigo));
                doctor.setFecha_inicio(rs.getString("fecha_inicio"));
                doctor.setHorario(obtenerHorarioTrabajo(rs.getString("horario")));
                doctor.setNo_colegiado(Integer.parseInt(rs.getString("no_colegiado")));
                doctor.setNombre(rs.getString("nombre"));
                doctor.setEmail(rs.getString("email"));
                doctor.setTelefono(Integer.parseInt(rs.getString("telefono")));
            }
        } catch ( SQLException sqle )
        {
            
        }
        return doctor;
    }
    
    public EspecialidadDTO obtenerEspecialidades( String codigo ) {
        EspecialidadDTO especial = new EspecialidadDTO();
        String sql = "SELECT c.codigo AS cod, c.nombre AS nom, c.costo AS cos, e.codigo AS codE FROM Especialidad e, Consulta c WHERE e.medico = ? AND e.consulta = c.codigo";
        ArrayList<ConsultaDTO> consultas = new ArrayList<>();
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while( rs.next() )
            {
                ConsultaDTO consulta = new ConsultaDTO();
                consulta.setCodigo(rs.getInt("cod"));
                consulta.setCosto(rs.getDouble("cos"));
                consulta.setNombre(rs.getString("nom"));
                consulta.setCodigoEspecialidad(rs.getInt("codE"));
                consultas.add(consulta);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DoctorDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        ConsultaDTO[] con = new ConsultaDTO[consultas.size()];
        for (int i = 0; i < con.length; i++)
        {
            con[i] = consultas.get(i);
        }
        
        especial.setConsulta(con);
        especial.setMedico(codigo);
        
        return especial;
    }
    
    public ArrayList<ConsultaDTO> obtenerConsultas(){
        ArrayList<ConsultaDTO> consultas = new ArrayList<>();
        String sql = "SELECT * FROM Consulta";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ConsultaDTO con = new ConsultaDTO();
                con.setCodigo(rs.getInt("codigo"));
                con.setCosto(rs.getDouble("costo"));
                con.setNombre(rs.getString("nombre"));
                consultas.add(con);
            }
        } catch ( SQLException sqle )
        {
            
        }
        return consultas;
    }

    public boolean actualizarDoctor(String codigo, String nombre, String dpi, String colegiado, String fecha, String horario, String telefono, String correo) {
        boolean actualizado = false;
        String sql = "UPDATE Medico SET nombre = ?, no_colegiado = ?, dpi = ?, horario = ?, email = ?, fecha_inicio = ?, telefono = ? "
                + "WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, nombre);
            ps.setString(2, colegiado);
            ps.setString(3, dpi);
            ps.setString(4, horario);
            ps.setString(5, correo);
            ps.setString(6, fecha);
            ps.setString(7, telefono);
            ps.setString(8, codigo);
            ps.executeUpdate();
            actualizado = true;
        } catch ( SQLException sqle )
        {
            
        }
        return actualizado;  
    }

    public boolean actualizarEspecialidad(String codigo, String especialidades) {
        int contador = 0;
        boolean actualizado = false;
        for (int i = 0; i < especialidades.length(); i++){
            if (especialidades.charAt(i)=='-'){
                contador++;
            }
        }
        if (contador > 1 && contador != 0){
            String[] especialidadesPartidas = especialidades.split("/");
            for (String especialidadesPartida : especialidadesPartidas) {
                String[] parts = especialidadesPartida.split("-");
                if (!parts[0].equalsIgnoreCase("SIN")){
                    actualizado = isActualizadaEspecialidad(Integer.parseInt(parts[0]),Integer.parseInt(parts[1]));
                }
            }
        } else {
            String[] parts = especialidades.split("-");
            if (!parts[0].equalsIgnoreCase("SIN")){
                actualizado = isActualizadaEspecialidad(Integer.parseInt(parts[0]),Integer.parseInt(parts[1]));
            }
        }
        return actualizado;
    }
    
    public boolean isActualizadaEspecialidad(int especialidad, int consulta){
        boolean actualizado = false;
        String sql = "UPDATE Especialidad SET consulta = ? WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setInt(1, consulta);
            ps.setInt(2, especialidad);
            ps.executeUpdate();
            actualizado = true;
        } catch ( SQLException sqle ) {
            
        }
        return actualizado;
    }
   
}
