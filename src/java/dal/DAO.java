/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.Account;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Categories;
import model.Product;

/**
 *
 * @author KimHo
 */
public class DAO extends DBContext {

    // tao tai khoan
    public void add(Account a) {

        String sql = "INSERT INTO `ACCOUNT` (`username`, `email`, `password`, `auth_method`, `role`) VALUES (?, ?, ?, ?, ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getUsername());
            st.setString(2, a.getEmail());
            st.setString(3, a.getPassword());
            st.setString(4, "local");
            st.setString(5, "user");
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public void update(Account a) {
        String sql = "UPDATE account set username= ? ,password = ? where email= ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, a.getUsername());
//            st.setString(2, a.getEmail());
            st.setString(2, a.getPassword());
            st.setString(3, a.getEmail());
//            st.setString(4, "local");
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    public boolean checkUser(String username) {

        String sql = "SELECT * FROM `ACCOUNT` WHERE `username`=?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean checkUserEmail(String email) {
        String sql = "select * from account where email= ? and auth_method = 'google' ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
//   TMS

    public DAO() {
        connectDB();
    }
    //Khai bao cac thanh phan xy ly databse
    Connection cnn;//Ket noi db
    PreparedStatement stm; //Thuc hien cac cau lenh sql
    ResultSet rs;//Dung de luu tru va xu ly du lieu lay ve tu select

    private void connectDB() {
        cnn = connection;
        if (cnn != null) {
            System.out.println("Connect success");
        } else {
            System.out.println("Connect fail");
        }
    }

    public void insertUserUsingGoogle(Account u) {
        try {
            String strSQL = "INSERT INTO Account (email, password, auth_method) VALUES (?, NULL, ?)";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, u.email);
            stm.setString(2, "google");
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
            // Optionally, log more details or handle specific cases
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("Error Code: " + ex.getErrorCode());
            System.out.println("Message: " + ex.getMessage());
            Throwable t = ex.getCause();
            while (t != null) {
                System.out.println("Cause: " + t);
                t = t.getCause();
            }
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (cnn != null) {
                    cnn.close();
                }
            } catch (Exception e) {
                System.out.println("Finally block: " + e.getMessage());
            }
        }
    }

    public boolean checkUserUsingGoogle(String email) {
        try {
            String strSQL = "select * from account where email = ? and auth_method = 'local' ";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, email);

            rs = stm.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("checkUserUsingGoogle" + e.getMessage());
        }
        return false;
    }

    public boolean checkUser1(String username, String password) {
        try {
            String strSQL = "select * from ACCOUNT where username = ? and password = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("checkUser1" + e.getMessage());
        }
        return false;
    }

