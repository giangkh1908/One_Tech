<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="com.vnpay.common.Config"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dal.DAO"%> 
<%@page import="dal.TransactionDAO"%> 
<%@page import="model.Account" %>
<%@page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>KẾT QUẢ THANH TOÁN</title>
        <link href="vnpay_jsp/assets/bootstrap.min.css" rel="stylesheet"/>
        <link href="vnpay_jsp/assets/jumbotron-narrow.css" rel="stylesheet"> 
        <script src="/vnpay_jsp/assets/jquery-1.11.3.min.js"></script>
        <script>
            // Redirect to "naptien" after 10 seconds
            setTimeout(function () {
                window.location.href = "naptien";
            }, 100000); // 10000 milliseconds = 10 seconds
        </script>
    </head>
    <body>
        <%
            // Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }
                // Sort the fields
            List<String> fieldNames = new ArrayList<>(fields.keySet());
            Collections.sort(fieldNames);
            
            // Print out field names for debugging
            for (String fieldName : fieldNames) {
                System.out.println("Field Name: " + fieldName);
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            System.out.println("vnp_SecureHash in vnpay_return.jsp" + vnp_SecureHash);
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
           String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
            boolean successTransaction = "00".equals(vnp_ResponseCode); // Assuming "00" is the success code
            boolean failureTransaction = !"00".equals(vnp_ResponseCode); // If not "00", it's a failure
            String redirectURL = "naptien?successTransaction=" + successTransaction + "&failureTransaction=" + failureTransaction;
            response.sendRedirect(redirectURL);
           
            String signValue = Config.hashAllFields(fields);
            System.out.println("signValue in vnpay_return.jsp" + signValue);
            String transactionCode = request.getParameter("vnp_TxnRef");
            // Retrieve the amount to add to the user's account
            String amountParam = request.getParameter("vnp_Amount");
            int amount = Integer.parseInt(amountParam)/ 100; // Adjust amount if needed
             Account acc = (Account) session.getAttribute("acc");
            
            // Check the transaction status and add money to the user's account if successful
            if (signValue.equals(vnp_SecureHash)) {
                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                    DAO dao = new DAO();
                    TransactionDAO tDAO = new TransactionDAO();
                    tDAO.addMoneyToUserAccount(String.valueOf(dao.getIdByUsername(acc.username)), amount, acc.username, transactionCode);
                }
            }
        %>
        <!-- Begin display -->
        <div class="container">
            <a href="naptien">HOME</a>
            <div class="header clearfix">
                <h3 class="text-muted">KẾT QUẢ THANH TOÁN</h3>
            </div>
            <div class="table-responsive">
                <div class="form-group">
                    <label >Mã giao dịch thanh toán:</label>
                    <label><%=request.getParameter("vnp_TxnRef")%></label>
                </div>    
                <div class="form-group">
                    <label >Số tiền:</label>
                    <label><%=amount%></label>
                </div>  
                <div class="form-group">
                    <label >Mô tả giao dịch:</label>
                    <label><%=request.getParameter("vnp_OrderInfo")%></label>
                </div> 
                <div class="form-group">
                    <label >Mã lỗi thanh toán:</label>
                    <label><%=request.getParameter("vnp_ResponseCode")%></label>
                </div> 
                <div class="form-group">
                    <label >Mã giao dịch tại CTT VNPAY-QR:</label>
                    <label><%=request.getParameter("vnp_TransactionNo")%></label>
                </div> 
                <div class="form-group">
                    <label >Mã ngân hàng thanh toán:</label>
                    <label><%=request.getParameter("vnp_BankCode")%></label>
                </div> 
                <div class="form-group">
                    <label >Thời gian thanh toán:</label>
                    <label><%=request.getParameter("vnp_PayDate")%></label>
                </div> 
                <div class="form-group">
                    <label >Tình trạng giao dịch:</label>
                    <label>
                        <%
                            if (signValue.equals(vnp_SecureHash)) {
                                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                                    out.print("Thành công");
                                } else {
                                    out.print("Không thành công");
                                }
                            } else {
                                out.print("invalid signature");
                            }
                        %>
                    </label>
                </div> 
            </div>
            <p>&nbsp;</p>
            <footer class="footer">
                <p>&copy; VNPAY 2020</p>
            </footer>
        </div>  
    </body>
</html>
