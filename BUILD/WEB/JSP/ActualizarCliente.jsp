<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Actualizar Cliente</title>
    </head>
    <body>
           <%
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            String nombre = request.getParameter("nombre");
            String apat = request.getParameter("ap");
            String amat = request.getParameter("am");
            String correo = request.getParameter("correo");
            String cel = request.getParameter("toc");
            String contra = request.getParameter("pwd");
            String est = request.getParameter("est");
            String cd = request.getParameter("cd");
            String col = request.getParameter("col");
            String calle = request.getParameter("calle");
            String cp = request.getParameter("cp");
            
            try{
                Connection con;
                con = Conexion.conectar();
                PreparedStatement sta;
                
                sta = con.prepareStatement
                ("UPDATE Cliente SET email = ?, celular = ?, appat = ?, apmat = ?, nombre = ?, contrasena = ?, estado = ?, ciudad = ?, colonia = ?, calle = ?, cp = ? WHERE idCliente = ? ");
                
                sta.setString(1, correo);
                sta.setString(2, cel);
                sta.setString(3, apat);
                sta.setString(4, amat);
                sta.setString(5, nombre);
                sta.setString(6, contra);
                sta.setString(7, est);
                sta.setString(8, cd);
                sta.setString(9, col);
                sta.setString(10, calle);
                sta.setString(11, cp);
                sta.setInt(12, idCliente);
                
                sta.executeUpdate();
            %>
            <script>
                alert("¡Datos actualizados!");
                window.location.href = "../JSP/PerfilCliente.jsp?nombre=<%=nombre%>";
            </script>
            <% 
            }catch(Exception e){
                System.out.println("Error: " + e.getMessage());
            } 
        %>
        
    </body>
</html>
