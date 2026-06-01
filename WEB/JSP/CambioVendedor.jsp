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

    Connection con =
            Conexion.conectar();

    PreparedStatement sta =
            con.prepareStatement(
                "SELECT * " +
                "FROM Vendedor " +
                "WHERE Usuario_idUsuario = ?"
            );

    sta.setInt(1, idUsuario);

    ResultSet rs =
            sta.executeQuery();

    if(!rs.next()){
        out.print("No se encontró el vendedor.");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <title>Cambio de Datos</title>

    <link href="../CSS/Cambio1.css"
          rel="stylesheet"
          type="text/css"/>

</head>

<body>

<main>

<section>

    <p>Cambio de Datos</p>

    <form action="ActualizarVendedor.jsp"
          method="post">

        <div class="campo">

            <label for="nombre">
                Nombre:
            </label>

            <input type="text"
                   name="nombre"
                   id="nombre"
                   value="<%=rs.getString("nombre")%>"
                   required>

        </div>

        <div class="campo">

            <label for="ap">
                Apellido Paterno:
            </label>

            <input type="text"
                   name="ap"
                   id="ap"
                   value="<%=rs.getString("appat")%>"
                   required>

        </div>

        <div class="campo">

            <label for="am">
                Apellido Materno:
            </label>

            <input type="text"
                   name="am"
                   id="am"
                   value="<%=rs.getString("apmat")%>"
                   required>

        </div>

        <div class="campo">

            <label for="correo">
                Correo:
            </label>

            <input type="email"
                   name="correo"
                   id="correo"
                   value="<%=rs.getString("email")%>"
                   required>

        </div>

        <div class="campo">

            <label for="toc">
                Teléfono o Celular:
            </label>

            <input type="number"
                   name="toc"
                   id="toc"
                   value="<%=rs.getString("celular")%>"
                   required>

        </div>

        <button type="submit">

            Cambiar Datos

        </button>

    </form>

</section>

</main>

<a href="PerfilVendedor.jsp"
   class="btn-regresar">

   ⬅ Volver al Perfil

</a>

<footer>

    &COPY; Flower Garden - Gestión de plantas y jardinería

</footer>

</body>
</html>