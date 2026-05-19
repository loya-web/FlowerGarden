<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reseñas de Producto</title>
        <link href="../CSS/ConsultarResena.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <header>
            <nav>

                <img src="../Imagenes/Flor.png" alt="Logo" width="50" height="50"/>
                <div></div>
                <a href="Contacto.html" >
                    <img src="../Imagenes/Telefono.png" alt="Telefono" width="50" height="50" />
                </a>
        </header>

        <main>
          
            <section>
                <%
                    int idProducto = Integer.parseInt(request.getParameter("idProducto"));
                    int totalResenas = 0;
                    Connection con;
                    con = Conexion.conectar();
                    PreparedStatement st;
                    st = con.prepareStatement("SELECT COUNT(*) AS totalResenas FROM Resenas WHERE Catalogo_idProducto = ?;");
                    st.setInt(1,idProducto);
                    
                    ResultSet rs = st.executeQuery();
                    if (rs.next()) {
                        totalResenas = rs.getInt("totalResenas");
                    } else{
                        out.println("gg");
                    }
                    int[] idResena = new int[totalResenas];
                    String[] descripcionResena=new String[totalResenas];
                    String[] nombre = new String[totalResenas];
                    String[] appat = new String[totalResenas];
                    String[] apmat = new String[totalResenas];
                    
                    PreparedStatement st2 = con.prepareStatement("select idResena, descripcionResena, nombre, appat, apmat from Resenas INNER JOIN Cliente ON Cliente.idCliente=Resenas.Cliente_idCliente;");
                    ResultSet res = st2.executeQuery();
                    for (int i=0; i<totalResenas; i++){
                        if(res.next()){
                            idResena[i]=res.getInt("idResena");
                            descripcionResena[i]=res.getString("descripcionResena");
                            nombre[i]=res.getString("nombre");
                            appat[i]=res.getString("appat");
                            apmat[i]=res.getString("apmat");
                        }
                    }
                %>
                <table>
                    <thead><tr><th>ID de Reseña</th><th>Descripcion</th><th>Cliente</th></tr></thead>
                    <tbody>
                    <%
                        for (int j=0; j<totalResenas; j++){
                            out.println("<tr>");
                            out.println("<td>"+ idResena[j] +"</td>");
                            out.println("<td>"+ descripcionResena[j] +"</td>");
                            out.println("<td>"+ nombre[j] +" "+ appat[j] +" "+ apmat[j] +"</td>");
                            out.println("</tr>");
                        }
                    %>
                    </tbody>
                </table>
            </section>
        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>


    </body>
</html>