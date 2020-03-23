<%-- 
    Document   : form_menu
    Created on : 24-nov-2018, 2:11:58
    Author     : Poolvazo
--%>

<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Logeo"%>
<%@page import ="modelo.ConexionBD"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu Principal</title>
    </head>
    <body>

        <%
            String usuario_acceso = String.valueOf(session.getAttribute("usuario_acceso"));

            if (usuario_acceso.equals(null)) {
                out.println("<script>location.replace('form_login.jsp')</script>");
            }

        %>     

        <%       String modulos_user = "";
            String perfil = String.valueOf(session.getAttribute("perfil"));

            if (perfil.equals("Administrador")) {
                modulos_user += "  ";
                modulos_user += "				<tr>	";
                modulos_user += "					<td align='center' height='30px'>";
                modulos_user += "						<h4>";
                modulos_user += "							<a href='form_usuarios.jsp' title='Modulo Clientes' >";
                modulos_user += "								<img src='../imagenes/cliente.png' width='48' height='48' border='0' > <br>";
                modulos_user += "								Modulo Usuarios";
                modulos_user += "							</a>";
                modulos_user += "						</h4>";
                modulos_user += "					</td>";

                modulos_user += "					<td align='center' height='30px'>";
                modulos_user += "						<h4>";
                modulos_user += "							<a href='form_reservacion.jsp' title='Modulo de Reservacion'>";
                modulos_user += "								<img src='../imagenes/reservacion.png' width='48' height='48' border='0'><br>";
                modulos_user += "								Modulo Reservaciones";
                modulos_user += "							</a>";
                modulos_user += "						</h4>	";
                modulos_user += "					</td>";

                modulos_user += "					<td align='center' height='30px'>";
                modulos_user += "						<h4>";
                modulos_user += "							<a href='form_peliculas.jsp' title='Modulo Peliculas' >";
                modulos_user += "								<img src='../imagenes/pelicula.png' width='48' height='48' border='0' > <br>";
                modulos_user += "								Modulo Peliculas";
                modulos_user += "							</a>";
                modulos_user += "						</h4>";
                modulos_user += "					</td>	";
                modulos_user += "				</tr>";
                modulos_user += "		";
                modulos_user += "<tr>";
                modulos_user += "					<td align='center' height='30px'>";
                modulos_user += "						<h4>";
                modulos_user += "							<a href='form_generos.jsp' title='Modulo Peliculas' >";
                modulos_user += "								<img src='../imagenes/pelicula.png' width='48' height='48' border='0' > <br>";
                modulos_user += "								Modulo Generos Peliculas";
                modulos_user += "							</a>";
                modulos_user += "						</h4>";
                modulos_user += "					</td>	";
                modulos_user += "					</tr>	";

            } else if (perfil.equals("Cliente")) {
                modulos_user = "<tr> <td align='center' height='30px'><h4><a href='../vistas/form_reservaciones.php' title='Modulo de Reservacion'> <img src='../imagenes/reservacion.png' width='48' height='48' border='0'><br> Modulo Reservaciones </a> </h4> </td> </tr>";
            } else {
                out.println("<script>location.replace('form_login.jsp')</script>");
                //modulos_user = "Perfil de usuario no identificado, modulos no disponibles";
            }
        %>
        <div>
            <table bgcolor='#A7E288' border='0' style='border-collapse: collapse;' width='50%' align='center' bgcolor='#83B8E8'>
                <tr>
                    <td colspan="3" height="50px" align="center">
                        <h1> 
                            * CINE PLAC * 
                            <img src='../imagenes/cineplac3.png'  width='75' height='48' border='0'>
                        </h1>
                    </td>
                </tr>

                <tr>
                    <td width='25%'>

                    </td>

                    <td width='50%' bgcolor='#A7E288'>     

                        <%
                            Connection con;

                            ConexionBD cBD = new ConexionBD();
                            con = cBD.conectarBD();

                            String dni_user = String.valueOf(session.getAttribute("usuario_acceso"));
                            String user_logeo = "";

                            String sql_cargarnombre = "SELECT c.nombre_cliente, c.apellidos_cliente "
                                    + "FROM usuarios u, clientes c "
                                    + "WHERE u.cod_cliente = c.cod_cliente AND u.dni_user=" + dni_user;

                            Statement sta = con.createStatement();
                            ResultSet rs = sta.executeQuery(sql_cargarnombre);

                            while (rs.next()) {
                                user_logeo = rs.getString("nombre_cliente") + " " + rs.getString("apellidos_cliente");
                            }
                        %>

                        Usuario : ${usuario_acceso}<br>
                        Cliente : <%= user_logeo%> <br>
                        Perfil  : ${perfil}<br>

                        <a href='form_login.jsp?cerrar=true'>    
                            <img src="../imagenes/salir.png">
                            Cerrar  &nbsp;   
                        </a>
                        <br>
                    </td>

                    <td width='25%'>

                    </td>

                </tr>
            </table>
        </div>

        <!--#####################################-->
        <div>
            <table bgcolor='#83B8E8' border='3' style='border-collapse: collapse;'' width='50%'' align='center' bgcolor='#83B8E8'>
                <tr>
                    <td colspan='4' height='50px'  align='center' bgcolor='#83B8E8'>
                        <h1>MENU PRINCIPAL<h1>
                                </td>
                                </tr>

                                <tr>
                                    <%=modulos_user%>
                                </tr>
                                </table>
                                </div>
                                </body>
                                </html>
