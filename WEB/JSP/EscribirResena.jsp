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

    if(!"CLIENTE".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8">

    <link href="../CSS/Resena1.css"
          rel="stylesheet"
          type="text/css"/>

    <title>Escribir Reseña</title>

</head>

<body>

<%
    int idProducto =
            Integer.parseInt(
                    request.getParameter("idProducto")
            );

    String producto =
            request.getParameter("producto");

    double precio =
            Double.parseDouble(
                    request.getParameter("precio")
            );
%>

<main>

    <section class="card-resena">

        <div class="producto-info">

            <h1>Escribir Reseña</h1>

            <div class="detalle">

                <p>
                    <strong>Producto:</strong>
                    <%=producto%>
                </p>

                <p>
                    <strong>Precio:</strong>
                    $<%=precio%>
                </p>

            </div>

        </div>

        <form action="GuardarResena.jsp?idProducto=<%=idProducto%>"
              method="post">

            <label>Calificación</label>

            <div class="rating">

                <input type="radio"
                       name="calificacion"
                       id="star5"
                       value="5"
                       required>

                <label for="star5">★</label>

                <input type="radio"
                       name="calificacion"
                       id="star4"
                       value="4">

                <label for="star4">★</label>

                <input type="radio"
                       name="calificacion"
                       id="star3"
                       value="3">

                <label for="star3">★</label>

                <input type="radio"
                       name="calificacion"
                       id="star2"
                       value="2">

                <label for="star2">★</label>

                <input type="radio"
                       name="calificacion"
                       id="star1"
                       value="1">

                <label for="star1">★</label>

            </div>

            <label for="resena">
                Tu reseña
            </label>

            <textarea
                name="resena"
                id="resena"
                placeholder="Escribe tu opinión sobre el producto..."
                required></textarea>

            <button type="submit">

                Enviar Reseña

            </button>

        </form>

    </section>

</main>

<a href="PerfilCliente.jsp"
   class="btn-regresar">

    ⬅ Volver al Perfil

</a>

<footer>

    &COPY; Flower Garden - Gestión de plantas y jardinería

</footer>

</body>
</html>