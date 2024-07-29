/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package manageproduct;

import category.Category;
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
@WebServlet(name = "AddProduct", urlPatterns = {"/addProduct"})
public class AddProduct extends HttpServlet {

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
            out.println("<title>Servlet AddProduct</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProduct at " + request.getContextPath() + "</h1>");
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
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String quantity_raw = "0";
        String price_raw = request.getParameter("price");
        String image_raw = request.getParameter("image");
        String desc = request.getParameter("description");
        String discount_raw = request.getParameter("discount");
        String cid_raw = request.getParameter("cid");
            ProductDAO d = new ProductDAO();
            CategoryDAO c = new CategoryDAO();
        int quantity;
        int price;
        String image;
        int cid;
        int discount;
        String status = "Active";
        try {
            quantity = Integer.parseInt(quantity_raw);
            price = Integer.parseInt(price_raw);
            discount = Integer.parseInt(discount_raw);
            image = "images/card/" + image_raw;
            cid = Integer.parseInt(cid_raw);
            
            Product p1 = d.getProductsById(id);
            if (p1 != null) {
                request.setAttribute("check", "id " + id + " existed!");
                request.getRequestDispatcher("manage").forward(request, response);
            } else {
                Product p = new Product(id, name, price, image, quantity, desc, discount, status, new Categories(cid));
                d.insertP(p);
                request.setAttribute("check1", "id " + id + " add successfully");
                response.sendRedirect("manage");
            }
        } catch (NumberFormatException e) {
            System.out.println(e);
            request.setAttribute("check", "Error updating product: Invalid input format");
            request.getRequestDispatcher("manage").forward(request, response);
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
