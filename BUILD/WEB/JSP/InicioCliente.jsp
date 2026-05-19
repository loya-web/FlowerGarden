<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio Cliente</title>
    </head>
    <body>
        <%
            String nombre = request.getParameter("nombre");
            String contrasena = request.getParameter("contraseña");
            
            try{
                Connection con;
                con = Conexion.conectar();
                PreparedStatement sta;
                ResultSet rs = null;
                boolean valido = false;
                
                sta = con.prepareStatement("SELECT * FROM cliente WHERE nombre = ? AND contrasena = ?");
                
                sta.setString(1, nombre);
                sta.setString(2, contrasena);
          
                rs = sta.executeQuery();
                
                if (rs.next()) {
                    valido = true;
                }

                if (valido) {
                    response.sendRedirect("PerfilCliente.jsp?nombre="+nombre);
                } else {
                    response.sendRedirect("../RegistroCliente.html");
                    
                }

            } catch (SQLException e) {
                out.println("Error de SQL: " + e.getMessage());
            }
        %>
    </body>
</html>
