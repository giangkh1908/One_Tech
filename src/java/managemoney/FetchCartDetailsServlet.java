/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package managemoney;

import com.google.gson.Gson;
import dal.BillDAO;
import dal.CartDAO;
import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Bill;
import model.Cart;

/**
 *
 * @author DELL
 */
public class FetchCartDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CartDAO cartDAO;
    private BillDAO billDAO;

    public void init() {
        cartDAO = new CartDAO();
        billDAO = new BillDAO();
    }

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
            out.println("<title>Servlet FetchCartDetailsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FetchCartDetailsServlet at " + request.getContextPath() + "</h1>");
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
        String transactionCode = request.getParameter("transactionCode");
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");
        int userId = dao.getIdByUsername(acc.username); // Assuming `acc` has a method `getId()`
        String role = dao.getRoleByUserId(userId);
        List<Cart> listCard = cartDAO.getAllCardIndetailTransact(userId, transactionCode, role);
        for (Cart cart : listCard) {
            System.out.println(cart.toString());
        }
        List<Bill> listBill = billDAO.getAllBillIndetailTransact(transactionCode);
        for (Bill bill : listBill) {
            System.out.println(bill.toString());
        }
        // Create a map to hold both lists
        Map<String, Object> data = new HashMap<>();
        data.put("listCard", listCard);
        data.put("listBill", listBill);

        // Convert map to JSON and write to response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        new Gson().toJson(data, response.getWriter());
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
