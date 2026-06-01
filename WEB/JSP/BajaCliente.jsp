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

    Connection con = Conexion.conectar();

    PreparedStatement stCliente =
            con.prepareStatement(
                    "SELECT idCliente, nombre " +
                    "FROM Cliente " +
                    "WHERE Usuario_idUsuario = ?"
            );

    stCliente.setInt(1, idUsuario);

    ResultSet rs = stCliente.executeQuery();

    int idCliente = 0;
    String nombre = "";

    if(rs.next()){
        idCliente = rs.getInt("idCliente");
        nombre = rs.getString("nombre");
    }else{
        response.sendRedirect("PerfilCliente.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Baja de Datos</title>
    <link href="../CSS/Baja3.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<header>
    <nav>

        <img src="../Imagenes/Flor.png"
             alt="Logo"
             width="50"
             height="50"/>

        <p><b>Eliminar Cuenta</b></p>

        <a href="../JSP/ContactoVendedor.jsp">
            <img src="../Imagenes/Telefono.png"
                 alt="Telefono"
                 width="50"
                 height="50"/>
        </a>

    </nav>
</header>

<main>

    <section>

        <p><%= nombre %></p>

        <p>¡Esta acción es IRREVERSIBLE!</p>

        <form action="../JSP/BorrarCliente.jsp"
              method="post">

            <p>
                ¿Estás seguro de eliminar tu usuario?
            </p>

            <button type="submit"
                    class="Confirmar">

                Sí, Eliminar Usuario

            </button>

            <a href="PerfilCliente.jsp">
                Cancelar y Volver
            </a>

        </form>

    </section>

</main>

<a href="PerfilCliente.jsp"
   class="btn-regresar">

    ⬅ Volver al Perfil

</a>

<footer>
    &COPY; Flower Garden - Gestión de plantas y jardinería
</footer>

</body>
</html>