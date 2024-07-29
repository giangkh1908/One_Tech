package dal;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import model.Transaction;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Repository;

/**
 *
 * @author KimHo
 */
public class TransactionDAO extends DBContext {

    public long getBalanceByUserId(String userId) {
        long balance = 0;
        String sql = "SELECT afterTransactMoney FROM `Transaction` WHERE userid = ? ORDER BY id DESC LIMIT 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userId);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                balance = rs.getLong("afterTransactMoney");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return balance;
    }

    public void addMoneyToUserAccount(String userId, int amountToAdd, String username, String transactionCode) {
        double currentBalance = getBalanceByUserId(userId);

        double newBalance = currentBalance + amountToAdd;

        String sql = "INSERT INTO `Transaction` (transaction_type, amount, beforeTransactMoney, afterTransactMoney, userid, created_at, description, transactionCode, status) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?,?, 'Processed')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "plus");
            st.setDouble(2, amountToAdd);
            st.setDouble(3, currentBalance);
            st.setDouble(4, newBalance);
            st.setString(5, userId);
            st.setString(6, "Hệ thống nạp tiền +" + amountToAdd + " cho tài khoản " + username);
            st.setString(7, transactionCode);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

//   TMS
    public TransactionDAO() {
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

    public List<Transaction> getTransactionListByUserId(String userId, String username, String from, String to, int currentPage, int recordsPerPage, String period) {
        List<Transaction> transactionList = new ArrayList<>();
        int start = (currentPage - 1) * recordsPerPage;

        try {
            StringBuilder strSQL = new StringBuilder("SELECT * FROM transaction WHERE 1=1 ");

            if (!username.equalsIgnoreCase("admin")) {
                strSQL.append("AND userid = ? ");
            }

            if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
                strSQL.append("AND created_at BETWEEN ? AND ? ");
            }

            if ("3months".equals(period)) {
                strSQL.append(" AND created_at BETWEEN DATE_SUB(NOW(), INTERVAL 3 MONTH) AND NOW()");
            } else if ("6months".equals(period)) {
                strSQL.append(" AND created_at BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW()");
            } else if ("9months".equals(period)) {
                strSQL.append(" AND created_at BETWEEN DATE_SUB(NOW(), INTERVAL 9 MONTH) AND NOW()");
            } else if ("1year".equals(period)) {
                strSQL.append(" AND created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 YEAR) AND NOW()");
            } else if (period == null) {
                strSQL.append(" ");
            }
            strSQL.append(" Order By created_at desc");

            strSQL.append(" LIMIT ?, ?");

            // Print the constructed query
            System.out.println("Query to fetch the list: " + strSQL.toString());

            try (PreparedStatement stm = connection.prepareStatement(strSQL.toString())) {
                int paramIndex = 1;

                if (!username.equalsIgnoreCase("admin")) {
                    stm.setString(paramIndex++, userId);
                }

                if (from != null && !from.isEmpty() && to != null && !to.isEmpty()) {
                    stm.setString(paramIndex++, from);
                    stm.setString(paramIndex++, to);
                }

                stm.setInt(paramIndex++, start);
                stm.setInt(paramIndex, recordsPerPage);

                // Print the parameters being set
                System.out.println("Parameters:");
                System.out.println("userId: " + userId);
                System.out.println("from: " + from);
                System.out.println("to: " + to);
                System.out.println("start: " + start);
                System.out.println("recordsPerPage: " + recordsPerPage);

                try (ResultSet rs = stm.executeQuery()) {
                    while (rs.next()) {
                        String id = rs.getString("id");
                        String transactionType = rs.getString("transaction_type");
                        DecimalFormat formatter = new DecimalFormat("#,###");
                        String amount = formatter.format(rs.getDouble("amount"));
                        String beforeTran = formatter.format(rs.getDouble("beforeTransactMoney"));
                        String afterTran = formatter.format(rs.getDouble("afterTransactMoney"));
                        String createdAt = rs.getString("created_at");
                        String userid = rs.getString("userid");
                        String description = rs.getString("description");
                        String transactionCode = rs.getString("transactionCode");

                        Transaction transaction = new Transaction(id, transactionType, amount, beforeTran, afterTran, userid, createdAt, description, transactionCode);
                        transactionList.add(transaction);
                    }
                }
            }
        } catch (SQLException e) {
            System.out.println("getTransactionListByUserId: " + e.getMessage());
        }

        return transactionList;
    }

    public String getDateByTransactionId(String transactionID) {
        String date = "";
        String sql = "SELECT created_at FROM `Transaction` WHERE id = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, transactionID);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                date = rs.getString("created_at");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return date;
    }

    public int getTotalRecords(String userid, String role, String period) {
        int totalRecords = 0;
        String baseQuery = "SELECT COUNT(*) FROM transaction";
        StringBuilder queryBuilder = new StringBuilder(baseQuery);

        // Adding condition to query
        if (!role.equals("admin")) {
            queryBuilder.append(" WHERE userid = ? ");
        }
        if ("3months".equals(period)) {
            if (!role.equals("admin")) {
                queryBuilder.append(" AND created_at BETWEEN DATE_SUB(NOW(), INTERVAL 3 MONTH) AND NOW()");
            } else {
                queryBuilder.append(" WHERE created_at BETWEEN DATE_SUB(NOW(), INTERVAL 3 MONTH) AND NOW()");
            }

        } else if ("6months".equals(period)) {
            if (!role.equals("admin")) {
                queryBuilder.append(" AND created_at BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW()");
            } else {
                queryBuilder.append(" WHERE created_at BETWEEN DATE_SUB(NOW(), INTERVAL 6 MONTH) AND NOW()");
            }
        } else if ("9months".equals(period)) {
            if (!role.equals("admin")) {
                queryBuilder.append(" AND created_at BETWEEN DATE_SUB(NOW(), INTERVAL 9 MONTH) AND NOW()");
            } else {
                queryBuilder.append(" WHERE created_at BETWEEN DATE_SUB(NOW(), INTERVAL 9 MONTH) AND NOW()");
            }
        } else if ("1year".equals(period)) {
            if (!role.equals("admin")) {
                queryBuilder.append(" AND created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 YEAR) AND NOW()");
            } else {
                queryBuilder.append(" WHERE created_at BETWEEN DATE_SUB(NOW(), INTERVAL 1 YEAR) AND NOW()");
            }
        }

        String query = queryBuilder.toString();
        System.out.println("query: " + query);

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            if (!role.equals("admin")) {
                statement.setString(1, userid); // Set the username parameter
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

    public boolean subtractMoneyToUserAccount(String userId, int amountToSubtract, String transactionCode, String description, List<Cart> cartItems, String userName) {
        Connection conn = null;
        PreparedStatement st = null;
        DAO dao = new DAO();
        CartDAO cDAO = new CartDAO();
        BillDAO bDAO = new BillDAO();
        RepositoryDAO repoDAO = new RepositoryDAO();

        try {
            conn = dao.getConnection(); // Get connection
            conn.setAutoCommit(false); // Start transaction

            // Set the transaction isolation level to REPEATABLE READ
            String isolationLevelSQL = "SET TRANSACTION ISOLATION LEVEL SERIALIZABLE";
            try (PreparedStatement isolationSt = conn.prepareStatement(isolationLevelSQL)) {
                isolationSt.execute();
            }

            double currentBalance = getBalanceByUserId(userId);
            double newBalance = currentBalance - amountToSubtract;

            String sql = "INSERT INTO `Transaction` (transaction_type, amount, beforeTransactMoney, afterTransactMoney, userid, created_at, description, transactionCode, status) VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, ?, ?, 'Processed')";

            st = conn.prepareStatement(sql);
            st.setString(1, "minus");
            st.setDouble(2, amountToSubtract);
            st.setDouble(3, currentBalance);
            st.setDouble(4, newBalance);
            st.setString(5, userId);
            st.setString(6, description);
            st.setString(7, transactionCode);

            int rowUpdated = st.executeUpdate();
            System.out.println("rowUpdated: " + rowUpdated);
            if (rowUpdated > 0) {
                int count = 1;

                for (Cart cartItem : cartItems) {
                    int quantity = cartItem.getQuantity();
                    for (int i = 0; i < quantity; i++) {
                        Repository repo = repoDAO.getRepoByProductID(conn, cartItem.getProductID());
                        if (repo != null) {
                            if (count == 1) {
                                // Update Cart status and transactionCode only once
                                String updateSql1 = "UPDATE Cart SET status = 'Processed' WHERE userid = ?";
                                try (PreparedStatement updateSt1 = conn.prepareStatement(updateSql1)) {
                                    updateSt1.setString(1, userId);
                                    updateSt1.executeUpdate();
                                }

                                String updateSql2 = "UPDATE Cart SET transactionCode = ? WHERE userid = ? AND status = 'Processed' AND (transactionCode IS NULL OR transactionCode = '')";
                                try (PreparedStatement updateSt2 = conn.prepareStatement(updateSql2)) {
                                    updateSt2.setString(1, transactionCode);
                                    updateSt2.setString(2, userId);
                                    updateSt2.executeUpdate();
                                }
                                count++;
                            }
                        } else {
                            conn.rollback();
                            return false;
                        }

                        bDAO.insertBill(conn, transactionCode, cartItem, repo.getCode(), repo.getSeriNumber(), userName, repo.getId());
                        repoDAO.updateStatusRepo(conn, cartItem.getProductID());
                    }
                    cDAO.updateQuantityProductAfterTransact(conn, cartItems, cDAO.getQuantityInStock(cartItem.getProductID()));
                }
            }

            conn.commit(); // Commit transaction
            return rowUpdated > 0;
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback transaction in case of error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            System.out.println(e);
            return false;
        } finally {
            if (st != null) {
                try {
                    st.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Reset to default state
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }

}
