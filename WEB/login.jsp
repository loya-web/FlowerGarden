<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Iniciar Sesión</title>

    <link href="CSS/Login.css"
          rel="stylesheet"
          type="text/css"/>

</head>

<body>

    <form method="post"
          action="<%=request.getContextPath()%>/LoginServlet">

        <p>Flower Garden</p>

        <label>Usuario</label>

        <input
            type="text"
            name="j_username"
            autocomplete="username"
            placeholder="Ingresa tu nombre"
            required>

        <label>Contraseña</label>

        <input
            type="password"
            name="j_password"
            autocomplete="current-password"
            placeholder="Ingresa tu contraseña"
            required>

        <button type="submit">
            Iniciar Sesión
        </button>

        <%
            if(request.getParameter("error") != null){
        %>

            <div class="error">

                Usuario o contraseña incorrectos

            </div>

        <%
            }
        %>

        <a href="index.html">

            Volver al inicio

        </a>

    </form>

</body>

</html>