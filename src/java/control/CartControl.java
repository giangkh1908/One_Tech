/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.CartDAO;
import dal.DAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Cart;

/**
 *
 * @author ADMIN
 */
public class CartControl extends HttpServlet {

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
            out.println("<title>Servlet CartControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartControl at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        if ("getCartItemCount".equals(action)) {
            try {
                HttpSession session = request.getSession();
                Account acc = (Account) session.getAttribute("acc");
                if (acc == null) {
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    response.getWriter().write("User not logged in.");
                    return;
                }
                // Get user ID from session
                String username = acc.getUsername();
                DAO dao = new DAO();
                int userId = dao.getIdByUsername(username);

                CartDAO cartDAO = new CartDAO();
                int count = cartDAO.countItemsByUserID(userId);
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(String.valueOf(count));

            } catch (Exception e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error fetching cart item count: " + e.getMessage());
            }
        }
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
        String action = request.getParameter("action");
        System.out.println(action);
        if ("addToCart".equals(action)) {
            try {
                // Get data from form
                String productId = request.getParameter("productId");
                String sourcePage = request.getParameter("sourcePage");
                int quantity = 1; // Default quantity

                HttpSession session = request.getSession();
                Account acc = (Account) session.getAttribute("acc");
                if (acc == null) {
                    request.getSession().setAttribute("accIsNull", acc == null);
                    if ("shop".equals(sourcePage)) {
                        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                        response.getWriter().write("You must be logged in to add products to cart.");
                        return;
                    } else if ("detail".equals(sourcePage)) {
                        response.sendRedirect("home"); // Redirect to login page
                    } else {
                        response.sendRedirect("home"); // Redirect to login page
                    }
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    response.getWriter().write("You must be logged in to add products to cart.");
                    return;
                }
                // Check if quantity is provided and valid
                String quantityParam = request.getParameter("quantity1");
                if (quantityParam != null && !quantityParam.isEmpty()) {
                    try {
                        quantity = Integer.parseInt(quantityParam);
//                        if (quantity <= 0 || quantity > 5) {
//                            throw new NumberFormatException("Quantity must be between 1 and 5.");
//                        }
                    } catch (NumberFormatException ex) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write("Invalid quantity value: " + ex.getMessage());
                        return;
                    }
                }
                // Get current user from session

                // Get user ID from database
                DAO dao = new DAO();
                ProductDAO product = new ProductDAO();
                CartDAO cartDAO = new CartDAO();
                int userId = dao.getIdByUsername(acc.getUsername());
                System.out.println("x: " + userId);
                int productQuantity = product.getQuantityById(productId);
                System.out.println("Product quantity: " + productQuantity);
                System.out.println("quantity: " + quantity);
                if (productQuantity < 0) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("This product is out of stock.");
                    return;
                }

                int currentCartQuantity = cartDAO.getCartQuantityByProductId(userId, productId);
                System.out.println("Current cart quantity: " + currentCartQuantity);
                // Check cart quantity
                if ((currentCartQuantity + quantity > productQuantity)) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("Not enough stock for the requested quantity.");
                    return;
                }
                // Create CartItem object
                Cart item = new Cart();
                item.setUserID(userId);
                item.setProductID(productId);
                item.setQuantity(quantity); // Default quantity is 1 when adding to cart

                // add cart
                boolean isAdded = cartDAO.addToCart(item);
                System.out.println("isAdded" + isAdded);
                if (isAdded) {
                    request.getSession().setAttribute("cartSuccess", isAdded);
                }

                if ("shop".equals(sourcePage)) {
                    
                    response.sendRedirect("shop");
                } else if ("detail".equals(sourcePage)) {
                    String referer = request.getHeader("referer");
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect("home");
                }
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Product added to cart successfully!");
            } catch (NumberFormatException ex) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Error adding product to cart: " + ex.getMessage());
            }
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

}
