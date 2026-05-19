<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ContactoVendedor</title>
        <link href="../CSS/Contacto.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            int totalVendedor = 0;
            Connection con;
            con = Conexion.conectar();
            PreparedStatement st;
            st = con.prepareStatement("SELECT COUNT(*) AS totalVendedor FROM Vendedor;");
            
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalVendedor = rs.getInt("totalVendedor");
            }
            
            int[] idVendedor = new int[totalVendedor];
            String[] nombre=new String[totalVendedor];
            String[] appat=new String[totalVendedor];
            String[] apmat=new String[totalVendedor];
            String[] correo=new String[totalVendedor];
            String[] celular=new String[totalVendedor];
            String sql = "SELECT idVendedor, email, celular, appat, apmat, nombre FROM Vendedor;";
            PreparedStatement st2 = con.prepareStatement(sql);
            ResultSet res = st2.executeQuery();
            for (int i=0; i<totalVendedor; i++){
                if(res.next()){
                    idVendedor[i]=res.getInt("idVendedor");
                    nombre[i]=res.getString("nombre");
                    appat[i]=res.getString("appat");
                    apmat[i]=res.getString("apmat");
                    correo[i]=res.getString("email");
                    celular[i]=res.getString("celular");
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
            <h2>Vendedores</h2>
            <div>
                <table>
                    <thead><tr><th>ID de Vendedor</th><th>Nombre</th><th>Apellido Paterno</th><th>Apellido Materno</th><th>Correo</th><th>Celular</th></tr></thead>
                    <tbody>
                        <%
                            for (int j=0; j<totalVendedor; j++){
                                out.println("<tr>");
                                out.println("<td>"+ idVendedor[j] +"</td>");
                                out.println("<td>"+ nombre[j] +"</td>");
                                out.println("<td>"+ appat[j] +"</td>");
                                out.println("<td>"+ apmat[j] +"</td>");
                                out.println("<td>"+ correo[j] +"</td>");
                                out.println("<td>"+ celular[j] +"</td>");
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
