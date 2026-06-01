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

    if(!"CLIENTE".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }

    Integer idUsuario =
            (Integer) session.getAttribute("idUsuario");

    String nombrePerfil =
            (String) session.getAttribute("nombre");

    Connection con =
            Conexion.conectar();

    int idCliente = 0;

    PreparedStatement stCliente =
            con.prepareStatement(
                "SELECT idCliente " +
                "FROM Cliente " +
                "WHERE Usuario_idUsuario = ?"
            );

    stCliente.setInt(1, idUsuario);

    ResultSet rsCliente =
            stCliente.executeQuery();

    if(rsCliente.next()){
        idCliente =
                rsCliente.getInt("idCliente");
    }

    int totalVentas = 0;

    PreparedStatement st =
            con.prepareStatement(
                "SELECT COUNT(*) AS totalVentas " +
                "FROM Ventas " +
                "WHERE Cliente_idCliente = ?"
            );

    st.setInt(1, idCliente);

    ResultSet rs = st.executeQuery();

    if(rs.next()){
        totalVentas = rs.getInt("totalVentas");
    }

    int[] idVenta = new int[totalVentas];
    int[] idProducto = new int[totalVentas];
    String[] producto = new String[totalVentas];
    double[] precio = new double[totalVentas];
    String[] descripcion = new String[totalVentas];
    String[] fechaVenta = new String[totalVentas];
    String[] estadoPago = new String[totalVentas];
    String[] estadoEntrega = new String[totalVentas];

    double total = 0;

    String sql =
            "SELECT Ventas.idVentas, " +
            "Catalogo.idProducto, " +
            "Catalogo.producto, " +
            "Catalogo.precio, " +
            "Catalogo.descripcion, " +
            "Ventas.fechaVenta, " +
            "Ventas.estadoPago, " +
            "Ventas.estadoEntrega " +
            "FROM Ventas " +
            "INNER JOIN Catalogo " +
            "ON Catalogo.idProducto = Ventas.Catalogo_idProducto " +
            "WHERE Ventas.Cliente_idCliente = ? " +
            "ORDER BY Ventas.fechaVenta DESC";

    PreparedStatement st2 =
            con.prepareStatement(sql);

    st2.setInt(1, idCliente);

    ResultSet res =
            st2.executeQuery();

    for(int i = 0; i < totalVentas; i++){

        if(res.next()){

            idVenta[i] =
                    res.getInt("idVentas");

            idProducto[i] =
                    res.getInt("idProducto");

            producto[i] =
                    res.getString("producto");

            precio[i] =
                    res.getDouble("precio");

            descripcion[i] =
                    res.getString("descripcion");

            fechaVenta[i] =
                    res.getString("fechaVenta");

            estadoPago[i] =
                    res.getString("estadoPago");

            estadoEntrega[i] =
                    res.getString("estadoEntrega");

            total += precio[i];
        }
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <title>Carrito de Compras</title>

    <link href="../CSS/Carrito2.css"
          rel="stylesheet"
          type="text/css"/>

</head>

<body>

<header>

    <nav>

        <img src="../Imagenes/Flor.png"
             alt="Flor"
             width="50"
             height="50"/>

        <h2>Mis Pedidos</h2>

        <a href="../logout">

            <img src="../Imagenes/Salida.png"
                 alt="Salir"
                 width="50"
                 height="50"/>

        </a>

    </nav>

</header>

<main>

    <section class="summary">

        <div class="summary-card">

            <h3>Total de productos</h3>

            <p><%= totalVentas %></p>

        </div>

        <div class="summary-card">

            <h3>Total estimado</h3>

            <p>$ <%= total %></p>

        </div>

    </section>

    <section class="products">

        <%
            if(totalVentas == 0){
        %>

        <div class="empty-cart">

            <h2>Tu carrito está vacío</h2>

            <p>
                Explora el catálogo y agrega productos.
            </p>

        </div>

        <%
            }else{

                for(int j = 0; j < totalVentas; j++){
        %>

        <div class="product-card">

            <div class="product-image">

                <img src="../Imagenes/Maceta.png"
                     alt="Producto"
                     width="90"
                     height="90"/>

            </div>

            <div class="product-info">

                <div class="top-info">

                    <div>

                        <h2><%= producto[j] %></h2>

                        <p class="description">
                            <%= descripcion[j] %>
                        </p>

                    </div>

                    <div class="product-price">

                        <p>$ <%= precio[j] %></p>

                    </div>

                </div>

                <div class="details">

                    <span>
                        Venta #<%= idVenta[j] %>
                    </span>

                    <span>
                        Producto #<%= idProducto[j] %>
                    </span>

                    <span class="date">
                        📅 <%= fechaVenta[j] %>
                    </span>

                </div>

                <div class="status-container">

                    <div class="status-box pago">

                        <h4>Estado de Pago</h4>

                        <p><%= estadoPago[j] %></p>

                    </div>

                    <div class="status-box entrega">

                        <h4>Entrega</h4>

                        <p><%= estadoEntrega[j] %></p>

                    </div>

                </div>

            </div>

        </div>

        <%
                }
            }
        %>

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