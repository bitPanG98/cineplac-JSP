<%-- 
    Document   : form_login
    Created on : 24-nov-2018, 0:43:53
    Author     : Poolvazo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Inicio de Sesion </title>
        
        <link rel='stylesheet' type='text/css' href='../css/personalizar/componentes.css'>

        <script src="../js/validacion.js"></script>
    </head>
    <body>

        <%
            if (request.getParameter("cerrar") != null) {
                session.invalidate();
            }
        %>
        <div>
            <form id='form-login' name='form-login' method='post' action='../Servlet_Logeo'>

                <div>
                    <table border='0' width='40%' align='center'>
                        <tr>
                            <td align='center' height='70' >
                                <p class='texto_cabezera'> Iniciar Sesion </p>
                            </td>
                        </tr>
                    </table>
                </div>

                <div>
                    <table border='0' width='40%' align='center'  bgcolor='#85F5DB' >

                        <tr>		
                            <td rowspan='4' width='30%' align='center' >
                                <img src='../imagenes/security2.png'  width='150px' height='' border='0'>
                            </td>

                            <td width='25%' height='50px' align='right'>			
                                Usuario ->
                            </td>
                            <td align='center'>			
                                <input type='text' name='caja-usuario' id='caja-usuario' class='caja_texto' maxlength="8" onKeyPress="return SoloNumeros(event);">
                            </td>
                        </tr>

                        <tr>
                            <td width='15%' height='50px' align='right'>
                                Password ->
                            </td>
                            <td align='center'>			
                                <input type='password' name='caja-password' id='caja-password'  class='caja_texto'>
                            </td>
                        </tr>

                        <tr>
                            <td colspan='2' align='center' height='25px' style="background: #F65A50">
                                <label id="text-mensaje" >
                                    <a href="form_suscribirse.jsp">Registrarse</a>
                                </label>
                            </td>
                        </tr>

                        <tr>
                            <td colspan='2' align='center' height="50px">
                                <input type='submit' name='ingresar' value='Ingresar' class='boton_login' onclick="">
                            </td>
                        </tr>

                    </table>
                </div>
            </form>
        </div>
    </body>
</html>
