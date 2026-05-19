<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Carrito de Compras</title>
        <link href="../CSS/Carrito2.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            int totalVentas = 0;
            Connection con;
            con = Conexion.conectar();
            PreparedStatement st;
            st = con.prepareStatement("SELECT COUNT(*) AS totalVentas FROM Ventas WHERE Cliente_idCliente = "+ idCliente +";");
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalVentas = rs.getInt("totalVentas");
            } else{
                out.println("gg");
            }
            
            int[] idVenta = new int[totalVentas];
            int[] idProducto = new int[totalVentas];
            String[] producto=new String[totalVentas];
            double[] precio=new double[totalVentas];
            String[] descripcion=new String[totalVentas];
            String sql = "SELECT Ventas.idVentas, Catalogo.idProducto, Catalogo.producto, Catalogo.precio," +
                    "Catalogo.descripcion FROM Ventas INNER JOIN Catalogo ON Catalogo.idProducto "
                    + "= Ventas.Catalogo_idProducto WHERE Ventas.Cliente_idCliente = "+ idCliente +";";
            PreparedStatement st2 = con.prepareStatement(sql);
            ResultSet res = st2.executeQuery();
            for (int i=0; i<totalVentas; i++){
                if(res.next()){
                    idVenta[i]=res.getInt("idVentas");
                    idProducto[i]=res.getInt("idProducto");
                    producto[i]=res.getString("producto");
                    precio[i]=res.getDouble("precio");
                    descripcion[i]=res.getString("descripcion");
                }
            }
        %>
        <header>
            <nav>
                <img src="../Imagenes/Flor.png" alt="Flor" width="50" height="50"/>
                <div></div>

                <a href="../index.html">
                    <img src="../Imagenes/Salida.png" alt="CerrarSesion" width="50" height="50"/>
                </a>


            </nav>
        </header>
        <main>
            <h2>Mis pedidos</h2>
            <div>
                <table>
                    <thead><tr><th>ID de Venta</th><th>ID de Producto</th><th>Producto</th><th>Precio</th><th>Descripcion</th></tr></thead>
                    <tbody>
                        <%
                            for (int j=0; j<totalVentas; j++){
                                out.println("<tr>");
                                out.println("<td>"+ idVenta[j] +"</td>");
                                out.println("<td>"+ idProducto[j] +"</td>");
                                out.println("<td>"+ producto[j] +"</td>");
                                out.println("<td>"+ precio[j] +"</td>");
                                out.println("<td>"+ descripcion[j] +"</td>");
                                out.println("</tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </main>

        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>


    </body>
</html>
