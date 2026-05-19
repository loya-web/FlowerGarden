
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reseña</title>
    </head>
    <body>
        <%
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            String resena = request.getParameter("resena");
            
            try{
                Connection con = Conexion.conectar();
                PreparedStatement st;
                st = con.prepareStatement("INSERT INTO Resenas (descripcionResena, Cliente_idCliente, Catalogo_idProducto) VALUES(?,?,?);");

                st.setString(1,resena);
                st.setInt(2,idCliente);
                st.setInt(3,idProducto);

                st.executeUpdate();
                
                PreparedStatement sta2;
                String nombre = "";
                sta2 = con.prepareStatement("select nombre from Cliente where idCliente="+ idCliente + ";");
                ResultSet res = sta2.executeQuery();
                if(res.next()){
                    nombre = res.getString("nombre");
                }
        %>
        <script>
            alert("¡Reseña guardada!");
            window.location.href = "PerfilCliente.jsp?nombre=<%=nombre%>";
        </script>
        <%
            } catch(Exception e){
                System.out.println("Error: " + e.getMessage());
                out.print(e.getMessage());
            } 
        %>
    </body>
</html>
