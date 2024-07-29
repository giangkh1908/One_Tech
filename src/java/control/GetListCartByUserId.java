/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.CartDAO;
import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Cart;

/**
 *
 * @author ADMIN
 */
public class GetListCartByUserId extends HttpServlet {

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
            out.println("<title>Servlet GetListCartByUserId</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetListCartByUserId at " + request.getContextPath() + "</h1>");
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
        // Retrieve userId from session or request parameters
        DAO dao = new DAO();
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        int userId = dao.getIdByUsername(acc.username);

        // Handle userId not found case (for demonstration, you might want to handle differently)
        if (userId < 0) {
            request.setAttribute("errorMessage", "User ID not found in session");
            request.getRequestDispatcher("error.jsp").forward(request, response); // Forward to an error page
            return;
        }

        // Convert userId to integer if needed (assuming userId is numeric)
        // Initialize CartDAO and retrieve cart items
        CartDAO cartDAO = new CartDAO();
        List<Cart> cartItems = cartDAO.getAllCartByUserId(userId);
        if (!cartItems.isEmpty()) {
            boolean cartIsNotEmpty = true;
            request.setAttribute("cartIsNotEmpty", cartIsNotEmpty);
        }
        // Calculate total price
        double totalPrice = cartDAO.getTotal(userId);
        List<Cart> productOutOfStockList = cartDAO.getProductOutOfStock(userId);
        request.getSession().setAttribute("ProductOutOfStockList", productOutOfStockList);
        // Set attributes to pass data to JSP
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalPrice", totalPrice);
        request.getRequestDispatcher("cart.jsp").forward(request, response);
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
        processRequest(request, response);
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

}
