<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>
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

    Connection con = null;

    try{

        con =
                Conexion.conectar();

        String nombreImagen = null;

        PreparedStatement stImagen =
                con.prepareStatement(
                        "SELECT imagen " +
                        "FROM Catalogo " +
                        "WHERE idProducto = ?"
                );

        stImagen.setInt(1, idProducto);

        ResultSet rsImagen =
                stImagen.executeQuery();

        if(rsImagen.next()){

            nombreImagen =
                    rsImagen.getString("imagen");
        }

        if(nombreImagen != null &&
           !nombreImagen.trim().equals("")){

            String rutaImagenes =
                    application.getRealPath(
                            "/ImagenesProductos"
                    );

            File archivoImagen =
                    new File(
                            rutaImagenes
                            + File.separator
                            + nombreImagen
                    );

            if(archivoImagen.exists()){

                archivoImagen.delete();
            }
        }

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

    alert("¡Producto eliminado correctamente!");

    window.location.href =
            "CatalogoVendedor.jsp";

</script>

<%

    }catch(Exception e){

        e.printStackTrace();

        out.print(
                "Error: " + e.getMessage()
        );

    }finally{

        if(con != null){

            try{

                con.close();

            }catch(Exception e){}
        }
    }
%>

</body>

</html>