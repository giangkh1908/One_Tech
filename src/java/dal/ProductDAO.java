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
import model.Product;

/**
 *
 * @author KimHo
 */
public class ProductDAO extends DBContext {

    public CategoryDAO cDao = new CategoryDAO();

    public int getTotalRecords(String key, String categoryID) {
        int totalRecords = 0;
        String baseQuery = "SELECT COUNT(*) FROM product";
        StringBuilder queryBuilder = new StringBuilder(baseQuery);
        boolean hasKey = key != null && !key.trim().isEmpty();
        boolean hasCategoryID = categoryID != null && !categoryID.trim().isEmpty() && !categoryID.equalsIgnoreCase("all");
        List<String> conditions = new ArrayList<>();

        if (hasKey) {
            conditions.add(" (name LIKE ? OR price LIKE ? OR quantity LIKE ?) ");
        }

        if (hasCategoryID) {
            conditions.add(" categoryID = ?");
        }

        if (!conditions.isEmpty()) {
            queryBuilder.append(" WHERE ").append(String.join(" AND ", conditions));
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
            }

            if (hasCategoryID) {
                statement.setString(paramIndex++, categoryID);
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

    public List<Product> getProduct(int currentPage, int recordsPerPage, String key, String categoryID) {
        List<Product> list = new ArrayList<>();
        int start = (currentPage - 1) * recordsPerPage;

        StringBuilder sql = new StringBuilder("SELECT * FROM PRODUCT ");
        boolean hasConditions = false;

        if (key != null && !key.trim().isEmpty()) {
            sql.append("WHERE (name LIKE ? OR price LIKE ? OR quantity LIKE ?)");
            hasConditions = true;
        }

        if (categoryID != null && !categoryID.equalsIgnoreCase("all")) {
            if (hasConditions) {
                sql.append("AND categoryID = ? ");
            } else {
                sql.append("WHERE categoryID = ? ");
            }
            hasConditions = true;
        }

//        if (!hasConditions) {
//            sql.append("WHERE status = 'Active' ");
//        }
        sql.append("LIMIT ?, ?");

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            int paramIndex = 1;
            List<String> paramValues = new ArrayList<>();

            if (key != null && !key.trim().isEmpty()) {
                String searchKey = "%" + key + "%";
                st.setString(paramIndex++, searchKey);
                st.setString(paramIndex++, searchKey);
                st.setString(paramIndex++, searchKey);
                paramValues.add(searchKey);
                paramValues.add(searchKey);
                paramValues.add(searchKey);
            }

            if (categoryID != null && !categoryID.equalsIgnoreCase("all")) {
                st.setString(paramIndex++, categoryID);
                paramValues.add(categoryID);
            }

            st.setInt(paramIndex++, start);
            st.setInt(paramIndex, recordsPerPage);
            paramValues.add(String.valueOf(start));
            paramValues.add(String.valueOf(recordsPerPage));

            // Print the SQL query and parameters
            System.out.println("Executing query: " + sql.toString());
            System.out.println("With parameters: " + paramValues);

            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                Categories c = cDao.getCategoryById(rse.getInt("categoryID"));
                Product p = new Product(
                        rse.getString("id"),
                        rse.getString("name"),
                        rse.getDouble("price"),
                        rse.getString("image"),
                        rse.getInt("quantity"),
                        rse.getString("description"),
                        rse.getInt("discount"),
                        rse.getString("status"),
                        c
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Print the exception to the console for debugging
        }

        return list;
    }

    public List<Product> getProduct() {
        List<Product> list = new ArrayList<>();
        String sql = "select * from PRODUCT";

        try {

            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                Categories c = cDao.getCategoryById(rse.getInt("categoryID"));
                Product p = new Product(rse.getString("id"),
                        rse.getString("name"),
                        rse.getDouble("price"),
                        rse.getString("image"),
                        rse.getInt("quantity"),
                        rse.getString("description"),
                        rse.getInt("discount"),
                        rse.getString("status"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public int countAllProduct() {
        String sql = "select count(*) from PRODUCT where status ='Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }

        return 0;
    }

    public int countAllProductOfCategory(String cid) {
        String sql = "select count(*) from PRODUCT  where categoryID =? and status ='Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
        }

        return 0;
    }

    public List<Product> getTop12() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCT where status ='Active' LIMIT 12 ;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                Categories c = cDao.getCategoryById(rse.getInt("categoryID"));
                Product p = new Product(rse.getString("id"),
                        rse.getString("name"),
                        rse.getDouble("price"),
                        rse.getString("image"),
                        rse.getInt("quantity"),
                        rse.getString("description"),
                        rse.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> getProductByIndex(int offset, int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM PRODUCT where status ='Active' ORDER BY categoryID LIMIT ?, ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, offset);
            st.setInt(2, limit);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
        }
        return list;
    }

    public List<Product> getProductsByCid(int cid) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from PRODUCT where categoryID = ? and status ='Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cid);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                Categories c = cDao.getCategoryById(rse.getInt("categoryID"));
                Product p = new Product(rse.getString("id"),
                        rse.getString("name"),
                        rse.getDouble("price"),
                        rse.getString("image"),
                        rse.getInt("quantity"),
                        rse.getString("description"),
                        rse.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> getProductsByCid(String cid) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from PRODUCT where categoryID = ? and status ='Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cid);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                Categories c = cDao.getCategoryById(rse.getInt("categoryID"));
                Product p = new Product(rse.getString("id"),
                        rse.getString("name"),
                        rse.getDouble("price"),
                        rse.getString("image"),
                        rse.getInt("quantity"),
                        rse.getString("description"),
                        rse.getInt("discount"),
                        rse.getString("status"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> getProductsByPageSorted(int offset, int limit, String sort, String categoryId) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT where status ='Active'";
            if (categoryId != null && !categoryId.isEmpty()) {
                sql += " AND categoryId = ?";
            }
            switch (sort) {
                case "ASC":
                    sql += " ORDER BY price ASC";
                    break;
                case "DESC":
                    sql += " ORDER BY price DESC";
                    break;
                case "Name":
                    sql += " ORDER BY name";
                    break;
            }
            sql += " LIMIT ?, ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            if (categoryId != null && !categoryId.isEmpty()) {
                ps.setString(paramIndex++, categoryId);
            }
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    //search products

    public List<Product> searchProducts(String txt) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE name LIKE ? OR price LIKE ? OR quantity LIKE ? and status ='Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            String searchPattern = "%" + txt + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            st.setString(3, searchPattern);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                list.add(new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        rs.getString("status"), c));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //search product in a particular category
    public List<Product> searchProductsByCid(int categoryID, String txt) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE categoryID = ? and (name LIKE ? OR price LIKE ? OR quantity LIKE ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            st.setInt(1, categoryID);
            String searchPattern = "%" + txt + "%";
            st.setString(2, searchPattern);
            st.setString(3, searchPattern);
            st.setString(4, searchPattern);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                list.add(new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        rs.getString("status"), c));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    //get product by id
    public Product getProductById(String productId) {
        Product product = null;
        String sql = "SELECT * FROM Product WHERE id = ? and status ='Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, productId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID")); // Thay đổi cách lấy category theo nhu cầu
                product = new Product(rs.getString("id"), rs.getString("name"), rs.getInt("price"), rs.getString("image"),
                        rs.getInt("quantity"), rs.getString("description"), rs.getInt("discount"), rs.getString("status"), c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> getTop10() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM project1.PRODUCT WHERE discount > 0 ORDER BY discount desc LIMIT 10;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "select * from project1.PRODUCT where id = id";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Product(rs.getString(1), rs.getString(2), rs.getInt(3), rs.getDouble(4), rs.getString(5), rs.getInt(6), rs.getString(7), rs.getDouble(8)));
            }
        } catch (Exception e) {

        }
        return list;
    }

    public List<Product> getProductsSortedByPriceAsc(int offset, int limit) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Product ORDER BY price ASC;";
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsSortedByPriceDesc(int offset, int limit) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Product ORDER BY price DESC;";
            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsSortedByNameAsc(int offset, int limit) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Product ORDER BY name ASC;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCidForCategory(String categoryId, int limit, int offset) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT WHERE categoryId = ? LIMIT ? OFFSET ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, categoryId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCidForCategory1(int categoryId) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT WHERE categoryId = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsSortedByPriceAscForCategory(String categoryId, int limit, int offset) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT WHERE categoryId = ? ORDER BY price ASC LIMIT ? OFFSET ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, categoryId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsSortedByPriceAscForCategory1(int categoryId) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT WHERE categoryId = ? ORDER BY price ASC";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsSortedByPriceDescForCategory(String categoryId, int limit, int offset) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT WHERE categoryId = ? ORDER BY price DESC LIMIT ? OFFSET ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, categoryId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsSortedByPriceDescForCategory1(int categoryId) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT WHERE categoryId = ? ORDER BY price DESC";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsSortedByNameAscForCategory(String categoryId, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT WHERE categoryId = ? ORDER BY name ASC LIMIT ? OFFSET ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, categoryId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsSortedByNameAscForCategory1(int categoryId) {
        List<Product> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM PRODUCT WHERE categoryId = ? ORDER BY name ASC";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getProductsById(String id) {
        String sql = "select * from PRODUCT where id=? and status ='Active'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"), rs.getString("name"), rs.getDouble("price"), rs.getString("image"),
                        rs.getInt("quantity"), rs.getString("description"), rs.getDouble("discount"), c);

                return p;
            }
        } catch (SQLException e) {

        }
        return null;
    }

    public boolean insertP(Product p) {
        String sql = "INSERT INTO PRODUCT (id, name, categoryID, price, image, quantity, description, discount, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement st = null;

        try {
            st = connection.prepareStatement(sql);
            st.setString(1, p.getId());
            st.setString(2, p.getName());
            st.setInt(3, p.getCategory().getId());
            st.setDouble(4, p.getPrice());
            st.setString(5, p.getImage());
            st.setInt(6, p.getQuantity());
            st.setString(7, p.getDescription());
            st.setDouble(8, p.getDiscount());
            st.setString(9, p.getStatus());
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception and print stack trace
            return false;
        } finally {
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    public boolean updateP(Product p) {
        String sql = "UPDATE PRODUCT SET name=?, price=?, quantity=?, description=?, discount=?, image=?, categoryID=? WHERE id=?";
        PreparedStatement st = null;

        try {
            st = connection.prepareStatement(sql);
            st.setString(1, p.getName());
            st.setDouble(2, p.getPrice());
            st.setInt(3, p.getQuantity());
            st.setString(4, p.getDescription());
            st.setDouble(5, p.getDiscount());
            st.setString(6, p.getImage());
            st.setInt(7, p.getCategory().getId());
            st.setString(8, p.getId());
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exception and print stack trace
            return false;
        } finally {
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

    public List<Product> getRandom16() {
        List<Product> list = new ArrayList<>();
        String sql = "select * from project1.PRODUCT where id = id ORDER BY RAND( ) LIMIT 16;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> getSimilarPrice(String id) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM project1.PRODUCT WHERE price = (SELECT price FROM PRODUCT WHERE id = ?) LIMIT 4;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> getSimilarCategory(String id) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM project1.PRODUCT WHERE categoryID = (SELECT categoryID FROM PRODUCT WHERE id = ?) LIMIT 4;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> getSuperDeals(String cid) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM project1.PRODUCT WHERE discount > 0 AND categoryID = ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, cid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Categories c = cDao.getCategoryById(rs.getInt("categoryID"));
                Product p = new Product(rs.getString("id"),
                        rs.getString("name"),
                        rs.getInt("price"),
                        rs.getString("image"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> getProductsByID(String id) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from project1.PRODUCT where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                Categories c = cDao.getCategoryById(rse.getInt("categoryID"));
                Product p = new Product(rse.getString("id"),
                        rse.getString("name"),
                        rse.getInt("price"),
                        rse.getString("image"),
                        rse.getInt("quantity"),
                        rse.getString("description"),
                        rse.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Product> searchByName(String txtSearch) {
        List<Product> list = new ArrayList<>();
        String sql = "select * from project1.PRODUCT where name like ?;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + txtSearch + "%");
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                Categories c = cDao.getCategoryById(rse.getInt("categoryID"));
                Product p = new Product(rse.getString("id"),
                        rse.getString("name"),
                        rse.getInt("price"),
                        rse.getString("image"),
                        rse.getInt("quantity"),
                        rse.getString("description"),
                        rse.getInt("discount"),
                        c);
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public Product getProductByID(String id) {

        String sql = "select * from project1.PRODUCT where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                Categories c = cDao.getCategoryById(rse.getInt("categoryID"));
                Product p = new Product(rse.getString("id"),
                        rse.getString("name"),
                        rse.getInt("price"),
                        rse.getString("image"),
                        rse.getInt("quantity"),
                        rse.getString("description"),
                        rse.getInt("discount"),
                        c);
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getQuantityById(String id) {

        String sql = "select quantity from project1.PRODUCT where id = ?";
        int quantity = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                quantity = rse.getInt("quantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quantity;
    }

    public int getPriceById(String id) {

        String sql = "select price from project1.PRODUCT where id = ?";
        int price = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                price = rse.getInt("price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return price;
    }
    
     public String getImageById(String id) {

        String sql = "select image from project1.PRODUCT where id = ?";
        String image = "";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rse = st.executeQuery();
            while (rse.next()) {
                image = rse.getString("image");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return image.replace("images/card/", "");
    }
}
