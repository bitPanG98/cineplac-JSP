<%-- 
    Document   : form_suscribirse
    Created on : 24-nov-2018, 7:59:27
    Author     : Poolvazo
--%>

<%@page import="modelo.GestionarUsuario"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="modelo.ConexionBD"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Suscribirse</title>

        <script src="../js/validacion.js"></script>
        <link rel='stylesheet' type='text/css' href='../css/personalizar/componentes.css'>

        <script type="text/javascript">
            function obtenerValor()
            {
                document.getElementById("caja-usuario").value = document.getElementById("caja-dniC").value;
            }

        </script>
    </head>
    <body>
        <form id="form-suscribirse" name="form-suscribirse" method="post" action="../Servlet_Suscribirse">
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
                        <%
                            int codigo = GestionarUsuario.obtenerCodigo();
                        %>
                        <input type="text" length="8" id="caja-codigoC" name="caja-codigoC" value="<%=codigo%>" disabled>
                    </td>
                </tr>
                <tr>
                    <td align="right" width='30%' height='50px' >
                        DNI :
                    </td>
                    <td width='55%'>
                        <input type="text" onkeyup="obtenerValor()" id="caja-dniC" name="caja-dniC" maxlength="8" onKeyPress="return SoloNumeros(event);"  required>
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
                        <input type="text" id="caja-apellidosC" name="caja-apellidosC" onkeypress="return soloLetras(event);" required>
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

                <tr bgcolor="#6C84E8">
                    <td width='45%' height='50px' align="center" colspan="2">
                        <input type="submit" name="registrar" class="boton" value="Registrar">
                        <input type="button" name="cancelar" class="boton" value="Cancelar" onclick="location.href = 'form_menu.jsp'">
                    </td>

                </tr>
            </table>
        </form>
    </body>
</html>
