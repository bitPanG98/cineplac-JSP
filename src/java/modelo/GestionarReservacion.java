package modelo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Poolvazo
 */
public class GestionarReservacion {

    public GestionarReservacion() {

    }

        public static int getCodigoReservacion() {

        int codigoReservacion = 0;

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            String sql_getCodigo = "SELECT MAX(cod_reservacion)+1 FROM reservaciones ";

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_getCodigo);
            while (rs.next()) {
                codigoReservacion = rs.getInt(1);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return codigoReservacion;
    }
        
    public static ArrayList<Peliculas> CargarPeliculas() {

        ArrayList<Peliculas> datosPeliculas = new ArrayList<Peliculas>();

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            String sql_cargarDatos = "SELECT cod_pelicula, nombre, precio, stock FROM Peliculas WHERE estado=1";
            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_cargarDatos);

            while (rs.next()) {

                Peliculas peli = new Peliculas();

                peli.setCodigo(rs.getString("cod_pelicula"));
                peli.setNombre(rs.getString("nombre"));
                peli.setPrecio(rs.getString("precio"));
                peli.setStock(rs.getString("stock"));

                datosPeliculas.add(peli);

            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return datosPeliculas;
    }

    public static String getNombrePelicula(String codigoPelicula) {

        String nombrePelicula = "";

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            String sql_getNombre = "SELECT nombre FROM peliculas WHERE cod_pelicula=" + codigoPelicula;

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_getNombre);
            while (rs.next()) {
                nombrePelicula = rs.getString("nombre");
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return nombrePelicula;
    }

    public static double getPrecioPelicula(String codigoPelicula) {

        double precioPelicula = 0.0;

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            String sql_getNombre = "SELECT precio FROM peliculas WHERE cod_pelicula=" + codigoPelicula;

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_getNombre);
            while (rs.next()) {
                precioPelicula = rs.getDouble(1);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return precioPelicula;
    }

    public static int getStockPelicula(String codigoPelicula) {

        int stockPelicula = 0;

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            String sql_getNombre = "SELECT stock FROM peliculas WHERE cod_pelicula=" + codigoPelicula;

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_getNombre);
            while (rs.next()) {
                stockPelicula = rs.getInt(1);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return stockPelicula;
    }

    public static boolean RegistrarReservacion(Reservacion mireservacion) {

        boolean resp = false;
        Connection cn;
        ConexionBD con = new ConexionBD();
        cn = con.conectarBD();

        try {
            
            CallableStatement cs = cn.prepareCall("CALL sp_insertarReservaciones (?,?)");
            
            cs.setString(1, mireservacion.getFechaReservacion());
            cs.setDouble(2, mireservacion.getTotalPagar());
            
            int i = cs.executeUpdate();
            if (i > 0) {
                resp = true;
            } else {
                resp = false;

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return resp;
    }

}
