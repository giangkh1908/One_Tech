/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.security.SecureRandom;
import model.Cart;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Bill;
import model.Categories;
import model.Product;
import model.Repository;

/**
 *
 * @author ADMIN
 */
public class RepositoryDAO extends DBContext {
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

    public RepositoryDAO() {
        connectDB();
    }

    public void insertBill(String transactionCode, Cart cartItem, String billCode, String seriNumber, String username) {
        ProductDAO pDAO = new ProductDAO();
        CartDAO cDAO = new CartDAO();
        String sql = "INSERT INTO BILL (transactionCode, productName, quantity, price, total, code, seri_number, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = cnn.prepareStatement(sql)) {
            ps.setString(1, transactionCode);

            ps.setString(2, cartItem.getProductID());
            ps.setInt(3, 1);  // quantity for each unit is 1
            ps.setInt(4, cDAO.getPriceEachProduct(cartItem.getProductID()));

            ps.setString(5, cartItem.getTotal().replaceAll(",", "")); // total for each unit
            ps.setString(6, billCode);
            ps.setString(7, seriNumber);
            ps.setString(8, username);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

//    public List<Bill> getBillsByTransactionCode(String transactionCode) {
//        List<Bill> bills = new ArrayList<>();
//        String sql = "SELECT * FROM BILL WHERE transactionID = ?";
//        try (PreparedStatement ps = cnn.prepareStatement(sql)) {
//            ps.setString(1, transactionCode);
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    Bill bill = new Bill();
//                    bill.setProductName(rs.getString("productName"));
//                    bill.setQuantity(rs.getInt("quantity"));
//                    bill.setPrice(rs.getBigDecimal("price"));
//                    bill.setAmount(rs.getBigDecimal("amount"));
//                    bill.setTotal(rs.getBigDecimal("total"));
//                    bill.setCode(rs.getString("code"));
//                    bill.setSeriNumber(rs.getString("seri_number"));
//                    bills.add(bill);
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return bills;
//    }
    public List<Repository> getAllCardInRepository() {
        List<Repository> CardDetailList = new ArrayList<>();
        String sql = "select r.id, r.productID, p.price, p.discount, code, seri_number, r.status, r.created_at  from repository  r\n"
                + "join product p on r.productID = p.id ";

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Repository repo = new Repository();
                repo.setId(rs.getString("id"));
                repo.setProductId(rs.getString("productID"));
                repo.setPrice(rs.getString("price"));
                repo.setDiscount(rs.getString("discount"));
                repo.setCode(rs.getString("code"));
                repo.setSeriNumber(rs.getString("seri_number"));
                repo.setCreationDate(rs.getString("created_at"));
                repo.setStatus(rs.getString("status"));
                CardDetailList.add(repo);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return CardDetailList;
    }

    public List<Repository> getAllCardInRepository(int currentPage, int recordsPerPage, String key, String categoryID) {
        List<Repository> list = new ArrayList<>();
        int start = (currentPage - 1) * recordsPerPage;
        CategoryDAO cDAO = new CategoryDAO();
        StringBuilder sql = new StringBuilder(" select r.id, r.productID, p.price, p.discount, code, seri_number, r.status, r.created_at  from repository  r\n"
                + "join product p on r.productID = p.id  ");
        boolean hasConditions = false;

        if (key != null && !key.trim().isEmpty()) {
            sql.append("WHERE r.status = ? ");
            hasConditions = true;
        }

        if (categoryID != null && !categoryID.contains("all")) {
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
                String searchKey = key;
                st.setString(paramIndex++, searchKey);
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
                //Categories c = cDAO.getCategoryById(rse.getInt("categoryID"));
                Repository p = new Repository(
                        rse.getString("id"),
                        rse.getString("productID"),
                        rse.getString("price"),
                        rse.getString("discount"),
                        rse.getString("code"),
                        rse.getString("seri_number"),
                        rse.getString("status"),
                        rse.getString("created_at")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Print the exception to the console for debugging
        }

        return list;
    }

    public Repository getRepoByProductID(Connection conn, String productID) {
        Repository repo = null;
        String sql = "Select id, productid, code, seri_number, status from repository where productid = ? "
                + "and status = 'Active' order by id limit 1; ";

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setString(1, productID);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {

                repo = new Repository();
                repo.setId(rs.getString("id"));
                repo.setProductId(rs.getString("productid"));
                repo.setCode(rs.getString("code"));
                repo.setSeriNumber(rs.getString("seri_number"));
                repo.setStatus(rs.getString("status"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return repo;
    }

    public boolean updateStatusRepo(Connection conn, String productID) {
        String sql = "Update repository set status = 'Unavailable' where productid = ? "
                + "and status = 'Active' order by id limit 1";
        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setString(1, productID);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public int getTotalRecords(String key, String categoryID) {
        int totalRecords = 0;
        String baseQuery = "select count(*) \n"
                + "from repository r\n"
                + "join product p on r.productID = p.id \n"
                + "join category c on p.categoryID = c.id";
        StringBuilder queryBuilder = new StringBuilder(baseQuery);
        boolean hasKey = key != null && !key.trim().isEmpty();
        boolean hasCategoryID = categoryID != null && !categoryID.trim().isEmpty() && !categoryID.equalsIgnoreCase("all");
        List<String> conditions = new ArrayList<>();

        if (hasKey) {
            conditions.add(" r.status = ? ");
        }

        if (hasCategoryID) {
            conditions.add("  p.categoryID = ?");
        }

        if (!conditions.isEmpty()) {
            queryBuilder.append(" WHERE ").append(String.join(" AND ", conditions));
        }

        String query = queryBuilder.toString();
        System.out.println("query: " + query);

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            int paramIndex = 1;
            if (hasKey) {
                String searchKey = key;
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

    public List<String> getUniqueStatuses() {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT status FROM repository WHERE status IS NOT NULL order by status asc";
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

    public boolean insertNewCard(Repository p) {
        String sql = "INSERT INTO Repository (productID, created_at, code, seri_number, status) VALUES (?, CURRENT_TIMESTAMP, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, p.getProductId());
            st.setString(2, p.getCode());
            st.setString(3, p.getSeriNumber());
            st.setString(4, "Active");
            int rowsUpdated = st.executeUpdate();
            if(rowsUpdated > 0){
                updateQuantityAfterAddNewCard(p.getProductId());
            }
            return true; // Indicating that the insert operation was successful
        } catch (SQLException e) {
            e.printStackTrace(); // Print the stack trace for debugging
            return false; // Indicating that the insert operation failed
        }
    }

    public boolean updateQuantityAfterAddNewCard(String productID) {
        String sql = "Update Product set quantity = quantity + 1 where id = ? ";
        try(PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productID);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // Print the stack trace for debugging
            return false; // Indicating that the insert operation failed
        }
       
    }

}
