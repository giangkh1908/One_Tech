<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Random" %>
<%
// Invalidate the current session to ensure a new session is created
session.invalidate();
// Create a new session for the new request
session = request.getSession(true);

String captchaId = UUID.randomUUID().toString();
session.setAttribute(captchaId, new signin.CaptchaGenerator().generateCaptchaString());
%>
<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Quixlab - Bootstrap Admin Dashboard Template by Themefisher.com</title>
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
            <div class="nav-header">
                <div class="brand-logo">
                    <a href="home.jsp">
                        <b class="logo-abbr"><img src="images/logo.png" alt=""> </b>
                        <span class="logo-compact"><img src="./images/logo-compact.png" alt=""></span>
                        <span class="brand-title">
                            <img src="images/logo-text.png" alt="">
                        </span>
                    </a>
                </div>
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
                            <li class="icons dropdown"><a href="javascript:void(0)" data-toggle="dropdown">
                                    <i class="mdi mdi-email-outline"></i>
                                    <span class="badge gradient-1 badge-pill badge-primary">3</span>
                                </a>
                                <div class="drop-down animated fadeIn dropdown-menu">
                                    <div class="dropdown-content-heading d-flex justify-content-between">
                                        <span class="">3 New Messages</span>  

                                    </div>
                                    <div class="dropdown-content-body">
                                        <ul>
                                            <li class="notification-unread">
                                                <a href="javascript:void()">
                                                    <img class="float-left mr-3 avatar-img" src="images/avatar/1.jpg" alt="">
                                                    <div class="notification-content">
                                                        <div class="notification-heading">Saiful Islam</div>
                                                        <div class="notification-timestamp">08 Hours ago</div>
                                                        <div class="notification-text">Hi Teddy, Just wanted to let you ...</div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li class="notification-unread">
                                                <a href="javascript:void()">
                                                    <img class="float-left mr-3 avatar-img" src="images/avatar/2.jpg" alt="">
                                                    <div class="notification-content">
                                                        <div class="notification-heading">Adam Smith</div>
                                                        <div class="notification-timestamp">08 Hours ago</div>
                                                        <div class="notification-text">Can you do me a favour?</div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void()">
                                                    <img class="float-left mr-3 avatar-img" src="images/avatar/3.jpg" alt="">
                                                    <div class="notification-content">
                                                        <div class="notification-heading">Barak Obama</div>
                                                        <div class="notification-timestamp">08 Hours ago</div>
                                                        <div class="notification-text">Hi Teddy, Just wanted to let you ...</div>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void()">
                                                    <img class="float-left mr-3 avatar-img" src="images/avatar/4.jpg" alt="">
                                                    <div class="notification-content">
                                                        <div class="notification-heading">Hilari Clinton</div>
                                                        <div class="notification-timestamp">08 Hours ago</div>
                                                        <div class="notification-text">Hello</div>
                                                    </div>
                                                </a>
                                            </li>
                                        </ul>

                                    </div>
                                </div>
                            </li>
                            <li class="icons dropdown"><a href="javascript:void(0)" data-toggle="dropdown">
                                    <i class="mdi mdi-bell-outline"></i>
                                    <span class="badge badge-pill gradient-2 badge-primary">3</span>
                                </a>
                                <div class="drop-down animated fadeIn dropdown-menu dropdown-notfication">
                                    <div class="dropdown-content-heading d-flex justify-content-between">
                                        <span class="">2 New Notifications</span>  

                                    </div>
                                    <div class="dropdown-content-body">
                                        <ul>
                                            <li>
                                                <a href="javascript:void()">
                                                    <span class="mr-3 avatar-icon bg-success-lighten-2"><i class="icon-present"></i></span>
                                                    <div class="notification-content">
                                                        <h6 class="notification-heading">Events near you</h6>
                                                        <span class="notification-text">Within next 5 days</span> 
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void()">
                                                    <span class="mr-3 avatar-icon bg-danger-lighten-2"><i class="icon-present"></i></span>
                                                    <div class="notification-content">
                                                        <h6 class="notification-heading">Event Started</h6>
                                                        <span class="notification-text">One hour ago</span> 
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void()">
                                                    <span class="mr-3 avatar-icon bg-success-lighten-2"><i class="icon-present"></i></span>
                                                    <div class="notification-content">
                                                        <h6 class="notification-heading">Event Ended Successfully</h6>
                                                        <span class="notification-text">One hour ago</span>
                                                    </div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="javascript:void()">
                                                    <span class="mr-3 avatar-icon bg-danger-lighten-2"><i class="icon-present"></i></span>
                                                    <div class="notification-content">
                                                        <h6 class="notification-heading">Events to Join</h6>
                                                        <span class="notification-text">After two days</span> 
                                                    </div>
                                                </a>
                                            </li>
                                        </ul>

                                    </div>
                                </div>
                            </li>
                            <li class="icons dropdown d-none d-md-flex">
                                <a href="javascript:void(0)" class="log-user"  data-toggle="dropdown">
                                    <span>English</span>  <i class="fa fa-angle-down f-s-14" aria-hidden="true"></i>
                                </a>
                                <div class="drop-down dropdown-language animated fadeIn  dropdown-menu">
                                    <div class="dropdown-content-body">
                                        <ul>
                                            <li><a href="javascript:void()">English</a></li>
                                            <li><a href="javascript:void()">Dutch</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </li>
                            <li class="icons dropdown">
                                <div class="user-img c-pointer position-relative"   data-toggle="dropdown">
                                    <span class="activity active"></span>
                                    <img src="images/user/1.png" height="40" width="40" alt="">
                                </div>
                                <div class="drop-down dropdown-profile   dropdown-menu">
                                    <div class="dropdown-content-body">
                                        <ul>
                                            <li>
                                                <a href="app-profile.html"><i class="icon-user"></i> <span>Profile</span></a>
                                            </li>
                                            <li>
                                                <a href="email-inbox.html"><i class="icon-envelope-open"></i> <span>Inbox</span> <div class="badge gradient-3 badge-pill badge-primary">3</div></a>
                                            </li>

                                            <hr class="my-2">
                                            <li>
                                                <a href="page-lock.html"><i class="icon-lock"></i> <span>Lock Screen</span></a>
                                            </li>
                                            <li><a href="page-login.html"><i class="icon-key"></i> <span>Logout</span></a></li>
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
                                <li><a href="./UserProfile.jsp">Update Profile</a></li>

                            </ul>
                        </li>
                        <li class="nav-label">Table</li>
                        <li>
                            <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                                <i class="icon-menu menu-icon"></i><span class="nav-text">Table</span>
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
                                        <form class="form-valide" action="ChangePassword" method="post" id="profile-form" onsubmit="return validateForm(event)">
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="username">Account <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="username" value="${profile.getUsername()}" readonly name="username">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="oldPassword">Old password <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="password" class="form-control" id="oldPassword" value="${oldPassword}"  name="oldPassword" placeholder="Old password">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="newPassword">New password <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="password" class="form-control" id="newPassword" value="${newPassword}" name="newPassword" placeholder="New password">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="retypPassword">Re-type password <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="password" class="form-control" id="retypPassword" value="${retyPassword}" name="retypPassword" placeholder="Re-type password">
                                                </div>
                                            </div>
                                                <div class="form-group row" style="margin-left: 0px">

                                                <div class="col-lg-6">
                                                    <img width="250px" id="captchaImage" src="CaptchaGenerator?captchaId=<%=captchaId%>" alt="CAPTCHA Image" />
                                                    <img  class="captcha-refresh" src="captchaRefresh.png" alt="Refresh CAPTCHA" onclick="generateNewCaptcha()" />
                                                    
                                                  
                                                </div>

                                            </div>   
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="retypPassword">Captcha <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="password" class="form-control" id="retypPassword" value="${captcha}" name="retypPassword" placeholder="Input captcha">
                                                </div>
                                            </div>

                                            <c:if test="${not empty errorMessage}">
                                                <div class="error-message" style="text-align: center; color: red">${errorMessage}</div>
                                            </c:if>
                                            <c:if test="${not empty successMessage}">
                                                <div style="text-align: center; color: green" class="error-message" >${successMessage}</div>
                                            </c:if>
                                            <div class="form-group row">
                                                <div class="col-lg-8 ml-auto">
                                                    <button type="submit" class="btn btn-primary">Submit</button>
                                                </div>
                                            </div>
                                        </form>

                                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                                        <script>
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