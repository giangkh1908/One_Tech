package dal;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import model.Profile;
import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author DELL
 */
//chua cac ham xu ly database cho user
public class ProfileDAO extends DBContext {

    public boolean checkUser(String account, String password) {
        try {
            String strSQL = "select * from Users where account = ? and password = ?";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, account);
            stm.setString(2, password);
            rs = stm.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("checkUser" + e.getMessage());
        }
        return false;
    }

    public ProfileDAO() {
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

    public String getNameByAccount(String account) {
        try {
            String strSQL = "select * from Users where account = ? ";
            stm = cnn.prepareStatement(strSQL);
            stm.setString(1, account);

            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getString(3);
            }
        } catch (Exception e) {
            System.out.println("checkUser" + e.getMessage());
        }
        return "";
    }

    public boolean createProfile(Profile profile) {
        String query = "INSERT INTO Profile (userId, Fullname, PhoneNumber, LinkAvatar) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, profile.getUserId());
            statement.setString(2, profile.getFullname());

            statement.setString(3, profile.getPhoneNumber());
            statement.setString(4, profile.getLinkAvatar());
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return false;
    }

    public boolean checkProfileExist(int userId) {
        String query = "SELECT COUNT(*) FROM profile WHERE userid = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return false;
    }

    public Profile getProfileByUserId(int userId) {
        Profile profile = null;
        try {
            String strSQL = "select userId,username, fullName, a.email, linkAvatar,phoneNumber, a.status \n"
                    + "from profile p\n"
                    + "join account a on p.userId = a.id   \n"
                    + "where userId = ? ";
            stm = cnn.prepareStatement(strSQL);
            stm.setInt(1, userId);
            rs = stm.executeQuery();
            if (rs.next()) {
                String username = rs.getString("username");
                String fullName = rs.getString("fullName");
                String email = rs.getString("email");
                String linkAvatar = rs.getString("linkAvatar");
                String phoneNumber = rs.getString("phoneNumber");
                String status = rs.getString("status");
                profile = new Profile(String.valueOf(userId), username, fullName, email, linkAvatar, phoneNumber, status);
            }
        } catch (SQLException e) {
            System.out.println("getProfileByUserId: " + e.getMessage());

        }
        return profile;
    }

    public boolean updateProfile(Profile updatedProfile) {
        String query = "UPDATE profile SET Fullname = ?, LinkAvatar = ?, phoneNumber = ?, updated_at = CURRENT_TIMESTAMP WHERE UserID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, updatedProfile.getFullname());
            statement.setString(2, updatedProfile.getLinkAvatar());
            statement.setString(3, updatedProfile.getPhoneNumber());

            statement.setInt(4, Integer.parseInt(updatedProfile.getUserId()));

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public List<Profile> getAllProfile() {
        List<Profile> profileList = new ArrayList<>();
        String query = "select userId,username, a.email, phoneNumber, a.status\n"
                + "from profile  p\n"
                + "join account a on p.userId = a.id";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Profile profile = new Profile();
                profile.setUserId(resultSet.getString("UserID"));
                profile.setUsername(resultSet.getString("username"));
                profile.setEmail(resultSet.getString("email"));
                profile.setPhoneNumber(resultSet.getString("phoneNumber"));
                profile.setStatus(resultSet.getString("status"));
                profileList.add(profile);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return profileList;
    }

    public boolean updateProfileStatus(String status, int userId) {
        String query = "UPDATE profile SET status = ? WHERE userId = ?";

        try {
            PreparedStatement statement = cnn.prepareStatement(query);
            statement.setString(1, status);
            statement.setInt(2, userId);

            int rowsAffected = statement.executeUpdate();

            return rowsAffected > 0; // Returns true if at least one row was updated
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return false;
    }

    public int getTotalRecords(String key, String orderBy) {
        int totalRecords = 0;
        String baseQuery = "SELECT COUNT(*) FROM profile p JOIN account a ON p.userId = a.id";
        StringBuilder queryBuilder = new StringBuilder(baseQuery);
        boolean hasKey = key != null && !key.trim().isEmpty();
        boolean hasOrderBy = orderBy != null && !orderBy.trim().isEmpty();
        List<String> conditions = new ArrayList<>();

        if (hasKey) {
            conditions.add("(a.username LIKE ? OR p.fullName LIKE ? OR a.email LIKE ? OR p.phoneNumber LIKE ?)");
        }

        if (hasOrderBy) {
            if (orderBy.equalsIgnoreCase("active")) {
                conditions.add("a.status = 'active'");
            } else if (orderBy.equalsIgnoreCase("inactive")) {
                conditions.add("a.status = 'inactive'");
            }
        }

        if (!conditions.isEmpty()) {
            queryBuilder.append(" WHERE ").append(String.join(" AND ", conditions)).append(" AND role = 'user'");
        } else {
            queryBuilder.append(" WHERE role = 'user'");
        }

        String query = queryBuilder.toString();
        System.out.println("query: " + query);

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            int paramIndex = 1;
            if (hasKey) {
                String searchKey = "%" + key + "%";
                statement.setString(paramIndex++, searchKey);
                statement.setString(paramIndex++, searchKey);
                statement.setString(paramIndex++, searchKey);
                statement.setString(paramIndex++, searchKey);
            }

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    totalRecords = resultSet.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalRecords;
    }

    public List<Profile> getRecords(int currentPage, int recordsPerPage, String key, String orderby) {
        List<Profile> profileList = new ArrayList<>();
        int start = (currentPage - 1) * recordsPerPage;

        StringBuilder sql = new StringBuilder("SELECT p.userId, a.username, p.fullName, a.email, p.linkAvatar, p.phoneNumber, a.status, a.created_at as creationDate, a.lastLogin as lastLoginDate "
                + "FROM profile p "
                + "JOIN account a ON p.userId = a.id ");

        if (key != null && orderby.equalsIgnoreCase("inactive")) {
            sql.append("WHERE (a.username LIKE ? OR p.fullName LIKE ? OR a.email LIKE ? OR p.phoneNumber LIKE ?) and role = 'user' and a.status = 'inactive' ");
        } else if (key != null && orderby.equalsIgnoreCase("active")) {
            sql.append("WHERE (a.username LIKE ? OR p.fullName LIKE ? OR a.email LIKE ? OR p.phoneNumber LIKE ?) and role = 'user' and a.status = 'active' ");
        } else if (key != null) {
            sql.append("WHERE (a.username LIKE ? OR p.fullName LIKE ? OR a.email LIKE ? OR p.phoneNumber LIKE ?) and role='user' ");
        } else if (key == null) {
            sql.append("Where role = 'user' ");
        }

        if (orderby != null && orderby.equalsIgnoreCase("username")) {
            sql.append("ORDER BY a.username ");
        } else if (orderby != null && orderby.equalsIgnoreCase("fullname")) {
            sql.append("ORDER BY p.fullName ");
        } else if (orderby != null && orderby.equalsIgnoreCase("phoneNumber")) {
            sql.append("ORDER BY p.phoneNumber ");
        } else if (orderby != null && orderby.equalsIgnoreCase("email")) {
            sql.append("ORDER BY a.email ");
        } else if (orderby != null && orderby.equalsIgnoreCase("creationDate")) {
            sql.append("ORDER BY creationDate DESC ");
        } else {
            sql.append("ORDER BY p.userId ");
        }

        sql.append("limit ?, ? ");

        System.out.println("Executing query: " + sql.toString() + " with parameters: key=" + key + ", OFFSET=" + start + ", FETCH NEXT=" + recordsPerPage);  // Debugging log

        try (PreparedStatement statement = connection.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (key != null) {
                String searchKey = "%" + key + "%";
                statement.setString(paramIndex++, searchKey);
                statement.setString(paramIndex++, searchKey);
                statement.setString(paramIndex++, searchKey);
                statement.setString(paramIndex++, searchKey);
            }

            statement.setInt(paramIndex++, start);
            statement.setInt(paramIndex, recordsPerPage);

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Profile profile = new Profile();
                profile.setUserId(resultSet.getString("userId"));
                profile.setUsername(resultSet.getString("username"));
                profile.setFullname(resultSet.getString("fullName"));
                profile.setEmail(resultSet.getString("email"));
                profile.setPhoneNumber(resultSet.getString("phoneNumber"));
                profile.setStatus(resultSet.getString("status"));
                profile.setCreationDate(resultSet.getString("creationDate"));
                profile.setLastLoginDate(resultSet.getString("lastLoginDate"));
                profileList.add(profile);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return profileList;
    }

    public boolean updateAccountPassword(String password, String username) {
        String query = "UPDATE account SET password = ?,updated_at = CURRENT_TIMESTAMP WHERE username = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, password);
            statement.setString(2, username);

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

    public void updateAccountLoginDate(String username) {
        String query = "UPDATE account SET lastLogin = CURRENT_TIMESTAMP WHERE username = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, username);

            int rowsAffected = statement.executeUpdate();

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

    }
        public String getNameById(int id) {
    String name = "";
    String sql = "SELECT name FROM Users WHERE id = ?";
    
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        
        if (rs.next()) {
            name = rs.getString("name");
        }
    } catch (SQLException e) {
        System.out.println("getNameById: " + e.getMessage());
    }
    
    return name;
}

}
