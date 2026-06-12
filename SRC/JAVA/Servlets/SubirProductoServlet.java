package Servlets;

import Conectadita.Conexion;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/SubirProductoServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class SubirProductoServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String producto =
                    request.getParameter("nombre");

            double precio =
                    Double.parseDouble(
                            request.getParameter("precio")
                    );

            String descripcion =
                    request.getParameter("descripcion");

            Part archivo =
                    request.getPart("imagen");

            String nombreArchivo =
                    Paths.get(
                            archivo.getSubmittedFileName()
                    ).getFileName().toString();

            String rutaImagenes =
                    getServletContext()
                            .getRealPath("/ImagenesProductos");

            File directorio =
                    new File(rutaImagenes);

            if (!directorio.exists()) {

                directorio.mkdirs();
            }

            archivo.write(
                    rutaImagenes
                    + File.separator
                    + nombreArchivo
            );

            Connection con =
                    Conexion.conectar();

            PreparedStatement st =
                    con.prepareStatement(
                            "INSERT INTO Catalogo " +
                            "(producto, precio, descripcion, imagen) " +
                            "VALUES (?, ?, ?, ?)"
                    );

            st.setString(1, producto);
            st.setDouble(2, precio);
            st.setString(3, descripcion);
            st.setString(4, nombreArchivo);

            st.executeUpdate();

            response.sendRedirect(
                    "JSP/PerfilVendedor.jsp"
            );

        } catch (Exception e) {

            throw new ServletException(e);
        }
    }
}