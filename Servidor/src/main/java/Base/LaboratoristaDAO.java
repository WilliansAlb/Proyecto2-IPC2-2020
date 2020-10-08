/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import POJO.LaboratoristaDTO;
import POJO.TrabajoDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
            ps.setString(3, codigo);
            ps.setInt(4, dia);
            ps.executeUpdate();
            ingreso = true;
            System.out.println("Ingresado dia " + dia);
        } catch (SQLException sqle) {
            System.out.println(sqle+" ERROR: en metodo ingresarDiasTrabajo en clase LaboratoristaDAO");
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
    
    public String obtenerHorariosLimite(String laboratorista, String fecha){
        String horarios = "";
        String sql = "SELECT hora FROM Resultado WHERE fecha = ? "
                + "AND laboratorista = ? AND 24 > (SELECT COUNT(hora) FROM Resultado WHERE fecha = ? AND laboratorista = ?);";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) ){
            ps.setString(2,laboratorista);
            ps.setString(1, fecha);
            ps.setString(4,laboratorista);
            ps.setString(3, fecha);
            ResultSet rs = ps.executeQuery();
            while ( rs. next() ){
                horarios += rs.getInt("hora")+",";
                System.out.println(horarios);
            }
        } catch ( SQLException sqle ){
            System.out.println(sqle);
        }
        return horarios;
    }
    public boolean obtenerHorariosDia(String laboratorista, String fecha){
        boolean actualizado = false;
        String sql = "SELECT COUNT(hora) AS horas FROM Resultado WHERE fecha = ? AND laboratorista = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) ){
            ps.setString(2,laboratorista);
            ps.setString(1, fecha);
            ResultSet rs = ps.executeQuery();
            while ( rs. next() ){
                actualizado = rs.getInt("horas") < 24;
                System.out.println(rs.getInt("horas")+"");
            }
        } catch ( SQLException sqle ){
            System.out.println(sqle);
        }
        return actualizado;
    }
    
    public LaboratoristaDTO obtenerLaboratorista(String codigo)
    {
        LaboratoristaDTO lab = new LaboratoristaDTO();
        String slq = "SELECT l.examen AS examen, l.nombre AS nombre, l.no_registro AS registro, "
                + "l.dpi AS dpi, l.telefono AS telefono, l.fecha_inicio AS fecha, l.email AS email, e.nombre AS nombreE "
                + "FROM Laboratorista l, Examen e WHERE l.codigo = ? AND l.examen = e.codigo";
        
        try ( PreparedStatement ps = cn.prepareStatement(slq) )
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                lab.setCodigo(codigo);
                lab.setDpi(rs.getString("dpi"));
                lab.setEmail(rs.getString("email"));
                lab.setExamen(rs.getString("examen"));
                lab.setNombre(rs.getString("nombre"));
                lab.setNo_registro(rs.getString("registro"));
                lab.setNombreExamen(rs.getString("nombreE"));
                lab.setTelefono(rs.getString("telefono"));
                lab.setFecha(rs.getString("fecha"));
                lab.setTrabajos(obtenerDias(codigo));
            }
        } catch ( SQLException sqle ){
            
        }
        return lab;
    }
    
    public ArrayList<LaboratoristaDTO> obtenerTodosLaboratoristas(){
        ArrayList<LaboratoristaDTO> labs = new ArrayList<>();
        String slq = "SELECT l.examen AS examen, l.codigo AS codigo, l.nombre AS nombre, l.no_registro AS registro, "
                + "l.dpi AS dpi, l.telefono AS telefono, l.fecha_inicio AS fecha, l.email AS email, e.nombre AS nombreE "
                + "FROM Laboratorista l, Examen e WHERE l.examen = e.codigo";
        System.out.println("llega");
        try ( PreparedStatement ps = cn.prepareStatement(slq) )
        {
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                LaboratoristaDTO lab = new LaboratoristaDTO();
                lab.setCodigo(rs.getString("codigo"));
                lab.setDpi(rs.getString("dpi"));
                lab.setEmail(rs.getString("email"));
                lab.setExamen(rs.getString("examen"));
                lab.setNombre(rs.getString("nombre"));
                lab.setNo_registro(rs.getString("registro"));
                lab.setNombreExamen(rs.getString("nombreE"));
                lab.setTelefono(rs.getString("telefono"));
                lab.setFecha(rs.getString("fecha"));
                lab.setTrabajos(obtenerDias(rs.getString("codigo")));
                labs.add(lab);
            }
        } catch ( SQLException sqle ){
            System.out.println(sqle);
        }
        return labs;
    }
    
    public ArrayList<TrabajoDTO> obtenerDias(String codigo){
        ArrayList<TrabajoDTO> dias = new ArrayList<>();
        String sql = "SELECT * FROM Trabajo WHERE laboratorista = ?";
        try ( PreparedStatement ps = cn.prepareStatement(sql)) 
        {
            ps.setString(1, codigo);
            ResultSet rs = ps.executeQuery();
            while ( rs.next() )
            {
                TrabajoDTO trabajo = new TrabajoDTO();
                trabajo.setCodigo(rs.getInt("codigo"));
                trabajo.setCodigoLaboratorista(codigo);
                trabajo.setDia(rs.getInt("dia"));
                dias.add(trabajo);
            }
        } catch ( SQLException sqle )
        {
            
        }
        return dias;
    }

    public boolean actualizarLaboratorista(String codigo, String nombre, String dpi, String examen, String email,
            String registro, String fecha, String telefono) {
        boolean actualizado = false;
        String sql = "UPDATE Laboratorista SET nombre = ?, examen = ?, "
                + "no_registro = ?, dpi = ?, telefono = ?, "
                + "fecha_inicio = ?, email = ? WHERE codigo = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, nombre);
            ps.setString(2, examen);
            ps.setString(3, registro);
            ps.setString(4, dpi);
            ps.setString(5, telefono);
            ps.setString(6, fecha);
            ps.setString(7, email);
            ps.setString(8, codigo);
            ps.executeUpdate();
            actualizado = true;
        } catch ( SQLException sqle )
        {
            
        }
        return actualizado;  
    }

    public boolean actualizarTrabajo(String codigo, String dias) {
        int contador = 0;
        boolean actualizado = false;
        for (int i = 0; i < dias.length(); i++){
            if (dias.charAt(i)=='-'){
                contador++;
            }
        }
        if (contador > 1)
        {
            String[] partes = dias.split("/");
            for (int i = 0; i < partes.length; i++)
            {
                String[] dia = partes[i].split("-");
                if (dia[0].equalsIgnoreCase("2")){
                    actualizado = eliminarDia(codigo, Integer.parseInt(dia[1]));
                } else {
                    actualizado = agregarDia(codigo,Integer.parseInt(dia[1]));
                }
            }
        }
        else 
        {
            String[] dia = dias.split("-");
            if (dia[0].equalsIgnoreCase("2")){
                actualizado = eliminarDia(codigo, Integer.parseInt(dia[1]));
            } else {
                actualizado = agregarDia(codigo,Integer.parseInt(dia[1]));
            }
        }
        return actualizado;
    }

    private boolean eliminarDia(String codigo, int dia) {
        boolean actualizado = false;
        String sql = "DELETE FROM Trabajo WHERE laboratorista = ? AND dia = ?";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, codigo);
            ps.setInt(2, dia);
            ps.executeUpdate();
            actualizado = true;
        } catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return actualizado;  
    }

    private boolean agregarDia(String codigo, int dia) {
        boolean actualizado = false;
        String sql = "INSERT INTO Trabajo(laboratorista,dia) SELECT ?,? FROM dual WHERE NOT EXISTS (SELECT * FROM Trabajo WHERE laboratorista = ? AND dia = ?)";
        
        try ( PreparedStatement ps = cn.prepareStatement(sql) )
        {
            ps.setString(1, codigo);
            ps.setInt(2, dia);
            ps.setString(3, codigo);
            ps.setInt(4, dia);
            ps.executeUpdate();
            actualizado = true;
        } catch ( SQLException sqle )
        {
            System.out.println(sqle);
        }
        return actualizado; 
    }

    public boolean isExistente(String codigo) {
        boolean existente = false;
        String sql = "SELECT COUNT(*) AS total FROM Laboratorista WHERE codigo = ?";
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
