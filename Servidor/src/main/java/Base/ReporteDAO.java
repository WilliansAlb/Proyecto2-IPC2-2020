/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.ReporteDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class ReporteDAO {
    
    Connection cn;
    
    public ReporteDAO(Conector con){
        cn = con.getConexion();
    }
    

    public boolean ingresarReporte(String codigo, String paciente, String medico, String informe, String fecha, int hora) {
        boolean ingreso;
        String sql = "INSERT INTO Reporte(codigo, medico, paciente, fecha, "
                + "informe, hora) SELECT ?, ?, ?, ?, ?, ? FROM dual "
                + "WHERE NOT EXISTS (SELECT * FROM Reporte WHERE codigo = ?"
                + ")";
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ps.setString(2, medico);
            ps.setString(3, paciente);
            ps.setString(4, fecha);
            ps.setString(5, informe);
            ps.setInt(6, hora);
            ps.setString(7, codigo);
            ps.executeUpdate();
            ingreso = true;
        } catch ( SQLException sqle ) {
            ingreso = false;
            System.out.println("ERROR en el metodo ingresarReporte en ReporteDAO- ERROR:"+sqle);
        }
        return ingreso;
    }

    public boolean isCodigoExistente(String codigo) {
        boolean existente = false;
        String sql = "SELECT COUNT(*) AS total FROM Reporte WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql))
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
            {
                existente = rs.getInt("total") > 0;
            }
        } catch ( SQLException sqle ){
        
        }
        return existente;
    }
    public ArrayList<ReporteDTO> obtenerReportePaciente(String paciente){
        ArrayList<ReporteDTO> reportes = new ArrayList<>();
        String sql = "SELECT * FROM Reporte WHERE paciente = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, paciente);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                ReporteDTO report = new ReporteDTO();
                report.setCodigo(rs.getString("codigo"));
                report.setFecha(rs.getString("fecha"));
                report.setHora(rs.getInt("hora"));
                report.setInforme(rs.getString("informe"));
                report.setMedico(rs.getString("medico"));
                report.setPaciente(paciente);
                reportes.add(report);
            }
        }
        catch (SQLException sqle) 
        {
            System.out.println(sqle);
        }
        return reportes;
    }
    
    public String obtenerUltimoCodigo(){
        String codigo = "";
        String sql = "SELECT codigo FROM Reporte ORDER BY codigo DESC LIMIT 1;";
        
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
    
}
