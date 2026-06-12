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
                "SELECT V.*, U.contrasena " +
                "FROM Vendedor V " +
                "INNER JOIN Usuario U " +
                "ON U.idUsuario = V.Usuario_idUsuario " +
                "WHERE V.Usuario_idUsuario = ?"
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
                   readonly
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
                   readonly
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
                   readonly
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
        <div class="campo">
            <label for="clabe">
                CLABE:
            </label>
            <input type="text"
                name="clabe"
                id="clabe"
                maxlength="18"
                pattern="[0-9]{18}"
                title="La CLABE debe contener 18 dígitos"
                value="<%=rs.getString("clabe")%>"
                required>
        </div>

        <div class="campo">
            <label for="entidadFinanciera">
                Entidad Financiera:
            </label>
            <input type="text"
                   name="entidadFinanciera"
                   id="entidadFinanciera"
                   value="<%=rs.getString("entidadFinanciera")%>"
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