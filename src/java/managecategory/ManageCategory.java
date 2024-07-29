/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package managecategory;

import dal.CategoryDAO;
import dal.DAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.UUID;
import model.Categories;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ManageCategory", urlPatterns = {"/category"})
public class ManageCategory extends HttpServlet {

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
        HttpSession session = request.getSession();
        
        String csrfToken = UUID.randomUUID().toString();
        System.out.println("csrfToken in manage Servlet" + csrfToken);
        session.setAttribute("csrfToken", csrfToken);
        request.setAttribute("csrfToken", csrfToken);
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            ProductDAO d = new ProductDAO();
            CategoryDAO c = new CategoryDAO();
            String searchQuery = request.getParameter("search");
            
            String status = request.getParameter("status");
            if(status == null){
                status = "Active";
            }
            List<Categories> listC;
            int currentPage = 1;
            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }
           
            int totalRecords = c.getTotalRecords(searchQuery, status);
            System.out.println("totalRecords" + totalRecords);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / 10);
            listC = c.getCategory(currentPage, 10, searchQuery, status);
            for (Categories categories : listC) {
                System.out.println(categories.toString());
            }
//            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
//                listC = c.searchCategory(searchQuery);
//            } else if (status != null && !status.trim().isEmpty()) {
//                listC = c.getCategoriesByStatus(status);
//            } else {
//                
//            }
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("totalPages", totalPages);
            List<String> uniqueStatuses = c.getUniqueStatuses();
            request.setAttribute("listC", listC);
            request.setAttribute("uniqueStatuses", uniqueStatuses);
            request.getRequestDispatcher("managecategory.jsp").forward(request, response);
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