    public boolean checkUserAndEmail(String username, String email) {
        try {
            String strSQL = "select * from ACCOUNT where username = ? and password = email";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, username);
            stm.setString(2, email);
            rs = stm.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("checkUserAndEmail" + e.getMessage());
        }
        return false;
    }

    public String getEmailByName(String username) {
        String email = null;
        try {
            String strSQL = "SELECT email FROM account WHERE username = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, username);
            rs = stm.executeQuery();
            if (rs.next()) {
                email = rs.getString("email");
            }
        } catch (SQLException e) {
            System.out.println("getEmailByName: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (cnn != null) {
                    cnn.close();
                }
            } catch (SQLException e) {
                System.out.println("getEmailByName (finally block): " + e.getMessage());
            }
        }
        return email;
    }

    public Account getUserByEmail(String email) {
        Account account = null;
        try {
            String strSQL = "SELECT username, password, email FROM ACCOUNT WHERE email = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, email);
            rs = stm.executeQuery();
            if (rs.next()) {
                String username = rs.getString("username");
                String password = rs.getString("password");
                String userEmail = rs.getString("email");
                account = new Account(username, email, password);
            }
        } catch (SQLException e) {
            System.out.println("getUserByEmail: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
                if (cnn != null) {
                    cnn.close();
                }
            } catch (SQLException e) {
                System.out.println("getUserByEmail (finally block): " + e.getMessage());
            }
        }
        return account;
    }

    //Hung
    public Account checkAuthen(String username, String password) {
        String sql = "SELECT * FROM `ACCOUNT` WHERE `username`=? AND `password`=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                // Trả về một đối tượng account với username, password
                return new Account(username, password);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean isAdmin(String username) {
        String sql = "SELECT isAdmin FROM Account WHERE username=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getBoolean("isAdmin");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean updatePassword(String email, String newPassword) {
        String sql = "update account set password = ? where email=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setString(2, email);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public boolean checkEmail(String email) {
        String sql = "select * from account where email=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }




    
    public String getPasswordByUserId(String id) {
        String password = null;
        try {
            String strSQL = "SELECT password FROM account WHERE id = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                password = rs.getString("password");
            }
        } catch (SQLException e) {
            System.out.println("getPasswordByUserId: " + e.getMessage());

        }
        return password;
    }

    public int getIdByUsername(String username) {
        int id = 0;
        try {
            String strSQL = "SELECT id FROM account WHERE username = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, username);
            rs = stm.executeQuery();
            if (rs.next()) {
                id = rs.getInt("id");
            }
        } catch (SQLException e) {
            System.out.println("getIdByUsername: " + e.getMessage());
        }
        return id;
    }

    public String getStatusByUserId(int id) {
        String status = null;
        try {
            String strSQL = "SELECT status FROM account WHERE id = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                status = rs.getString("status");
            }
        } catch (SQLException e) {
            System.out.println("getStatusByUserId: " + e.getMessage());
        }
        return status;
    }

    public String getRoleByUserId(int id) {
        String role = null;
        try {
            String strSQL = "SELECT role FROM account WHERE id = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                role = rs.getString("role");
            }
        } catch (SQLException e) {
            System.out.println("getStatusByUserId: " + e.getMessage());
        }
        return role;
    }

    public boolean updateAccountStatus(String userId, String status) {
        String query = "UPDATE account SET status = ?,updated_at = CURRENT_TIMESTAMP WHERE ID = ?";

        try (PreparedStatement statement = cnn.prepareStatement(query)) {
            statement.setString(1, status);
            statement.setString(2, userId);

            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0; // Returns true if at least one row was updated
        } catch (SQLException ex) {
            ex.printStackTrace();
            // Optionally, log more details or handle specific cases
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("Error Code: " + ex.getErrorCode());
            System.out.println("Message: " + ex.getMessage());
            Throwable t = ex.getCause();
            while (t != null) {
                System.out.println("Cause: " + t);
                t = t.getCause();
            }
        }

        return false;

    }




    //NEW search category
    public List<Categories> searchCategory(String txt) {
        List<Categories> list = new ArrayList<>();
        String sql = "Select * from Category where id like ? or lower(name) like ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            String searchPattern = "%" + txt + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Categories(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {

        }
        return list;
    }

    //get all category
    public List<Categories> getAllCategory() {
        List<Categories> list = new ArrayList<>();
        String sql = "SELECT * FROM category WHERE status = 'Active'";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Categories(rs.getInt("id"), rs.getString("name")));
            }
        } catch (SQLException e) {
        }
        return list;
    }

    //update category
    public void updateCategory(int cid, String cname) {
        String sql = "update Category set name = ? where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cname);
            st.setInt(2, cid);
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }

    //add category
    public void addCategory(String cname) {
        String sql = "INSERT INTO category (name, status) VALUES (?, 'Active')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cname);
            st.executeUpdate();
        } catch (SQLException e) {
        }
    }

    //archive category
    public void archiveCategory(int id) {
        String sql = "UPDATE category SET status = 'Archived' WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

            // Also archive all products in this category
            String productSql = "UPDATE product SET status = 'Archived' WHERE categoryID = ?";
            PreparedStatement psProduct = connection.prepareStatement(productSql);
            psProduct.setInt(1, id);
            psProduct.executeUpdate();

        } catch (SQLException e) {

        }
    }

    //unarchive category
    public void unarchiveCategory(int id) {
        String sql = "UPDATE category SET status = 'Active' WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();

            // Also unarchive all products in this category
            String productSql = "UPDATE product SET status = 'Active' WHERE categoryID = ?";
            PreparedStatement psProduct = connection.prepareStatement(productSql);
            psProduct.setInt(1, id);
            psProduct.executeUpdate();

        } catch (SQLException e) {
           
        }
    }

    //archive product
    public void archiveProduct(String id) {
        String sql = "UPDATE PRODUCT set status = 'Archived' where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }

    //unarchive product
    public void unarchiveProduct(String id) {
        String sql = "UPDATE PRODUCT set status = 'Active' where id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }

    //get categories by status
    public List<Categories> getCategoriesByStatus(String status) {
        List<Categories> list = new ArrayList<>();
        String sql = "SELECT * FROM category WHERE status = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories category = new Categories();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setStatus(rs.getString("status"));
                list.add(category);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<String> getUniqueStatuses() {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT status FROM category WHERE status IS NOT NULL";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                statuses.add(rs.getString("status"));
            }
        } catch (SQLException e) {

        }
        return statuses;
    }
}
