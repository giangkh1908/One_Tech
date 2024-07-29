/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package managemoney;

import dal.DAO;
import dal.ProfileDAO;
import dal.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import model.Account;

/**
 *
 * @author DELL
 */
public class NapTien extends HttpServlet {

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
            out.println("<title>Servlet NapTien</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NapTien at " + request.getContextPath() + "</h1>");
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
        TransactionDAO tDAO = new TransactionDAO();
        DAO dao = new DAO();
        HttpSession session = request.getSession();
        ProfileDAO pDAO = new ProfileDAO();
        Account acc = (Account) session.getAttribute("acc");
        int userId = dao.getIdByUsername(acc.username);
        long balance = tDAO.getBalanceByUserId(String.valueOf(userId));
        DecimalFormat formatter = new DecimalFormat("#,###");
        String formattedValue = formatter.format(balance);
        request.setAttribute("balance", formattedValue);
        System.out.println("balance" + balance);
        String successParam = request.getParameter("successTransaction");
        String failureParam = request.getParameter("failureTransaction");
        boolean successTransaction = Boolean.parseBoolean(successParam);
        boolean failureTransaction = Boolean.parseBoolean(failureParam);
        request.getSession().setAttribute("successTransaction", successTransaction);
        request.getSession().setAttribute("failureTransaction", failureTransaction);
        request.getRequestDispatcher("naptien.jsp").forward(request, response);
        request.getRequestDispatcher("naptien.jsp").forward(request, response);
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
        String amount = request.getParameter("amount");
        System.out.println("amount" + amount);
        DecimalFormat formatter = new DecimalFormat("#,###");
        String formattedValue = formatter.format(amount);
        request.setAttribute("amount", formattedValue);
        request.getRequestDispatcher("ajaxServlet").forward(request, response);

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

    public static void main(String[] args) {
        DAO dao = new DAO();
        String userId = String.valueOf(2);
        TransactionDAO tDAO = new TransactionDAO();

        long balance = tDAO.getBalanceByUserId(String.valueOf(userId));

        DecimalFormat formatter = new DecimalFormat("#,###");
        String formattedValue = formatter.format(balance);
        System.out.println("balance " + formattedValue);
    }
}
