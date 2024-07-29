package signin;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dal.DAO;
import dal.ProfileDAO;
import register.EncryptionPassword;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Enumeration;
import model.Account;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;
import model.Account;
import model.Profile;

/**
 *
 * @author DELL
 */
public class LoginServlet extends HttpServlet {

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
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        UserGoogleDto user = getUserInfo(accessToken);
        System.out.println(user.getEmail());
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet LoginServlet</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form()
                        .add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE)
                        .build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").toString().replaceAll("\"", "");
    }

    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);

        return googlePojo;
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
        DAO u = new DAO();
        String username = request.getParameter("code");
        String accessToken = getToken(username);
        UserGoogleDto user = getUserInfo(accessToken);
        System.out.println(user.getEmail());
        System.out.println(u.checkUser(user.getEmail()));
        //when email exists in db
        if (u.checkUserEmail(user.getEmail())) {
            Account acc = u.getUserByEmail(user.getEmail());
            System.out.println(u.checkUserUsingGoogle(user.getEmail()));
            request.setAttribute("username", user.getEmail());
            request.setAttribute("auth_method", "google");
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } //when email no exists
        else {

            Account newUser = new Account("", user.getEmail(), "", "google");

            u.insertUserUsingGoogle(newUser);
            System.out.println(user.getEmail() + "123");
            request.setAttribute("auth_method", "google");
            request.setAttribute("username", user.getEmail());
            request.getRequestDispatcher("home.jsp").forward(request, response);
        }
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
        ProfileDAO pDAO = new ProfileDAO();
        String role = null;
        String status = null;
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String captcha = request.getParameter("captcha");
        System.out.println("captcha" + captcha);
        String captchaId = request.getParameter("captcha_id");
        System.out.println("captchaId" + captchaId);
        String sessionCaptcha = (String) request.getSession().getAttribute(captchaId);
        System.out.println("session captcha" + sessionCaptcha);
        request.setAttribute("username", username);
        request.setAttribute("password", password);
        HttpSession session = request.getSession();
        session.setAttribute("user", username);
        DAO u = new DAO();
        System.out.println("request.getSession(true)" + request.getSession(true));
        Account acc = u.checkAuthen(username, EncryptionPassword.toSHA1(password));
        Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attributeName = attributeNames.nextElement();
            Object attributeValue = session.getAttribute(attributeName);
            System.out.println("Attribute Name: " + attributeName + ", Attribute Value: " + attributeValue);
        }

//        System.out.println("acc.username" + acc.username);
        if (acc != null) {
            session.setAttribute("acc", acc);
            int userId = u.getIdByUsername(acc.username);
            role = u.getRoleByUserId(userId);
            status = u.getStatusByUserId(userId);
            session.setAttribute("role", role);
            boolean check = u.checkUser1(username, EncryptionPassword.toSHA1(password));
        }

        if (acc != null) {
            if (sessionCaptcha != null && sessionCaptcha.equals(captcha)) {
                if (status.equalsIgnoreCase("inactive")) {
                    request.setAttribute("errorMessage", "Your account has been banned");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                // Replace this with your actual authentication logic
                request.setAttribute("username", username);
                request.setAttribute("auth_method", "userAndPassWord");
                // Check if the user is an admin
                if (role.equalsIgnoreCase("admin")) {
                    pDAO.updateAccountLoginDate(username);
                    response.sendRedirect("home");
                } else {
                     Profile newProfile = new Profile();
                    int userId = u.getIdByUsername(acc.username);
                    pDAO.updateAccountLoginDate(username);
                    newProfile.setUserId(String.valueOf(userId));
                    pDAO.createProfile(newProfile);
                    response.sendRedirect("home");
                }
            } else {
                request.setAttribute("errorMessage", "Invalid CAPTCHA");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Invalid Username or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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

    public static void main(String[] args) {

        DAO u = new DAO();

        boolean checkUserGoogle = u.checkUserUsingGoogle("sontmhe182162@fpt.edu.vn");
        Account acc = u.getUserByEmail("tranminhson0505@gmail.com");
        System.out.println(acc.code);

    }
}
