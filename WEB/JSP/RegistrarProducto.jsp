<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String usuarioSesion =
            (String) session.getAttribute("usuario");

    String rol =
            (String) session.getAttribute("rol");

    if(usuarioSesion == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    if(!"VENDEDOR".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <title>Registrar Producto</title>

    <link href="../CSS/RegistroProducto.css"
          rel="stylesheet"
          type="text/css"/>

</head>

<body>

<main>

    <section>

        <p>Registro de Producto</p>

        <form action="<%=request.getContextPath()%>/SubirProductoServlet"
            method="post"
            enctype="multipart/form-data">

            <label for="nombre">
                Nombre de producto:
            </label>

            <input type="text"
                   name="nombre"
                   id="nombre"
                   required>

            <br>

            <label for="precio">
                Precio:
            </label>

            <input type="number"
                   step="0.01"
                   min="0"
                   name="precio"
                   id="precio"
                   required>

            <br>

            <label for="descripcion">
                Descripción:
            </label>

            <textarea name="descripcion"
                      id="descripcion"
                      required></textarea>

            <br>

            <label for="imagen">
                Imagen:
            </label>

            <input type="file"
                   name="imagen"
                   id="imagen"
                   accept="image/*"
                   required>

            <br>

            <button type="submit">

                Registrar Producto

            </button>

        </form>

    </section>

</main>

<a href="PerfilVendedor.jsp"
   class="btn-regresar">

    ⬅ Volver al Perfil

</a>

<footer>

    &COPY; Flower Garden - Gestión de plantas y jardinería

</footer>

</body>

</html>