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
            int idVendedor = Integer.parseInt(request.getParameter("idVendedor"));
            try{
                Connection con;
                con = Conexion.conectar();

                PreparedStatement sta;

                sta = con.prepareStatement("DELETE FROM Vendedor WHERE idVendedor = ?");
                sta.setInt(1,idVendedor);
                sta.executeUpdate();

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
