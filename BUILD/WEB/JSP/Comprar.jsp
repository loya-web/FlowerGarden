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

    if(!"CLIENTE".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Compra</title>
</head>

<body>

<%
try{

    Integer idUsuario =
            (Integer) session.getAttribute("idUsuario");

    int idProducto =
            Integer.parseInt(
                    request.getParameter("idProducto")
            );

    Connection con =
            Conexion.conectar();

    int idCliente = 0;

    PreparedStatement stCliente =
            con.prepareStatement(
                    "SELECT idCliente " +
                    "FROM Cliente " +
                    "WHERE Usuario_idUsuario = ?"
            );

    stCliente.setInt(1, idUsuario);

    ResultSet rsCliente =
            stCliente.executeQuery();

    if(rsCliente.next()){
        idCliente =
                rsCliente.getInt("idCliente");
    }

    PreparedStatement st =
            con.prepareStatement(
                    "INSERT INTO Ventas " +
                    "(Catalogo_idProducto, Cliente_idCliente) " +
                    "VALUES (?, ?)"
            );

    st.setInt(1, idProducto);
    st.setInt(2, idCliente);

    st.executeUpdate();
%>

<script>

    alert("¡Compra realizada correctamente!");

    window.location.href =
            "PerfilCliente.jsp";

</script>

<%

}catch(Exception e){

    e.printStackTrace();

    out.println(
            "<h2>Error: "
            + e.getMessage()
            + "</h2>"
    );
}
%>

</body>
</html>