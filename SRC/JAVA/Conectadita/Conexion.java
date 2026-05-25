package Conectadita;
import java.sql.*;

public class Conexion {
    public static Connection conectar(){
        Connection con = null;
        try{            
            Class.forName("com.mysql.cj.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/FlowerGarden","root","");
            return con;
        }
            catch (ClassNotFoundException | SQLException e){
            System.out.println("Error al conectar BD " + e.getMessage());    
            return con;
        }
    }
}
