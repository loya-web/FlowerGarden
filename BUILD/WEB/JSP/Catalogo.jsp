<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<%
    String usuarioSesion =
            (String) session.getAttribute("usuario");

    String rol =
            (String) session.getAttribute("rol");

    if(usuarioSesion == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    if(!"CLIENTE".equals(rol)){
        response.sendRedirect("../index.html");
        return;
    }
%>
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
                <a href="../JSP/ContactoVendedor.jsp">
                    <img src="../Imagenes/Telefono.png" alt="Telefono" width="50" height="50" />
                </a>
        </header>

        <main>
          
            <section>
                <%  
                    Integer idUsuario =
                    (Integer) session.getAttribute("idUsuario");
                    String nombre = (String) session.getAttribute("nombre");
                    int idCliente = 0;
                    int totalProductos = 0;
                    
                    Connection con;
                    con = Conexion.conectar();
                    
                    PreparedStatement stCliente =
                        con.prepareStatement(
                            "SELECT idCliente " +
                            "FROM Cliente " +
                            "WHERE Usuario_idUsuario = ?"
                        );
                    stCliente.setInt(1, idUsuario);
                    ResultSet rsCliente = stCliente.executeQuery();
                    if(rsCliente.next()){
                        idCliente = rsCliente.getInt("idCliente");
                    }
                    
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
                        //out.println(idCliente);
                        //out.println(idProducto);
                        out.println("<div>");
                        out.println("<p>Id: "+idProducto[j]+"</p>");
                        out.println("<p>Nombre: "+producto[j]+"</p>");
                        out.println("<p>Precio: $"+precio[j]+"</p>");
                        out.println("<p>"+descripcion[j]+"</p>");
                        %>
                        <form action="Comprar.jsp?idProducto=<%=idProducto[j]%>" method="post">
                        <%
                        //out.println("<form action='Comprar.jsp?idCliente="+idCliente+",&idProducto="+idProducto[j]+"'>");
                        out.println("<button type='submit'>Comprar</button>");
                        %></form><%
                        //out.println("</form>");
                        out.println("<form action='EscribirResena.jsp?idProducto="+idProducto[j]+"&producto="+producto[j]+"&precio="+precio[j]+"' method='post'>");
                        out.println("<button type='submit'>Reseñar</button>");
                        out.println("</form>");
                        out.println("</div>");
                    }
                %>
            </section>
            
            
        </main>
        <a href="PerfilCliente.jsp" 
           accesskey=""class="btn-regresar">

            ⬅ Volver al Perfil

        </a>
        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>


    </body>
</html>
