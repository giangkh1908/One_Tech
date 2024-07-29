/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package register;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author KimHo
 */
@WebServlet(name = "VerifyServlet", urlPatterns = {"/verify"})
public class VerifyServlet extends HttpServlet {

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
            out.println("<title>Servlet VerifyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        Account a = (Account) session.getAttribute("authcode");

        if (a == null) {
            // If the session does not have the authcode, redirect to register page
            response.sendRedirect("register.jsp");
            return;
        }

        Integer attempts = (Integer) session.getAttribute("attempts");
        if (attempts == null) {
            attempts = 0;
        }

        DAO d = new DAO();
        String code = request.getParameter("authcode");
        long codeSentTime = Long.parseLong(request.getParameter("codeSentTime"));
        long currentTime = System.currentTimeMillis();
        long expirationTime = 3 * 60 * 60 * 1000; // 3 hours in milliseconds

        // Check if the code has expired
        if (currentTime - codeSentTime > expirationTime) {
            session.invalidate();
            request.setAttribute("error", "The verification code has expired. Please register again.");
            request.getRequestDispatcher("emailverification.jsp").forward(request, response);
            return;
        }
        // Check code
        if (code.equalsIgnoreCase(a.getCode())) {
            if (d.checkUserEmail(a.email)) {
                d.update(a);
            } else {
                d.add(a);
            }
            request.setAttribute("username", a.username);
            request.setAttribute("error", "Please re-enter password to sign in");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            attempts++;
            if (attempts > 5) {
                session.invalidate(); // Invalidate the session to clear all attributes
                response.sendRedirect("register.jsp");
            } else {
                session.setAttribute("attempts", attempts);
                request.setAttribute("error", "Code is incorrect!!! Attempts remaining: " + (5 - attempts));
                request.getRequestDispatcher("emailverification.jsp").forward(request, response);
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
