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

/**
 *
 * @author ADMIN
 */
public class CartDAO extends DBContext {

    ProfileDAO dao = new ProfileDAO();

    // Create (INSERT) a new cart item
    public boolean insertCart(Cart cart) {
        String sql = "INSERT INTO CART (userID, productID, quantity, created_at, updated_at, created_by, isDelete, deletedBy, deletedAt, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, cart.getUserID());
            st.setString(2, cart.getProductID());
            st.setInt(3, cart.getQuantity());
            st.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            st.setTimestamp(5, null);
            st.setString(6, dao.getNameById(cart.getUserID()));
            st.setBoolean(7, false);
            st.setString(8, null);
            st.setTimestamp(9, null);
            st.setString(10, "Active");
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Read (SELECT) a cart item by ID
    public Cart getCartById(int id) {
        String sql = "SELECT * FROM CART WHERE id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return extractCartFromResultSet(rs);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public boolean updateCartQuantity(int cartId, int newQuantity) {
        String sql = "UPDATE CART SET quantity = ?, updated_at = ? WHERE id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, newQuantity);
            st.setTimestamp(2, new Timestamp(System.currentTimeMillis())); // Update timestamp to current time
            st.setInt(3, cartId);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Delete (DELETE) a cart item by ID
    public boolean deleteCart(int id) {
        String sql = "DELETE FROM CART WHERE id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Retrieve all cart items
    public List<Cart> getCarts() {
        List<Cart> list = new ArrayList<>();
        String sql = "SELECT * FROM CART";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Cart cart = extractCartFromResultSet(rs);
                list.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Search carts by user ID or product ID
    public List<Cart> searchCarts(String txt) {
        List<Cart> list = new ArrayList<>();
        String sql = "SELECT * FROM CART WHERE userID LIKE ? OR productID LIKE ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            String searchPattern = "%" + txt + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Cart cart = extractCartFromResultSet(rs);
                list.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper method to extract Cart object from ResultSet
    private Cart extractCartFromResultSet(ResultSet rs) throws SQLException {
        Cart cart = new Cart();
        cart.setId(rs.getInt("id"));
        cart.setUserID(rs.getInt("userID"));
        cart.setProductID(rs.getString("productID"));
        cart.setQuantity(rs.getInt("quantity"));
        return cart;
    }

    // Add item to cart or update quantity if already exists
//    public void addToCart(Cart item) {
//        String sql = "INSERT INTO CART (userID, productID, quantity, created_at, updated_at, created_by, isDelete, deletedBy, deletedAt, status) "
//                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) "
//                + "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity), updated_at = VALUES(updated_at)";
//
//        try ( PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, item.getUserID());
//            st.setString(2, item.getProductID());
//            st.setInt(3, item.getQuantity());
//            st.setTimestamp(4, new Timestamp(System.currentTimeMillis())); // created_at
//            st.setTimestamp(5, new Timestamp(System.currentTimeMillis())); // updated_at
//            st.setString(6, dao.getNameById(item.getUserID())); // created_by (example value)
//            st.setBoolean(7, false); // isDelete
//            st.setString(8, null); // deletedBy
//            st.setTimestamp(9, null); // deletedAt
//            st.setString(10, "Active"); // status
//
//            st.executeUpdate();
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//    }
    public boolean addToCart(Cart item) {
        String selectSql = "SELECT quantity FROM CART WHERE userID = ? AND productID = ?";
        String updateSql = "UPDATE CART SET quantity = ?, updated_at = ? WHERE userID = ? AND productID = ?";
        String insertSql = "INSERT INTO CART (userID, productID, quantity, created_at, updated_at, created_by, isDelete, deletedBy, deletedAt, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement selectStatement = connection.prepareStatement(selectSql)) {
            selectStatement.setInt(1, item.getUserID());
            selectStatement.setString(2, item.getProductID());
            ResultSet rs = selectStatement.executeQuery();

            if (rs.next()) {
                // If both userID and productID exist, update the quantity
                int currentQuantity = rs.getInt("quantity");
                int newQuantity = currentQuantity + item.getQuantity();

                try (PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {
                    updateStatement.setInt(1, newQuantity);
                    updateStatement.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                    updateStatement.setInt(3, item.getUserID());
                    updateStatement.setString(4, item.getProductID());
                    updateStatement.executeUpdate();
                }
            } else {
                // If either userID or productID does not exist, insert a new row
                try (PreparedStatement insertStatement = connection.prepareStatement(insertSql)) {
                    insertStatement.setInt(1, item.getUserID());
                    insertStatement.setString(2, item.getProductID());
                    insertStatement.setInt(3, item.getQuantity());
                    insertStatement.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                    insertStatement.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
                    insertStatement.setString(6, dao.getNameById(item.getUserID()));
                    insertStatement.setBoolean(7, false);
                    insertStatement.setString(8, null);
                    insertStatement.setTimestamp(9, null);
                    insertStatement.setString(10, "Active");
                    insertStatement.executeUpdate();
                }
            }

            rs.close(); // Close the ResultSet explicitly

            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // Remove item from cart by productId
    public boolean removeFromCart(String productId) {
        String sql = "DELETE FROM CART WHERE productID = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was deleted
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // Get total price of items in the cart
    public int getTotal(int userId) {
        int total = 0;
        String sql = "SELECT SUM(eachPriceTable.eachPrice) AS totalPrice\n"
                + "FROM (\n"
                + "    SELECT\n"
                + "		c.userID,\n"
                + "        c.status,\n"
                + "        ((p.price * c.quantity) - (c.quantity * p.price * p.discount) / 100) AS eachPrice\n"
                + "    FROM \n"
                + "        product p\n"
                + "    JOIN \n"
                + "        cart c \n"
                + "    ON \n"
                + "        p.id = c.productID\n"
                + ") AS eachPriceTable where eachPriceTable.userID = ? and eachPriceTable.status = 'Active'";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt("totalPrice");  // Use the correct alias name
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return total;
    }

    public String getImageByProductID(String productId) {
        String image = "";
        String sql = "select c.productID,p.image from cart c\n"
                + "join product p on c.productID = p.id where c.productID = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    image = rs.getString("image");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return image;
    }

    public String getProductIdByCart(List<Cart> cartList) {
        for (Cart cart : cartList) {
            return cart.getProductID();
        }
        return null;
    }

    // Get all cart items by user ID
    public List<Cart> getAllCartByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT * FROM CART WHERE userID = ? and status = 'Active' ";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Cart cart = extractCartFromResultSet(rs);
                cartList.add(cart);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return cartList;
    }

    public int getCartQuantityByProductId(int userId, String productId) {
        String sql = "SELECT quantity FROM cart WHERE userID = ? AND productID = ?";
        int quantity = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, productId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quantity;
    }

    public int countItemsByUserID(int userId) {
        String sql = "SELECT COUNT(productID) AS cartItemCount FROM cart WHERE userID = ? and status = 'Active' ";
        int quantity = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("cartItemCount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return quantity;
    }

    public String getCategoryByProductID(String productId) {
        String category = "";
        String sql = "select p.id, c.name\n"
                + "from product p\n"
                + "join category c\n"
                + "on p.categoryID = c.id where p.id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productId);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    category = rs.getString("name");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return category;
    }

    public int getTotalEachProduct(String productID) {
        int total = 0;
        String sql = "select ((p.price *c.quantity)- (c.quantity * p.price * p.discount)/100) as EachPrice\n"
                + "from product p\n"
                + "join cart c \n"
                + "on p.id = c.productID\n"
                + "where c.productID = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt("EachPrice");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return total;
    }

    public int getDiscountByProductId(String productID) {
        int discount = 0;
        String sql = "select discount\n"
                + "from product p\n"
                + "\n"
                + " where p.id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    discount = rs.getInt("discount");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return discount;
    }

    public boolean updateCartStatusAfterTransact(Connection conn, int userID) throws SQLException {
        String sql = "UPDATE Cart SET status = 'Processed' WHERE userid = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setInt(1, userID);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean updateQuantityProductAfterTransact(Connection conn, List<Cart> cartItems, int quantityInStock) {
        String sql = "UPDATE product SET quantity = ? WHERE id = ?";
        boolean allUpdated = true;

        try (Connection connection = getConnection(); // Assuming you have a method to get the DB connection
                 PreparedStatement st = connection.prepareStatement(sql)) {

            connection.setAutoCommit(false);  // Start transaction

            for (Cart cartItem : cartItems) {
                String productID = cartItem.getProductID();
                int quantityToBuy = cartItem.getQuantity();
                //int quantityInStock = quantityInStock;  // Assuming you have a method to get the current stock

                int newQuantity = quantityInStock - quantityToBuy;
                if (newQuantity < 0) {
                    allUpdated = false;
                    break;  // Optional: Decide whether to stop or continue if one update fails
                }

                st.setInt(1, newQuantity);
                st.setString(2, productID);
                int rowsUpdated = st.executeUpdate();
                if (rowsUpdated <= 0) {
                    allUpdated = false;
                    break;
                }
            }

            if (allUpdated) {
                connection.commit();
            } else {
                connection.rollback();
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
            allUpdated = false;
        }

        return allUpdated;
    }

    public boolean isStringUnique(String randomString) {
        String sql = "SELECT COUNT(*) FROM Transaction WHERE transactionCode = ?";
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, randomString);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public int getPriceEachProduct(String productID) {
        int priceAfterDiscount = 0;
        String sql = "select (price - ((price * discount)/100)) as PriceEachProduct \n"
                + "from product\n"
                + "where id = ? ";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    priceAfterDiscount = rs.getInt("PriceEachProduct");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return priceAfterDiscount;
    }

    public boolean updateCodeAfterTransact(Connection conn, int userID, String transactionCode) {

        String sql = "UPDATE Cart SET transactionCode = ? WHERE userid = ? AND status = 'Processed' AND (transactionCode IS NULL OR transactionCode = '')";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, transactionCode);
            st.setInt(2, userID);

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Cart> getAllCardIndetailTransact(int userId, String transactionCode, String role) {
        List<Cart> cartList = new ArrayList<>();
        String sql = "";
        if (role.equalsIgnoreCase("admin")) {
            sql = "select ct.productID,ct.quantity, p.price, p.discount, cy.name \n"
                    + "from cart ct\n"
                    + "join product p on ct.productId = p.id\n"
                    + "join category cy on p.categoryID = cy.id \n"
                    + "where transactionCode = ?";

        } else {
            sql = "select ct.productID,ct.quantity, p.price, p.discount, cy.name \n"
                    + "from cart ct\n"
                    + "join product p on ct.productId = p.id\n"
                    + "join category cy on p.categoryID = cy.id \n"
                    + "where ct.userID = ? and transactionCode = ?";
        }

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            if (role.equalsIgnoreCase("admin")) {
                st.setString(1, transactionCode);
            } else {
                st.setInt(1, userId);
                st.setString(2, transactionCode);
            }

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCategory(rs.getString("name"));
                cart.setQuantity(Integer.parseInt(rs.getString("quantity")));
                cart.setTotal(rs.getString("price"));
                cartList.add(cart);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return cartList;
    }

    public int getQuantityInCart(int userID) {
        int quantity = 0;
        String sql = "select count(productID)  as quantity\n"
                + "from cart\n"
                + "where userid = ?  and status = 'Active' ;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return quantity;
    }

    public int getQuantityInStock(String productID) {
        int quantity = 0;
        String sql = "select quantity  \n"
                + "from product \n"
                + "where id = ? ;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return quantity;
    }

    public int getMaxQuantityWhenAdding(String productID, int userID) {
        int maxQuantityToAdd = 0;
        String sql = "SELECT \n"
                + "    p.quantity AS stock_quantity, \n"
                + "    COALESCE((SELECT SUM(c.quantity) FROM CART c WHERE c.userID = ? AND c.status = 'Active' AND c.productID = ?), 0) AS cart_quantity,\n"
                + "    p.quantity - COALESCE((SELECT SUM(c.quantity) FROM CART c WHERE c.userID = ? AND c.status = 'Active' AND c.productID = ?), 0) AS max_quantity_to_add\n"
                + "FROM \n"
                + "    PRODUCT p \n"
                + "WHERE \n"
                + "    p.id = ?;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userID);
            st.setString(2, productID);
            st.setInt(3, userID);
            st.setString(4, productID);
            st.setString(5, productID);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    maxQuantityToAdd = rs.getInt("max_quantity_to_add");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return maxQuantityToAdd;
    }

    public boolean deteletProductOutStock(String productID, int userID) {
        String sql = "Delete from cart where productID = ? and userID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, productID);
            st.setInt(2, userID);

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public List<Cart> getProductOutOfStock(int userId) {
        List<Cart> ProductOutOfStockList = new ArrayList<>();

        String sql = "select c.productID, p.quantity from cart c join product p \n"
                + "on c.productID = p.id where userid = ? and (p.quantity - c.quantity < 0) and c.status = 'Active'";

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setInt(1, userId);

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setProductID(rs.getString("productID"));
                 cart.setQuantity(rs.getInt("quantity"));
                ProductOutOfStockList.add(cart);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return ProductOutOfStockList;
    }

}
