<%-- 
    Document   : form_reservacion
    Created on : 24-nov-2018, 21:19:04
    Author     : Poolvazo
--%>

<%@page import="controlador.Servlet_Reservacion"%>
<%@page import="modelo.DetalleReservacion"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="modelo.GestionarReservacion"%>
<%@page import="modelo.Peliculas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="modelo.ConexionBD"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title> Reservacion de Peliculas </title>

        <link rel='stylesheet' type='text/css' href='../css/personalizar/componentes.css'>
        <link rel="stylesheet" href="../css/font-awesome.min.css">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/animate.css">
        <link rel="stylesheet" href="../css/main.css">

        <link rel="stylesheet" type="text/css" href="css/color/green.css">

        <script src="../js/validacion.js"></script>

    </head>
    <body bgcolor="#8CE4F4">     
        <%
            String usuario_acceso = String.valueOf(session.getAttribute("usuario_acceso"));

            if (usuario_acceso.equals(null)) {
                out.println("<script>location.replace('form_login.jsp')</script>");
            }

        %> 
        <form id="form-reservacion" name="form-reservacion" method="post" action="../Servlet_Reservacion">
            <input type="hidden" name="accion" value="agregar">

            <div>
                <table align="center" width="40%" border="0">
                    <tr>
                        <td align="center" height="40px">
                            Reservacion de Peliculas
                            <%                                int codigoReservacion = GestionarReservacion.getCodigoReservacion();
                            %>
                            <input type="hidden" name="codigoReserva" value="<%=codigoReservacion%>">
                        </td>
                    </tr>
                </table>
            </div> 

            <div>>
                <br>
            </div>

            <div>
                <table align="center" width="60%" border="0" bgcolor="#8CE4F4">
                    <tr>
                        <td align="left" colspan="3" height="40px" bgcolor="#3B9CF2">
                            Datos de Cliente:
                        </td>
                    </tr>
                    <tr>

                        <%                            Connection con;
                            ConexionBD cBD = new ConexionBD();
                            con = cBD.conectarBD();

                            String dni_user = String.valueOf(session.getAttribute("usuario_acceso"));
                            String nombreCliente = "";
                            String apellidosCliente = "";
                            String codigoC="";
                            String sql_cargarDatos = "SELECT c.cod_cliente, c.dni_cliente, c.nombre_cliente, c.apellidos_cliente "
                                    + "FROM clientes c, usuarios u "
                                    + "WHERE u.cod_cliente = c.cod_cliente AND u.dni_user=" + dni_user;

                            Statement sta = con.createStatement();
                            ResultSet rs = sta.executeQuery(sql_cargarDatos);

                            while (rs.next()) {
                                codigoC = rs.getString("cod_cliente");
                                nombreCliente = rs.getString("nombre_cliente");
                                apellidosCliente = rs.getString("apellidos_cliente");
                            }
                        %>
                    <input type="hidden" name="codigoCliente" value="<%=codigoC%>">
                    <td height="40px">
                        DNI : 
                        <input type="text" name="caja_dni" id="caja_dni" value="<%=dni_user%>" disabled/>
                    </td>
                    <td>
                        Nombre(s) : 
                        <input type="text" name="caja_dni" id="caja_dni" value="<%=nombreCliente%>" disabled/>
                    </td>
                    <td>
                        Apellidos : 
                        <input type="text" name="caja_dni" id="caja_dni" value="<%=apellidosCliente%>" disabled/> 
                    </td>
                    </tr>
                </table>
            </div>

            <div>
                <br>
            </div>

            <div>
                <table align="center" width="50%" border="0" bgcolor="#8CE4F4">
                    <tr>
                        <td align="center" colspan="3" height="40px" bgcolor="#3B9CF2">
                            Datos de Pelicula :
                        </td>
                    </tr>
                    <tr>
                        <td height="40px" align="right" width="40%">
                            Pelicula :
                        </td>
                        <td>
                            <select id="combo_pelicula" name="combo_pelicula">
                                <%
                                    ArrayList<Peliculas> listaPeliculas = GestionarReservacion.CargarPeliculas();
                                    for (int i = 0; i < listaPeliculas.size(); i++) {
                                        Peliculas pelis = listaPeliculas.get(i);
                                %> 
                                <option value='<%=pelis.getCodigo()%>'>
                                    <%=pelis.getNombre() + " \t<--->  Precio : " + pelis.getPrecio() + " $"%>
                                </option>
                                <%
                                    }
                                %>
                            </select>
                        </td>

                        <td width="150%" align='center'>
                            Cantidad : 
                            <input type='text' name="caja_cantidad" id="caja_cantidad"  onKeyPress="return SoloNumeros(event);" required>
                            <input type="submit" name="agregar" value="+" class="btn btn-default"/>

                        </td>
                    </tr>

                </table>
            </div>

            <div>
                <br>
            </div>

            <div>
                <table align="center" width="50%" border="1" >
                    <tr align="center">
                        <td width="6%">
                            Item
                        </td>
                        <td width="12%">
                            Codigo P
                        </td>
                        <td width="35%">
                            Pelicula
                        </td>
                        <td width="15%">
                            Precio U
                        </td>
                        <td width="15%">
                            Cantidad
                        </td>
                        <td width="20%">
                            SubTotal
                        </td>
                    </tr>
                    <%
                        double totalPagar = 0;

                        DecimalFormat formatoD = new DecimalFormat("0.00");
                        DecimalFormatSymbols dfs = formatoD.getDecimalFormatSymbols();
                        dfs.setDecimalSeparator('.');
                        formatoD.setDecimalFormatSymbols(dfs);

                        ArrayList<DetalleReservacion> miListaDetalle = (ArrayList<DetalleReservacion>) session.getAttribute("listaDetalleReservacion");

                        if (miListaDetalle != null) {
                            for (int i = 0; i < miListaDetalle.size(); i++) {
                                DetalleReservacion mp = miListaDetalle.get(i);

                    %>
                    <tr align="center">
                        <td>
                            <%=mp.getNumero()%>
                        </td>
                        <td>
                            <%=mp.getCodigoPelicula()%>

                        </td>
                        <td>
                            <%=mp.getPelicula()%>
                            <input type="hidden" name="pelicula" value="<%=mp.getPelicula()%>">
                        </td>
                        <td>
                            <%=mp.getPrecioU()%>
                        </td>
                        <td>
                            <%=mp.getCantidad()%>
                            <input type="hidden" name="cantidadPeli" value="<%=mp.getCantidad()%>">
                        </td>
                        <td align="right">
                            <%=formatoD.format(mp.getSubTotal())%>
                            <input type="hidden" name="subTotalPeli" value="<%=formatoD.format(mp.getSubTotal())%>">
                        </td>
                        <td >
                            <input type="button" name="quitar" value="-" class="btn btn-danger" onclick="location.href = '../Servlet_Reservacion?item=<%=mp.getNumero()%>&&accion=quitar'"/>
                        </td>
                    </tr>
                    <%
                                totalPagar = totalPagar + mp.getSubTotal();
                                mp.setTotalPagar(Double.parseDouble(formatoD.format(totalPagar)));
                            }
                        }
                    %>

                    <tr>
                        <td colspan="5" align="right">
                            Total Pagar :
                        </td>
                        <td >
                            <input type="text" id="caja_totalpagar" name="caja_totalpagar" id="caja_totalpagar" value="<%=formatoD.format(totalPagar)%>" disabled="" style="text-align: right;">
                        </td>
                    </tr>

                </table>
            </div>

            <div>
                <br>
            </div>

            <div>
                <table align="center" width="40%" bgcolor="#3B9CF2">
                    <tr>
                        <td width="20%" align="center" height="40px">
                            <%
                            DetalleReservacion mp = new DetalleReservacion();
                            %>
                            <input type="button" name="registrar" class="btn btn-danger" value="Registrar Reservacion" onclick="location.href = '../Servlet_Reservacion?totalPagar=<%=formatoD.format(totalPagar)%>&&codigoReserva=<%=codigoReservacion%>&&codigoCliente=<%=codigoC%>&&pelicula=<%=mp.getPelicula()%>&&cantidadPeli=<%=mp.getCantidad()%>&&subTotalPeli=<%=formatoD.format(mp.getSubTotal())%>&&accion=registrar'" />
                        </td>
                        <td width="20%" align="center">
                            <input type="button" name="cancelar" class="btn btn-danger" value="Cancelar Reservacion" onclick="location.href = 'form_menu.jsp'" />
                        </td>
                    </tr>
                </table>
            </div>

        </form>
    </body>
</html>
