<%-- 
    Document   : login
    Created on : May 18, 2024, 8:18:18 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%> 
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <style>
            body {
                background-image: url(images/banner_background.jpg); /* Replace with the actual path to your image */
                background-size: cover;
                background-position: center;
            }
        </style>
    </head>
    <body>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center mb-5">
                        <h2 class="heading-section"></h2>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="login-wrap p-4 p-md-5">
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h3 class="mb-4">Email Verification</h3>
                                    </div>

                                </div>
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h5 class="mb-4">Please enter CODE that has been sent to your email.</h5>
                                    </div>

                                </div>
                                <form action="verify" method="post" id="verificationForm" class="signin-form">
                                    <div class="form-group mt-3">
                                        <div class="form-group">
                                            <input type="text" class="form-control" name="authcode" required>
                                            <label class="form-control-placeholder" for="authcode">Code</label>
                                        </div>
                                        <div class="form-group">
                                            <button type="submit" class="form-control btn btn-primary rounded submit px-3">Verify</button>
                                        </div>
                                    </div>
                                    <input type="hidden" id="attempts" name="attempts" value="0">
                                    <input type="hidden" id="codeSentTime" name="codeSentTime" value="<%= new Date().getTime() %>">
                                </form>
                                <p id="error" class="text-center" style="color: red;">
                                    <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
                                </p>
                                <p class="text-center">No CODE sent? <a href="#" id="resendLink">Resend</a></p>
                                <p id="timer" class="text-center" style="display: none;">
                                    Please wait <span id="countdown">60</span> seconds to resend.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <script>
            document.getElementById('resendLink').addEventListener('click', function (event) {
                event.preventDefault(); // Prevent the default link behavior

                // Disable the resend link
                this.style.pointerEvents = 'none';
                document.getElementById('timer').style.display = 'block';

                // Start the countdown
                let countdown = 60;
                const countdownElement = document.getElementById('countdown');
                const interval = setInterval(() => {
                    countdown--;
                    countdownElement.textContent = countdown;
                    if (countdown <= 0) {
                        clearInterval(interval);
                        document.getElementById('resendLink').style.pointerEvents = 'auto';
                        document.getElementById('timer').style.display = 'none';
                    }
                }, 1000);

                // Perform the resend action
                fetch('ResendMail')
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.text();
                        })
                        .catch(error => {
                            console.error('There was a problem with the fetch operation:', error);
                        });
            });
        </script>
        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>

