/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package manageproduct;

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
import model.Product;

/**
 *
 * @author KimHo
 */
@WebServlet(name = "ManageServlet", urlPatterns = {"/manage"})
public class ManageServlet extends HttpServlet {

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
            out.println("<title>Servlet ManageServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageServlet at " + request.getContextPath() + "</h1>");
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
        
        String csrfToken = UUID.randomUUID().toString();
        System.out.println("csrfToken in manage Servlet" + csrfToken);
        session.setAttribute("csrfToken", csrfToken);
        request.setAttribute("csrfToken", csrfToken);
        ProductDAO d = new ProductDAO();
        CategoryDAO c = new CategoryDAO();

        String cID = request.getParameter("id");
        String searchQuery = request.getParameter("search");
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        String key = null, orderBy = null;
        int totalRecords = d.getTotalRecords(searchQuery, cID);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / 10);
        System.out.println("totalRecords" + totalRecords);
        List<Product> listP = null;

        listP = d.getProduct(currentPage, 10, searchQuery, cID);
//        if (searchQuery != null && !searchQuery.isEmpty()) {
//            if (cID != null && !cID.isEmpty() && !cID.equals("all")) {
//                try {
//                    int categoryId = Integer.parseInt(cID);
//                    listP = d.searchProductsByCid(categoryId, searchQuery);
//                } catch (NumberFormatException e) {
//                    listP = d.searchProducts(searchQuery);
//                }
//            } else {
//                listP = d.searchProducts(searchQuery);
//            }
//        } else if (cID == null || cID.isEmpty() || cID.equals("all")) {
//             int categoryId = Integer.parseInt(cID);
//            
//        } else {
//            try {
//                int categoryId = Integer.parseInt(cID);
//                listP = d.getProductsByCid(cID);
//            } catch (NumberFormatException e) {
//            }
//        }
        List<Categories> listC = c.getCategory();
        String productId = request.getParameter("productId");
        if (productId != null) {
            Product product = d.getProductById(productId);
            request.setAttribute("product", product);
        }
        request.setAttribute("totalRecords", totalRecords);
        //request.setAttribute("records", records);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("listC", listC);
        request.setAttribute("listP", listP);
        request.getRequestDispatcher("manageproduct.jsp").forward(request, response);
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
