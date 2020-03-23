package modelo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GestionarPeliculas {

    public String RegistrarPeliculas(String nombre, String duracion, String descripcion, String stock, String genero, String precio) {

        Connection con;
        ConexionBD conectarBD = new ConexionBD();
        con = conectarBD.conectarBD();

        String mensaje = "Fallo";

        try {

            CallableStatement cs = con.prepareCall("CALL sp_insertarPeliculas(?, ?, ?, ?, ?, ?)");

            cs.setString(1, nombre);
            cs.setString(2, duracion);
            cs.setString(3, descripcion);
            cs.setString(4, stock);
            cs.setString(5, genero);
            cs.setString(6, precio);

            int respuesta = cs.executeUpdate();
            if (respuesta > 0) {
                mensaje = "Exito";
            } else {
                mensaje = "Ocurrio un error al registrar pelicula";
            }

        } catch (SQLException ex) {
            System.out.println("Error SQL " + ex.getMessage());
            mensaje = "Excepcion SQL -> " + ex.getMessage();
        }

        return mensaje;
    }

    public static ArrayList<Peliculas> CargarPeliculas() {

        ArrayList<Peliculas> lista = new ArrayList<Peliculas>();

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {
            CallableStatement cs = con.prepareCall("CALL sp_mostrarDatosPeliculas");
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {

                Peliculas p = new Peliculas();
                p.setCodigo(rs.getString("cod_pelicula"));
                p.setNombre(rs.getString("nombre"));
                p.setDuracion(rs.getString("duracion"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setStock(rs.getString("stock"));
                p.setGenero(rs.getString("nombre_gp"));
                p.setPrecio(rs.getString("precio"));
                p.setEstado(rs.getString("estado"));
                lista.add(p);

            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return lista;
    }

    public static String DarDeBajaPeliculas(String codigoP) {

        String mensaje = "Fallo";

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            CallableStatement cs = con.prepareCall("CALL sp_bajaPeliculas (?)");
            cs.setString(1, codigoP);

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
