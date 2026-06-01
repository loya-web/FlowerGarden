package controlador;

import Conectadita.Conexion;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String usuario =
                request.getParameter("j_username");

        String contrasena =
                request.getParameter("j_password");

        Connection con = null;

        try {

            con = Conexion.conectar();

            String sql =
                    "SELECT U.idUsuario, R.rol " +
                    "FROM Usuario U " +
                    "INNER JOIN Usuario_Rol UR " +
                    "ON U.idUsuario = UR.Usuario_idUsuario " +
                    "INNER JOIN Rol R " +
                    "ON R.idRol = UR.Rol_idRol " +
                    "WHERE U.usuario = ? " +
                    "AND U.contrasena = ?";

            PreparedStatement st =
                    con.prepareStatement(sql);

            st.setString(1, usuario);
            st.setString(2, contrasena);

            ResultSet rs =
                    st.executeQuery();

            if (rs.next()) {

                int idUsuario =
                        rs.getInt("idUsuario");

                String rol =
                        rs.getString("rol");

                HttpSession session =
                        request.getSession();

                session.setAttribute(
                        "usuario",
                        usuario);

                session.setAttribute(
                        "rol",
                        rol);

                session.setAttribute(
                        "idUsuario",
                        idUsuario);

                if (rol.equalsIgnoreCase("CLIENTE")) {

                    String nombre = "";

                    PreparedStatement stCliente =
                            con.prepareStatement(
                                    "SELECT nombre " +
                                    "FROM Cliente " +
                                    "WHERE Usuario_idUsuario = ?"
                            );

                    stCliente.setInt(
                            1,
                            idUsuario);

                    ResultSet rsCliente =
                            stCliente.executeQuery();

                    if (rsCliente.next()) {

                        nombre =
                                rsCliente.getString(
                                        "nombre");
                        session.setAttribute("nombre", nombre);
                    }

                    response.sendRedirect(
                        request.getContextPath()
                        + "/JSP/PerfilCliente.jsp");

                } else if (rol.equalsIgnoreCase("VENDEDOR")) {

                    String nombre = "";

                    PreparedStatement stVendedor =
                            con.prepareStatement(
                                    "SELECT nombre " +
                                    "FROM Vendedor " +
                                    "WHERE Usuario_idUsuario = ?"
                            );

                    stVendedor.setInt(
                            1,
                            idUsuario);

                    ResultSet rsVendedor =
                            stVendedor.executeQuery();

                    if (rsVendedor.next()) {

                        nombre =
                                rsVendedor.getString(
                                        "nombre");
                        session.setAttribute("nombre", nombre);
                    }

                    response.sendRedirect(
                        request.getContextPath()
                        + "/JSP/PerfilVendedor.jsp");

                } else if (rol.equalsIgnoreCase("ADMIN")) {

                    response.sendRedirect(
                            request.getContextPath()
                            + "/JSP/Seguro.jsp");
                }

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp?error=1");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?error=1");
        }
    }
}