/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.ConexionBD;
import modelo.GenerosP;
import modelo.GestionarPeliculas;
import modelo.Peliculas;

/**
 *
 * @author Poolvazo
 */
public class Servlet_Peliculas extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String operacion = request.getParameter("accion");
        if (operacion.equals("registrar")) {
            registrarPeliculas(request, response);
        } else if (operacion.equals("darBaja")) {
            DarBajaPelicula(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public String obtenerCodigo() {

        Connection con;

        ConexionBD cBD = new ConexionBD();
        con = cBD.conectarBD();

        String codigoPelicula = "";

        try {

            String sql_obtenerID = "SELECT max(p.cod_pelicula)+1 FROM peliculas p";

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_obtenerID);

            while (rs.next()) {
                codigoPelicula = rs.getString(1);
            }

        } catch (SQLException ex) {
            System.out.println("Exception SQL -> " + ex.getMessage());
        }

        return codigoPelicula;
    }

    public static ArrayList<GenerosP> CargarGenerosPeliculas() {

        ArrayList<GenerosP> generosp = new ArrayList<GenerosP>();

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            String sql_CargarNombresGeneros = "SELECT cod_generopelicula, nombre_gp FROM generos_peliculas WHERE estado=1";

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_CargarNombresGeneros);

            while (rs.next()) {

                GenerosP gp = new GenerosP();
                gp.setNombre(rs.getString("nombre_gp"));
                gp.setCodigo(rs.getString("cod_generopelicula"));

                generosp.add(gp);

            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return generosp;

    }

    private void registrarPeliculas(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String mensaje = "";

        String codigo = request.getParameter("caja_codigo");
        String nombre = request.getParameter("caja_nombre");
        String duracion = request.getParameter("caja_duracion");
        String descripcion = request.getParameter("caja_descripcion");
        String stock = request.getParameter("caja_stock");
        String genero = request.getParameter("combo_genero");
        String precio = request.getParameter("caja_precio");

        System.out.println("Nombre -> " + nombre);
        System.out.println("Descripcion ->" + descripcion);

        GestionarPeliculas p = new GestionarPeliculas();
        mensaje = p.RegistrarPeliculas(nombre, duracion, descripcion, stock, genero, precio);

        if (mensaje.equals("Exito")) {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + "Datos de Pelicula registrados :)");
        } else {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + mensaje);
        }

    }

    private void DarBajaPelicula(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigoP = request.getParameter("codigoP");
        String mensaje = GestionarPeliculas.DarDeBajaPeliculas(codigoP);

        if (mensaje.equals("Exito")) {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje= 'La Pelicula [" + codigoP + "] ha sido dado de baja correctamente'");
        } else {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + mensaje);
        }

    }

}
