package signin;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import javax.imageio.ImageIO;
import com.google.gson.JsonObject;
import java.io.PrintWriter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class CaptchaGenerator extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Map<String, String> captchaStore = new ConcurrentHashMap<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String newCaptcha = request.getParameter("new");
        System.out.println("newCaptcha" + newCaptcha);
        if (newCaptcha != null && newCaptcha.equals("true")) {
            // Generate a new CAPTCHA
            String newCaptchaId = UUID.randomUUID().toString();
            String newCaptchaValue = generateCaptchaString();
            captchaStore.put(newCaptchaId, newCaptchaValue);
            System.out.println("Current CAPTCHA store contents:");
            for (Map.Entry<String, String> entry : captchaStore.entrySet()) {
                System.out.println("Captcha ID: " + entry.getKey() + " | Captcha Value: " + entry.getValue());
            }
            HttpSession session = request.getSession();
            session.setAttribute(newCaptchaId, newCaptchaValue);

            // Return new CAPTCHA ID as JSON response
            JsonObject json = new JsonObject();
            json.addProperty("captchaId", newCaptchaId);
            response.setContentType("application/json");
            response.getWriter().write(json.toString());
        } else {
            String captchaId = request.getParameter("captchaId");
            HttpSession session = request.getSession();
            String captchaValue = (String) session.getAttribute(captchaId);

            if (captchaValue == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Captcha not found");
                return;
            }

            int width = 280;
            int height = 75;
            BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g2d = bufferedImage.createGraphics();
            g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
            g2d.setColor(Color.WHITE);
            g2d.fillRect(0, 0, width, height);

            drawRandomLines(g2d, width, height);

            drawCaptchaText(g2d, captchaValue);

            drawRandomLines(g2d, width, height);

            response.setContentType("image/jpeg");
            ImageIO.write(bufferedImage, "jpg", response.getOutputStream());
            g2d.dispose();
        }
    }

    private void drawRandomLines(Graphics2D g2d, int width, int height) {
        Random random = new Random();
        g2d.setColor(Color.LIGHT_GRAY);
        for (int i = 0; i < 10; i++) {
            int x1 = random.nextInt(width);
            int y1 = random.nextInt(height);
            int x2 = random.nextInt(width);
            int y2 = random.nextInt(height);
            g2d.drawLine(x1, y1, x2, y2);
        }
    }

    private void drawCaptchaText(Graphics2D g2d, String captchaValue) {
        Random random = new Random();
        char[] data = captchaValue.toCharArray();
        int x = 20;
        for (char character : data) {
            g2d.setFont(new Font("Arial", Font.BOLD, 40 + random.nextInt(10)));
            g2d.setColor(new Color(random.nextInt(255), random.nextInt(255), random.nextInt(255)));
            g2d.drawString(String.valueOf(character), x, 50 + random.nextInt(15) - 7);
            x += 30;
        }
    }

    public String generateCaptchaString() {
        // char[] data = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".toCharArray();
        char[] data = "0123456789".toCharArray();
        Random random = new Random();
        StringBuilder captchaString = new StringBuilder();
        for (int i = 0; i < 5; i++) {
            captchaString.append(data[random.nextInt(data.length)]);
        }
        return captchaString.toString();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CaptchaGenerator</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CaptchaGenerator at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
