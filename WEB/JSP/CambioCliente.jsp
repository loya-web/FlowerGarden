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

    Connection con =
            Conexion.conectar();

    PreparedStatement sta =
            con.prepareStatement(
                "SELECT C.*, U.contrasena " +
                "FROM Cliente C " +
                "INNER JOIN Usuario U " +
                "ON U.idUsuario = C.Usuario_idUsuario " +
                "WHERE Usuario_idUsuario = ?"
            );

    sta.setInt(1, idUsuario);

    ResultSet rs = sta.executeQuery();

    if (!rs.next()) {
        out.print("No se encontró el cliente");
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

    <form action="../JSP/ActualizarCliente.jsp"
          method="post">

        <div class="campo">

            <label>Nombre:</label>

            <input type="text"
                   name="nombre"
                   value="<%=rs.getString("nombre")%>"
                   readonly
                   required>

        </div>

        <div class="campo">

            <label>Apellido Paterno:</label>

            <input type="text"
                   name="ap"
                   value="<%=rs.getString("appat")%>"
                   readonly
                   required>

        </div>

        <div class="campo">

            <label>Apellido Materno:</label>

            <input type="text"
                   name="am"
                   value="<%=rs.getString("apmat")%>"
                   readonly
                   required>

        </div>

        <div class="campo">

            <label>Correo:</label>

            <input type="email"
                   name="correo"
                   value="<%=rs.getString("email")%>"
                   required>

        </div>

        <div class="campo">

            <label>Teléfono:</label>

            <input type="number"
                   name="toc"
                   value="<%=rs.getString("celular")%>"
                   required>

        </div>
                   
        <div class="campo">

            <label for="pwd">
                Contraseña:
            </label>

            <div class="password-container">

                <input type="password"
                       name="pwd"
                       id="pwd"
                       value="<%=rs.getString("contrasena")%>"
                       maxlength="50"
                       pattern="^(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$"
                       title="La contraseña debe tener mínimo 8 caracteres, una mayúscula, un número y un carácter especial."
                       required>

                <button type="button"
                        class="toggle-password"
                        onclick="togglePassword()">

                    👁

                </button>

            </div>

            <small>
                Mínimo 8 caracteres, una mayúscula,
                un número y un carácter especial.
            </small>

        </div>

        <p>Dirección</p>

        <div class="campo">

            <label>Estado:</label>

            <input type="text"
                   name="est"
                   value="<%=rs.getString("estado")%>"
                   required>

        </div>

        <div class="campo">

            <label>Ciudad:</label>

            <input type="text"
                   name="cd"
                   value="<%=rs.getString("ciudad")%>"
                   required>

        </div>

        <div class="campo">

            <label>Colonia:</label>

            <input type="text"
                   name="col"
                   value="<%=rs.getString("colonia")%>"
                   required>

        </div>

        <div class="campo">

            <label>Calle:</label>

            <input type="text"
                   name="calle"
                   value="<%=rs.getString("calle")%>"
                   required>

        </div>

        <div class="campo">

            <label>Código Postal:</label>

            <input type="number"
                   name="cp"
                   value="<%=rs.getInt("cp")%>"
                   required>

        </div>

        <button type="submit">
            Cambiar Datos
        </button>

    </form>

</section>

</main>

<a href="PerfilCliente.jsp"
   class="btn-regresar">

    ⬅ Volver al Perfil

</a>
<script>

function togglePassword(){

    const campo =
            document.getElementById("pwd");

    if(campo.type === "password"){

        campo.type = "text";

    }else{

        campo.type = "password";
    }
}

</script>
</body>

</html>