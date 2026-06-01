<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Conectadita.Conexion"%>
<%@page import="java.sql.*"%>

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

    Integer idUsuario =
            (Integer) session.getAttribute("idUsuario");

    int idCliente = 0;

    Connection con = null;

    try{

        con = Conexion.conectar();

        // Obtener idCliente asociado al usuario en sesión
        PreparedStatement stCliente =
                con.prepareStatement(
                    "SELECT idCliente " +
                    "FROM Cliente " +
                    "WHERE Usuario_idUsuario = ?"
                );

        stCliente.setInt(1, idUsuario);

        ResultSet rsCliente =
                stCliente.executeQuery();

        if(rsCliente.next()){

            idCliente =
                    rsCliente.getInt("idCliente");

        }else{

            out.print("No se encontró el cliente.");
            return;
        }

        int idProducto =
                Integer.parseInt(
                    request.getParameter("idProducto")
                );

        String resena =
                request.getParameter("resena");

        int calificacion =
                Integer.parseInt(
                    request.getParameter("calificacion")
                );

        PreparedStatement st =
                con.prepareStatement(
                    "INSERT INTO Resenas " +
                    "(descripcionResena, calificacion, Cliente_idCliente, Catalogo_idProducto) " +
                    "VALUES (?, ?, ?, ?)"
                );

        st.setString(1, resena);
        st.setInt(2, calificacion);
        st.setInt(3, idCliente);
        st.setInt(4, idProducto);

        st.executeUpdate();
%>

<script>

    alert("¡Reseña guardada!");

    window.location.href =
            "PerfilCliente.jsp";

</script>

<%

    }catch(Exception e){

        System.out.println(
                "Error: " + e.getMessage());

        out.print(
                "Error: " + e.getMessage());

        e.printStackTrace();

    }finally{

        if(con != null){

            try{

                con.close();

            }catch(SQLException e){

                e.printStackTrace();
            }
        }
    }
%>