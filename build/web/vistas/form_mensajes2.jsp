<%-- 
    Document   : form_mensajes2
    Created on : 24-nov-2018, 14:40:35
    Author     : Poolvazo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mensaje</title>
    </head>
    <body>
        <table align="center" width="30%" border="1" style="border-collapse: collapse;">
            <tr>
                <td align="center" height="20px" bgcolor="#3BF5B4">
                    <image src="../imagenes/iconos-boton/alerta.png" width='30px' height='' border='0'/>
                    <br>
                    Mensaje :
                </td>
            </tr>
            <tr>
                <td align="center" height="50px" bgcolor="#B0ED9C">
                <%
                    if(request.getParameter("mensaje")!=null){
                        out.println(request.getParameter("mensaje"));
                    }
                %> 
                </td>
            </tr>
            
            <tr>
                <td align="center" height="15px" bgcolor="">
                    <a href="form_menu.jsp" > 
                    <image src="../imagenes/iconos-boton/regresar1.png" width='50px' height='20px' border='0' />
                    </a>
                </td>
            </tr>
        </table>  
    </body>
</html>
