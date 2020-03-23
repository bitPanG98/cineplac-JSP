/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import static modelo.GestionarUsuario.obtenerCodigo;

/**
 *
 * @author Poolvazo
 */
public class GestionarSuscribirse {

    public GestionarSuscribirse() {

    }

    public static String registrarUsaurio(String dniCliente, String nombreCliente, String apellidosCliente, String usuario, String password, String perfil) {

        Connection con;
        ConexionBD conectarBD = new ConexionBD();
        con = conectarBD.conectarBD();

        String mensaje = "";
        int codigoCliente = obtenerCodigo();
        try {

            int num = 0;
            String sql_verififcar = "SELECT count(*) FROM clientes WHERE dni_cliente=" + dniCliente;
            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_verififcar);

            while (rs.next()) {
                num = rs.getInt(1);
            }

            if (num == 0) {
                
                String sql_registraCliente = "INSERT INTO clientes VALUES(?,?,?,?,?)";

                String sql_registrarUsuario = "INSERT INTO usuarios VALUES(?,?,?,?,?,?)";

                PreparedStatement prepaS = con.prepareCall(sql_registraCliente);
                prepaS.setInt(1, codigoCliente);
                prepaS.setString(2, dniCliente.trim());
                prepaS.setString(3, nombreCliente.trim());
                prepaS.setString(4, apellidosCliente.trim());
                prepaS.setInt(5, 1);

                int resultado = prepaS.executeUpdate();

                if (resultado > 0) {

                    PreparedStatement prepaS1 = con.prepareCall(sql_registrarUsuario);
                    prepaS1.setString(1, null);
                    prepaS1.setString(2, dniCliente);
                    prepaS1.setString(3, password.trim());
                    prepaS1.setString(4, perfil.trim());
                    prepaS1.setInt(5, codigoCliente);
                    prepaS1.setInt(6, 1);

                    int resul = prepaS1.executeUpdate();
                    if (resul > 0) {
                        System.out.println("Se registro el usuario");
                    } else {
                        System.out.println("No s eregistro usuario");
                    }

                    mensaje = "Exito";

                } else {
                    mensaje = "Ocurrio un error al guardar los datos";
                }

            } else {
                mensaje = "Usuario ya registrado, verifique DNI";
            }
        } catch (SQLException ex) {
            System.out.println("Exceptio SQL -> " + ex.getMessage());
            mensaje = "Exceptio SQL -> " + ex.getMessage();
        }

        return mensaje;
    }

}
