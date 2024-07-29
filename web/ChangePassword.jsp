<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Random" %>
<%
    
session = request.getSession(true);
String captchaId = UUID.randomUUID().toString();
String captchaString = new signin.CaptchaGenerator().generateCaptchaString();
session.setAttribute(captchaId, captchaString);
%>
<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Change-Password</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
        <!-- Custom Stylesheet -->
        <link href="css/style_1.css" rel="stylesheet">
        <style>
            .captcha-container {
                display: flex;
                align-items: center;
            }
            .captcha-container img {
                margin-right: 10px;
            }
            .captcha-refresh {
                cursor: pointer;
                width: 50px;
            }
            .avatar-upload {
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                text-align: center;
            }

            .avatar-upload img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                margin-bottom: 10px;
            }

            .avatar-upload input {
                display: none;
            }

            .avatar-upload label {
                display: inline-block;
                background-color: #f5f5f5;
                padding: 6px 12px;
                cursor: pointer;
            }
        </style>
    </head>

    <body>

        <!--*******************
            Preloader start
        ********************-->
        <div id="preloader">
            <div class="loader">
                <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
                </svg>
            </div>
        </div>
        <!--*******************
            Preloader end
        ********************-->


        <!--**********************************
            Main wrapper start
        ***********************************-->
        <div id="main-wrapper">

            <!--**********************************
                Nav header start
            ***********************************-->
            <div class="nav-header" style="background: rgb(14, 140, 228) ">

                <a href="home">
                    <link href="css/style.css" rel="stylesheet">
                    <h3 class="logo" style="color: white; text-align: center; margin-top: 10%;
                        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol';">
                        OneTech</h3>
                </a>            
            </div>
            <!--**********************************
                Nav header end
            ***********************************-->

            <!--**********************************
                Header start
            ***********************************-->
            <div class="header">    
                <div class="header-content clearfix">

                    <div class="nav-control">
                        <div class="hamburger">
                            <span class="toggle-icon"><i class="icon-menu"></i></span>
                        </div>
                    </div>

                    <div class="header-right">
                        <ul class="clearfix">


                            <li class="icons dropdown">
                                <div class="user-img c-pointer position-relative"   data-toggle="dropdown">
                                    <span class="activity active"></span>
                                    <img src="images/user/1.png" height="40" width="40" alt="">
                                </div>
                                <div class="drop-down dropdown-profile   dropdown-menu">
                                    <div class="dropdown-content-body">
                                        <ul>

                                            <li><a href="logout"><i class="icon-key"></i> <span>Logout</span></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--**********************************
                Header end ti-comment-alt
            ***********************************-->

            <!--**********************************
                Sidebar start
            ***********************************-->
            <div class="nk-sidebar">           
                <div class="nk-nav-scroll">
                    <ul class="metismenu" id="menu">
                        <li class="nav-label">My Account</li>
                        <li>
                            <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                                <i class="icon-note menu-icon"></i><span class="nav-text">Forms</span>
                            </a>
                            <ul aria-expanded="false">
                                <li><a href="./UpdateProfile">Update Profile</a></li>
                                <li><a href="naptien">Recharge Money</a></li>
                                <li><a href="historytransaction">History Transaction</a></li>

                            </ul>
                        </li>

                        <li>
                            <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                                <i class="icon-menu menu-icon"></i><span class="nav-text">Change Password</span>
                            </a>
                            <ul aria-expanded="false">
                                <c:if test="${role eq 'admin'}">
                                    <li><a href="ManageAccount" aria-expanded="false">Account</a></li>
                                    </c:if>

                                <li><a href="ChangePassword" aria-expanded="false">Change Password</a></li>

                            </ul>
                        </li>

                    </ul>
                </div>
            </div>
            <!--**********************************
                Sidebar end
            ***********************************-->

            <!--**********************************
                Content body start
            ***********************************-->
            <div class="content-body">

                <div class="row page-titles mx-0">
                    <div class="col p-md-0">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="ChangePassword">Change Password</a></li>
                            <li class="breadcrumb-item active"><a href="home.jsp">Home</a></li>
                        </ol>
                    </div>
                </div>
                <!-- row -->

                <div class="container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-lg-12">
                            <div class="card">

                                <div class="card-body">
                                    <div class="form-validation">
                                        <form class="form-valide" action="ChangePassword" method="post" id="profile-form">
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="username">Account <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="username" value="${not empty param.username ? param.username : profile.getUsername()}" readonly name="username">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="oldPassword">Old password <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="password" class="form-control" id="oldPassword" value="${not empty param.oldPassword ? param.oldPassword : ''}" name="oldPassword" placeholder="Old password">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="newPassword">New password <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="password" class="form-control" id="newPassword" value="${not empty param.newPassword ? param.newPassword : ''}" name="newPassword" placeholder="New password">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="retypPassword">Re-type password <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="password" class="form-control" id="retypPassword" value="${not empty param.retypPassword ? param.retypPassword : ''}" name="retypPassword" placeholder="Re-type password">
                                                </div>
                                            </div>
                                            <div class="form-group row" style="margin-left: 0px">
                                                <div class="col-lg-6">
                                                    <img width="250px" id="captchaImage" src="CaptchaGenerator?captchaId=<%=captchaId%>" alt="CAPTCHA Image" />
                                                    <img class="captcha-refresh" src="captchaRefresh.png" alt="Refresh CAPTCHA" onclick="generateNewCaptcha()" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="captcha">Captcha <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="captcha" value="" name="captcha" placeholder="Input captcha">
                                                </div>
                                            </div>
                                            <c:if test="${not empty errorMessage}">
                                                <div class="error-message" style="text-align: center; color: red">${errorMessage}</div>
                                            </c:if>
                                            <c:if test="${not empty successMessage}">
                                                <div style="text-align: center; color: green" class="error-message">${successMessage}</div>
                                                <script>
                                                    document.getElementById("oldPassword").value = "";
                                                    document.getElementById("newPassword").value = "";
                                                    document.getElementById("retypPassword").value = "";
                                                    document.getElementById("captcha").value = "";
                                                </script>
                                            </c:if>
                                            <div class="form-group row">
                                                <div class="col-lg-8 ml-auto">
                                                    <button type="submit" class="btn btn-primary">Submit</button>
                                                </div>
                                            </div>
                                            <input type="hidden" id="captcha_id" name="captcha_id" value="<%=captchaId%>">
                                        </form>



                                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                                        <script>
                                                    window.onload = function () {
                                                        var formStatus = document.getElementById('formStatus').value;
                                                        if (formStatus === 'success') {
                                                            document.getElementById('oldPassword').value = '';
                                                            document.getElementById('newPassword').value = '';
                                                            document.getElementById('retypPassword').value = '';
                                                            document.getElementById('captcha').value = '';
                                                        }
                                                        async function validateForm(event) {
                                                            event.preventDefault(); // Prevent form from submitting

                                                            const oldPassword = document.getElementById('oldPassword').value;
                                                            const newPassword = document.getElementById('newPassword').value;
                                                            const retypPassword = document.getElementById('retypPassword').value;
                                                            const username = document.getElementById('username').value;

                                                            if (!oldPassword || !newPassword || !retypPassword) {
                                                                Swal.fire({
                                                                    title: "Inform",
                                                                    text: "Missing required parameter!",
                                                                    icon: "error"
                                                                });
                                                                return false;
                                                            }

                                                            if (newPassword.length < 8) {
                                                                Swal.fire({
                                                                    title: "Inform",
                                                                    text: "Password is too short. At least 8 characters.",
                                                                    icon: "error"
                                                                });
                                                                return false;
                                                            }

                                                            if (newPassword !== retypPassword) {
                                                                Swal.fire({
                                                                    title: "Inform",
                                                                    text: "Re-type password not match.",
                                                                    icon: "error"
                                                                });
                                                                return false;
                                                            }


                                        </script>




                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- #/ container -->
            </div>
            <!--**********************************
                Content body end
            ***********************************-->


            <!--**********************************
                Footer start
            ***********************************-->
            <div class="footer">
                <div class="copyright">
                    <p>Copyright &copy; Designed & Developed by <a href="https://themeforest.net/user/quixlab">Quixlab</a> 2018</p>
                </div>
            </div>
            <!--**********************************
                Footer end
            ***********************************-->
        </div>
        <!--**********************************
            Main wrapper end
        ***********************************-->

        <!--**********************************
            Scripts
        ***********************************-->
        <script src="plugins/common/common.min.js"></script>
        <script src="js/custom.min.js"></script>
        <script src="js/settings.js"></script>
        <script src="js/gleek.js"></script>
        <script src="js/styleSwitcher.js"></script>

        <script src="./plugins/validation/jquery.validate.min.js"></script>
        <script src="./plugins/validation/jquery.validate-init.js"></script>
        <script>

                                                            function displayAvatar(input) {
                                                                if (input.files && input.files[0]) {
                                                                    var reader = new FileReader();
                                                                    reader.onload = function (e) {
                                                                        document.getElementById('avatarImage').src = e.target.result;
                                                                    }
                                                                    reader.readAsDataURL(input.files[0]);
                                                                }
                                                            }
                                                            function displayImage() {
                                                                var input = document.getElementById("img-link").value;
                                                                var img = document.getElementById("preview-img");
                                                                img.src = input;
                                                            }

                                                            // Set the image source when the page loads
                                                            window.onload = function () {
                                                                var input = document.getElementById("img-link").value;
                                                                var img = document.getElementById("preview-img");
                                                                img.src = input;
                                                            };
        </script>
        <script type="text/javascript">
                    function generateNewCaptcha() {
                        var xhr = new XMLHttpRequest();
                        xhr.open("GET", "CaptchaGenerator?new=true", true);
                        xhr.onreadystatechange = function () {
                            if (xhr.readyState == 4 && xhr.status == 200) {
                                var response = JSON.parse(xhr.responseText);
                                document.getElementById("captchaImage").src = "CaptchaGenerator?captchaId=" + response.captchaId;
                                document.getElementById("captcha_id").value = response.captchaId;
                            }
                        };
                        xhr.send();
                    }

                    // Detect when the page is loaded via the browser's back button
                    window.addEventListener("pageshow", function (event) {
                        if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
                            // The page is loaded from the back/forward cache
                            document.getElementById("captcha-field").value = "";
                            generateNewCaptcha();
                        }
                    }
                    );
        </script>
    </body>

</html>