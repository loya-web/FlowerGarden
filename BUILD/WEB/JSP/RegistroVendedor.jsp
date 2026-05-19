<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro Vendedor</title>
    </head>
    <body>
        <%
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
                
                sta = con.prepareStatement("INSERT INTO Vendedor (email, celular, appat, apmat, nombre, contrasena) VALUES (?, ?, ?, ?, ?, ?)");
                
                sta.setString(1, correo);
                sta.setString(2, cel);
                sta.setString(3, apat);
                sta.setString(4, amat);
                sta.setString(5, nombre);
                sta.setString(6, contra);
                
                sta.executeUpdate();
        %>
        <script>
            alert("¡Registro Exitoso!");
            window.location.href = "../InicioVendedor.html";
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
