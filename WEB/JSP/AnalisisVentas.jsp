<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>

    <head>

        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>Analítica de Ventas</title>

        <link href="../CSS/AnalisisVentas.css"
              rel="stylesheet"
              type="text/css"/>

    </head>

    <body>

        <%
            Connection con = Conexion.conectar();

            int totalVentas = 0;
            int totalClientes = 0;
            int totalResenas = 0;

            double ingresosTotales = 0;
            double promedioCalificacion = 0;

            String productoMasVendido = "Sin datos";
            int ventasProducto = 0;

            String productoMasCaro = "Sin datos";
            double precioMasAlto = 0;

            PreparedStatement st1 =
                con.prepareStatement(
                    "SELECT COUNT(*) AS total FROM Ventas"
                );

            ResultSet rs1 = st1.executeQuery();

            if(rs1.next()){

                totalVentas = rs1.getInt("total");
            }

            PreparedStatement st2 =
                con.prepareStatement(
                    "SELECT SUM(Catalogo.precio) AS ingresos " +
                    "FROM Ventas " +
                    "INNER JOIN Catalogo " +
                    "ON Catalogo.idProducto = Ventas.Catalogo_idProducto"
                );

            ResultSet rs2 = st2.executeQuery();

            if(rs2.next()){

                ingresosTotales =
                    rs2.getDouble("ingresos");
            }

            PreparedStatement st3 =
                con.prepareStatement(
                    "SELECT COUNT(*) AS clientes FROM Cliente"
                );

            ResultSet rs3 = st3.executeQuery();

            if(rs3.next()){

                totalClientes =
                    rs3.getInt("clientes");
            }

            PreparedStatement st4 =
                con.prepareStatement(
                    "SELECT COUNT(*) AS resenas FROM Resenas"
                );

            ResultSet rs4 = st4.executeQuery();

            if(rs4.next()){

                totalResenas =
                    rs4.getInt("resenas");
            }

            PreparedStatement st5 =
                con.prepareStatement(
                    "SELECT AVG(calificacion) AS promedio " +
                    "FROM Resenas"
                );

            ResultSet rs5 = st5.executeQuery();

            if(rs5.next()){

                promedioCalificacion =
                    rs5.getDouble("promedio");
            }

            PreparedStatement st6 =
                con.prepareStatement(
                    "SELECT producto, COUNT(*) AS total " +
                    "FROM Ventas " +
                    "INNER JOIN Catalogo " +
                    "ON Catalogo.idProducto = Ventas.Catalogo_idProducto " +
                    "GROUP BY producto " +
                    "ORDER BY total DESC " +
                    "LIMIT 1"
                );

            ResultSet rs6 = st6.executeQuery();

            if(rs6.next()){

                productoMasVendido =
                    rs6.getString("producto");

                ventasProducto =
                    rs6.getInt("total");
            }

            PreparedStatement st7 =
                con.prepareStatement(
                    "SELECT producto, precio " +
                    "FROM Catalogo " +
                    "ORDER BY precio DESC " +
                    "LIMIT 1"
                );

            ResultSet rs7 = st7.executeQuery();

            if(rs7.next()){

                productoMasCaro =
                    rs7.getString("producto");

                precioMasAlto =
                    rs7.getDouble("precio");
            }
        %>

        <header>

            <nav>

                <img src="../Imagenes/Flor.png"
                     alt="Flor"
                     width="50"
                     height="50"/>

                <h2>Analítica de Ventas</h2>

                <a href="../index.html">

                    <img src="../Imagenes/Salida.png"
                         alt="Salir"
                         width="50"
                         height="50"/>

                </a>

            </nav>

        </header>

        <main>

            <section class="dashboard">

                <div class="card">

                    <h3>Total de Ventas</h3>

                    <p><%= totalVentas %></p>

                </div>

                <div class="card">

                    <h3>Ingresos Totales</h3>

                    <p>$ <%= ingresosTotales %></p>

                </div>

                <div class="card">

                    <h3>Clientes Registrados</h3>

                    <p><%= totalClientes %></p>

                </div>

                <div class="card">

                    <h3>Total de Reseñas</h3>

                    <p><%= totalResenas %></p>

                </div>

                <div class="card wide">

                    <h3>Producto Más Vendido</h3>

                    <p><%= productoMasVendido %></p>

                    <span>
                        <%= ventasProducto %> ventas
                    </span>

                </div>

                <div class="card wide">

                    <h3>Producto Más Caro</h3>

                    <p><%= productoMasCaro %></p>

                    <span>
                        $ <%= precioMasAlto %>
                    </span>

                </div>

                <div class="card wide">

                    <h3>Promedio de Calificaciones</h3>

                    <p>
                        ⭐
                        <%= String.format("%.1f", promedioCalificacion) %>
                    </p>

                </div>

            </section>

        </main>
        <a href="PerfilVendedor.jsp?nombre=<%=request.getParameter("nombre")%>" 
           accesskey=""class="btn-regresar">
            ⬅ Volver al Perfil
        </a>
        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>
    </body>
</html>