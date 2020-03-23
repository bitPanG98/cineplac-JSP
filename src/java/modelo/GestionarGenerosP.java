/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Poolvazo
 */
public class GestionarGenerosP {

    public String RegistrarGeneros(String nombre, String descripcion) {

        Connection con;
        ConexionBD conectarBD = new ConexionBD();
        con = conectarBD.conectarBD();

        String mensaje = "Fallo";

        try {

            CallableStatement cs = con.prepareCall("CALL sp_insertarGeneroPeliculas(?, ?)");

            cs.setString(1, nombre);
            cs.setString(2, descripcion);

            int respuesta = cs.executeUpdate();
            if (respuesta > 0) {
                mensaje = "Exito";
            } else {
                mensaje = "Ocurrio un error al suscribirse";
            }

        } catch (SQLException ex) {
            System.out.println("Error SQL " + ex.getMessage());
            mensaje = "Excepcion SQL -> " + ex.getMessage();
        }

        return mensaje;
    }

    public static ArrayList<GenerosP> CargarGenerosPeliculas() {

        ArrayList<GenerosP> lista = new ArrayList<GenerosP>();

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {
            CallableStatement cs = con.prepareCall("CALL sp_cargarGeneros");
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {

                GenerosP gp = new GenerosP();
                gp.setCodigo(rs.getString("cod_generopelicula"));
                gp.setNombre(rs.getString("nombre_gp"));
                gp.setDescripcion(rs.getString("descripcion_gp"));
                gp.setEstado(rs.getString("estado"));
                lista.add(gp);

            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return lista;
    }

    public static String DarDeBajaUsuario(GenerosP gp) {

        String mensaje = "Fallo";

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {
            
            CallableStatement cs = con.prepareCall("CALL sp_bajaGeneroPeliculas (?)");
            cs.setString(1, gp.getCodigo());

            int respuesta = cs.executeUpdate();
            if (respuesta > 0) {
                mensaje = "Exito";
            } else {
                mensaje = "Fallo";
            }

        } catch (Exception e) {
            System.out.println(e);
            mensaje = "Excepcion SQL -> " + e.getMessage();
        }

        return mensaje;
    }
}
