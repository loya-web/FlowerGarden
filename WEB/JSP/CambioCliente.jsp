<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cambio de Datos</title>
        <link href="../CSS/Cambio1.css" rel="stylesheet" type="text/css"/>
    </head>
   
    
     <body>
        <%
            String idCliente = request.getParameter("idCliente");
            Connection con;
            con = Conexion.conectar();
            PreparedStatement sta;
            sta = con.prepareStatement("SELECT * FROM Cliente WHERE idCliente = ?");
            sta.setString(1,idCliente);
            ResultSet rs = sta.executeQuery();
            rs.next();
        %>
        <main>
        <section>

            <p>Cambio de Datos</p>
         
            <form action="../JSP/ActualizarCliente.jsp?idCliente=<%=idCliente%>" method="post">

                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" id="nombre" value="<%=rs.getString("nombre")%>" required><br>
            
                <label for="ap">Apellido Paterno:</label>
                <input type="text" name="ap" id="ap" value="<%=rs.getString("appat")%>" required><br>

                <label for="am">Apellido Materno:</label>
                <input type="text" name="am" id="am" value="<%=rs.getString("apmat")%>" required><br>

                <label for="correo">Correo:</label>
                <input type="email" name="correo" id="correo" value="<%=rs.getString("email")%>" required><br>

                <label for="toc">Teléfono o Celular:</label>
                <input type="number" name="toc" id="toc" value="<%=rs.getString("celular")%>" required><br>

                <label for="pwd">Contraseña:</label>
                <input type="text" name="pwd" id="pwd" value="<%=rs.getString("contrasena")%>" required><br>
                
                <p>Dirección</p><br>
                
                <label for="est">Estado:</label>
                <input type="text" name="est" id="est" value="<%=rs.getString("estado")%>" required><br>
                
                <label for="cd">Ciudad:</label>
                <input type="text" name="cd" id="cd" value="<%=rs.getString("ciudad")%>" required><br>
                
                <label for="col">Colonia:</label>
                <input type="text" name="col" id="col" value="<%=rs.getString("colonia")%>" required><br>
                
                <label for="calle">Calle:</label>
                <input type="text" name="calle" id="calle" value="<%=rs.getString("calle")%>" required><br>
                
                <label for="cp">Código Postal:</label>
                <input type="number" name="cp" id="cp" value="<%=rs.getInt("cp")%>" required><br>

                <button type="submit">Cambiar Datos</button>
              
            </form>

        </section>
      </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>

    </body>
    
</html>
