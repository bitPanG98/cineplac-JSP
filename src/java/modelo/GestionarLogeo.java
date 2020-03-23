package modelo;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Poolvazo
 */
public class GestionarLogeo {

    public GestionarLogeo() {

    }

    public static String ingresar(String usuario, String password, HttpServletRequest request) {

        HttpSession session = request.getSession();

        String mensaje = "Fallo";
        boolean encontro = false;

        Connection con;
        ConexionBD conBD = new ConexionBD();
        con = conBD.conectarBD();

        try {

            CallableStatement cs = con.prepareCall("CALL sp_logueo (?, ?)");

            cs.setString(1, usuario);
            cs.setString(2, password);

            ResultSet resultado = cs.executeQuery();

            while (resultado.next()) {

                encontro = true;

                Logeo login = new Logeo();
                login.setUsuario(resultado.getString("dni_user"));
                login.setPerfil(resultado.getString("perfil"));
                
                session.setAttribute("usuario_acceso", resultado.getString("dni_user"));
                session.setAttribute("perfil", resultado.getString("perfil"));


            }

            if (encontro) {
                mensaje = "Exito";
            } else {
                mensaje = "Usuario o Password incorrectos :(";
            }

        } catch (SQLException e) {
            System.out.println(e);
            mensaje = "Ocurrio una excepcion SQL -> " + e.getMessage();
        }

        return mensaje;
    }

}
