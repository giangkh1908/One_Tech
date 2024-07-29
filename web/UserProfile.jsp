<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Profile</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
        <!-- Custom Stylesheet -->
        <link href="css/style_1.css" rel="stylesheet">
        <style>
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
                    <!--                    <div class="header-left">
                                            <div class="input-group icons">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text bg-transparent border-0 pr-2 pr-sm-3" id="basic-addon1"><i class="mdi mdi-magnify"></i></span>
                                                </div>
                                                <input type="search" class="form-control" placeholder="Search Dashboard" aria-label="Search Dashboard">
                                                <div class="drop-down   d-md-none">
                                                    <form action="#">
                                                        <input type="text" class="form-control" placeholder="Search">
                                                    </form>
                                                </div>
                                            </div>
                                        </div>-->
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
                                <li><a href="UpdateProfile">Update Profile</a></li>
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
                            <li class="breadcrumb-item"><a href="javascript:void(0)">Dashboard</a></li>
                            <li class="breadcrumb-item active"><a href="javascript:void(0)">Home</a></li>
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
                                        <form class="form-valide" id="profile-form" action="UpdateProfile" method="post">

                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="val-username">Username <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="username" name="username" value="${profile.getUsername()}" readonly>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="fullname">Fullname <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="fullname" name="fullname" value="${profile.getFullname()}" placeholder="Enter a fullname">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="email">Email <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="email" class="form-control" id="email" name="email" value="${profile.getEmail()}" readonly placeholder="Your valid email">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="phoneNumber">Phone Number <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${profile.getPhoneNumber()}" placeholder="Enter a fullname">
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="dob">Link IMG <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="img-link" name="linkAvatar" oninput="displayImage()" value="${profile.getLinkAvatar()}">
                                                    <img id="preview-img" alt="alt" style="width: 100px; height: 100px; border-radius: 50%; margin-bottom: 10px;" />
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <div class="col-lg-8 ml-auto">
                                                    <button type="submit" class="btn btn-primary">Submit</button>
                                                </div>
                                            </div>
                                        </form>

                                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                        <!--                                        <script>
                                                                                    $(document).ready(function () {
                                                                                        const originalData = $('#profile-form').serialize();
                                        
                                                                                        document.getElementById('profile-form').addEventListener('submit', function (event) {
                                                                                            event.preventDefault(); // Prevent the form from submitting immediately
                                        
                                                                                            Swal.fire({
                                                                                                title: "Do you want to save the changes?",
                                                                                                showDenyButton: true,
                                                                                                showCancelButton: true,
                                                                                                confirmButtonText: "Save",
                                                                                                denyButtonText: `Don't save`
                                                                                            }).then((result) => {
                                                                                                if (result.isConfirmed) {
                                                                                                    $.ajax({
                                                                                                        type: 'POST',
                                                                                                        url: 'UpdateProfile',
                                                                                                        data: $('#profile-form').serialize(), // Serialize the form data
                                                                                                        success: function (response) {
                                                                                                            Swal.fire("Saved!", "", "success");
                                                                                                        },
                                                                                                        error: function () {
                                                                                                            Swal.fire("Error updating profile", "", "error");
                                                                                                        }
                                                                                                    });
                                                                                                } else if (result.isDenied) {
                                                                                                    Swal.fire("Changes are not saved", "", "info");
                                                                                                    $('#profile-form')[0].reset(); // Reset form fields to their original values
                                                                                                    // Re-populate form fields with original data
                                                                                                    $.each(originalData.split('&'), function (index, value) {
                                                                                                        var keyValue = value.split('=');
                                                                                                        $('[name="' + decodeURIComponent(keyValue[0]) + '"]').val(decodeURIComponent(keyValue[1]));
                                                                                                    });
                                                                                                }
                                                                                            });
                                                                                        });
                                                                                    });
                                                                                </script>-->



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
    </body>

</html>