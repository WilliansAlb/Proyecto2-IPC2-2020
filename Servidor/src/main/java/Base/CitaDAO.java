/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.CitaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class CitaDAO {
    
    Connection cn;
    
    public CitaDAO(Conector con){
        cn = con.getConexion();
    }
    
    public boolean ingresarCita(String codigo, String paciente, String medico, int consulta, String fecha, int hora){
        boolean ingreso;
        String sql = "INSERT INTO Cita(codigo,medico,paciente,fecha,consulta,hora)"
                + " SELECT ?, ?, ?, ?, ?, ? FROM dual WHERE NOT EXISTS (SELECT * FROM"
                + " Cita WHERE codigo = ? OR (hora = ? AND medico = ? AND fecha = ?))";
        
        try(PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, medico);
            ps.setString(3, paciente);
            ps.setString(4, fecha);
            ps.setInt(5, consulta);
            ps.setInt(6, hora);
            ps.setString(7, codigo);
            ps.setInt(8, hora);
            ps.setString(9, medico);
            ps.setString(10, fecha);
            ps.executeUpdate();
            ingreso = true;
        } catch (SQLException sqle){
            ingreso = false;
            System.out.println(sqle);
        }
        
        return ingreso;
    }
    
    public ArrayList<String> obtenerCitasHora(String codigo, String fecha){
        ArrayList<String> citas = new ArrayList<>();
        String sql = "SELECT c.hora AS hora FROM Cita c, "
                + "Consulta con, Paciente p WHERE c.medico = ? AND c.fecha = ? AND c.realizada = ? AND con.codigo = c.consulta AND "
                + "p.codigo = c.paciente ORDER BY (c.hora) ASC, (c.fecha) ASC";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, fecha);
            ps.setBoolean(3, false);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                Double hora = (double)rs.getInt("hora")/100;
                citas.add(hora+"");
            }
        } catch (SQLException sqle){
            System.out.println(sqle);
        }
        return citas;
    }
    
    public String obtenerUltimo(){
        String codigo = "";
        String sql = "SELECT codigo FROM Cita ORDER BY codigo DESC LIMIT 1;";
        
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
    public boolean actualizarCita(String codigo){
        boolean actualizado = false;
        String sql = "UPDATE Cita SET realizada = ? WHERE codigo = ?";
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setBoolean(1, true);
            ps.setString(2, codigo);
            ps.executeUpdate();
            actualizado = true;
        }
        catch (SQLException sqle){
            System.out.println("ERROR en metodo actualizarCita en CitaDAO ERROR: "+sqle);
        }
        return actualizado;
    }
    
    public ArrayList<CitaDTO> obtenerCitas(String codigo, String fecha){
        ArrayList<CitaDTO> citas = new ArrayList<>();
        String sql = "SELECT c.codigo AS cod, c.medico AS med, p.nombre AS pac, "
                + "c.fecha AS fec, con.nombre AS cons, c.hora AS ho FROM Cita c, "
                + "Consulta con, Paciente p WHERE c.medico = ? AND c.fecha = ? AND c.realizada = ? AND con.codigo = c.consulta AND "
                + "p.codigo = c.paciente ORDER BY (c.hora) ASC, (c.fecha) ASC";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, fecha);
            ps.setBoolean(3, false);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                CitaDTO cita = new CitaDTO();
                cita.setCodigo(rs.getString("cod"));
                cita.setFecha(fecha);
                cita.setMedico(codigo);
                cita.setRealizada(false);
                cita.setHora(rs.getInt("ho"));
                cita.setConsulta(rs.getString("cons"));
                cita.setPaciente(rs.getString("pac"));
                citas.add(cita);
            }
        } catch (SQLException sqle){
            System.out.println(sqle);
        }
        return citas;
    }
    
    
    public ArrayList<CitaDTO> obtenerCitas(String codigo){
        ArrayList<CitaDTO> citas = new ArrayList<>();
        String sql = "SELECT c.codigo AS cod, c.medico AS med, p.nombre AS pac, "
                + "c.fecha AS fec, con.nombre AS cons, c.hora AS ho FROM Cita c, "
                + "Consulta con, Paciente p WHERE c.medico = ? AND c.realizada = ? AND con.codigo = c.consulta AND "
                + "p.codigo = c.paciente ORDER BY (c.hora) ASC, (c.fecha) ASC";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setBoolean(2, false);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                CitaDTO cita = new CitaDTO();
                cita.setCodigo(rs.getString("cod"));
                cita.setFecha(rs.getString("fec"));
                cita.setMedico(codigo);
                cita.setRealizada(false);
                cita.setHora(rs.getInt("ho"));
                cita.setConsulta(rs.getString("cons"));
                cita.setPaciente(rs.getString("pac"));
                citas.add(cita);
            }
        } catch (SQLException sqle){
            System.out.println(sqle);
        }
        return citas;
    }
    public ArrayList<CitaDTO> obtenerCitasDePaciente(String paciente){
        ArrayList<CitaDTO> citas = new ArrayList<>();
        String sql = "SELECT c.codigo, c.medico, p.nombre, "
                + "c.fecha, con.nombre, c.hora, c.realizada FROM Cita c, "
                + "Consulta con, Paciente p WHERE c.paciente = ? AND con.codigo = c.consulta AND "
                + "p.codigo = c.paciente ORDER BY (c.hora) ASC, (c.fecha) ASC";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, paciente);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                CitaDTO cita = new CitaDTO();
                cita.setCodigo(rs.getString(1));
                cita.setFecha(rs.getString(4));
                cita.setMedico(rs.getString(2));
                cita.setRealizada(rs.getBoolean(7));
                cita.setHora(rs.getInt(6));
                cita.setConsulta(rs.getString(5));
                cita.setPaciente(rs.getString(3));
                citas.add(cita);
            }
        } catch (SQLException sqle){
            System.out.println(sqle);
        }
        return citas;
    }
    
    public ArrayList<CitaDTO> obtenerCitasDePacientePendientes(String paciente){
        ArrayList<CitaDTO> citas = new ArrayList<>();
        String sql = "SELECT c.codigo, c.medico, p.nombre, "
                + "c.fecha, con.nombre, c.hora, c.realizada FROM Cita c, "
                + "Consulta con, Paciente p WHERE c.paciente = ? AND con.codigo = c.consulta AND "
                + "p.codigo = c.paciente AND c.realizada = ? ORDER BY (c.hora) ASC, (c.fecha) ASC";
        
        try (PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, paciente);
            ps.setBoolean(2, false);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                CitaDTO cita = new CitaDTO();
                cita.setCodigo(rs.getString(1));
                cita.setFecha(rs.getString(4));
                cita.setMedico(rs.getString(2));
                cita.setRealizada(rs.getBoolean(7));
                cita.setHora(rs.getInt(6));
                cita.setConsulta(rs.getString(5));
                cita.setPaciente(rs.getString(3));
                citas.add(cita);
            }
        } catch (SQLException sqle){
            System.out.println(sqle);
        }
        return citas;
    }
    public String obtenerPacienteCita(String codigo){
        String paciente = "";
        String sql = "SELECT paciente FROM Cita WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) ){
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                paciente = rs.getString("paciente");
            }
        }
        catch (SQLException sqle){
            System.out.println(sqle);
        }
        return paciente;
    }
}
