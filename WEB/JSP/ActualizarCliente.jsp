<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>

<%
    String usuarioSesion =
            (String) session.getAttribute("usuario");

    String rol =
            (String) session.getAttribute("rol");

    if (usuarioSesion == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    if (!"CLIENTE".equals(rol)) {
        response.sendRedirect("../index.html");
        return;
    }

    Integer idUsuario =
            (Integer) session.getAttribute("idUsuario");

    String nombre = request.getParameter("nombre");
    String apat = request.getParameter("ap");
    String amat = request.getParameter("am");
    String correo = request.getParameter("correo");
    String cel = request.getParameter("toc");
    String est = request.getParameter("est");
    String cd = request.getParameter("cd");
    String col = request.getParameter("col");
    String calle = request.getParameter("calle");
    String cp = request.getParameter("cp");

    Connection con = null;

    try {

        con = Conexion.conectar();

        con.setAutoCommit(false);

        // ======================================
        // 1. ACTUALIZAR USUARIO (LOGIN NAME)
        // ======================================
        PreparedStatement stUsuario =
                con.prepareStatement(
                    "UPDATE Usuario SET usuario = ? WHERE idUsuario = ?"
                );

        stUsuario.setString(1, nombre);
        stUsuario.setInt(2, idUsuario);

        stUsuario.executeUpdate();

        // ======================================
        // 2. ACTUALIZAR CLIENTE (PERFIL)
        // ======================================
        PreparedStatement stCliente =
                con.prepareStatement(
                    "UPDATE Cliente SET " +
                    "email = ?, " +
                    "celular = ?, " +
                    "appat = ?, " +
                    "apmat = ?, " +
                    "nombre = ?, " +
                    "estado = ?, " +
                    "ciudad = ?, " +
                    "colonia = ?, " +
                    "calle = ?, " +
                    "cp = ? " +
                    "WHERE Usuario_idUsuario = ?"
                );

        stCliente.setString(1, correo);
        stCliente.setString(2, cel);
        stCliente.setString(3, apat);
        stCliente.setString(4, amat);
        stCliente.setString(5, nombre);
        stCliente.setString(6, est);
        stCliente.setString(7, cd);
        stCliente.setString(8, col);
        stCliente.setString(9, calle);
        stCliente.setInt(10, Integer.parseInt(cp));
        stCliente.setInt(11, idUsuario);

        stCliente.executeUpdate();

        con.commit();

        // actualizar sesión también
        session.setAttribute("nombre", nombre);
        session.setAttribute("usuario", nombre);

%>

<script>
    alert("¡Datos actualizados correctamente!");
    window.location.href = "../JSP/PerfilCliente.jsp";
</script>

<%
    } catch (Exception e) {

        if (con != null) {
            try {
                con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        out.print("Error: " + e.getMessage());
        e.printStackTrace();

    } finally {
        if (con != null) {
            try {
                con.setAutoCommit(true);
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>