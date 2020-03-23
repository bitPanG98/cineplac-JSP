<%-- 
    Document   : form_generos
    Created on : 24-nov-2018, 9:54:21
    Author     : Poolvazo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.GenerosP"%>
<%@page import="modelo.GestionarGenerosP"%>
<%@page import="controlador.Servlet_GenerosP"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>




<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Generos Peliculas </title>

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
            <form id="form_generos" name="form_generos" method="post" action="../Servlet_GenerosP">
                <input type="hidden" name="accion" value="registrar">
                <table align="center"  width="30%" bgcolor='#85F5DB'>
                    <tr>
                        <td height="50px" align="center" colspan="2" bgcolor="#3799A9">
                            Gestion de Generos P
                        </td>
                    </tr>

                    <tr>
                        <td align="right" height="40px">
                            Codigo :
                        </td>
                        <td>
                            <%                                Servlet_GenerosP sg = new Servlet_GenerosP();
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
                            Descripcion :
                        </td>
                        <td>
                            <input type="text" name="caja_descripcion" id="caja_descripcion" >
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
                            <input type="submit" name="registrar" class="boton" value="Registrar">
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
                        Descripcion
                    </td>
                    <td align="center" width="10%" bgcolor="#4886CB">
                        Estado
                    </td>
                    <td align="center" width="15%" bgcolor="#4886CB">
                        ..
                    </td>

                </tr>



                <%
                    ArrayList<GenerosP> datosGP = GestionarGenerosP.CargarGenerosPeliculas();
                    for (int i = 0; i < datosGP.size(); i++) {
                        GenerosP gp = datosGP.get(i);
                %>
                <tr>
                    <td align="center">
                        <%=gp.getCodigo()%>
                    </td>
                    <td align="center">
                        <%= gp.getNombre()%>
                    </td>
                    <td>
                        <P align="justify">
                            <%= gp.getDescripcion()%> 
                        </P>
                    </td>
                    <td align="center">
                        <%= gp.getEstado()%>
                    </td>
                    <td align="center">
                        <input type="button" name="btnEliminar" value="Dar de baja" id="btnEliminar" class="boton" onclick ="location.href = '../Servlet_GenerosP?codigoGP=<%=gp.getCodigo()%>&&accion=darBaja'">
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </body>
</html>
