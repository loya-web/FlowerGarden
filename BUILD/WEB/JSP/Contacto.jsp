<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contacto</title>
        <link href="../CSS/Contacto.css" rel="stylesheet" type="text/css"/>
    </head>
    <header>
        <nav>
            <img src="../Imagenes/Flor.png" alt="Logo" width="50" height="50"/>
            <div></div>
            <a href="Contacto.html" >
                <img src="../Imagenes/Telefono.png" alt="Telefono" width="50" height="50" />
            </a>
        </nav>
    </header>
    <body>
        <main>
            <section>
                <h2>Contactar al vendedor</h2>
                <form action="Contacto.jsp" method="post">
                    <label>Asunto</label>
                    <input type="text" placeholder="Consulta sobre un producto">
                    <label>Mensaje</label>
                    <textarea rows="4" placeholder="Escribe tu mensaje..."></textarea>
                    <button class="submit">Enviar mensaje</button>
                </form>
            </section>
        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>
    </body>
</html>
