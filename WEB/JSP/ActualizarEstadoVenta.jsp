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

    <title>Actualizar Venta</title>

</head>

<body>

<%
try{

    int idVenta =
            Integer.parseInt(
                    request.getParameter(
                            "idVenta"
                    )
            );

    String estadoPago =
            request.getParameter(
                    "estadoPago"
            );

    String estadoEntrega =
            request.getParameter(
                    "estadoEntrega"
            );

    Connection con =
            Conexion.conectar();

    PreparedStatement st =
            con.prepareStatement(
                    "UPDATE Ventas " +
                    "SET estadoPago = ?, " +
                    "estadoEntrega = ? " +
                    "WHERE idVentas = ?"
            );

    st.setString(1, estadoPago);
    st.setString(2, estadoEntrega);
    st.setInt(3, idVenta);

    st.executeUpdate();
%>

<script>

    alert(
        "Estado actualizado correctamente"
    );

    window.location.href =
            "ConsultarVentas.jsp";

</script>

<%
}catch(Exception e){

    out.print(
        "Error: "
        + e.getMessage()
    );
}
%>

</body>
</html>