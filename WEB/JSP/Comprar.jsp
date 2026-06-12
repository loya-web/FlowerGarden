<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="Conectadita.Conexion"%>

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

    int idProducto =
            Integer.parseInt(
                    request.getParameter("idProducto")
            );

    Connection con =
            Conexion.conectar();

    String producto = "";
    double precio = 0;
    String descripcion = "";

    PreparedStatement st =
            con.prepareStatement(
                    "SELECT producto, precio, descripcion " +
                    "FROM Catalogo " +
                    "WHERE idProducto = ?"
            );

    st.setInt(1, idProducto);

    ResultSet rs =
            st.executeQuery();

    if(rs.next()){
        producto =
                rs.getString("producto");

        precio =
                rs.getDouble("precio");

        descripcion =
                rs.getString("descripcion");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Confirmar Compra</title>

        <link href="../CSS/Catalogo2.css"
              rel="stylesheet"
              type="text/css"/>
    </head>

    <body>

        <header>
            <nav>
                <img src="../Imagenes/Flor.png"
                     alt="Logo"
                     width="50"
                     height="50"/>

                <a href="Catalogo.jsp">
                    <img src="../Imagenes/Salida.png"
                         alt="Regresar"
                         width="50"
                         height="50"/>
                </a>
            </nav>
        </header>

        <main>

            <section>

                <div>

                    <p>ID: <%=idProducto%></p>

                    <p><%=producto%></p>

                    <p>$<%=precio%></p>

                    <p><%=descripcion%></p>

                    <form action="ConfirmarCompra.jsp"
                          method="post">

                        <input type="hidden"
                               name="idProducto"
                               value="<%=idProducto%>">

                        <label>
                            Método de pago:
                        </label>

                        <br><br>

                        <select name="tipoPago"
                                required
                                style="
                                width:100%;
                                padding:12px;
                                border-radius:10px;
                                border:1px solid #ccc;
                                margin-bottom:20px;">

                            <option value="">
                                Seleccione una opción
                            </option>

                            <option value="EFECTIVO">
                                Efectivo
                            </option>

                            <option value="TRANSFERENCIA">
                                Transferencia bancaria
                            </option>

                        </select>

                        <button type="submit">
                            Confirmar compra
                        </button>

                    </form>

                </div>

            </section>

        </main>
        <a href="PerfilCliente.jsp"
            class="btn-regresar">
             ⬅ Volver al Perfil
         </a>
        <footer>
            &COPY; Flower Garden - Gestión de plantas y jardinería
        </footer>

    </body>
</html>