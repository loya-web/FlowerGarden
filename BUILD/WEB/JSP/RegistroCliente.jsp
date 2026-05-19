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
                
                sta = con.prepareStatement("INSERT INTO Cliente (email, celular, appat, apmat, nombre, contrasena, estado, ciudad, colonia, calle, cp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                
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
                
                sta.executeUpdate();
        %>
        <script>
            alert("¡Registro Exitoso!");
            window.location.href = "../InicioCliente.html";
        </script>
        <%
                /*
                response.sendRedirect("../InicioVendedor.html");
                out.print("<h1 align='center'>Registro exitoso</h1>");
                */
            }catch(Exception e){
                System.out.println("Error: " + e.getMessage());
                out.print(e.getMessage());
            } 
        %>
    </body>
</html>