<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>

<%
    String usuarioSesion =
            (String) session.getAttribute("usuario");

    String rol =
            (String) session.getAttribute("rol");

    Integer idUsuario =
            (Integer) session.getAttribute("idUsuario");

    if(usuarioSesion == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    if(!"CLIENTE".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }

    try{

        Connection con =
                Conexion.conectar();

        PreparedStatement stCliente =
                con.prepareStatement(
                        "SELECT idCliente " +
                        "FROM Cliente " +
                        "WHERE Usuario_idUsuario = ?"
                );

        stCliente.setInt(1, idUsuario);

        ResultSet rs =
                stCliente.executeQuery();

        int idCliente = 0;

        if(rs.next()){
            idCliente = rs.getInt("idCliente");
        }

        PreparedStatement st1 =
                con.prepareStatement(
                        "DELETE FROM Resenas " +
                        "WHERE Cliente_idCliente = ?"
                );

        st1.setInt(1, idCliente);
        st1.executeUpdate();

        PreparedStatement st2 =
                con.prepareStatement(
                        "DELETE FROM Ventas " +
                        "WHERE Cliente_idCliente = ?"
                );

        st2.setInt(1, idCliente);
        st2.executeUpdate();

        PreparedStatement st3 =
                con.prepareStatement(
                        "DELETE FROM Cliente " +
                        "WHERE idCliente = ?"
                );

        st3.setInt(1, idCliente);
        st3.executeUpdate();

        PreparedStatement st4 =
                con.prepareStatement(
                        "DELETE FROM Usuario_Rol " +
                        "WHERE Usuario_idUsuario = ?"
                );

        st4.setInt(1, idUsuario);
        st4.executeUpdate();

        PreparedStatement st5 =
                con.prepareStatement(
                        "DELETE FROM Usuario " +
                        "WHERE idUsuario = ?"
                );

        st5.setInt(1, idUsuario);
        st5.executeUpdate();

        session.invalidate();
%>

<script>

    alert("¡Cuenta eliminada!");

    window.location.href =
            "../index.html";

</script>

<%
    }catch(Exception e){

        out.println(
                "Error: "
                + e.getMessage()
        );
    }
%>