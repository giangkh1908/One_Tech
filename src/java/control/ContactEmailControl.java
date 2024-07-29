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
import java.text.DecimalFormat;
import model.Account;
import register.EmailService;

/**
 *
 * @author ADMIN
 */
public class ContactEmailControl extends HttpServlet {

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
            out.println("<title>Servlet ContactEmailControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ContactEmailControl at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        CartDAO cartDAO = new CartDAO();
        DAO dao = new DAO();

        Account acc = (Account) session.getAttribute("acc");
        if (acc != null) {
            int quantity = cartDAO.getQuantityInCart(dao.getIdByUsername(acc.username));
            request.setAttribute("quantity", quantity);
        }
        request.getRequestDispatcher("contact.jsp").forward(request, response);
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
        String name = request.getParameter("contact_form_name");
        String email = request.getParameter("contact_form_email");
        String phone = request.getParameter("contact_form_phone");
        String message = request.getParameter("message");

        // Email subject and content
        String subject = "Contact Form Submission";
        String content = "Hi, " + name + "\n\n"
                + "We have received your message:\n"
                + message + "\n\n"
                + "We will be in touch soon. Thank you for waiting.";

        // Create a thread to send email
        Thread emailThread = new Thread(() -> {
            String resultMessage;
            try {
                // Send email
                EmailService.sendEmailForContact("smtp.gmail.com", "587",
                        "quangvu1922@gmail.com", "gdku hrng jcef abaz", email, subject, content);
                resultMessage = "The email was sent successfully.";
            } catch (Exception e) {
                e.printStackTrace();
                resultMessage = "There was an error: " + e.getMessage();
            }

            // Store result message in session
            synchronized (request.getSession()) {
                request.getSession().setAttribute("Message", resultMessage);
            }
        });

        // Start the thread to send email
        emailThread.start();

        // Redirect to Result.jsp immediately
        response.setContentType("text/html; charset=UTF-8");
        response.sendRedirect("Result.jsp");
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
