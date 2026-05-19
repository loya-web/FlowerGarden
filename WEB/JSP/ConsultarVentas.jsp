<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consultar Ventas</title>
        <link href="../CSS/ConsultarVentas.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            int totalVentas = 0;
            Connection con;
            con = Conexion.conectar();
            PreparedStatement st;
            st = con.prepareStatement("SELECT COUNT(*) AS totalVentas FROM Ventas;");
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalVentas = rs.getInt("totalVentas");
            }
            
            int[] idVentas = new int[totalVentas];
            int[] idProducto = new int[totalVentas];
            String[] producto= new String[totalVentas];
            double[] precio = new double[totalVentas];
            String[] descripcion = new String[totalVentas];
            int[] idCliente = new int[totalVentas];
            String[] nombre = new String[totalVentas];
            String[] appat = new String[totalVentas];
            String[] apmat = new String[totalVentas];
            String[] email = new String[totalVentas];
            String[] celular = new String[totalVentas];
            String[] estado = new String[totalVentas];
            String[] ciudad = new String[totalVentas];
            String[] colonia = new String[totalVentas];
            String[] calle = new String[totalVentas];
            int[] cp = new int[totalVentas];
            
            String sql = "SELECT idVentas, idProducto, producto, precio, descripcion, idCliente, nombre, appat, apmat, email, celular, estado, ciudad, colonia, calle, cp FROM Ventas INNER JOIN Catalogo ON Catalogo.idProducto=Ventas.Catalogo_idProducto INNER JOIN Cliente ON Cliente.idCliente=Ventas.Cliente_idCliente;";
            PreparedStatement st2 = con.prepareStatement(sql);
            ResultSet res = st2.executeQuery();
            for (int i=0; i<totalVentas; i++){
                if(res.next()){
                    idVentas[i]=res.getInt("idVentas");
                    idProducto[i]=res.getInt("idProducto");
                    producto[i]=res.getString("producto");
                    precio[i]=res.getDouble("precio");
                    descripcion[i]=res.getString("descripcion");
                    idCliente[i]=res.getInt("idCliente");
                    nombre[i]=res.getString("nombre");
                    appat[i]=res.getString("appat");
                    apmat[i]=res.getString("apmat");
                    email[i]=res.getString("email");
                    celular[i]=res.getString("celular");
                    estado[i]=res.getString("estado");
                    ciudad[i]=res.getString("ciudad");
                    colonia[i]=res.getString("colonia");
                    calle[i]=res.getString("calle");
                    cp[i]=res.getInt("cp");
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
            <h2>Ventas</h2>
            <div>
                <table>
                    <thead><tr><th>ID de Venta</th><th>ID de Producto</th><th>Producto</th><th>Precio</th><th>Descripcion</th><th>ID de Cliente</th><th>Cliente</th><th>Correo</th><th>Celular</th><th>Estado</th><th>Ciudad</th><th>Colonia</th><th>Calle</th><th>Código Postal</th></tr></thead>
                    <tbody>
                        <%
                            for (int j=0; j<totalVentas; j++){
                                out.println("<tr>");
                                out.println("<td>"+ idVentas[j] +"</td>");
                                out.println("<td>"+ idProducto[j] +"</td>");
                                out.println("<td>"+ producto[j] +"</td>");
                                out.println("<td>"+ precio[j] +"</td>");
                                out.println("<td>"+ descripcion[j] +"</td>");
                                out.println("<td>"+ idCliente[j] +"</td>");
                                out.println("<td>"+ nombre[j] + " " + appat[j] + " " + apmat[j] + "</td>");
                                out.println("<td>"+ email[j] +"</td>");
                                out.println("<td>"+ celular[j] +"</td>");
                                out.println("<td>"+ estado[j] +"</td>");
                                out.println("<td>"+ ciudad[j] +"</td>");
                                out.println("<td>"+ colonia[j] +"</td>");
                                out.println("<td>"+ calle[j] +"</td>");
                                out.println("<td>"+ cp[j] +"</td>");
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
