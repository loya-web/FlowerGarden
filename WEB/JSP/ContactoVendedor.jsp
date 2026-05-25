<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contacto Administrador</title>

        <link href="../CSS/Contacto.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>

        <%
            Connection con;
            con = Conexion.conectar();

            PreparedStatement st;

            st = con.prepareStatement(
                "SELECT nombre, appat, apmat, email, celular FROM Vendedor LIMIT 1;"
            );

            ResultSet rs = st.executeQuery();

            rs.next();
        %>

        <header>
            <nav>

                <img src="../Imagenes/Flor.png"
                     alt="Flor"
                     width="50"
                     height="50"/>

                <h2>Contacto Administrador</h2>

                <a href="../index.html">

                    <img src="../Imagenes/Salida.png"
                         alt="Salir"
                         width="50"
                         height="50"/>

                </a>

            </nav>
        </header>

        <main>

            <section class="contact-card">

                <div class="profile">

                    <img src="../Imagenes/Usuario.png"
                         alt="Administrador">

                    <h1>
                        <%= rs.getString("nombre") %>
                        <%= rs.getString("appat") %>
                        <%= rs.getString("apmat") %>
                    </h1>

                    <p class="role">
                        Administrador de Flower Garden
                    </p>

                </div>

                <div class="contact-info">

                    <div class="info-box">

                        <h3>Correo Electrónico</h3>

                        <p>
                            <%= rs.getString("email") %>
                        </p>

                    </div>

                    <div class="info-box">

                        <h3>Teléfono</h3>

                        <p>
                            <%= rs.getString("celular") %>
                        </p>

                    </div>

                </div>

                <div class="message-box">

                    <p>
                        Si tienes dudas sobre productos, pedidos,
                        pagos o soporte, puedes comunicarte directamente
                        con el administrador de Flower Garden.
                    </p>

                </div>

            </section>

        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>

    </body>
</html>
