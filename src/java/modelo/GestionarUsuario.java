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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Poolvazo
 */
public class GestionarUsuario {

    public static int obtenerCodigo() {

        Connection con;

        ConexionBD cBD = new ConexionBD();
        con = cBD.conectarBD();

        int codigoCliente = 0;

        try {

            String sql_obtenerID = "SELECT max(c.cod_cliente)+1 FROM clientes c";

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_obtenerID);

            while (rs.next()) {
                codigoCliente = rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.out.println("Exception SQL -> " + ex.getMessage());
        }

        return codigoCliente;
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

            }else{
                mensaje = "Usuario ya registrado, verifique DNI";
            }
        } catch (SQLException ex) {
            System.out.println("Exceptio SQL -> " + ex.getMessage());
            mensaje = "Exceptio SQL -> " + ex.getMessage();
        }

        return mensaje;
    }

    public static ArrayList<Usuario> CargarUsuarios() {

        ArrayList<Usuario> listaUsuarios = new ArrayList<Usuario>();

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            String sql_CargarDatos = "SELECT c.cod_cliente, c.dni_cliente, c.nombre_cliente, c.apellidos_cliente, u.dni_user, u.password_user, u.perfil, c.estado_cliente "
                    + "FROM clientes c, usuarios u "
                    + "WHERE c.cod_cliente=u.cod_cliente";

            Statement sta = con.createStatement();
            ResultSet rs = sta.executeQuery(sql_CargarDatos);

            while (rs.next()) {

                Usuario miUser = new Usuario();
                miUser.setCodigoCliente(rs.getInt(1));
                miUser.setDniCliente(rs.getString("dni_cliente"));
                miUser.setNombreCliente(rs.getString("nombre_cliente"));
                miUser.setApellidosCliente(rs.getString("apellidos_cliente"));
                miUser.setDniUsuario(rs.getString("dni_user"));
                miUser.setPasswordCliente(rs.getString("password_user"));
                miUser.setPerfilCliente(rs.getString("perfil"));
                miUser.setEstadoCliente(rs.getInt(8));

                listaUsuarios.add(miUser);

            }

        } catch (Exception e) {
            System.out.println(e);
        }

        return listaUsuarios;
    }

    public static String DarDeBajaUsuario(String dniCliente) {

        String mensaje = "Fallo";

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            CallableStatement cs = con.prepareCall("CALL sp_bajaCliente (?)");
            cs.setString(1, dniCliente);

            int respuesta = cs.executeUpdate();
            if (respuesta > 0) {

                String sql_inhabilitarUser = "UPDATE usuarios SET estado_user=0 WHERE dni_user=?";
                PreparedStatement prepaS = con.prepareCall(sql_inhabilitarUser);
                prepaS.setString(1, dniCliente);

                int resp = prepaS.executeUpdate();
                if (resp > 0) {
                    System.out.println("Usuario inhabilitado");
                } else {
                    System.out.println("Ocrrior un error");
                }

                mensaje = "Exito";

            } else {
                mensaje = "Fallo";
            }

        } catch (SQLException ex) {
            System.out.println(ex);
            mensaje = "Excepcion SQL -> " + ex.getMessage();
        }

        return mensaje;
    }
}
