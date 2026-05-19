<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro Cliente</title>
    </head>
    <body>
        <%
            int idClie =Integer.parseInt( request.getParameter("idCliente"));
            int idProd =Integer.parseInt( request.getParameter("idProducto"));
            try{
                Connection con;
                con = Conexion.conectar();
                PreparedStatement sta;
                
                sta = con.prepareStatement("INSERT INTO Ventas (Catalogo_idProducto, Cliente_idCliente) VALUES (?, ?)");
                sta.setInt(1, idProd);
                sta.setInt(2, idClie);
                sta.executeUpdate();
                
                PreparedStatement sta2;
                String nombre = "";
                sta2 = con.prepareStatement("select nombre from Cliente where idCliente="+ idClie + ";");
                ResultSet res = sta2.executeQuery();
                if(res.next()){
                    nombre = res.getString("nombre");
                }
        %>
        <script>
            alert("¡Compra exitosa!");
            window.location.href = "PerfilCliente.jsp?nombre=<%=nombre%>";
        </script>
        <%
            }catch(Exception e){
                System.out.println("Error: " + e.getMessage());
                out.print(e.getMessage());
            } 
        %>
    </body>
</html>