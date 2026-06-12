<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>

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
%>

<!DOCTYPE html>
<html>

<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <title>Catalogo de Productos</title>

    <link href="../CSS/Catalogo2.css"
          rel="stylesheet"
          type="text/css"/>

</head>

<body>

<header>

    <nav>

        <img src="../Imagenes/Flor.png"
             alt="Logo"
             width="50"
             height="50"/>

        <div></div>

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

<%
    Connection con =
            Conexion.conectar();

    PreparedStatement st =
            con.prepareStatement(
                    "SELECT idProducto, " +
                    "producto, " +
                    "precio, " +
                    "descripcion, " +
                    "imagen " +
                    "FROM Catalogo"
            );

    ResultSet rs =
            st.executeQuery();

    while(rs.next()){
%>

<div>

    <img class="producto-img"
         src="../ImagenesProductos/<%= rs.getString("imagen") %>"
         alt="<%= rs.getString("producto") %>">

    <p>
        Id: <%= rs.getInt("idProducto") %>
    </p>

    <p>
        Nombre: <%= rs.getString("producto") %>
    </p>

    <p>
        Precio: $<%= rs.getDouble("precio") %>
    </p>

    <p>
        <%= rs.getString("descripcion") %>
    </p>

    <form action="EliminarProducto.jsp"
          method="post">

        <input type="hidden"
               name="idProducto"
               value="<%= rs.getInt("idProducto") %>">

        <button type="submit">

            Eliminar

        </button>

    </form>

    <form action="ConsultarResenas.jsp"
          method="post">

        <input type="hidden"
               name="idProducto"
               value="<%= rs.getInt("idProducto") %>">

        <button type="submit">

            Ver Reseñas

        </button>

    </form>

</div>

<%
    }
%>

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