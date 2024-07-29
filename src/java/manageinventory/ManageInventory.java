/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package manageinventory;

import dal.DAO;
import dal.ProfileDAO;
import dal.RepositoryDAO;
import dal.CategoryDAO;
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
import model.Repository;

/**
 *
 * @author DELL
 */
public class ManageInventory extends HttpServlet {

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
            out.println("<title>Servlet ManageInventory</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageInventory at " + request.getContextPath() + "</h1>");
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
//        Account acc = (Account) session.getAttribute("acc");
//        int userId = dao.getIdByUsername(acc.username);
//        role = dao.getRoleByUserId(userId);
        ProfileDAO pDAO = new ProfileDAO();
        RepositoryDAO repoDAO = new RepositoryDAO();
        CategoryDAO cateDAO = new CategoryDAO();
        List<Categories> listC = cateDAO.getCategory();
        String categoryID = request.getParameter("cid");
        ProductDAO proDAO = new ProductDAO();
        List<Product> productList = proDAO.getProductsByCid(categoryID);

        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        String key = null;
        String cID = request.getParameter("id");
        String status = request.getParameter("status");
        if (status == null) {
            status = "Active";
        }
        System.out.println("cID" + cID);
        int totalRecords = repoDAO.getTotalRecords(status, cID);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / 10);
        //List<Repository> AllCardDetailList = repoDAO.getAllCardInRepository();

        List<Repository> AllCardDetailList = repoDAO.getAllCardInRepository(currentPage, 10, status, cID);

        for (Repository repository : AllCardDetailList) {
            System.out.println(repository.toString());
        }

        request.setAttribute("listC", listC);
          request.setAttribute("productList", productList);
        List<String> uniqueStatuses = repoDAO.getUniqueStatuses();

        request.setAttribute("uniqueStatuses", uniqueStatuses);


        request.setAttribute("totalRecords", totalRecords);
        //request.setAttribute("records", records);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("AllCardDetailList", AllCardDetailList);
        request.getRequestDispatcher("manageinventory.jsp").forward(request, response);
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
