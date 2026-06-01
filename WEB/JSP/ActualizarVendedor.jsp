<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>

<%
    String usuarioSesion =
            (String) session.getAttribute("usuario");

    String rol =
            (String) session.getAttribute("rol");

    if(usuarioSesion == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    if(!"VENDEDOR".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }

    Integer idUsuario =
            (Integer) session.getAttribute("idUsuario");

    String nombre =
            request.getParameter("nombre");

    String apat =
            request.getParameter("ap");

    String amat =
            request.getParameter("am");

    String correo =
            request.getParameter("correo");

    String cel =
            request.getParameter("toc");

    Connection con = null;

    try{

        con = Conexion.conectar();

        con.setAutoCommit(false);

        // ==========================
        // ACTUALIZAR USUARIO
        // ==========================

        PreparedStatement stUsuario =
                con.prepareStatement(
                    "UPDATE Usuario " +
                    "SET usuario = ? " +
                    "WHERE idUsuario = ?"
                );

        stUsuario.setString(1, nombre);
        stUsuario.setInt(2, idUsuario);

        stUsuario.executeUpdate();

        // ==========================
        // ACTUALIZAR VENDEDOR
        // ==========================

        PreparedStatement stVendedor =
                con.prepareStatement(
                    "UPDATE Vendedor " +
                    "SET email = ?, " +
                    "celular = ?, " +
                    "appat = ?, " +
                    "apmat = ?, " +
                    "nombre = ? " +
                    "WHERE Usuario_idUsuario = ?"
                );

        stVendedor.setString(1, correo);
        stVendedor.setString(2, cel);
        stVendedor.setString(3, apat);
        stVendedor.setString(4, amat);
        stVendedor.setString(5, nombre);
        stVendedor.setInt(6, idUsuario);

        stVendedor.executeUpdate();

        con.commit();

        session.setAttribute(
                "nombre",
                nombre);

        session.setAttribute(
                "usuario",
                nombre);
%>

<script>

    alert("¡Datos actualizados correctamente!");

    window.location.href =
            "PerfilVendedor.jsp";

</script>

<%
    }catch(Exception e){

        if(con != null){

            try{

                con.rollback();

            }catch(SQLException ex){

                ex.printStackTrace();
            }
        }

        out.println(
            "Error: "
            + e.getMessage()
        );

        e.printStackTrace();

    }finally{

        if(con != null){

            try{

                con.setAutoCommit(true);
                con.close();

            }catch(SQLException e){

                e.printStackTrace();
            }
        }
    }
%>