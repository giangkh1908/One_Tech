/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.CartDAO;
import dal.CategoryDAO;
import dal.DAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Categories;
import model.Product;

/**
 *
 * @author MTTRBLX
 */
public class SuperDealControl extends HttpServlet {

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
        ProductDAO d = new ProductDAO();
        CategoryDAO c = new CategoryDAO();

        String categoryID = request.getParameter("categoryID");

        List<Product> listP = d.getRandom16();
        List<Product> listP2 = d.getRandom16();
        List<Product> listP3 = d.getSuperDeals(categoryID);
        List<Product> listP4 = d.getRandom16();
        List<Product> listTop3 = d.getProductByIndex(4, 3);
        Product p = d.getProductByID("vcoin100");

        List<Categories> listC = c.getCategory();

        request.setAttribute("listP", listP);
        request.setAttribute("listP2", listP2);
        request.setAttribute("listP3", listP3);
        request.setAttribute("listP4", listP4);
        request.setAttribute("product", p);
        request.setAttribute("listTop3", listTop3);
        request.setAttribute("listC", listC);
        HttpSession session = request.getSession();
        CartDAO cartDAO = new CartDAO();
        DAO dao = new DAO();

        Account acc = (Account) session.getAttribute("acc");
        if (acc != null) {
            int quantity = cartDAO.getQuantityInCart(dao.getIdByUsername(acc.username));
            request.setAttribute("quantity", quantity);
        }
        request.getRequestDispatcher("superdeals.jsp").forward(request, response);
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
