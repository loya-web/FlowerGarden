<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar Vendedor</title>
    </head>
    <body>
           <%
            int idVendedor = Integer.parseInt(request.getParameter("idVendedor"));
            String nombre = request.getParameter("nombre");
            String apat = request.getParameter("ap");
            String amat = request.getParameter("am");
            String correo = request.getParameter("correo");
            String cel = request.getParameter("toc");
            String contra = request.getParameter("pwd");
            
            try{
                Connection con;
                con = Conexion.conectar();
                PreparedStatement sta;
                
                sta = con.prepareStatement
                ("UPDATE Vendedor SET email = ?, celular = ?, appat = ?, apmat = ?, nombre = ?, contrasena = ? WHERE idVendedor = ? ");
                
                sta.setString(1, correo);
                sta.setString(2, cel);
                sta.setString(3, apat);
                sta.setString(4, amat);
                sta.setString(5, nombre);
                sta.setString(6, contra);
                sta.setInt(7, idVendedor);
                
                sta.executeUpdate();
            %>
            <script>
                alert("¡Datos actualizados!");
                window.location.href = "../JSP/PerfilVendedor.jsp?nombre=<%=nombre%>";
            </script>
            <% 
            }catch(Exception e){
                System.out.println("Error: " + e.getMessage());
                out.println(e.getMessage());
            } 
        %>
        
    </body>
</html>