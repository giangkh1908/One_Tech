package managemoney;

import dal.DAO;
import dal.TransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;
import model.Account;
import model.Cart;
import model.Transaction;

public class ManageHistoryTransaction extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManageHistoryTransaction</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManageHistoryTransaction at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processTransactionHistory(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processTransactionHistory(request, response);
    }

    private void processTransactionHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        DAO dao = new DAO();
        TransactionDAO tDao = new TransactionDAO();
        Account acc = (Account) session.getAttribute("acc");
        String username = acc.username;

        int userId = dao.getIdByUsername(username);
        String role = dao.getRoleByUserId(dao.getIdByUsername(username));
        String period = request.getParameter("period");

        // Default to 3 months if the role is user and no period is specified
        if (role.equalsIgnoreCase("user") && (period == null || period.isEmpty())) {
            period = "3months";
        }

        int totalRecords = tDao.getTotalRecords(String.valueOf(userId), role, period);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / 10);
        request.setAttribute("role", role);
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Transaction> allTransactions = tDao.getTransactionListByUserId(String.valueOf(userId), username, "", "", currentPage, 10, period);

        if (period != null && !period.isEmpty()) {
            LocalDate fromDate = getFromDate(period);
            LocalDateTime fromDateTime = fromDate.atStartOfDay();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            allTransactions = allTransactions.stream()
                    .filter(t -> {
                        LocalDateTime transactionDate = LocalDateTime.parse(t.getCreationDate(), formatter);
                        return transactionDate.isAfter(fromDateTime);
                    })
                    .collect(Collectors.toList());
        }
            
        request.setAttribute("transactionList", allTransactions);
        request.setAttribute("selectedPeriod", period);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("HistoryTransaction.jsp").forward(request, response);
    }

    private LocalDate getFromDate(String period) {
        LocalDate now = LocalDate.now();
        switch (period) {
            case "3months":
                return now.minusMonths(3);
            case "6months":
                return now.minusMonths(6);
            case "9months":
                return now.minusMonths(9);
            case "1year":
                return now.minusYears(1);
            default:
                return now;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
