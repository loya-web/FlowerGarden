<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/RegistroProducto.css" rel="stylesheet" type="text/css"/>
        <title>Registrar Producto</title>
    </head>
    <body>
        <%
            int idVendedor = Integer.parseInt(request.getParameter("idVendedor"));
        %>
        <main>
        <section>
            <p>Registro de Producto</p>
            <form action="GuardarProducto.jsp?idVendedor=<%=idVendedor%>" method="post">
                
                <label for="nombre">Nombre de producto:</label>
                <input type="text" name="nombre" id="nombre" required><br>

                <label for="precio">Precio:</label>
                <input type="decimal" name="precio" id="precio" required><br>

                <label for="descripcion">Descripcion:</label>
                <textarea name="descripcion" id="descripcion" required></textarea><br>

                <button type="submit">Registrar Producto</button>

            </form>
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
