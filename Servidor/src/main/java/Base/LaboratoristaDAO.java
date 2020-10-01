/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.LaboratoristaDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author yelbetto
 */
public class LaboratoristaDAO {

    Connection cn;

    public LaboratoristaDAO(Conector con) {
        cn = con.getConexion();
    }

    public boolean ingresarLaboratorista(String codigo, String examen, String nombre, String dpi, String registro, String correo, String inicio, String telefono) {
        String sql = "INSERT INTO Laboratorista(codigo,examen,nombre,no_registro,dpi,telefono,fecha_inicio,email) "
                + " SELECT ?, ?, ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Laboratorista WHERE codigo = ?);";
        boolean ingreso;
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, examen);
            ps.setString(3, nombre);
            ps.setString(4, registro);
            ps.setString(5, dpi);
            ps.setString(6, telefono);
            ps.setString(7, inicio);
            ps.setString(8, correo);
            ps.setString(9, codigo);
            ps.executeUpdate();
            ingreso = true;
        } catch (SQLException sqle) {
            System.err.print("ERROR: " + sqle);
            ingreso = false;
        }
        return ingreso;
    }

    public int obtenerDia(String dia) {
        String sql = "SELECT codigo FROM Dia WHERE nombre = ?";
        int codigoDia = -1;

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, dia);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                codigoDia = rs.getInt("codigo");
            }
        } catch (SQLException slqe) {
            System.out.println(slqe);
        }
        return codigoDia;
    }

    public boolean ingresarDiasTrabajo(String codigo, String dias) {
        int dia = obtenerDia(dias);
        String sql = "INSERT INTO Trabajo(laboratorista,dia) SELECT ?, ? FROM dual WHERE NOT EXISTS (SELECT * FROM Trabajo WHERE "
                + "laboratorista = ? AND dia = ?)";
        boolean ingreso = false;

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setInt(2, dia);
            ps.executeUpdate();
            ingreso = true;
            System.out.println("Ingresado dia " + dia);
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return ingreso;
    }

    public String obtenerLaboratoristas(String examen, int dia) {
        String laboratoristas = "";
        String sql = "SELECT l.codigo AS cod, l.nombre AS nom FROM Laboratorista l, Trabajo t WHERE l.examen = ? AND t.dia = ? GROUP BY(l.codigo)";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, examen);
            ps.setInt(2, dia);
            ResultSet rs = ps.executeQuery();
            System.out.println("entra acá");
            while (rs.next()) {
                laboratoristas += rs.getString("cod") + "," + rs.getString("nom") + "|";
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return laboratoristas;
    }
    
    public String obtenerHorarios(String laboratorista, String fecha){
        String horarios = "";
        String sql = "SELECT * FROM Resultado WHERE laboratorista = ? AND fecha = ? AND realizado = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) ){
            ps.setString(1,laboratorista);
            ps.setString(2, fecha);
            ps.setBoolean(3, false);
            ResultSet rs = ps.executeQuery();
            while ( rs. next() ){
                horarios += rs.getInt("hora")+",";
            }
        } catch ( SQLException sqle ){
            System.out.println(sqle);
        }
        return horarios;
    }
    
    public LaboratoristaDTO obtenerLaboratorista(String codigo)
    {
        LaboratoristaDTO lab = new LaboratoristaDTO();
        String slq = "SELECT * FROM Laboratorista WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(slq) )
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                
            }
        } catch ( SQLException sqle ){
            
        }
        return lab;
    }
}
