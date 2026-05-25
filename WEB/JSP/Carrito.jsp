<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>

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

        <%
            int idCliente = Integer.parseInt(
                    request.getParameter("idCliente")
            );

            int totalVentas = 0;

            Connection con;

            con = Conexion.conectar();

            PreparedStatement st;

            st = con.prepareStatement(
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

            double total = 0;

            String sql =
                "SELECT Ventas.idVentas, " +
                "Catalogo.idProducto, " +
                "Catalogo.producto, " +
                "Catalogo.precio, " +
                "Catalogo.descripcion " +
                "FROM Ventas " +
                "INNER JOIN Catalogo " +
                "ON Catalogo.idProducto = Ventas.Catalogo_idProducto " +
                "WHERE Ventas.Cliente_idCliente = ?";

            PreparedStatement st2 = con.prepareStatement(sql);

            st2.setInt(1, idCliente);

            ResultSet res = st2.executeQuery();

            for(int i = 0; i < totalVentas; i++){

                if(res.next()){

                    idVenta[i] = res.getInt("idVentas");

                    idProducto[i] = res.getInt("idProducto");

                    producto[i] = res.getString("producto");

                    precio[i] = res.getDouble("precio");

                    descripcion[i] = res.getString("descripcion");

                    total += precio[i];
                }
            }
        %>

        <header>

            <nav>

                <img src="../Imagenes/Flor.png"
                     alt="Flor"
                     width="50"
                     height="50"/>

                <h2>Mis Pedidos</h2>

                <a href="../index.html">

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

                        <h2><%= producto[j] %></h2>

                        <p class="description">
                            <%= descripcion[j] %>
                        </p>

                        <div class="details">

                            <span>
                                ID Venta:
                                <%= idVenta[j] %>
                            </span>

                            <span>
                                ID Producto:
                                <%= idProducto[j] %>
                            </span>

                        </div>

                    </div>

                    <div class="product-price">

                        <p>$ <%= precio[j] %></p>

                    </div>

                </div>

                <%
                        }
                    }
                %>

            </section>

        </main>

        <footer>

            &COPY; Flower Garden - Gestión de plantas y jardinería

        </footer>

    </body>

</html>