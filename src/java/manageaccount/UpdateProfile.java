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

public class UpdateProfile extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet UpdateProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        int userId = 0;
        HttpSession session = request.getSession();
        ProfileDAO pDAO = new ProfileDAO();
        Account acc = (Account) session.getAttribute("acc");
        if (acc == null) {
            response.sendRedirect("login.jsp");
        } else {

            Profile newProfile = new Profile();
            userId = dao.getIdByUsername(acc.username);
            newProfile.setUserId(String.valueOf(userId));
            newProfile.setFullname("");
            newProfile.setPhoneNumber("");
            newProfile.setLinkAvatar("");
            if (!pDAO.checkProfileExist(dao.getIdByUsername(acc.username))) {
                pDAO.createProfile(newProfile);
            }
        }

        String role = dao.getRoleByUserId(userId);
        Profile profile = pDAO.getProfileByUserId(userId);
        System.out.println(profile.toString());
        session.setAttribute("role", role);
        session.setAttribute("profile", profile);
        request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
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
        Account acc = (Account) session.getAttribute("acc");
        DAO dao = new DAO();
        int userId = dao.getIdByUsername(acc.username);
        String username = request.getParameter("username");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        System.out.println(fullname);
        String phoneNumber = request.getParameter("phoneNumber");
        String linkAvatar = request.getParameter("linkAvatar");

        Profile updateProfile = new Profile();
        updateProfile.setUserId(String.valueOf(userId));
        updateProfile.setFullname(fullname);
        updateProfile.setUsername(username);
        updateProfile.setEmail(email);
        updateProfile.setLinkAvatar(linkAvatar);
        updateProfile.setPhoneNumber(phoneNumber);

        ProfileDAO profileDAO = new ProfileDAO();
        boolean success = profileDAO.updateProfile(updateProfile);
        System.out.println("success" + success);
        if (success) {
            session.setAttribute("profile", updateProfile);
            request.getRequestDispatcher("UserProfile.jsp").forward(request, response);
        } else {
            response.sendRedirect("error.jsp"); // Redirect to an error page
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
    }

}
