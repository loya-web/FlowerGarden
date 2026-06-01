<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>

<%
    String usuarioSesion = (String) session.getAttribute("usuario");
    String rol = (String) session.getAttribute("rol");
    Integer idUsuario = (Integer) session.getAttribute("idUsuario");
    String nombre = (String) session.getAttribute("nombre");

    if(usuarioSesion == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    if(!"CLIENTE".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }

    if(idUsuario == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    Connection con = Conexion.conectar();
    int idCliente = 0;
    PreparedStatement sta =
            con.prepareStatement(
                    "SELECT idCliente " +
                    "FROM Cliente " +
                    "WHERE Usuario_idUsuario = ?"
            );
    sta.setInt(1, idUsuario);
    ResultSet rs = sta.executeQuery();
    if(rs.next()){
        idCliente = rs.getInt("idCliente");
    }else{
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Perfil Cliente</title>
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0">
        <link href="../CSS/Perfil1.css"
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

                <p><b>Perfil</b></p>
                <a href="../logout">
                    <img src="../Imagenes/Salida.png"
                         alt="CerrarSesion"
                         width="50"
                         height="50"/>
                </a>
            </nav>
        </header>
        <main>
            <div class="info">
                <div>
                    <img src="../Imagenes/Usuario.png"
                         alt="Usuario"
                         width="100"
                         height="100"/>
                </div>
                <div>
                    <p style="text-align:center;">
                        Hola <%=nombre%>!
                    </p>
                </div>
            </div>

            <div class="options">

                <a href="../JSP/Catalogo.jsp">
                    <p>Catalogo</p>
                    <img src="../Imagenes/Catalogo.png"
                         alt="Catalogo"
                         width="150"
                         height="150"/>
                </a>

                <a href="../JSP/Carrito.jsp">
                    <p>Carrito de Compras</p>
                    <img src="../Imagenes/Carrito1.png"
                         alt="Carrito"
                         width="150"
                         height="150"/>
                </a>

                <a href="../JSP/CambioCliente.jsp">
                    <p>Cambio de Datos</p>
                    <img src="../Imagenes/Cambio.png"
                         alt="Cambio"
                         width="150"
                         height="150"/>
                </a>

                <a href="../JSP/BajaCliente.jsp">
                    <p>Eliminar cuenta</p>

                    <img src="../Imagenes/Baja.png"
                         alt="Baja"
                         width="150"
                         height="150"/>
                </a>
                
                <a href="../JSP/ContactoVendedor.jsp">
                    <p>Contacto con Vendedor</p>
                    <img src="../Imagenes/Contacto.png"
                         alt="Contacto"
                         width="150"
                         height="150"/>
                </a>
                
                <a href="../JSP/AsistenteIA.jsp">
                    <p>Asistente de IA</p>
                    <img src="../Imagenes/AsistenteIA.png"
                         alt="Asistente de IA"
                         width="150"
                         height="150"/>
                </a>
            </div>

        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>

    </body>
</html>