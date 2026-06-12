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
        <title>Procesando Compra</title>
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

    String tipoPago =
            request.getParameter("tipoPago");

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

    }else{

        throw new Exception(
                "No se encontró el cliente."
        );
    }

    PreparedStatement st =
            con.prepareStatement(
                    "INSERT INTO Ventas " +
                    "(" +
                    "Catalogo_idProducto, " +
                    "Cliente_idCliente, " +
                    "tipoPago" +
                    ") " +
                    "VALUES (?, ?, ?)"
            );

    st.setInt(1, idProducto);
    st.setInt(2, idCliente);
    st.setString(3, tipoPago);

    st.executeUpdate();
%>

<script>

    alert(
        "¡Compra realizada correctamente!\n" +
        "Método de pago: <%=tipoPago%>"
    );

    window.location.href =
            "PerfilCliente.jsp";

</script>

<%

}catch(Exception e){

    e.printStackTrace();
%>

<script>

    alert(
        "Error al realizar la compra"
    );

    window.location.href =
            "Catalogo.jsp";

</script>

<%
}
%>

    </body>
</html>