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

    if(!"VENDEDOR".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }

    if(idUsuario == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    Connection con = Conexion.conectar();
    int idVendedor = 0;
    PreparedStatement sta =
            con.prepareStatement(
                    "SELECT idVendedor " +
                    "FROM Vendedor " +
                    "WHERE Usuario_idUsuario = ?"
            );
    sta.setInt(1, idUsuario);
    ResultSet rs = sta.executeQuery();

    if(rs.next()){
        idVendedor = rs.getInt("idVendedor");
    }else{
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Perfil Vendedor</title>
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
                    <p>Hola <%=nombre%>!</p>
                </div>
            </div>
            <div class="options">
                <a href="../JSP/CatalogoVendedor.jsp">
                    <p>Catalogo</p>
                    <img src="../Imagenes/Catalogo.png"
                         alt="Catalogo"
                         width="150"
                         height="150"/>
                </a>
                <a href="../JSP/RegistrarProducto.jsp">
                    <p>Registrar Producto</p>
                    <img src="../Imagenes/RegistroProducto.png"
                         alt="Registrar Producto"
                         width="150"
                         height="150"/>
                </a>
                <a href="../JSP/CambioVendedor.jsp">
                    <p>Cambio de Datos</p>
                    <img src="../Imagenes/Cambio.png"
                         alt="Cambio"
                         width="150"
                         height="150"/>
                </a>
                <a href="../JSP/ConsultarVentas.jsp">
                    <p>Consultar Ventas</p>
                    <img src="../Imagenes/ConsultaVentas.png"
                         alt="Consultar Ventas"
                         width="150"
                         height="150"/>
                </a>
                <a href="../JSP/AnalisisVentas.jsp">
                    <p>Análisis de Ventas</p>
                    <img src="../Imagenes/AnalisisVentas.png"
                         alt="Analisis de Ventas"
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