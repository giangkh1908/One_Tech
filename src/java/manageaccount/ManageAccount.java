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
import java.util.List;
import model.Account;

/**
 *
 * @author DELL
 */
public class ManageAccount extends HttpServlet {

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
            out.println("<title>Servlet ManageAccount</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageAccount at " + request.getContextPath() + "</h1>");
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
        String role = null;
        HttpSession session = request.getSession();
        DAO dao = new DAO();
        Account acc = (Account) session.getAttribute("acc");
        int userId = dao.getIdByUsername(acc.username);
        role = dao.getRoleByUserId(userId);
        ProfileDAO pDAO = new ProfileDAO();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        String key = request.getParameter("key");
        String orderBy = request.getParameter("orderBy");
        if(orderBy == null){
            orderBy = "userId";
        }
        if (orderBy != null) {
            orderBy = orderBy.trim();
        }
        System.out.println("key123" + key + "key null?");
        ;
        System.out.println("order by" + orderBy);

        int totalRecords = pDAO.getTotalRecords(key, orderBy);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / 10);
        List<Profile> records = pDAO.getRecords(currentPage, 10, key, orderBy);
        System.err.println("Current page: " + currentPage);  // Debugging log
        System.err.println("Total records: " + totalRecords);  // Debugging log
        System.err.println("Total pages: " + totalPages);  // Debugging log
        System.err.println("Number of records fetched: " + records.size());  // Debugging log               
        List<Profile> profileList = pDAO.getAllProfile();
        List<Profile> listProfile = pDAO.getAllProfile();
        for (Profile record : records) {
            System.out.println(record.toString());
        }

        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("records", records);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("AccountList.jsp").forward(request, response);
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

    public static void main(String[] args) {

    }
}
