/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import modelo.ConexionBD;
import modelo.GestionarLogeo;
import modelo.Logeo;

/**
 *
 * @author Poolvazo
 */
@WebServlet(name = "Servlet_Logeo", urlPatterns = {"/Servlet_Logeo"})
public class Servlet_Logeo extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        Login(request, response);
        
        
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    
    private void Login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
                
        String mensaje;
        
        String usuario = request.getParameter("caja-usuario").trim();
        String password = request.getParameter("caja-password").trim();              
        
        try{
            
            if (usuario.equals("") || password.equals("")) {
            
                mensaje = " Debe completar todos los campos :) ";
                response.sendRedirect("vistas/form_mensajes.jsp?mensaje="+mensaje);
                
                //request.setAttribute("text-mensaje", mensaje);
                //out.println(request.getContextPath());
                //out.println(getServletContext().getRealPath("Vistas")+"/form_login.jsp");
                //request.getRequestDispatcher(getServletContext().getRealPath("Servlet_Logeo.java")+"/form_login.jsp").forward(request, response);
            
            }else{
            
                GestionarLogeo acceder = new GestionarLogeo();
                mensaje = acceder.ingresar(usuario,password, request);

                if (mensaje.equals("Exito")) {             
                    //request.getSession().setAttribute("mensaje", usuario);
                   
                    response.sendRedirect("vistas/form_menu.jsp");

                }else{
                    
                    response.sendRedirect("vistas/form_mensajes.jsp?mensaje="+mensaje);

                    // response.sendRedirect("vistas/form_mensajes.jsp?mensaje='"+mensaje+"'");
                    /*Enviamos nuestro valor  a la pagian jsp atraves del id d eun objeto etiqueta*/
                    //request.setAttribute("text-mensaje", mensaje);
                    /*redirecinamos a la pagina*/
                   // request.getRequestDispatcher(request.getContextPath()+"vistas/form_login.jsp").forward(request, response);

                }
                      
            }
                      
        }catch(Exception ex){
            out.println(ex);
        }
    }
}
