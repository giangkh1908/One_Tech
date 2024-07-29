<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            background-image: url(images/banner_background.jpg);
            background-size: cover;
            background-position: center;
            font-family: 'Lato', sans-serif;
        }
        .ftco-section {
            padding: 4em 0;
        }
        .container {
            background: rgba(255, 255, 255, 0.8);
            padding: 2em;
            border-radius: 10px;
        }
        h1, h2 {
            color: #333;
        }
        p {
            color: #555;
        }
        .logo_container {
            font-size: 3rem;
            text-align: center;
            margin-bottom: 20px;
        }
        .logo a {
            font-size: 2em;
            /*color: #333;*/
            text-decoration: none;
            font-weight: bold;
        }
        .success-message {
            text-align: center;
            margin-top: 2em;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 1em;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12">
                    <div class="logo_container">
                        <div class="logo"><a href="home.jsp">OneTech</a></div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="success-message">
                        <h1>Send Email Successful</h1>
                        <p>Your email has been sent successfully.</p>
                        <a href="home" class="back-link">Back to Home</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>