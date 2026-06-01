<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>

<%
    String nombre = request.getParameter("nombre");
    String apat = request.getParameter("ap");
    String amat = request.getParameter("am");
    String correo = request.getParameter("correo");
    String cel = request.getParameter("toc");
    String contra = request.getParameter("pwd");
    String est = request.getParameter("est");
    String cd = request.getParameter("cd");
    String col = request.getParameter("col");
    String calle = request.getParameter("calle");
    String cp = request.getParameter("cp");

    Connection con = null;

    try {
        con = Conexion.conectar();

        con.setAutoCommit(false);

        // =========================
        // 1. INSERT EN USUARIO
        // Usuario.usuario = nombre
        // =========================
        PreparedStatement userStmt =
            con.prepareStatement(
                "INSERT INTO Usuario (usuario, contrasena) VALUES (?, ?)",
                Statement.RETURN_GENERATED_KEYS
            );

        userStmt.setString(1, nombre);   // 👈 CAMBIO IMPORTANTE
        userStmt.setString(2, contra);

        userStmt.executeUpdate();

        ResultSet rsUser = userStmt.getGeneratedKeys();

        int idUsuario = 0;

        if (rsUser.next()) {
            idUsuario = rsUser.getInt(1);
        }

        // =========================
        // 2. ASIGNAR ROL CLIENTE
        // =========================
        PreparedStatement rolStmt =
            con.prepareStatement(
                "INSERT INTO Usuario_Rol (Usuario_idUsuario, Rol_idRol) " +
                "VALUES (?, (SELECT idRol FROM Rol WHERE rol = 'CLIENTE'))"
            );

        rolStmt.setInt(1, idUsuario);
        rolStmt.executeUpdate();

        // =========================
        // 3. INSERT EN CLIENTE
        // (SIN CONTRASEÑA)
        // =========================
        PreparedStatement clienteStmt =
            con.prepareStatement(
                "INSERT INTO Cliente " +
                "(email, celular, appat, apmat, nombre, estado, ciudad, colonia, calle, cp, Usuario_idUsuario) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );

        clienteStmt.setString(1, correo);
        clienteStmt.setString(2, cel);
        clienteStmt.setString(3, apat);
        clienteStmt.setString(4, amat);
        clienteStmt.setString(5, nombre);
        clienteStmt.setString(6, est);
        clienteStmt.setString(7, cd);
        clienteStmt.setString(8, col);
        clienteStmt.setString(9, calle);
        clienteStmt.setInt(10, Integer.parseInt(cp));
        clienteStmt.setInt(11, idUsuario);

        clienteStmt.executeUpdate();

        con.commit();
%>

<script>
    alert("¡Registro exitoso!");
    window.location.href = "../login.jsp";
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

        out.print("Error en registro: " + e.getMessage());
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