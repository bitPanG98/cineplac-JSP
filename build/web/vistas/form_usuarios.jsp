<%-- 
    Document   : form-usuarios
    Created on : 24-nov-2018, 23:49:28
    Author     : Poolvazo
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelo.GestionarUsuario"%>
<%@page import="modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modulo Usuarios</title>

        <link rel='stylesheet' type='text/css' href='../css/personalizar/componentes.css'>
        <script src="../js/validacion.js"></script>
        <script type="text/javascript">
            function obtenerValor()
            {
                document.getElementById("caja-usuario").value = document.getElementById("caja-dniC").value;
            }

        </script>
    </head>

    <body>

        <%
            String usuario_acceso = String.valueOf(session.getAttribute("usuario_acceso"));

            if (usuario_acceso.equals(null)) {
                out.println("<script>location.replace('form_login.jsp')</script>");
            }

        %> 
        <form id="form-usuario" name="form-usuario" method="post" action="../Servlet_Usuario">
            <input type="hidden" name="accion" value="registrar">
            <table border="0" align="center" width="40%" bgcolor='#85F5DB'>
                <tr>
                    <td align="center" colspan="2" height="50px" bgcolor="#3799A9">
                        Modulo de Usuarios
                    </td>
                </tr>

                <tr>
                    <td align="right" width='30%' height='50px' >
                        Codigo :
                    </td>
                    <td width='55%'>
                        <%                            int codigo = GestionarUsuario.obtenerCodigo();
                        %>
                        <input type="text" length="8" id="caja-codigoC" name="caja-codigoC" value="<%=codigo%>" disabled>
                    </td>
                </tr>
                <tr>
                    <td align="right" width='30%' height='50px' >
                        DNI :
                    </td>
                    <td width='55%'>
                        <input type="text" onkeyup="obtenerValor()" id="caja-dniC" name="caja-dniC"  maxlength="8" onKeyPress="return SoloNumeros(event);" required>
                    </td>
                </tr>

                <tr>
                    <td align="right" width='45%' height='50px' >
                        Nombre(s) :  
                    </td>
                    <td width='55%'>
                        <input type="text" id="caja-nombreC" name="caja-nombreC" onkeypress="return soloLetras(event);" required>
                    </td>
                </tr>

                <tr>
                    <td align="right" width='45%' height='50px' >
                        Apellidos :
                    </td>
                    <td>
                        <input type="text" id="caja-apellidosC" name="caja-apellidosC"  onkeypress="return soloLetras(event);" required>
                    </td>
                </tr>

                <tr>
                    <td align="right" width='45%' height='50px' >
                        Usuario :
                    </td>
                    <td>
                        <input type="text" id="caja-usuario" name="caja-usuario" disabled>
                    </td>
                </tr>

                <tr>
                    <td  align="right" width='45%' height='50px' >
                        Password :
                    </td>
                    <td>
                        <input type="password" id="caja-password" name="caja-password" required>
                    </td>
                </tr>

                <tr>
                    <td  align="right" width='45%' height='50px' >
                        Perfil :
                    </td>
                    <td>
                        <select id="comboPerfil" name="comboPerfil">
                            <option value="Administrador">
                                Administrador
                            </option>
                            <option value="Cliente">
                                Cliente
                            </option>
                        </select>
                    </td>
                </tr>

                <tr bgcolor="#6C84E8">
                    <td width='45%' height='50px' align="center" colspan="2">
                        <input type="submit" name="registrar" value="Registrar" class="boton">
                        <input type="button" name="cancelar" value="Cancelar" class="boton" onclick="location.href = 'form_menu.jsp'">
                    </td>

                </tr>
            </table>
            <div>
                <br><br>
            </div>
            <table  align="center" width="60%" bgcolor='#86EDC4' border="1" style="border-collapse: collapse;">
                <tr align="center"  bgcolor="#3F8AD9">
                    <td height='50px' >
                        Codigo
                    </td>
                    <td bgcolor="#3F8AD9">
                        DNI
                    </td>
                    <td>
                        Nombre(s)
                    </td>
                    <td>
                        Apellidos
                    </td>
                    <td>
                        Usuario
                    </td>
                    <td>
                        Password
                    </td>
                    <td>
                        Perfil
                    </td>
                    <td>
                        Estado
                    </td>
                </tr>

                <%
                    ArrayList<Usuario> datosUsuarios = GestionarUsuario.CargarUsuarios();
                    for (int i = 0; i < datosUsuarios.size(); i++) {
                        Usuario miUser = datosUsuarios.get(i);
                %>
                <tr>
                    <td>
                        <%=miUser.getCodigoCliente()%>
                    </td>
                    <td>
                        <%=miUser.getDniCliente()%>
                    </td>
                    <td>
                        <%=miUser.getNombreCliente()%>
                    </td>
                    <td>
                        <%=miUser.getApellidosCliente()%>
                    </td>
                    <td>
                        <%=miUser.getDniCliente()%>
                    </td>
                    <td>
                        <%=miUser.getPasswordCliente()%>
                    </td>
                    <td>
                        <%=miUser.getPerfilCliente()%>
                    </td>
                    <td>
                        <%
                            int estado = miUser.getEstadoCliente();
                            String estadoCliente = "";
                            if (estado == 1) {
                                estadoCliente = "Activo";
                            } else {
                                estadoCliente = "Inactivo";
                            }
                        %>
                        <%=estadoCliente%>
                    </td>
                    <td align="center">
                        <%

                        %>
                        <input type="button" name="btnDarBaja" class="boton" value="Dar de baja" id="btnDarBaja" class="boton" onclick ="location.href = '../Servlet_Usuario?dniCliente=<%=miUser.getDniCliente()%>&&accion=darBaja'">
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </form>
    </body>
</html>
