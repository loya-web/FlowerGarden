<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mis Datos</title>
        <link href="../CSS/ConsultaDatos.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>

        <header>
            <nav>

                <img src="../Imagenes/Flor.png" alt="Logo" width="50" height="50"/>
                <div></div>
                <a href="Contacto.html" >
                    <img src="../Imagenes/Telefono.png" alt="Telefono" width="50" height="50" />
                </a>

            </nav>

        </header>

        <main>
            <section id="principal">
            <section id="uno">

                <h2>Mis Datos</h2>

                <%
                String id=request.getParameter("idVendedor");
                Connection con;
                con = Conexion.conectar();
                PreparedStatement sta;
                sta = con.prepareStatement("SELECT * FROM Vendedor WHERE idVendedor = ?");
                sta.setString(1,id);
                ResultSet rs = sta.executeQuery();
                    rs.next();
                %>


                <p>ID: <%= rs.getInt("idVendedor") %></p>
                <p>Nombre:  <%= rs.getString("nombre") %> </p>
                <p>Apellido Paterno: <%= rs.getString("appat") %> </p>
                <p>Apellido Materno: <%= rs.getString("apmat") %> </p>
                <p>Correo: <%= rs.getString("email") %> </p>
                <p>Celular: <%= rs.getString("celular") %> </p>
                <p>Contraseña: <%= rs.getString("contrasena") %> </p>
            </section>

            <section id="dos">
                <img src="../Imagenes/Datos.png" alt=""/>
            </section>
            </section>
        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>

    </body>

</html>
