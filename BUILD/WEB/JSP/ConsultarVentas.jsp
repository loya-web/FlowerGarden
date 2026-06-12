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

    <title>Consultar Ventas</title>

    <link href="../CSS/ConsultarVentas.css"
          rel="stylesheet"
          type="text/css"/>

</head>

<body>

<%
    int totalVentas = 0;

    Connection con =
            Conexion.conectar();

    PreparedStatement st =
            con.prepareStatement(
                    "SELECT COUNT(*) AS totalVentas " +
                    "FROM Ventas"
            );

    ResultSet rs =
            st.executeQuery();

    if(rs.next()){

        totalVentas =
                rs.getInt("totalVentas");
    }

    String sql =
            "SELECT idVentas, producto, precio, descripcion, imagen, " +
            "nombre, appat, apmat, email, celular, " +
            "estado, ciudad, colonia, calle, cp, " +
            "fechaVenta, estadoPago, estadoEntrega, tipoPago " +
            "FROM Ventas " +
            "INNER JOIN Catalogo " +
            "ON Catalogo.idProducto = Ventas.Catalogo_idProducto " +
            "INNER JOIN Cliente " +
            "ON Cliente.idCliente = Ventas.Cliente_idCliente " +
            "ORDER BY Ventas.fechaVenta DESC";

    PreparedStatement st2 =
            con.prepareStatement(sql);

    ResultSet res =
            st2.executeQuery();

    double totalIngresos = 0;
%>

<header>

    <nav>

        <img src="../Imagenes/Flor.png"
             alt="Flor"
             width="50"
             height="50"/>

        <h2>Panel de Ventas</h2>

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

        <h3>Total de Ventas</h3>

        <p><%= totalVentas %></p>

    </div>

</section>

<section class="sales-container">

<%
    while(res.next()){

        totalIngresos +=
                res.getDouble("precio");
%>

<div class="sale-card">

    <div class="sale-header">

        <div class="sale-image">

            <img src="../ImagenesProductos/<%= res.getString("imagen") %>"
                 alt="<%= res.getString("producto") %>">

        </div>

        <div class="sale-main">

            <div class="top">

                <div>

                    <h2>
                        <%= res.getString("producto") %>
                    </h2>

                    <p class="sale-id">
                        Venta #<%= res.getInt("idVentas") %>
                    </p>

                </div>

                <div class="price">

                    $ <%= res.getDouble("precio") %>

                </div>

            </div>

        </div>

    </div>

    <div class="description">

        <p>
            <%= res.getString("descripcion") %>
        </p>

    </div>

    <div class="extra-info">

        <div class="info-mini">

            <h4>Fecha de Venta</h4>

            <p>
                <%= res.getString("fechaVenta") %>
            </p>

        </div>

        <div class="info-mini">

            <h4>Tipo de Pago</h4>

            <p class="estado">
                <%= res.getString("tipoPago") %>
            </p>

        </div>

        <div class="info-mini">

            <h4>Estado de Pago</h4>

            <p class="estado">
                <%= res.getString("estadoPago") %>
            </p>

        </div>

        <div class="info-mini">

            <h4>Entrega</h4>

            <p class="estado">
                <%= res.getString("estadoEntrega") %>
            </p>

        </div>

    </div>

    <div class="customer">

        <h3>Cliente</h3>

        <p>

            <%= res.getString("nombre") %>
            <%= res.getString("appat") %>
            <%= res.getString("apmat") %>

        </p>

    </div>

    <div class="contact-grid">

        <div class="info-box">

            <h4>Correo</h4>

            <p>
                <%= res.getString("email") %>
            </p>

        </div>

        <div class="info-box">

            <h4>Celular</h4>

            <p>
                <%= res.getString("celular") %>
            </p>

        </div>

    </div>

    <div class="address">

        <h4>Dirección</h4>

        <p>

            <%= res.getString("calle") %>,
            <%= res.getString("colonia") %>,
            <%= res.getString("ciudad") %>,
            <%= res.getString("estado") %>,
            C.P. <%= res.getInt("cp") %>

        </p>

    </div>

    <form class="update-form"
          action="ActualizarEstadoVenta.jsp"
          method="post">

        <input type="hidden"
               name="idVenta"
               value="<%=res.getInt("idVentas")%>">

        <div class="select-group">

            <div>

                <label>
                    Estado de Pago
                </label>

                <select name="estadoPago">

                    <option>No pagado</option>
                    
                    <option>Pagado</option>

                </select>

            </div>

            <div>

                <label>
                    Estado de Entrega
                </label>

                <select name="estadoEntrega">

                    <option>Pendiente</option>

                    <option>En camino</option>

                    <option>Entregado</option>

                </select>

            </div>

        </div>

        <button type="submit">

            Actualizar Estado

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