<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Recharge Money</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
        <!-- Custom Stylesheet -->
        <link href="css/style_1.css" rel="stylesheet">
        <style>
            #formattedDisplay {
                display: none;
            }
        </style>
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
    <% 
                  Boolean successTransaction = (Boolean) session.getAttribute("successTransaction");
                                  System.out.println("successTransaction" + successTransaction);

                  Boolean failureTransaction = (Boolean) session.getAttribute("failureTransaction");
                   System.out.println("failureTransaction" + failureTransaction);
                  
                  // Do not remove the session attribute here
    %>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
                            <li class="breadcrumb-item active"><a href="home">Home</a></li>
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
                                        <form class="form-valide" action="vnpayajax" method="post" onsubmit="validateForm(event)">
                                            <h3>Recharge Money</h3>
                                            <hr class="border border-primary border-2 opacity-20" style="color: blue">

                                            <div class="form-group row" >
                                                <label class="col-lg-4 col-form-label" for="val-username">Method <span class="text-danger"></span></label>
                                                <div class="col-lg-6">
                                                    <input style="background-color: rgb(14, 140, 228); text-align: center; color:white" type="text" class="form-control" id="username" name="username" value="VNPAY Payment Gateway" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="fullname">Balance (VND)<span class="text-danger"></span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="fullname" name="fullname" value="${balance}" disabled>
                                                </div>
                                            </div>
                                            <div class="form-group row">
                                                <label class="col-lg-4 col-form-label" for="fullname">Amount (VND) <span class="text-danger">*</span></label>
                                                <div class="col-lg-6">
                                                    <input type="text" class="form-control" id="amount" name="amount" value="10000" placeholder="Số tiền cần nạp (Tối thiểu 10.000 vnđ)" oninput="updateFormattedDisplay(this)">
                                                </div>

                                            </div>
                                            <div id="formattedDisplay"></div>
                                            <div  id="errorMessage" style="color:red;margin-left: 400px;margin-top: -20px;"></div>
                                            <div style="margin-left: 400px; " id="textDisplay"></div>


                                            <div class="form-group row" >
                                                <div class="col-lg-8 ml-auto" style="margin-top: 20px">
                                                    <button type="submit" class="btn btn-primary">Submit</button>
                                                </div>
                                            </div>
                                        </form>
                                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                                        <script>
                                            function removeCartSuccessFlag() {
                                                // Send a request to the server to remove the session attribute
                                                fetch('removeCartSuccessFlag').then(response => {
                                                    if (!response.ok) {
                                                        console.error('Failed to remove cartSuccess flag');
                                                    }
                                                });
                                            }
                                        </script>
                                        <c:if test="${failureTransaction != null && failureTransaction}">
                                            <script>
                                                const Toast = Swal.mixin({
                                                    toast: true,
                                                    position: "top-end",
                                                    showConfirmButton: false,
                                                    timer: 3000,
                                                    timerProgressBar: true,
                                                    didOpen: (toast) => {
                                                        toast.onmouseenter = Swal.stopTimer;
                                                        toast.onmouseleave = Swal.resumeTimer;
                                                    },
                                                    didClose: () => {
                                                        removeCartSuccessFlag(); // Remove the flag after the toast is closed
                                                    }
                                                });
                                                Toast.fire({
                                                    icon: "error",
                                                    title: "Nạp tiền thất bại. Vui lòng thử lại."
                                                });
                                            </script>
                                        </c:if>
                                        <c:if test="${successTransaction != null && successTransaction}">
                                            <script>
                                                const Toast = Swal.mixin({
                                                    toast: true,
                                                    position: "top-end",
                                                    showConfirmButton: false,
                                                    timer: 3000,
                                                    timerProgressBar: true,
                                                    didOpen: (toast) => {
                                                        toast.onmouseenter = Swal.stopTimer;
                                                        toast.onmouseleave = Swal.resumeTimer;
                                                    },
                                                    didClose: () => {
                                                        removeCartSuccessFlag(); // Remove the flag after the toast is closed
                                                    }
                                                });
                                                Toast.fire({
                                                    icon: "success",
                                                    title: "Nạp tiền thành công"
                                                });
                                            </script>
                                        </c:if>

                                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                                        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                                        <script>


                                                // Function to format the number with commas
                                                function formatNumberWithCommas(value) {
                                                    return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                                }

                                                // Function to update the display with the formatted number
                                                function updateFormattedDisplay(input) {
                                                    const formattedDisplay = document.getElementById('formattedDisplay');
                                                    const errorMessage = document.getElementById('errorMessage');
                                                    const textDisplay = document.getElementById('textDisplay');
                                                    const submitButton = document.getElementById('submitButton');
                                                    let value = input.value.replace(/,/g, '');
                                                    if (value === '') {
                                                        submitButton.disabled = true;
                                                        errorMessage.textContent = "";
                                                        formattedDisplay.textContent = "";
                                                        textDisplay.textContent = "";
                                                        return;
                                                    }
                                                    if (isNaN(value)) {
                                                        errorMessage.textContent = "Please enter only numbers.";
                                                        //formattedDisplay.textContent = "";
                                                        textDisplay.textContent = "";
                                                        submitButton.disabled = true;
                                                    } else if (value < 10000 || value > 10000000) {
                                                        errorMessage.textContent = "Please enter a value between 10,000 and 10,000,000.";
                                                        formattedDisplay.textContent = "";
                                                        textDisplay.textContent = "";
                                                        submitButton.disabled = true;
                                                    } else {
                                                        errorMessage.textContent = "";
                                                        //input.value = formatNumberWithCommas(value);
                                                        formattedDisplay.textContent = formatNumberWithCommas(value);
                                                        textDisplay.textContent = numberToVietnamese(value);
                                                        submitButton.disabled = false;
                                                    }
                                                }

                                                // Function to remove commas for form submission
                                                function removeCommasForSubmission(input) {
                                                    input.value = input.value.replace(/,/g, '');
                                                }

                                                // Function to convert number to Vietnamese text
                                                function numberToVietnamese(num) {
                                                    const units = ["", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"];
                                                    const tens = ["", "mười", "hai mươi", "ba mươi", "bốn mươi", "năm mươi", "sáu mươi", "bảy mươi", "tám mươi", "chín mươi"];
                                                    const hundreds = ["", "một trăm", "hai trăm", "ba trăm", "bốn trăm", "năm trăm", "sáu trăm", "bảy trăm", "tám trăm", "chín trăm"];

                                                    if (num == 0)
                                                        return "không";
                                                    if (num.length > 9)
                                                        return "Số quá lớn";

                                                    let str = "";
                                                    let numStr = num.toString();
                                                    while (numStr.length < 9) {
                                                        numStr = "0" + numStr;
                                                    }

                                                    const millions = parseInt(numStr.substring(0, 3));
                                                    const thousands = parseInt(numStr.substring(3, 6));
                                                    const unitsValue = parseInt(numStr.substring(6, 9));

                                                    if (millions > 0) {
                                                        str += convertThreeDigits(millions) + " triệu ";
                                                    }
                                                    if (thousands > 0) {
                                                        str += convertThreeDigits(thousands) + " nghìn ";
                                                    }
                                                    if (unitsValue > 0) {
                                                        str += convertThreeDigits(unitsValue) + " ";
                                                    }

                                                    return str.trim();
                                                }

                                                function convertThreeDigits(num) {
                                                    const units = ["", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"];
                                                    const tens = ["", "mười", "hai mươi", "ba mươi", "bốn mươi", "năm mươi", "sáu mươi", "bảy mươi", "tám mươi", "chín mươi"];
                                                    const hundreds = ["", "một trăm", "hai trăm", "ba trăm", "bốn trăm", "năm trăm", "sáu trăm", "bảy trăm", "tám trăm", "chín trăm"];

                                                    let hundred = Math.floor(num / 100);
                                                    let ten = Math.floor((num % 100) / 10);
                                                    let unit = num % 10;

                                                    let result = hundreds[hundred];
                                                    if (ten > 0 || unit > 0) {
                                                        if (ten > 0) {
                                                            result += " " + tens[ten];
                                                        }
                                                        if (unit > 0) {
                                                            result += " " + units[unit];
                                                        }
                                                    }
                                                    return result;
                                                }

                                                // Function to validate form on submission
                                                function validateForm(event) {
                                                    const amountInput = document.getElementById('amount');
                                                    let value = amountInput.value.replace(/,/g, '');
                                                    if (parseInt(value) < 10000 || parseInt(value) > 1000000000) {
                                                        event.preventDefault();
                                                        Swal.fire({
                                                            icon: 'error',
                                                            title: 'Oops...',
                                                            text: "Please enter a value between 10,000 and 1,000,000,000"
                                                        });
                                                    }
                                                    if (amountInput.value.trim() === '') {
                                                        event.preventDefault();
                                                        Swal.fire({
                                                            icon: 'error',
                                                            title: 'Oops...',
                                                            text: "Missing parameter for field 'Amount of money'"
                                                        });
                                                    } else {
                                                        removeCommasForSubmission(amountInput);
                                                    }
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
    </body>

</html>