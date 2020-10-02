/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.ExamenDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class ExamenDAO {

    Connection cn;

    public ExamenDAO(Conector con) {
        cn = con.getConexion();
    }

    public boolean ingresarExamen(String codigo, String nombre, String descripcion, Double costo, boolean orden, String informe) {
        String sql = "INSERT INTO Examen(codigo, nombre,orden,costo,informe,descripcion) "
                + " SELECT ?, ?, ?, ?, ?, ?"
                + " FROM dual WHERE NOT EXISTS (SELECT * FROM Examen WHERE codigo = ?);";
        boolean ingresado = false;
        try (PreparedStatement ps1 = cn.prepareStatement(sql);) {
            ps1.setString(1, codigo);
            ps1.setString(2, nombre);
            ps1.setBoolean(3, orden);
            ps1.setDouble(4, costo);
            ps1.setString(5, informe);
            ps1.setString(6, descripcion);
            ps1.setString(7, codigo);
            ps1.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle) {
            System.err.print("ERROR: " + sqle);
            System.out.println("ERROR: "+sqle);
        }
        return ingresado;
    }
    
    public String obtenerCodigo(String nombre){
        String sql = "SELECT codigo FROM Examen WHERE nombre = ?";
        String codigo = "";
        try (PreparedStatement ps1 = cn.prepareStatement(sql)){
            ps1.setString(1, nombre);
            ResultSet rs = ps1.executeQuery();
            while(rs.next()){
                codigo = rs.getString("codigo");
            }
        } catch (SQLException sqle){
            codigo = "ERROR: "+sqle;
        }
        return codigo;
    }
    
    public ArrayList<ExamenDTO> obtenerExamenes(){
        ArrayList<ExamenDTO> examenes = new ArrayList<>();
        String sql = "SELECT * FROM Examen";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                ExamenDTO examen = new ExamenDTO();
                examen.setCodigo(rs.getString("codigo"));
                examen.setCosto(rs.getDouble("costo"));
                examen.setDescripcion(rs.getString("descripcion"));
                examen.setInforme(rs.getString("informe"));
                examen.setNombre(rs.getString("nombre"));
                examen.setOrden(rs.getBoolean("orden"));
                examenes.add(examen);
            }
        } catch ( SQLException exa ){
        
        }
        return examenes;
    }
    
    public boolean isOrdenRequerida(String codigo){
        String sql = "SELECT orden FROM Examen WHERE codigo = ?";
        boolean requerida = false;
        
        try ( PreparedStatement ps = cn.prepareStatement(sql)){
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                requerida = rs.getBoolean("orden");
            }
        } catch ( SQLException sqle){
            requerida = false;
                System.out.println(sqle);
        }
        return requerida;
    }

    public boolean actualizarExamen(String codigo, String nombre, String descripcion, Double costo, boolean orden, String informe) {
        String sql = "UPDATE Examen SET nombre = ?,orden = ?,costo = ?,informe = ?,descripcion = ? WHERE codigo = ?";
        boolean ingresado = false;
        try (PreparedStatement ps1 = cn.prepareStatement(sql);) {
            ps1.setString(1, nombre);
            ps1.setBoolean(2, orden);
            ps1.setDouble(3, costo);
            ps1.setString(4, informe);
            ps1.setString(5, descripcion);
            ps1.setString(6, codigo);
            ps1.executeUpdate();
            ingresado = true;
        } catch (SQLException sqle) {
            System.err.print("ERROR: " + sqle);
            System.out.println("ERROR: "+sqle);
        }
        return ingresado;
    }
    
    public boolean isExistente(String codigo){
        boolean existente = false;
        String sql = "SELECT COUNT(*) AS total FROM Examen WHERE codigo = ?";
        try (PreparedStatement ps1 = cn.prepareStatement(sql);) {
            ps1.setString(1, codigo);
            ResultSet rs = ps1.executeQuery();
            while ( rs.next() )
            {
                existente = rs.getInt("total") > 0;
            }
        } catch (SQLException sqle) {
            System.err.print("ERROR: " + sqle);
            System.out.println("ERROR: "+sqle);
        }
        return existente;
    }

}
