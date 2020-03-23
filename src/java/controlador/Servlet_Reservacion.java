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
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.ConexionBD;
import modelo.DetalleReservacion;
import modelo.GestionarReservacion;
import modelo.Peliculas;
import modelo.Reservacion;

/**
 *
 * @author Poolvazo
 */
public class Servlet_Reservacion extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            String opcion = request.getParameter("accion");
            out.println("Opcion enviada -> " + opcion);
            if (opcion.equals("agregar")) {
                agregarItem(request, response);
            } else if (opcion.equals("quitar")) {
                quitarItem(request, response);
            } else if (opcion.equals("registrar")) {
                registrarReservacion(request, response);
            }

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

    public void agregarItem(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        ArrayList<DetalleReservacion> listaDetalleReservacion;

        if (session.getAttribute("listaDetalleReservacion") == null) {
            listaDetalleReservacion = new ArrayList<DetalleReservacion>();
        } else {
            listaDetalleReservacion = (ArrayList<DetalleReservacion>) session.getAttribute("listaDetalleReservacion");
        }

        /*Obtenemos valores d elos input de JSP*/
        String codigoPelicula = request.getParameter("combo_pelicula");
        String nombrePelicula = GestionarReservacion.getNombrePelicula(codigoPelicula);
        double precioUPelicula = GestionarReservacion.getPrecioPelicula(codigoPelicula);
        int stockPelicula = GestionarReservacion.getStockPelicula(codigoPelicula);
        String cantidad = request.getParameter("caja_cantidad");
        int can = Integer.parseInt(cantidad);

        /*Setarlos los valores  ami clase DetalleReservacion*/
        DetalleReservacion miDetalleReserva = new DetalleReservacion();
        miDetalleReserva.setCodigoPelicula(codigoPelicula);
        miDetalleReserva.setPelicula(nombrePelicula);
        miDetalleReserva.setPrecioU(precioUPelicula);
        miDetalleReserva.setCantidad(Integer.parseInt(cantidad));

        double subTotal = precioUPelicula * can;
        miDetalleReserva.setSubTotal(subTotal);

        int indice = -1;
        for (int i = 0; i < listaDetalleReservacion.size(); i++) {
            DetalleReservacion detalleR = listaDetalleReservacion.get(i);
            if (detalleR.getCodigoPelicula().equals(miDetalleReserva.getCodigoPelicula())) {
                indice = i;
                break;
            }
        }

        if (indice == -1) {
            miDetalleReserva.setNumero(String.valueOf(listaDetalleReservacion.size() + 1));
            listaDetalleReservacion.add(miDetalleReserva);
        } else {
            miDetalleReserva.setNumero(String.valueOf(indice + 1));
            listaDetalleReservacion.set(indice, miDetalleReserva);
        }

        /*Asignamos mi objeto a mi lista*/
        //listaDetalleReservacion.add(miDetalleReserva);
        session.setAttribute("listaDetalleReservacion", listaDetalleReservacion);
        response.sendRedirect("vistas/form_reservacion.jsp");

    }

    private void quitarItem(HttpServletRequest request, HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession(false);

        int numeroVenta = Integer.parseInt(request.getParameter("item"));
        ArrayList lista = (ArrayList) session.getAttribute("listaDetalleReservacion");
        lista.remove(numeroVenta - 1);
        response.sendRedirect("vistas/form_reservacion.jsp");

    }

    private void registrarReservacion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection cn;
        ConexionBD con = new ConexionBD();
        cn = con.conectarBD();

        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();

            ArrayList lista = (ArrayList) session.getAttribute("listaDetalleReservacion");
            DecimalFormat df = new DecimalFormat("0.00");
            DecimalFormatSymbols dfs = df.getDecimalFormatSymbols();
            dfs.setDecimalSeparator('.');
            df.setDecimalFormatSymbols(dfs);

            Date date = new Date();
            DateFormat formato_fechahora = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String fechaReservacion = formato_fechahora.format(date);

            Reservacion miReserva = new Reservacion();
            miReserva.setFechaReservacion(fechaReservacion);

            String totalPagar = request.getParameter("totalPagar");
            miReserva.setTotalPagar(Double.parseDouble(totalPagar));

            boolean resp = GestionarReservacion.RegistrarReservacion(miReserva);

            if (resp) {
                response.sendRedirect("vistas/form_mensajes2.jsp?mensaje='Su reservacion de peliculas se realizo correctamente'");
                // Regostrar detalle resrvacion
                String codigoReserva = request.getParameter("codigoReserva");
                String codigoCliete[] = request.getParameterValues("codigoCliente");
                String pelicula[] = request.getParameterValues("pelicula");
                String cantidadPeli[] = request.getParameterValues("cantidadPeli");
                String subTotalPeli[] = request.getParameterValues("subTotalPeli");

                for (int i = 0; i < pelicula.length; i++) {
                    try {
                        CallableStatement cs = cn.prepareCall("CALL sp_insertarDetalleReservacion (?,?,?,?,?)");
                        cs.setString(1, codigoReserva);
                        cs.setString(2, codigoCliete[i]);
                        cs.setString(3, pelicula[i]);
                        cs.setString(4, cantidadPeli[i]);
                        cs.setString(5, subTotalPeli[i]);

                        int j = cs.executeUpdate();
                        if (j == 1) {
                            response.sendRedirect("vistas/form_mensajes2.jsp?mensaje='Su reservacion de peliculas se realizo correctamente'");
                            lista.clear();
                        } else {
                            response.sendRedirect("vistas/form_mensajes2.jsp?mens='Error al realizar la resrvacion de peliculas'");
                        }
                    } catch (Exception e) {
                        System.out.println(e);
                        e.printStackTrace();
                    }
                }
            } else {
                response.sendRedirect("vistas/form_mensajes2.jsp?mensaje='Error al registrar la reservacion'");
            }
        }

    }

}
