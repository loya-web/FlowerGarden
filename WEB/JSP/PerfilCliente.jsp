<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil Cliente</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../CSS/Perfil1.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <header>

            <nav>

                <img src="../Imagenes/Flor.png" alt="Flor" width="50" height="50"/>
                <p><b>Perfil</b></p>
                

                <a href="../index.html">
                    <img src="../Imagenes/Salida.png" alt="CerrarSesion" width="50" height="50"/>
                </a>

            </nav>
        </header>

        <main>
            <%
                String nombre = request.getParameter("nombre");

                Connection con;
                con = Conexion.conectar();
                PreparedStatement sta;
                   
                
                sta = con.prepareStatement("SELECT * FROM cliente WHERE nombre = ?");
                sta.setString(1, nombre);
                ResultSet rs = sta.executeQuery();
                    rs.next();
                PreparedStatement sta2;
                sta2 = con.prepareStatement("select idCliente from Cliente where nombre = '"+nombre+"'");
                ResultSet res = sta2.executeQuery();
                int idCliente=0;
                if(res.next()){
                    idCliente = res.getInt("idCliente");
                }
            %>
            <div class="info">
                <div>
                    <img src="../Imagenes/Usuario.png" alt="Usuario" width="100" height="100"/>
                </div>

                <div> 
                    <p style="text-align:center;">Hola <%=nombre%>!</p>
                </div>
                <!--
                <div class="nom">
                    <p></p>
                    <br><br><br>
                

                    <p style="text-align:center;"></p>
                    <br>

                </div>
                -->
            </div>

            <div class="options">

                <a href="../JSP/Catalogo.jsp?idCliente=<%=idCliente%>" >
                    <p>Catalogo</p>
                    <img src="../Imagenes/Catalogo.png" alt="Catalogo" width="150" height="150" />
                </a>

                <a href="../JSP/Carrito.jsp?idCliente=<%=idCliente%>">
                    <p>Carrito de Compras</p>
                    <img src="../Imagenes/Carrito1.png" alt="Carrito" width="150" height="150"/>
                </a>

                <a href="../JSP/ConsultaCliente.jsp?idCliente=<%=idCliente%>">
                    <p>Consulta de Datos</p>
                    <img src="../Imagenes/Lupa.png" alt="Lupa" width="150" height="150"/>
                </a>

                <a href="../JSP/CambioCliente.jsp?idCliente=<%=idCliente%>">
                    <p>Cambio de Datos</p>
                    <img src="../Imagenes/Cambio.png" alt="Cambio" width="150" height="150"/>
                </a>

                <a href="../JSP/BajaCliente.jsp?idCliente=<%=idCliente%>">
                    <p>Eliminar cuenta</p>
                    <img src="../Imagenes/Baja.png" alt="Baja" width="150" height="150"/>
                </a>

                <a href="../JSP/ContactoVendedor.jsp">
                    <p>Contacto con Vendedor</p>
                    <img src="../Imagenes/Contacto.png" alt="Contacto" width="150" height="150"/>
                </a>

            </div>

        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>
    </body>
</html>
