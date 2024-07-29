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

/**
 *
 * @author ADMIN
 */
public class BillDAO extends DBContext {
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

    public BillDAO() {
        connectDB();
    }

    public void insertBill(Connection conn, String transactionCode, Cart cartItem, String billCode, String seriNumber, String username, String repoID) {
        ProductDAO pDAO = new ProductDAO();
        CartDAO cDAO = new CartDAO();
        String sql = "INSERT INTO BILL (transactionCode, productID, quantity, price, total, code, seri_number, created_by, repositoryId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = cnn.prepareStatement(sql)) {
            ps.setString(1, transactionCode);

            ps.setString(2, cartItem.getProductID());
            ps.setInt(3, 1);  // quantity for each unit is 1
            ps.setInt(4, cDAO.getPriceEachProduct(cartItem.getProductID()));

            ps.setString(5, cartItem.getTotal().replaceAll(",", "")); // total for each unit
            ps.setString(6, billCode);
            ps.setString(7, seriNumber);
            ps.setString(8, username);
            ps.setString(9, repoID);
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
    public List<Bill> getAllBillIndetailTransact(String transactionCode) {
        List<Bill> BillList = new ArrayList<>();
        String sql = "select productId, code, seri_number \n"
                + "from bill where transactionCode = ? ";

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setString(1, transactionCode);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Bill bill = new Bill();
                bill.setProductName(rs.getString("productId"));
                bill.setCode(rs.getString("code"));
                bill.setSeriNumber(rs.getString("seri_number"));

                BillList.add(bill);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return BillList ;
    }

}
