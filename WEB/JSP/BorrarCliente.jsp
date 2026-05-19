<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Borrar Cuenta</title>
    </head>
    <body>
        <%
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            try{
                Connection con;
                con = Conexion.conectar();

                PreparedStatement sta1;
                PreparedStatement sta2;
                PreparedStatement sta3;

                sta1 = con.prepareStatement("DELETE FROM Resenas WHERE Cliente_idCliente = ?");
                sta1.setInt(1,idCliente);
                sta1.executeUpdate();
                sta2 = con.prepareStatement("DELETE FROM Ventas WHERE Cliente_idCliente = ?");
                sta2.setInt(1,idCliente);
                sta2.executeUpdate();
                sta3 = con.prepareStatement("DELETE FROM Cliente WHERE idCliente = ?");
                sta3.setInt(1,idCliente);
                sta3.executeUpdate();
                %>
                <script>
                    alert("¡Cuenta eliminada!");
                    window.location.href = "../index.html";
                </script>
                <%
            } catch (Exception e){
                out.println("Error. " + e.getMessage());
            }
        %>
    </body>
</html>