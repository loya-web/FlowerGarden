<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Zona Segura</title>
</head>
<body>

<h1>Acceso autorizado</h1>

<p>
Usuario:
<%= request.getUserPrincipal().getName() %>
</p>

<p>
Rol ADMIN:
<%= request.isUserInRole("ADMIN") %>
</p>

<p>
Rol VENDEDOR:
<%= request.isUserInRole("VENDEDOR") %>
</p>

<p>
Rol CLIENTE:
<%= request.isUserInRole("CLIENTE") %>
</p>

<a href="<%=request.getContextPath()%>/logout">
Cerrar sesión
</a>

</body>
</html>
