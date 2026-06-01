<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>

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

    <title>Guardar Producto</title>

</head>

<body>

<%
    String producto =
            request.getParameter("nombre");

    double precio =
            Double.parseDouble(
                    request.getParameter("precio")
            );

    String descripcion =
            request.getParameter("descripcion");

    try{

        Connection con =
                Conexion.conectar();

        PreparedStatement sta =
                con.prepareStatement(
                        "INSERT INTO Catalogo " +
                        "(producto, precio, descripcion) " +
                        "VALUES (?, ?, ?)"
                );

        sta.setString(1, producto);
        sta.setDouble(2, precio);
        sta.setString(3, descripcion);

        sta.executeUpdate();
%>

<script>

    alert("¡Producto registrado correctamente!");

    window.location.href =
            "PerfilVendedor.jsp";

</script>

<%
    }catch(Exception e){

        System.out.println(
                "Error: " + e.getMessage()
        );

        out.print(
                "Error: " + e.getMessage()
        );
    }
%>

</body>

</html>