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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.ConexionBD;
import modelo.GestionarSuscribirse;
import modelo.GestionarUsuario;

/**
 *
 * @author Poolvazo
 */
public class Servlet_Suscribirse extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        suscribirse(request, response);
        try (PrintWriter out = response.getWriter()) {

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

            String sql_obtenerID = "SELECT max(c.cod_cliente)+1 FROM clientes c";

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

    public void suscribirse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dniCliente = request.getParameter("caja-dniC");
        String nombreCliente = request.getParameter("caja-nombreC");
        String apellidosCliente = request.getParameter("caja-apellidosC");
        String password = request.getParameter("caja-password");
        String perfil = "Cliente";

        if (dniCliente.length() < 8) {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + "Porfavor el Nº DNI debe tener 8 caracteres");
        } else {
            
            String mensaje = "";
            mensaje = GestionarSuscribirse.registrarUsaurio(dniCliente, nombreCliente, apellidosCliente, dniCliente, password, perfil);
            if (mensaje.equals("Exito")) {
                response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + "Usuario Suscrito Correctamente");
            } else {
                response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + mensaje);
            }
        }
    }
}
