/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.BillDAO;
import dal.CartDAO;
import dal.DAO;
import dal.RepositoryDAO;
import dal.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;
import java.text.NumberFormat;
import java.util.List;
import model.Account;
import model.Cart;
import model.Repository;

/**
 *
 * @author ADMIN
 */
public class CheckoutController extends HttpServlet {

    private static final String CHARACTERS = "0123456789";
    private static final SecureRandom RANDOM = new SecureRandom();
    private static final int STRING_LENGTH = 10;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = new DAO();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        int userId = dao.getIdByUsername(acc.username);

        CartDAO cartDAO = new CartDAO();
        List<Cart> cartItems = cartDAO.getAllCartByUserId(userId);
        for (Cart cartItem : cartItems) {
            System.out.println(cartItem.toString());
        }
        for (Cart cartItem : cartItems) {
            String productID = cartItem.getProductID();
            String image = cartDAO.getImageByProductID(productID);
            cartItem.setImageURL(image);
            String category = cartDAO.getCategoryByProductID(productID);
            cartItem.setCategory(category);
            int totalEachProduct = cartDAO.getTotalEachProduct(productID);

            cartItem.setTotal(formatNumber(totalEachProduct));
            int discount = cartDAO.getDiscountByProductId(productID);
            cartItem.setDiscount(discount);
        }
//        for (Cart cartItem : cartItems) {
//            int quantityInStock = cartDAO.getQuantityInStock(cartItem.getProductID());
//            System.out.println("quantityInStock" + quantityInStock);
//            if (quantityInStock == 0) {
//                boolean deteletProductOutStock = cartDAO.deteletProductOutStock(cartItem.getProductID(), userId);
//                System.out.println("deteletProductOutStock" + deteletProductOutStock);
//            }
//        }
        int totalPrice = cartDAO.getTotal(userId);

        request.setAttribute("cartItems", cartItems);

        request.setAttribute("totalPrice", formatNumber(totalPrice));
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO dao = new DAO();
        TransactionDAO tDAO = new TransactionDAO();
        CartDAO cartDAO = new CartDAO();

        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        int userId = dao.getIdByUsername(acc.username);
        List<Cart> cartItems = cartDAO.getAllCartByUserId(userId);

        for (Cart cartItem : cartItems) {
            String productID = cartItem.getProductID();
            String image = cartDAO.getImageByProductID(productID);
            cartItem.setImageURL(image);
            String category = cartDAO.getCategoryByProductID(productID);
            cartItem.setCategory(category);
            int totalEachProduct = cartDAO.getTotalEachProduct(productID);

            cartItem.setTotal(formatNumber(totalEachProduct));
            int discount = cartDAO.getDiscountByProductId(productID);
            cartItem.setDiscount(discount);
        }
        int totalPrice = cartDAO.getTotal(userId);
        long balance = tDAO.getBalanceByUserId(String.valueOf(userId));

        System.out.println("balance < totalPrice" + (balance < totalPrice));
        if (balance < totalPrice) {
            request.setAttribute("errorMessage", "Not enough money");
            request.setAttribute("cartItems", cartItems);

            request.setAttribute("totalPrice", formatNumber(totalPrice));
            request.getRequestDispatcher("checkout.jsp").forward(request, response);

        } else {

            // Proceed with payment processing logic
            // E.g., update the user's balance, mark the cart items as paid, etc.
            String transactionCode = generateUniqueRandomString();
            boolean checkProcess = tDAO.subtractMoneyToUserAccount(String.valueOf(userId), totalPrice, transactionCode, "Mua hàng", cartItems, acc.username);
//            boolean checkProcess = cartDAO.updateCartStatusAfterTransact(userId);
            System.out.println("checkProcess" + checkProcess);
            if (checkProcess) {
                request.getSession().setAttribute("checkProcess", checkProcess);

            } else {
                List<Cart> productOutOfStockList = cartDAO.getProductOutOfStock(userId);
                request.getSession().setAttribute("ProductOutOfStockList", productOutOfStockList);

                request.getSession().setAttribute("checkProcess", checkProcess);

                response.sendRedirect("GetListCartByUserId");

            }

            //new CartDAO().updateCodeAfterTransact(userId, transactionCode);
            CartDAO cDAO = new CartDAO();

            //System.out.println("updateQuantityProductAfterTransact" + cartDAO.updateQuantityProductAfterTransact(cartItems));
//            BillDAO bDAO = new BillDAO();
//            for (Cart cartItem : cartItems) {
//                RepositoryDAO repoDAO = new RepositoryDAO();
//                int quantity = cartItem.getQuantity();
//                for (int i = 0; i < quantity; i++) {
//                    Repository repo = repoDAO.getRepoByProductID(cartItem.getProductID());
//                    System.out.println("productID " + cartItem.getProductID());
//                    System.out.println("repo" + repo.toString());
//                    bDAO.insertBill(transactionCode, cartItem, repo.getCode(), repo.getSeriNumber(), acc.username, repo.getId());
//                    repoDAO.updateStatusRepo(cartItem.getProductID());
//                }
//                cDAO.updateQuantityProductAfterTransact(cartItems, cartDAO.getQuantityInStock(cartItem.getProductID()));
//
//            }
//            for (Cart cartItem : cartItems) {
//            }
//            for (Cart cartItem : cartItems) {
//
//            }
            List<Cart> listCard = new CartDAO().getAllCardIndetailTransact(userId, transactionCode, "");
            session.setAttribute("listCard", listCard);
            for (Cart cart : listCard) {
                System.out.println(cart.toString());
            }
            // Deduct the total price from the user's balance
            request.setAttribute("listCard", listCard);
//            request.setAttribute("successMessage", "Paid successfully.");
            response.sendRedirect("historytransaction");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public static String formatNumber(int number) {
        NumberFormat numberFormat = NumberFormat.getInstance();
        return numberFormat.format(number);
    }

    public String generateUniqueRandomString() {
        CartDAO cartDAO = new CartDAO();

        String randomString;
        boolean checkUnique;
        do {
            randomString = generateRandomString(STRING_LENGTH);
            checkUnique = cartDAO.isStringUnique(randomString);
        } while (!checkUnique);
        return randomString;
    }

    private String generateRandomString(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int index = RANDOM.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }

}
