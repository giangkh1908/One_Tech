/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import dal.CartDAO;
import dal.CategoryDAO;
import dal.DAO;
import dal.ProductDAO;
import dal.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.List;
import model.Account;
import model.Product;
import model.Categories;

/**
 *
 * @author MTTRBLX
 */
public class HomeControl extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String txtSearch = request.getParameter("txt");
        ProductDAO d = new ProductDAO();
        CategoryDAO c = new CategoryDAO();
        CartDAO cartDAO = new CartDAO();
        TransactionDAO t = new TransactionDAO();
        DAO dao = new DAO();
        int quantity = 0;
        HttpSession session = request.getSession();

        Account acc = (Account) session.getAttribute("acc");
//        if (acc == null) {
//            System.out.println("acc == null in home" + (acc == null));
//           
//            request.getSession().setAttribute("accIsNull", acc == null);
//        }
        if (acc != null) {
            quantity = cartDAO.getQuantityInCart(dao.getIdByUsername(acc.username));
            long balance = t.getBalanceByUserId(String.valueOf(dao.getIdByUsername(acc.username)));
            DecimalFormat formatter = new DecimalFormat("#,###");
            String formattedValue = formatter.format(balance);
            session.setAttribute("balance", formattedValue);
            String role = dao.getRoleByUserId(dao.getIdByUsername(acc.username));
            request.getSession().setAttribute("admin", role.equalsIgnoreCase("admin"));
        }

        List<Product> listP = d.getRandom16();
        List<Product> listP2 = d.getRandom16();
        List<Product> listP3 = d.getRandom16();
        List<Product> listSearch = d.searchByName(txtSearch);
        List<Product> listP4 = d.getRandom16();
        List<Product> listTop3 = d.getProductByIndex(4, 3);
        List<Product> listTop10 = d.getTop10();
        Product p = d.getProductByID("vcoin100");

        List<Categories> listC = c.getCategory();

        request.setAttribute("listP", listP);
        request.setAttribute("listP2", listP2);
        request.setAttribute("listP3", listP3);
        request.setAttribute("listSearch", listSearch);
        request.setAttribute("listP4", listP4);
        request.setAttribute("product", p);
        request.setAttribute("listTop3", listTop3);
        request.setAttribute("listC", listC);
        request.setAttribute("listTop10", listTop10);
        if (acc != null) {

            request.setAttribute("quantity", quantity);
        }

        request.getRequestDispatcher("home.jsp").forward(request, response);
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
