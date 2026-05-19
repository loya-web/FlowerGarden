<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Baja de Datos</title>
        <link href="../CSS/Baja3.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <header>
            <nav>

                <img src="../Imagenes/Flor.png" alt="Logo" width="50" height="50"/>
                <p><b>Eliminar Cuenta</b></p>
                <a href="Contacto.html" >
                    <img src="../Imagenes/Telefono.png" alt="Telefono" width="50" height="50" />
                </a>

            </nav>
        </header>

        <main>
            <section>
                 <%
                    int idVendedor = Integer.parseInt(request.getParameter("idVendedor"));

                    Connection con;
                    con = Conexion.conectar();
                    PreparedStatement sta;
                   
                    sta = con.prepareStatement("SELECT * FROM Vendedor WHERE  idVendedor = ?");
                    sta.setInt(1, idVendedor);
                    
                    ResultSet rs = sta.executeQuery();
                    rs.next();
                    %>
                    
                <p><%= rs.getString("nombre") %></p>
                <p>¡Esta acción es IRREVERSIBLE!</p>

                <form action="../JSP/BorrarVendedor.jsp?idVendedor=<%=idVendedor%>" method="post">

                    <p>¿ Estas seguro de eliminar tu usuario ?</p>
                    <button type="submit" class="Confirmar">Sí, Eliminar Usuario</button>
                    <a href="../JSP/PerfilVendedor.jsp?nombre=<%=rs.getString("nombre")%>"> Cancelar y Volver </a>
                </form>
            </section>
        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>

    </body>
</html>
