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

    <title>Eliminar Producto</title>
</head>

<body>

<%
    int idProducto =
            Integer.parseInt(
                    request.getParameter("idProducto")
            );

    try{

        Connection con =
                Conexion.conectar();

        PreparedStatement sta1 =
                con.prepareStatement(
                        "DELETE FROM Ventas " +
                        "WHERE Catalogo_idProducto=?"
                );

        sta1.setInt(1,idProducto);

        sta1.executeUpdate();

        PreparedStatement sta2 =
                con.prepareStatement(
                        "DELETE FROM Resenas " +
                        "WHERE Catalogo_idProducto=?"
                );

        sta2.setInt(1,idProducto);

        sta2.executeUpdate();

        PreparedStatement sta3 =
                con.prepareStatement(
                        "DELETE FROM Catalogo " +
                        "WHERE idProducto=?"
                );

        sta3.setInt(1,idProducto);

        sta3.executeUpdate();
%>

<script>

    alert("¡Producto eliminado!");

    window.location.href =
            "PerfilVendedor.jsp";

</script>

<%
    }catch(Exception e){

        out.print(e.getMessage());
    }
%>

</body>
</html>