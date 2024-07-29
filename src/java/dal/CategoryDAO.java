/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Categories;

/**
 *
 * @author KimHo
 */
public class CategoryDAO extends DBContext {

    public int getTotalRecords(String key, String status) {
        int totalRecords = 0;
        String baseQuery = "SELECT COUNT(*) FROM category";
        StringBuilder queryBuilder = new StringBuilder(baseQuery);
        boolean hasKey = key != null && !key.trim().isEmpty();
        boolean hasStatus = (status != null);
        System.out.println("hasStatus" + hasStatus);
        List<String> conditions = new ArrayList<>();

        if (hasKey) {
            conditions.add(" id like ? or lower(name) like ? ");
        }

        if (hasStatus) {
            conditions.add(" status = ? ");
        }

        if (!conditions.isEmpty()) {
            queryBuilder.append(" WHERE").append(String.join(" AND ", conditions));
        } else {
            queryBuilder.append(" WHERE status = 'Active'");
        }

        String query = queryBuilder.toString();
        System.out.println("query: " + query);

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            int paramIndex = 1;
            if (hasKey) {
                String searchKey = "%" + key + "%";
                statement.setString(paramIndex++, searchKey);
                statement.setString(paramIndex++, searchKey);

            }

            if (hasStatus) {
                statement.setString(paramIndex++, status);
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

    public List<Categories> getCategory(int currentPage, int recordsPerPage, String key, String status) {
        List<Categories> list = new ArrayList<>();
        int start = (currentPage - 1) * recordsPerPage;
        StringBuilder sql = new StringBuilder("SELECT * FROM category ");
        boolean hasConditions = false;

        if (key != null && !key.trim().isEmpty()) {
            sql.append(" where (id like ? or lower(name) like ?)  ");
            hasConditions = true;
        }

        if (status != null) {
            if (status.equalsIgnoreCase("Active")) {
                if (key == null) {
                    sql.append(" where status = ? ");
                } else {
                    sql.append(" and status = ? ");
                }

            } else if (status.equalsIgnoreCase("Archived")) {
                if (key == null) {
                    sql.append(" where status = ? ");
                } else {
                    sql.append(" and status = ? ");
                }
            }
            hasConditions = true;
        }

        if (!hasConditions) {
            sql.append("WHERE status != 'archived' ");
        }

        sql.append("LIMIT ?, ?");

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (key != null && !key.trim().isEmpty()) {
                String searchKey = "%" + key + "%";
                st.setString(paramIndex++, searchKey);
                st.setString(paramIndex++, searchKey);

            }

            if (status != null) {
                st.setString(paramIndex++, status);
            }

            st.setInt(paramIndex++, start);
            st.setInt(paramIndex, recordsPerPage);

            // Print the SQL query and parameters for debugging
            System.out.println("Executing query: " + sql.toString());

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories c = new Categories(rs.getInt("id"), rs.getString("name"), rs.getString("status"));
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Print the exception to the console for debugging
        }

        return list;
    }

    // view all category
    public List<Categories> getCategory() {
        List<Categories> list = new ArrayList<>();
        String sql = "select * from category where status = 'Active' ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories c = new Categories(rs.getInt("id"), rs.getString("name"));
                list.add(c);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public Categories getCategoryById(int id) {
        String sql = "select * from CATEGORY where id=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rse = st.executeQuery();
            if (rse.next()) {
                Categories c = new Categories(rse.getInt("id"),
                        rse.getString("name"));
                return c;
            }
        } catch (SQLException e) {

        }
        return null;
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
        String sql = "SELECT * FROM category WHERE status IS NULL OR status != 'archived'";

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
        String sql = "Insert into category (name, status) values (?, 'Active')";
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
        String sql = "SELECT DISTINCT status FROM category WHERE status IS NOT NULL order by status asc";
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
