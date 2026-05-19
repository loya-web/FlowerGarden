
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Guardar Producto</title>
    </head>
    <body>
        <%
            int idVendedor = Integer.parseInt(request.getParameter("idVendedor"));
            String producto = request.getParameter("nombre");
            double precio = Double.parseDouble(request.getParameter("precio"));
            String descripcion = request.getParameter("descripcion");
            
            try{
                Connection con;
                con = Conexion.conectar();
                PreparedStatement sta;
                
                sta = con.prepareStatement("INSERT INTO Catalogo (producto, precio, descripcion) VALUES (?, ?, ?)");
                
                sta.setString(1, producto);
                sta.setDouble(2, precio);
                sta.setString(3, descripcion);
                
                sta.executeUpdate();
                
                PreparedStatement st;
                String nombre = "";
                st = con.prepareStatement("select nombre from Vendedor where idVendedor="+ idVendedor + ";");
                ResultSet res = st.executeQuery();
                if(res.next()){
                    nombre = res.getString("nombre");
                }
        %>
        <script>
            alert("¡Producto Registrado!");
            window.location.href = "PerfilVendedor.jsp?nombre=<%=nombre%>";
        </script>
        <%
            }catch(Exception e){
                System.out.println("Error: " + e.getMessage());
                out.print(e.getMessage());
            } 
        %>
    </body>
</html>
