
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author KimHo
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            // Sửa URL, username, password để xác thực với MySQL
            String url = "jdbc:mysql://localhost:3306/project1"; // URL kết nối với MySQL
            String username = "root"; // Tên người dùng của MySQL
            String password = "19082003"; // Mật khẩu của MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }

    public Connection getConnection() {
        return connection;
    }

    public static void main(String[] args) {
        DBContext dbContext = new DBContext();
        Connection cnn = dbContext.getConnection();

        if (cnn != null) {
            System.out.println("Kết nối thành công đến cơ sở dữ liệu!");
        } else {
            System.out.println("Không thể kết nối đến cơ sở dữ liệu!");
        }
    }
}
