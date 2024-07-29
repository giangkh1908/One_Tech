package manageaccount;

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

public class UpdateStatus extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateStatus</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateStatus at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("acc") == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You must be logged in to perform this action");
            return;
        }

        Account acc = (Account) session.getAttribute("acc");
        if (acc == null || !"admin".equals(acc.getUsername())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to update the account status");
            return;
        }

        String token = request.getParameter("token");
        System.out.println("Received token: " + token); // Logging for debugging

        if (token == null || !isValidToken(token)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid or missing token");
            return;
        }

        String id = request.getParameter("id");
        String newStatus = request.getParameter("newStatus");
        String page = request.getParameter("page");

        System.out.println("Updating status for ID: " + id + " to new status: " + newStatus); // Logging for debugging

        ProfileDAO fDAO = new ProfileDAO();
        DAO dao = new DAO();

        Profile profile = fDAO.getProfileByUserId(Integer.parseInt(id));
        if (profile != null) {
            dao.updateAccountStatus(id, newStatus);
            String referer = request.getHeader("referer");
            response.sendRedirect(referer);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Profile not found");
        }
    }

    private boolean isValidToken(String token) {
        // Logging for debugging
        System.out.println("Validating token: " + token);
        return "secureToken123".equals(token);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
