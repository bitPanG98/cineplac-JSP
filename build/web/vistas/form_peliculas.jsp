<%-- 
    Document   : form_peliculas
    Created on : 24-nov-2018, 9:54:21
    Author     : Poolvazo
--%>

<%@page import="modelo.GenerosP"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Peliculas"%>
<%@page import="modelo.GestionarPeliculas"%>
<%@page import="controlador.Servlet_Peliculas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Peliculas </title>
        
        <script src="../js/validacion.js"></script>
        <link rel='stylesheet' type='text/css' href='../css/personalizar/componentes.css'>
    </head>
    <body>

        <%
            String usuario_acceso = String.valueOf(session.getAttribute("usuario_acceso"));

            if (usuario_acceso.equals(null)) {
                out.println("<script>location.replace('form_login.jsp')</script>");
            }

        %> 
        <div>
            <form id="form_peliculas" name="form_peliculas" method="post" action="../Servlet_Peliculas">

                <input type="hidden" name="accion" value="registrar">
                <table align="center"  width="30%" bgcolor='#85F5DB'>
                    <tr>
                        <td height="50px" align="center" colspan="2" bgcolor="#3799A9">
                            Gestion de Peliculas
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="40px">
                            Codigo :
                        </td>
                        <td>
                            <%                                Servlet_Peliculas sg = new Servlet_Peliculas();
                                String codigo = sg.obtenerCodigo();

                            %>
                            <input type="text" name="caja_codigo" id="caja_codigo" disabled="" value="<%= codigo%>">
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="30px">
                            Nombre :
                        </td>
                        <td>
                            <input type="text" name="caja_nombre" id="caja_nombre" required>
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="30px">
                            Duracion :
                        </td>
                        <td>
                            <input type="time" name="caja_duracion" id="caja_duracion" required>
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="30px">
                            Descripcion :
                        </td>
                        <td>
                            <input type="text" name="caja_descripcion" id="caja_descripcion" required="">
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="30px">
                            Stock :
                        </td>
                        <td>
                            <input type="number" min="1" name="caja_stock" id="caja_stock" required>
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="30px">
                            Genero :
                        </td>
                        <td>

                            <!--<input type="text" name="caja_genero" id="caja_genero" required>-->
                            <select name="combo_genero" id="combo_genero">
                                <%
                                    ArrayList<GenerosP> generosP = Servlet_Peliculas.CargarGenerosPeliculas();
                                    for (int i = 0; i < generosP.size(); i++) {
                                        GenerosP gp = generosP.get(i);
                                %> 
                                <option value='<%=gp.getCodigo()%>'>
                                    <%=gp.getNombre()%>
                                </option>    
                                <%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="30px">
                            Precio :
                        </td>
                        <td>
                            <input type="text" name="caja_precio" id="caja_precio" onkeypress="return filterFloat(event,this);" required>
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="30px">
                            Estado :
                        </td>
                        <td>
                            <input type="checkbox" name="estado" id="estado" checked>
                        </td>
                    </tr>


                    <tr bgcolor="#83F3A2">
                        <td align="center" height="50px" >
                            <input type="submit" name="registrarpelicula" class="boton" value="Registrar">
                        </td>
                        <td align="center" height="50px">
                            <input type="button" name="cancelar" value="Cancelar" class="boton" onclick="location.href = 'form_menu.jsp'">
                        </td>
                    </tr>
                </table>
            </form>
        </div>

        <div>

        </div>
        <br>         
        <div>
            <table width="50%" align="center" border="1" style="border-collapse: collapse;">
                <tr>
                    <td width="10%" height="30px" align="center" bgcolor="#4886CB">
                        Codigo
                    </td>
                    <td align="center" bgcolor="#4886CB">
                        Nombre
                    </td>
                    <td align="center" bgcolor="#4886CB">
                        Duracion
                    </td>
                    <td align="center" bgcolor="#4886CB">
                        Descripcion
                    </td>
                    <td align="center" bgcolor="#4886CB">
                        Stock
                    </td>
                    <td align="center" bgcolor="#4886CB">
                        Genero
                    </td>
                    <td align="center" bgcolor="#4886CB">
                        Precio
                    </td>
                    <td align="center" width="10%" bgcolor="#4886CB">
                        Estado
                    </td>
                    <td align="center" width="15%" bgcolor="#4886CB">
                        ..
                    </td>

                </tr>



                <%
                    ArrayList<Peliculas> datosP = GestionarPeliculas.CargarPeliculas();
                    for (int i = 0; i < datosP.size(); i++) {
                        Peliculas p = datosP.get(i);
                %>
                <tr>
                    <td align="center">
                        <%=p.getCodigo()%>
                    </td>
                    <td align="center">
                        <%= p.getNombre()%>
                    </td>
                    <td align="center">
                        <%= p.getDuracion()%>
                    </td>
                    <td>
                        <P align="justify">
                            <%= p.getDescripcion()%> 
                        </P>
                    </td>
                    <td align="center">
                        <%= p.getStock()%>
                    </td>
                    <td align="center">
                        <%= p.getGenero()%>
                    </td>
                    <td align="center">
                        <%= p.getPrecio()%>
                    </td>
                    <td align="center">
                        <%= p.getEstado()%>
                    </td>
                    <td align="center">
                        <input type="button" name="btnEliminar" value="Dar de baja" id="btnEliminar" class="boton" onclick ="location.href = '../Servlet_Peliculas?codigoP=<%=p.getCodigo()%>&&accion=darBaja'">
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </body>
</html>
