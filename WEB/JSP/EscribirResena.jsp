
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/Resena1.css" rel="stylesheet" type="text/css"/>
        <title>Reseña</title>
    </head>
    
    <body>
        <main>
        <section>
            <%
                int idCliente = Integer.parseInt(request.getParameter("idCliente"));
                int idProducto = Integer.parseInt(request.getParameter("idProducto"));
                String producto = request.getParameter("producto");
                double precio = Double.parseDouble(request.getParameter("precio"));
            %>
            <p id="uno">Escribir Reseña</p>
            <p id="dos">Producto: <%=producto%></p>
            <p id="tres">Precio: <%=precio%></p>
            <form action="GuardarResena.jsp?idCliente=<%=idCliente%>&idProducto=<%=idProducto%>" method="post">

                <label for="resena">Reseña:</label>
                <input type="text" name="resena" id="resena" required><br>

                <button type="submit">Enviar</button> 
            </form>
        </section>
        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>

    </body>
</html>
