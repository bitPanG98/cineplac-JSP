/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.GestionarUsuario;

/**
 *
 * @author Poolvazo
 */
public class Servlet_Usuario extends HttpServlet {

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

        String cmd = request.getParameter("accion");
        if (cmd.equals("registrar")) {
            RegistrarUsuario(request, response);
        } else if (cmd.equals("darBaja")) {
            DarBajaUsuario(request, response);
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

    public void RegistrarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String dniCliente = request.getParameter("caja-dniC").trim();
        String nombreCliente = request.getParameter("caja-nombreC").trim();
        String apellidosCliente = request.getParameter("caja-apellidosC").trim();
        String password = request.getParameter("caja-password").trim();
        String perfil = request.getParameter("comboPerfil").trim();

        if (dniCliente.length() < 8) {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + "Porfavor el Nº DNI debe tener 8 caracteres");
        } else {

            String mensaje = "";
            mensaje = GestionarUsuario.registrarUsaurio(dniCliente, nombreCliente, apellidosCliente, dniCliente, password, perfil);
            if (mensaje.equals("Exito")) {
                response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + "Usuario Registrado Correctamente");
            } else {
                response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + mensaje);
            }

        }

    }

    private void DarBajaUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dniCliente = request.getParameter("dniCliente");
        String mensaje = GestionarUsuario.DarDeBajaUsuario(dniCliente);

        if (mensaje.equals("Exito")) {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje= 'Cliente [" + dniCliente + "] ha sido dado de baja correctamente'");
        } else {
            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje=" + mensaje);
        }

    }

}
