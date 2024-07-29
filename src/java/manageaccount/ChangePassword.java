package manageaccount;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dal.DAO;
import dal.ProfileDAO;
import model.Profile;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import register.EncryptionPassword;

/**
 *
 * @author DELL
 */
public class ChangePassword extends HttpServlet {

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
            out.println("<title>Servlet ChangePassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePassword at " + request.getContextPath() + "</h1>");
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
        ProfileDAO pDAO = new ProfileDAO();
        Account acc = (Account) session.getAttribute("acc");
        int userId = dao.getIdByUsername(acc.username);
        String role = dao.getRoleByUserId(userId);
        Profile profile = pDAO.getProfileByUserId(userId);
        session.setAttribute("role", role);
        session.setAttribute("profile", profile);
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);

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
        DAO dao = new DAO();
        Account acc = (Account) session.getAttribute("acc");
        String username = acc.username;
        int userId = dao.getIdByUsername(username);

        String newPassword = request.getParameter("newPassword");
        String retyPassword = request.getParameter("retypPassword");
        String captcha = request.getParameter("captcha");
        String captchaId = request.getParameter("captcha_id");
        String sessionCaptcha = (String) request.getSession().getAttribute(captchaId);

        String oldPassword = request.getParameter("oldPassword");
        String s = EncryptionPassword.toSHA1(oldPassword);
        String passwordByUserId = dao.getPasswordByUserId(String.valueOf(userId));

        if (newPassword.isEmpty() || oldPassword.isEmpty() || retyPassword.isEmpty() || captcha.isEmpty()) {
            request.setAttribute("errorMessage", "Missing required parameter!");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            return;
        }
        if (!EncryptionPassword.toSHA1(oldPassword).equalsIgnoreCase(dao.getPasswordByUserId(String.valueOf(userId)))) {
            request.setAttribute("newPassword", newPassword);
            request.setAttribute("retyPassword", retyPassword);
            request.setAttribute("oldPassword", oldPassword);
            request.setAttribute("errorMessage", "Wrong account information");
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            return;
        } else {
            if (newPassword.length() < 8) {
                request.setAttribute("errorMessage", "Password is too short. At least 8 characters");
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            } else if (!newPassword.equals(retyPassword)) {
                request.setAttribute("errorMessage", "Re-type password not match");
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            } else if (newPassword.equals(oldPassword)) {
                request.setAttribute("errorMessage", "New password must not be the same as the old password");
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            } else {
                ProfileDAO fDao = new ProfileDAO();
                boolean passwordUpdated = fDao.updateAccountPassword(EncryptionPassword.toSHA1(newPassword), username);
                if (sessionCaptcha != null && sessionCaptcha.equals(captcha)) {
                    if (passwordUpdated) {
                        request.setAttribute("successMessage", "Your work has been saved");
                        request.getSession().removeAttribute(captchaId);
                    } else {
                        request.setAttribute("errorMessage", "Your work has not been saved");
                        request.getSession().removeAttribute(captchaId);
                    }
                } else {
                    request.setAttribute("errorMessage", "Invalid CAPTCHA");
                    request.getSession().removeAttribute(captchaId);
                }
                ProfileDAO pDAO = new ProfileDAO();
                Profile profile = pDAO.getProfileByUserId(userId);
                session.setAttribute("profile", profile);
                request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
            }
        }
    }

    public static void main(String[] args) {

        String username = "user1";
        ProfileDAO dao = new ProfileDAO();
        String newPassword = "12345678";
        boolean passwordUpdated = dao.updateAccountPassword(newPassword, username);

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
