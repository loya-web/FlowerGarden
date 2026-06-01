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
    Integer idUsuario =
            (Integer) session.getAttribute("idUsuario");

    int idVendedor = 0;

    Connection con =
            Conexion.conectar();

    PreparedStatement stVend =
            con.prepareStatement(
                    "SELECT idVendedor " +
                    "FROM Vendedor " +
                    "WHERE Usuario_idUsuario = ?"
            );

    stVend.setInt(1, idUsuario);

    ResultSet rsVend =
            stVend.executeQuery();

    if(rsVend.next()){
        idVendedor =
                rsVend.getInt("idVendedor");
    }

    int totalProductos = 0;

    PreparedStatement st =
            con.prepareStatement(
                    "SELECT COUNT(*) AS totalProductos " +
                    "FROM Catalogo"
            );

    ResultSet rs =
            st.executeQuery();

    if(rs.next()){
        totalProductos =
                rs.getInt("totalProductos");
    }

    int[] idProducto =
            new int[totalProductos];

    String[] producto =
            new String[totalProductos];

    double[] precio =
            new double[totalProductos];

    String[] descripcion =
            new String[totalProductos];

    PreparedStatement st2 =
            con.prepareStatement(
                    "SELECT idProducto, producto, precio, descripcion " +
                    "FROM Catalogo"
            );

    ResultSet res =
            st2.executeQuery();

    for(int i=0;i<totalProductos;i++){

        if(res.next()){

            idProducto[i] =
                    res.getInt("idProducto");

            producto[i] =
                    res.getString("producto");

            precio[i] =
                    res.getDouble("precio");

            descripcion[i] =
                    res.getString("descripcion");
        }
    }

    for(int j=0;j<totalProductos;j++){
%>

<div>

    <p>Id: <%=idProducto[j]%></p>

    <p>Nombre: <%=producto[j]%></p>

    <p>Precio: $<%=precio[j]%></p>

    <p><%=descripcion[j]%></p>

    <form action="EliminarProducto.jsp"
          method="post">

        <button type="submit">

            Eliminar

        </button>

    </form>

    <form action="ConsultarResenas.jsp?idProducto=<%=idProducto[j]%>"
          method="post">

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