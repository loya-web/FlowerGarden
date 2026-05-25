<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>

    <head>

        <meta http-equiv="Content-Type"
              content="text/html; charset=UTF-8">

        <title>Consultar Reseñas</title>

        <link href="../CSS/ConsultarResena.css"
              rel="stylesheet"
              type="text/css"/>

    </head>

    <body>

        <%
            int idProducto = Integer.parseInt(
                request.getParameter("idProducto")
            );

            int totalResenas = 0;

            Connection con;

            con = Conexion.conectar();

            PreparedStatement st;

            st = con.prepareStatement(
                "SELECT COUNT(*) AS totalResenas " +
                "FROM Resenas " +
                "WHERE Catalogo_idProducto = ?;"
            );

            st.setInt(1, idProducto);

            ResultSet rs = st.executeQuery();

            if(rs.next()){

                totalResenas = rs.getInt("totalResenas");
            }

            int[] idResena = new int[totalResenas];

            String[] descripcionResena =
                new String[totalResenas];

            int[] calificacion =
                new int[totalResenas];

            String[] nombre =
                new String[totalResenas];

            String[] appat =
                new String[totalResenas];

            String[] apmat =
                new String[totalResenas];

            String sql =
                "SELECT idResena, descripcionResena, " +
                "calificacion, nombre, appat, apmat " +
                "FROM Resenas " +
                "INNER JOIN Cliente " +
                "ON Cliente.idCliente = Resenas.Cliente_idCliente " +
                "WHERE Catalogo_idProducto = ?;";

            PreparedStatement st2 =
                con.prepareStatement(sql);

            st2.setInt(1, idProducto);

            ResultSet res = st2.executeQuery();

            for(int i = 0; i < totalResenas; i++){

                if(res.next()){

                    idResena[i] =
                        res.getInt("idResena");

                    descripcionResena[i] =
                        res.getString("descripcionResena");

                    calificacion[i] =
                        res.getInt("calificacion");

                    nombre[i] =
                        res.getString("nombre");

                    appat[i] =
                        res.getString("appat");

                    apmat[i] =
                        res.getString("apmat");
                }
            }
        %>

        <header>

            <nav>

                <img src="../Imagenes/Flor.png"
                     alt="Flor"
                     width="50"
                     height="50"/>

                <h2>Panel de Reseñas</h2>

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

                    <h3>Total de Reseñas</h3>

                    <p><%= totalResenas %></p>

                </div>

            </section>

            <section class="reviews-container">

                <%
                    for(int j = 0; j < totalResenas; j++){
                %>

                <div class="review-card">

                    <div class="review-top">

                        <div>

                            <h2>
                                Reseña #<%= idResena[j] %>
                            </h2>

                            <p class="client-name">

                                <%= nombre[j] %>
                                <%= appat[j] %>
                                <%= apmat[j] %>

                            </p>

                        </div>

                        <div class="stars">

                            <%
                                for(int k = 1; k <= 5; k++){

                                    if(k <= calificacion[j]){
                            %>

                                ★

                            <%
                                    }else{
                            %>

                                ☆

                            <%
                                    }
                                }
                            %>

                        </div>

                    </div>

                    <div class="review-description">

                        <p>
                            <%= descripcionResena[j] %>
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