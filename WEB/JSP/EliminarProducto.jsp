
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Producto</title>
    </head>
    <body>
        <%
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            int idVendedor = Integer.parseInt(request.getParameter("idVendedor"));
            
            try{
                Connection con;
                con = Conexion.conectar();
                
                PreparedStatement sta1;
                sta1 = con.prepareStatement("DELETE FROM Ventas WHERE Catalogo_idProducto=?");
                sta1.setInt(1,idProducto);
                sta1.executeUpdate();
                
                PreparedStatement sta2;
                sta2 = con.prepareStatement("DELETE FROM Resenas WHERE Catalogo_idProducto=?");
                sta2.setInt(1,idProducto);
                sta2.executeUpdate();
                
                PreparedStatement sta3;
                sta3 = con.prepareStatement("DELETE FROM Catalogo WHERE idProducto=?");
                sta3.setInt(1,idProducto);
                sta3.executeUpdate();
                
                PreparedStatement st;
                String nombre = "";
                st = con.prepareStatement("select nombre from Vendedor where idVendedor="+ idVendedor + ";");
                ResultSet res = st.executeQuery();
                if(res.next()){
                    nombre = res.getString("nombre");
                }
        %>
        <script>
            alert("¡Producto Eliminado!");
            window.location.href = "PerfilVendedor.jsp?nombre=<%=nombre%>";
        </script>
        <%
            } catch(Exception e){
                System.out.println("Error: " + e.getMessage());
                out.print(e.getMessage());
            } 
        %>
    </body>
</html>
