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
import model.Categories;
import model.Product;

/**
 *
 * @author KimHo
 */
@WebServlet(name = "UpdateProduct", urlPatterns = {"/updateProduct"})
public class UpdateProduct extends HttpServlet {

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
            out.println("<title>Servlet UpdateProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProduct at " + request.getContextPath() + "</h1>");
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
        ProductDAO productDAO = new ProductDAO();
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String quantity_raw = request.getParameter("quantity");
        String price_raw = request.getParameter("price");
        String discount_raw = request.getParameter("discount");
        String image_raw = request.getParameter("image");
        String desc = request.getParameter("description");
        String cid_raw = request.getParameter("cid");

        ProductDAO d = new ProductDAO();
        CategoryDAO c = new CategoryDAO();

        int quantity;
        double price;
        int cid;
        double discount;
        String image;
        try {
            quantity = productDAO.getQuantityById(id);
            System.out.println("quantity" + quantity);
            price = productDAO.getPriceById(id);
            System.out.println("price" + price);
            discount = Double.parseDouble(discount_raw);
            System.out.println("discount" + discount);
            cid = Integer.parseInt(cid_raw);
            System.out.println("cid" + cid);
            image = "images/card/" + image_raw;
            System.out.println("image" + image);
            Product p = d.getProductsById(id);
            p = new Product(id, name, price, image, quantity, desc, discount, new Categories(cid));
            System.out.println("p.toString + " + p.toString());
            boolean UpdateProduct = d.updateP(p);
            System.out.println("UpdateProduct" + UpdateProduct);
            if(UpdateProduct){
                request.getSession().setAttribute("UpdateProduct", UpdateProduct);
            }
            
            
            request.setAttribute("check", "id " + id + " update successfully");
            String referer = request.getHeader("referer");
            response.sendRedirect(referer);

        } catch (NumberFormatException e) {
            System.out.println(e + "123");
            request.setAttribute("check1", "Error updating product: Invalid input format");
            request.getRequestDispatcher("manageproduct.jsp").forward(request, response);
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
    }// </editor-fold>

}
