<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>

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

            Connection con;

            con = Conexion.conectar();

            PreparedStatement st;

            st = con.prepareStatement(
                "SELECT COUNT(*) AS totalVentas FROM Ventas;"
            );

            ResultSet rs = st.executeQuery();

            if(rs.next()){

                totalVentas = rs.getInt("totalVentas");
            }

            int[] idVentas = new int[totalVentas];
            int[] idProducto = new int[totalVentas];

            String[] producto = new String[totalVentas];

            double[] precio = new double[totalVentas];

            String[] descripcion = new String[totalVentas];

            int[] idCliente = new int[totalVentas];

            String[] nombre = new String[totalVentas];

            String[] appat = new String[totalVentas];

            String[] apmat = new String[totalVentas];

            String[] email = new String[totalVentas];

            String[] celular = new String[totalVentas];

            String[] estado = new String[totalVentas];

            String[] ciudad = new String[totalVentas];

            String[] colonia = new String[totalVentas];

            String[] calle = new String[totalVentas];

            int[] cp = new int[totalVentas];

            double totalIngresos = 0;

            String sql =
                "SELECT idVentas, idProducto, producto, precio, descripcion, " +
                "idCliente, nombre, appat, apmat, email, celular, " +
                "estado, ciudad, colonia, calle, cp " +
                "FROM Ventas " +
                "INNER JOIN Catalogo " +
                "ON Catalogo.idProducto = Ventas.Catalogo_idProducto " +
                "INNER JOIN Cliente " +
                "ON Cliente.idCliente = Ventas.Cliente_idCliente;";

            PreparedStatement st2 = con.prepareStatement(sql);

            ResultSet res = st2.executeQuery();

            for(int i = 0; i < totalVentas; i++){

                if(res.next()){

                    idVentas[i] = res.getInt("idVentas");

                    idProducto[i] = res.getInt("idProducto");

                    producto[i] = res.getString("producto");

                    precio[i] = res.getDouble("precio");

                    descripcion[i] = res.getString("descripcion");

                    idCliente[i] = res.getInt("idCliente");

                    nombre[i] = res.getString("nombre");

                    appat[i] = res.getString("appat");

                    apmat[i] = res.getString("apmat");

                    email[i] = res.getString("email");

                    celular[i] = res.getString("celular");

                    estado[i] = res.getString("estado");

                    ciudad[i] = res.getString("ciudad");

                    colonia[i] = res.getString("colonia");

                    calle[i] = res.getString("calle");

                    cp[i] = res.getInt("cp");

                    totalIngresos += precio[i];
                }
            }
        %>

        <header>

            <nav>

                <img src="../Imagenes/Flor.png"
                     alt="Flor"
                     width="50"
                     height="50"/>

                <h2>Panel de Ventas</h2>

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

                    <h3>Total de Ventas</h3>

                    <p><%= totalVentas %></p>

                </div>

                <div class="summary-card">

                    <h3>Ingresos Totales</h3>

                    <p>$ <%= totalIngresos %></p>

                </div>

            </section>

            <section class="sales-container">

                <%
                    for(int j = 0; j < totalVentas; j++){
                %>

                <div class="sale-card">

                    <div class="top">

                        <div>

                            <h2>
                                <%= producto[j] %>
                            </h2>

                            <p class="sale-id">
                                Venta #<%= idVentas[j] %>
                            </p>

                        </div>

                        <div class="price">

                            $ <%= precio[j] %>

                        </div>

                    </div>

                    <div class="description">

                        <p>
                            <%= descripcion[j] %>
                        </p>

                    </div>

                    <div class="customer">

                        <h3>Cliente</h3>

                        <p>
                            <%= nombre[j] %>
                            <%= appat[j] %>
                            <%= apmat[j] %>
                        </p>

                        <span>
                            ID Cliente:
                            <%= idCliente[j] %>
                        </span>

                    </div>

                    <div class="contact-grid">

                        <div class="info-box">

                            <h4>Correo</h4>

                            <p>
                                <%= email[j] %>
                            </p>

                        </div>

                        <div class="info-box">

                            <h4>Celular</h4>

                            <p>
                                <%= celular[j] %>
                            </p>

                        </div>

                    </div>

                    <div class="address">

                        <h4>Dirección</h4>

                        <p>
                            <%= calle[j] %>,
                            <%= colonia[j] %>,
                            <%= ciudad[j] %>,
                            <%= estado[j] %>,
                            C.P. <%= cp[j] %>
                        </p>

                    </div>

                </div>

                <%
                    }
                %>

            </section>

        </main>

        <footer>

            &COPY; Flower Garden - Gestión de plantas y jardinería

        </footer>

    </body>

</html>