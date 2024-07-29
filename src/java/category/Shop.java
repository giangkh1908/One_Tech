package category;

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
import java.util.List;
import model.Categories;
import model.Product;

/**
 *
 * @author KimHo
 */
public class Shop extends HttpServlet {

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
            out.println("<title>Servlet Shop</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Shop at " + request.getContextPath() + "</h1>");
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
        ProductDAO d = new ProductDAO();
        CategoryDAO c = new CategoryDAO();
        int endPage = 0;
        int productCount;
        String sort = request.getParameter("sort_by");
        String categoryId = request.getParameter("cid");

        if (sort == null || sort.isEmpty()) {
            sort = "ASC"; // Default sort if none provided
        }

        if (categoryId == null || categoryId.isEmpty()) {
            // No category selected, show all products
            productCount = d.countAllProduct();
        } else {
            // Category selected, show products of that category
            productCount = d.countAllProductOfCategory(categoryId);
        }
        endPage = productCount / 12;
        if (productCount % 12 != 0) {
            endPage++;
        }
        // Calculate endPage based on total product count
        if (productCount > 0) {
            endPage = productCount / 12;
            if (productCount % 12 != 0) {
                endPage++;
            }
        }

        int page = 1; // Default page number
        String indexParam = request.getParameter("index");
        if (indexParam != null && !indexParam.isEmpty()) {
            try {
                page = Integer.parseInt(indexParam);
            } catch (NumberFormatException e) {
                e.printStackTrace(); // Print stack trace for debugging
            }
        }

        int productsPerPage = 12;
        int offset = (page - 1) * productsPerPage;

        List<Product> listP;
        if (categoryId == null || categoryId.isEmpty()) {
            listP = d.getProductsByPageSorted(offset, productsPerPage, sort, null);
        } else {
            listP = d.getProductsByPageSorted(offset, productsPerPage, sort, categoryId);
        }
        List<Categories> listC = c.getCategory();
        request.setAttribute("page", page);
        // Set attributes to be used in shop.jsp
        request.setAttribute("sort_by", sort);
        request.setAttribute("cid", categoryId);
        request.setAttribute("productsPerPage", productsPerPage);
        request.setAttribute("productCount", productCount);
        request.setAttribute("listP", listP);
        request.setAttribute("endPage", endPage);
        request.setAttribute("listC", listC);

        // Forward the request to shop.jsp for rendering
        request.getRequestDispatcher("shop.jsp").forward(request, response);
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
