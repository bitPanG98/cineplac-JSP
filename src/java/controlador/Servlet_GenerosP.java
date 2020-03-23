/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.ConexionBD;
import modelo.GenerosP;
import modelo.GestionarGenerosP;

/**
 *
 * @author Poolvazo
 */
public class Servlet_GenerosP extends HttpServlet {

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
        if (operacion.equals("darBaja")) {
            DarBajaUsuario(request, response);
        } else if (operacion.equals("registrar")) {
            registrarGeneros(request, response);
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

        String codigoCliente = "";

        try {

            String sql_obtenerID = "SELECT max(gp.cod_generopelicula)+1 FROM generos_peliculas gp";

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_obtenerID);

            while (rs.next()) {
                codigoCliente = rs.getString(1);
            }

        } catch (SQLException ex) {
            System.out.println("Exception SQL -> " + ex.getMessage());
        }

        return codigoCliente;
    }

    private void registrarGeneros(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String mensaje = "";

        String codigo = request.getParameter("caja_codigo");
        String nombre = request.getParameter("caja_nombre");
        String descripcion = request.getParameter("caja_descripcion");

        System.out.println("ombre -> " + nombre);
        System.out.println("Descripcion ->" + descripcion);

        GestionarGenerosP gp = new GestionarGenerosP();
        mensaje = gp.RegistrarGeneros(nombre, descripcion);

        if (mensaje.equals("Exito")) {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + "Datos de Genero Pelicula registrados :)");
        } else {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + mensaje);
        }

    }

    private void DarBajaUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        GenerosP gp = new GenerosP();
        gp.setCodigo(request.getParameter("codigoGP"));

        String mensaje = GestionarGenerosP.DarDeBajaUsuario(gp);
        if (mensaje.equals("Exito")) {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje= 'El Genero de Pelicula [" + gp.getCodigo() + "] ha sido dado de baja correctamente'");
        } else {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + mensaje);
        }
    }

}
