/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package category;

import com.google.gson.Gson;
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
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Categories;
import model.Product;

/**
 *
 * @author KimHo
 */
public class Data extends HttpServlet {

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
            out.println("<title>Servlet Data</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Data at " + request.getContextPath() + "</h1>");
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

        List<Map<String, Object>> productList = new ArrayList<>();
        for (Product product : listP) {
            Map<String, Object> productData = new HashMap<>();
            productData.put("id", product.getId());
            productData.put("name", product.getName());
            productData.put("price", product.getPrice());
            productData.put("formattedPrice", product.getFormattedPrice());
            productData.put("image", product.getImage());
            productData.put("quantity", product.getQuantity());
            productData.put("description", product.getDescription());
            productData.put("discount", product.getDiscount());
            productData.put("category", product.getCategory());
            productData.put("status", product.getStatus());
            productList.add(productData);
        }

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("page", page);
        responseData.put("sort_by", sort);
        responseData.put("cid", categoryId);
        responseData.put("productsPerPage", productsPerPage);
        responseData.put("productCount", productCount);
        responseData.put("listP", productList);
        responseData.put("endPage", endPage);
        responseData.put("listC", listC);

        // Convert responseData to JSON string
        String json = new Gson().toJson(responseData);

        // Write JSON string to file
        String filePath = "D:/ISP392_IS1804_G1/data.json";
        try (FileWriter fileWriter = new FileWriter(filePath)) {
            fileWriter.write(json);
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Set content type and write JSON response back to client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
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
