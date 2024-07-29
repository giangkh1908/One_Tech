<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
        <link rel="stylesheet" href="css/style.css">
        <style>
            body {
                background-image: url(images/banner_background.jpg);
                background-size: cover;
                background-position: center;
            }
            .forgot-password-heading {
                font-weight: bold;
                color: #14317a; /* Dark blue color */
                margin-bottom: 10px; /* Add margin below the heading */
                font-size: 24px; /* Make the text bigger */
            }
            .forgot-password-description {
                color: #ccc; /* Adjust color as needed */
                font-size: 14px; /* Adjust font size as needed */
                margin-bottom: 20px; /* Add margin below the description */
            }
            .forgot-password-description::after {
                content: "";
                display: block;
                width: 50px; /* Adjust width as needed */
                border-bottom: 1px solid #ccc; /* Adjust color as needed */
                margin-top: 5px; /* Adjust margin as needed */
            }
            .wrap {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <div class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <!-- Forgot Password heading with dark blue color -->
                            <div class="forgot-password-heading">Forgot Password</div>
                            <!-- Description with lighter style and underline -->
                            <div class="forgot-password-description">
                                Enter the email you used to create an account and we will send you the code via email to reset your password
                            </div>
                            <!-- Forgot password form -->
                            <div class="login-wrap p-4 p-md-5">
                                <form action="ForgotPassword" method="post" class="signin-form">
                                    <div class="form-group mt-3">
                                        <input type="email" class="form-control" name="email" required>
                                        <label class="form-control-placeholder" for="email">Email</label>
                                    </div>
                                    <!-- Add more form fields as needed -->
                                    <div class="form-group">
                                        <button type="submit" class="form-control btn btn-primary rounded submit px-3">Reset Password</button>
                                    </div>
                                </form>
                                <c:if test="${not empty error}">
                                    <p style="color:red;">${error}</p>
                                </c:if>
                                <p class="text-center">Remember your password? <a href="login.jsp">Sign In</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>