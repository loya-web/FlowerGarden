<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Catalogo de Productos</title>
        <link href="../CSS/Catalogo2.css" rel="stylesheet" type="text/css"/>
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
                    String idVendedor = request.getParameter("idVendedor");
                    int totalProductos = 0;
                    Connection con;
                    con = Conexion.conectar();
                    PreparedStatement st;
                    st = con.prepareStatement("SELECT COUNT(*) AS totalProductos FROM Catalogo;");
                    
                    ResultSet rs = st.executeQuery();
                    if (rs.next()) {
                        totalProductos = rs.getInt("totalProductos");
                    } else{
                        out.println("gg");
                    }
                    int[] idProducto = new int[totalProductos];
                    String[] producto=new String[totalProductos];
                    double[] precio=new double[totalProductos];
                    String[] descripcion=new String[totalProductos];
                    PreparedStatement st2 = con.prepareStatement("select idProducto, producto, precio, descripcion from Catalogo;");
                    ResultSet res = st2.executeQuery();
                    for (int i=0; i<totalProductos; i++){
                        if(res.next()){
                            idProducto[i]=res.getInt("idProducto");
                            producto[i]=res.getString("producto");
                            precio[i]=res.getDouble("precio");
                            descripcion[i]=res.getString("descripcion");
                        }
                    }
                    for (int j=0; j<totalProductos; j++){
                        out.println("<div>");
                        out.println("<p>Id: "+idProducto[j]+"</p>");
                        out.println("<p>Nombre: "+producto[j]+"</p>");
                        out.println("<p>Precio: $"+precio[j]+"</p>");
                        out.println("<p>"+descripcion[j]+"</p>");
                        
                        out.println("<form action='EliminarProducto.jsp?idProducto="+idProducto[j]+"&idVendedor="+idVendedor+"' method='post'>");
                        out.println("<button type='submit'>Eliminar</button>");
                        out.println("</form>");
                        
                        out.println("<form action='ConsultarResenas.jsp?idProducto="+idProducto[j]+"' method='post'>");
                        out.println("<button type='submit'>Ver Reseñas</button>");
                        out.println("</form>");
                        out.println("</div>");
                    }
                %>
            </section>
            
            
        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>


    </body>
</html>