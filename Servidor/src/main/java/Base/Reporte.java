/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author yelbetto
 */
public class Reporte {

    Connection cn;

    public Reporte(Conector cn) {
        this.cn = cn.getConexion();
    }

    public ArrayList<String[]> obtener10MedicosMasInformes(String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT COUNT(r.medico) AS total, r.medico,m.nombre FROM Reporte r, Medico m WHERE r.fecha BETWEEN ? AND ? AND r.medico = m.codigo GROUP BY r.medico ORDER BY total DESC LIMIT 10";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, fecha1);
            ps.setString(2, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[3];
                datos[0] = rs.getInt(1) + "";
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }

    public ArrayList<String[]> obtenerIngresosObtenidosPorMedico(String codigo, String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT ROUND(SUM(costo),2) AS suma, m.codigo, m.nombre FROM Consulta c, Medico m, Cita i WHERE m.codigo = ? AND i.medico = m.codigo AND c.codigo = i.consulta AND i.fecha BETWEEN ? AND ? AND i.realizada = true GROUP BY m.codigo";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, fecha1);
            ps.setString(3, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[3];
                datos[0] = rs.getDouble(1) + "";
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }

    public ArrayList<String[]> obtener5MedicosConMenorCantidadCitas(String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT COUNT(m.codigo) AS total, m.codigo, m.nombre FROM Cita i, Medico m WHERE i.medico = m.codigo AND i.fecha BETWEEN ? AND ? GROUP BY m.codigo ORDER BY total ASC LIMIT 5;";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, fecha1);
            ps.setString(2, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[3];
                datos[0] = rs.getInt(1) + "";
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }

    public ArrayList<String[]> obtenerExamenesLaboratorioMasDemandados(String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT COUNT(e.codigo) AS total, e.codigo,e.nombre FROM Examen e, Resultado r WHERE r.examen = e.codigo AND r.fecha BETWEEN ? AND ? GROUP BY e.codigo ORDER BY total DESC";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, fecha1);
            ps.setString(2, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[3];
                datos[0] = rs.getInt(1) + "";
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }

    public ArrayList<String[]> obtenerIngresoPorPaciente(String codigo, String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT ROUND(SUM(costo),2) AS suma, p.codigo, p.nombre FROM Consulta c, Paciente p, Cita i WHERE p.codigo = ? AND i.paciente = p.codigo AND c.codigo = i.consulta AND i.fecha BETWEEN ? AND ? AND i.realizada = true GROUP BY p.codigo";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, fecha1);
            ps.setString(3, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[3];
                datos[0] = rs.getDouble(1) + "";
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }

    public ArrayList<String[]> obtenerResultadosRequeridosPorMedico(String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT COUNT(m.codigo) AS total, r.medico, m.nombre FROM Resultado r, Medico m WHERE r.medico = m.codigo AND r.fecha BETWEEN ? AND ? GROUP BY r.medico ORDER BY m.codigo";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, fecha1);
            ps.setString(2, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[4];
                datos[0] = rs.getInt(1) + "";
                datos[1] = rs.getString(2);
                datos[3] = obtenerExamenesMasRequeridos(rs.getString(2),fecha1,fecha2);
                datos[2] = rs.getString(3);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }

    public String obtenerExamenesMasRequeridos(String codigo, String fecha1, String fecha2) {
        String medicos = "";
        String sql = "SELECT COUNT(e.codigo) AS total, e.codigo, e.nombre FROM Resultado r, Medico m, Examen e WHERE r.medico = ? AND r.medico = m.codigo AND r.fecha BETWEEN ? AND ? AND r.examen = e.codigo GROUP BY e.codigo ORDER BY total DESC LIMIT 3;";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, fecha1);
            ps.setString(3, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                medicos+= rs.getString(3)+"/";
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }
    
    public ArrayList<String[]> obtenerExamenesARealizarseEnElDia(String codigo, String fecha, boolean realizado) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT r.codigo, p.nombre, e.nombre, r.hora, m.nombre FROM Resultado r, Paciente p, Medico m, Examen e WHERE r.paciente = p.codigo AND r.examen = e.codigo AND r.medico = m.codigo AND  r.fecha = ? AND r.laboratorista = ? AND r.realizado = ? ORDER BY r.fecha ASC, r.hora ASC";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, fecha);
            ps.setString(2, codigo);
            ps.setBoolean(3, realizado);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[5];
                datos[0] = rs.getString(1);
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                datos[3] = (rs.getInt(4)/100)+"";
                datos[4] = rs.getString(5);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }
    
    public ArrayList<String[]> obtenerPorcentajeDeUtilizacionHoras(String codigo, String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT ROUND((COUNT(fecha)/24)*100,2) AS porcentaje, fecha FROM Resultado WHERE laboratorista = ? AND fecha BETWEEN ? AND ? GROUP BY fecha ORDER BY fecha DESC";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, fecha1);
            ps.setString(3, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[2];
                datos[0] = rs.getDouble(1)+"%";
                datos[1] = rs.getString(2);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }
    
    public ArrayList<String[]> obtener10FechasConMasTrabajoRealizado(String codigo) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT COUNT(fecha) AS total, fecha FROM Resultado WHERE laboratorista = ? AND realizado = ? GROUP BY fecha ORDER BY total DESC LIMIT 10;";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setBoolean(2, true);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[2];
                datos[0] = rs.getInt(1)+"";
                datos[1] = rs.getString(2);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }
    
    public ArrayList<String[]> obtenerCitasAgendadasIntervaloTiempo(String codigo, String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT i.codigo, c.nombre, p.nombre, i.fecha, i.hora FROM Cita i, Consulta c, Medico m, Paciente p WHERE i.paciente = p.codigo AND i.medico = ? AND i.consulta = c.codigo AND i.medico = m.codigo AND i.fecha BETWEEN ? AND ? AND i.realizada = ? ORDER BY fecha DESC, hora DESC";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, fecha1);
            ps.setString(3, fecha2);
            ps.setBoolean(4, false);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[5];
                datos[0] = rs.getString(1);
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                datos[3] = rs.getString(4);
                datos[4] = (rs.getInt(5)/100)+"";
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }
    
    public ArrayList<String[]> obtenerCitasAgendadasHoy(String codigo, String fecha1) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT i.codigo, c.nombre, p.nombre, i.fecha, i.hora FROM Cita i, Consulta c, Medico m, Paciente p WHERE i.paciente = p.codigo AND i.medico = ? AND i.consulta = c.codigo AND i.medico = m.codigo AND i.fecha = ? AND i.realizada = ? ORDER BY fecha DESC, hora DESC";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codigo);
            ps.setString(2, fecha1);
            ps.setBoolean(3, false);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[5];
                datos[0] = rs.getString(1);
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                datos[3] = rs.getString(4);
                datos[4] = (rs.getInt(5)/100)+"";
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }
    
    public ArrayList<String[]> obtenerMayorCantidadDeInformes(String fecha1, String fecha2) {
        ArrayList<String[]> medicos = new ArrayList<>();
        String sql = "SELECT  COUNT(r.paciente) AS total, r.paciente, p.nombre FROM Reporte r, Paciente p WHERE r.paciente = p.codigo AND r.fecha BETWEEN ? AND ? GROUP BY paciente ORDER BY total DESC";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, fecha1);
            ps.setString(2, fecha2);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] datos = new String[3];
                datos[0] = rs.getInt(1)+"";
                datos[1] = rs.getString(2);
                datos[2] = rs.getString(3);
                medicos.add(datos);
            }
        } catch (SQLException sqle) {
            System.out.println(sqle);
        }
        return medicos;
    }

}
