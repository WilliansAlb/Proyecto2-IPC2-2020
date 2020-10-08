/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.ResultadoDTO;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class ResultadoDAO {
    
    Connection cn;
    
    public ResultadoDAO(Conector con){
        cn = con.getConexion();
    }

    public boolean ingresarResultado(String codigo, String paciente, String laboratorista, String examen, InputStream archivoOrden, InputStream archivoInforme, String fecha, int hora, String medico) {
        boolean ingreso;
        String sql = "INSERT INTO Resultado(codigo,paciente,examen,"
                + "laboratorista,fecha,orden,hora,informe,realizado,medico) "
                + "SELECT ?, ?, ?, ?, ?, ?, ?, ?, ?, ? FROM dual "
                + "WHERE NOT EXISTS (SELECT * FROM Resultado WHERE "
                + "codigo = ? )";
        try(PreparedStatement ps = cn.prepareStatement(sql);){
            ps.setString(1, codigo);
            ps.setString(2, paciente);
            ps.setString(3, examen);
            ps.setString(4, laboratorista);
            ps.setString(5, fecha);
            ps.setBlob(6, archivoOrden);
            ps.setInt(7, hora);
            ps.setBlob(8, archivoInforme);
            ps.setBoolean(9, true);
            ps.setString(10, medico);
            ps.setString(11, codigo);
            ps.executeUpdate();
            ingreso = true;
        } catch ( SQLException ex ){
            ingreso = false;
            System.out.println(ex +" ERROR en metodo ingresarResultado en clase ResultadoDAO");
        }
        return ingreso;
    }
    public boolean ingresarResultadoSinRealizar(String codigo, String paciente, String laboratorista, String examen, InputStream archivoOrden, InputStream archivoInforme, String fecha, int hora, String medico) {
        boolean ingreso;
        String sql = "INSERT INTO Resultado(codigo,paciente,examen,"
                + "laboratorista,fecha,orden,hora,informe,realizado,medico) "
                + "SELECT ?, ?, ?, ?, ?, ?, ?, ?, ?, ? FROM dual "
                + "WHERE NOT EXISTS (SELECT * FROM Resultado WHERE "
                + "codigo = ? )";
        try(PreparedStatement ps = cn.prepareStatement(sql);){
            ps.setString(1, codigo);
            ps.setString(2, paciente);
            ps.setString(3, examen);
            ps.setString(4, laboratorista);
            ps.setString(5, fecha);
            ps.setBlob(6, archivoOrden);
            ps.setInt(7, hora);
            ps.setBlob(8, archivoInforme);
            ps.setBoolean(9, false);
            ps.setString(10, medico);
            ps.setString(11, codigo);
            ps.executeUpdate();
            ingreso = true;
        } catch ( SQLException ex ){
            ingreso = false;
        }
        return ingreso;
    }
    
    public String obtenerUltimo(){
        String codigo = "";
        String sql = "SELECT codigo FROM Resultado ORDER BY codigo DESC LIMIT 1;";
        
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
    
    public ArrayList<ResultadoDTO> obtenerResultados(){
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo "
                + "ORDER BY fecha ASC, hora ASC";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
     public ArrayList<ResultadoDTO> obtenerResultadosDeLaboratorista(String laboratorista){
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.laboratorista = ? "
                + "ORDER BY fecha ASC, hora ASC";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, laboratorista);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
    public ArrayList<ResultadoDTO> obtenerResultadosDePaciente(String paciente){
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.paciente = ? "
                + "ORDER BY fecha ASC, hora ASC";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, paciente);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
    public ArrayList<ResultadoDTO> obtenerResultadosDePacienteRealizado(String paciente){
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.paciente = ? "
                + "AND r.realizado = ? "
                + "ORDER BY fecha ASC, hora ASC";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, paciente);
            ps.setBoolean(2, true);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
    public ArrayList<ResultadoDTO> obtenerResultadosDePacienteEspecificosRealizados(String paciente,String examen, String fecha1, String fecha2){
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.paciente = ? "
                + "AND r.realizado = ? AND r.examen = ? AND r.fecha BETWEEN ? AND ? "
                + "ORDER BY fecha DESC, hora DESC";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, paciente);
            ps.setBoolean(2, true);
            ps.setString(3, examen);
            ps.setString(4, fecha1);
            ps.setString(5, fecha2);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
     public ArrayList<ResultadoDTO> obtenerUltimosResultadosDePacienteRealizado(String paciente){
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.paciente = ? "
                + "AND r.realizado = ? "
                + "ORDER BY fecha DESC, hora DESC LIMIT 5";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, paciente);
            ps.setBoolean(2, true);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
    
     public ArrayList<ResultadoDTO> obtenerResultadosDePacientePendientes(String paciente){
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.paciente = ? "
                + "AND r.realizado = ? "
                + "ORDER BY fecha ASC, hora ASC";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, paciente);
            ps.setBoolean(2, false);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
     
     public ArrayList<ResultadoDTO> obtenerResultadosDeLaboratoristaHoy(String laboratorista){
        SimpleDateFormat objSDF = new SimpleDateFormat("yyyy-MM-dd");
        String hoy = objSDF.format(new java.util.Date());
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.laboratorista = ? "
                + "AND r.realizado = ? AND r.fecha = ? "
                + "ORDER BY fecha ASC, hora ASC";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, laboratorista);
            ps.setBoolean(2, false);
            ps.setString(3, hoy);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
     
      public ArrayList<ResultadoDTO> obtenerResultadosDeLaboratoristaFechas(String laboratorista, String fecha1, String fecha2){
        ArrayList<ResultadoDTO> resultados = new ArrayList<>();
        String sql = "SELECT r.codigo, e.nombre, r.fecha, r.hora, r.informe, r.laboratorista, r.medico, r.orden, p.nombre,"
                + "r.realizado FROM Resultado r, Paciente p, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.laboratorista = ? "
                + "AND r.fecha BETWEEN ? AND ? "
                + "ORDER BY fecha ASC, hora ASC";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, laboratorista);
            ps.setString(2, fecha1);
            ps.setString(3, fecha2);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ResultadoDTO result = new ResultadoDTO();
                result.setCodigo(rs.getString(1));
                result.setExamen(rs.getString(2));
                result.setFecha(rs.getString(3));
                result.setHora(rs.getInt(4));
                result.setInforme(rs.getBinaryStream(5));
                result.setLaboratorista(rs.getString(6));
                result.setMedico(rs.getString(7));
                result.setOrden(rs.getBinaryStream(8));
                result.setPaciente(rs.getString(9));
                result.setRealizado(rs.getBoolean(10));
                resultados.add(result);
                System.out.println("encuentra en el intervalo");
            }
        }
        catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return resultados;
    }
    
    public boolean isRealizado(InputStream archivo, String codigo){
        boolean realizado = false;
        String sql = "UPDATE Resultado SET informe = ?, realizado = ? WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setBlob(1, archivo);
            ps.setBoolean(2, true);
            ps.setString(3, codigo);
            ps.executeUpdate();
            realizado = true;
        }
        catch ( SQLException sqle ){
            System.out.println(sqle);
        }
        return realizado;
    }
    
}
