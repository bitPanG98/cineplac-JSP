/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Poolvazo
 */
public class ConexionBD {
    
    Connection conectar = null;
    
    
    private final String bd = "proyecto_cineplac";
    private final String user = "root";
    private final String password = "";
    private final String link = "jdbc:mysql://localhost/"+bd;
    
    public Connection conectarBD(){
       
        try{
        
            Class.forName("com.mysql.jdbc.Driver");
            conectar = DriverManager.getConnection(link,user,password);
        
            if (conectar != null) {
                System.out.println("Conexion exitosa a una base de datos"+bd);
            }else{
                System.out.println("Verifique las credenciales de acceso");
            }
            
        }catch (ClassNotFoundException ex){
            System.out.println(" Debe cargar el driver de MySQL");
            
        } catch (SQLException ex) {
            System.out.println("Ocurrio un error SQL: "+ex.getMessage());
        }
        
        return conectar;
    }
    
}
