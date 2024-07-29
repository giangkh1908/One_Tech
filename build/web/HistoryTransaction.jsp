<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>History Transaction</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
        <!-- Custom Stylesheet -->
        <link href="./plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            .highlight {
                font-weight: bold;
                background-color: rgb(9, 130, 215);
                color: white;
                width: 222px;
                height: 40px;
                border: none;
                border-radius: 10px;
            }

            .dim {
                background-color: rgb(228, 231, 234);
                color: white;
                width: 222px;
                height: 40px;
                border: none;
                border-radius: 10px;
            }

            .active-filter {
                background-color: #007bff;
                /* Change to your desired color */
                color: #fff;
            }

            .filter-button {
                background-color: gray;
                color: white;
                border: none;
                border-radius: 150px;
                padding: 5px 10px;
                margin: 5px;
                cursor: pointer;
            }
        </style>
        <style>
            th {
                cursor: pointer;
                user-select: none;
            }

            th.sorted-asc::after {
                content: " \2191";
            }

            th.sorted-desc::after {
                content: " \2193";
            }
        </style>
        <style>
            th {
                background-color: #f2f2f2;
                cursor: pointer;
                /* Indicate that the header is clickable for sorting */
                white-space: nowrap;
                /* Prevent text from wrapping */
            }

            /* Optionally, handle overflow if the text is too long */
            th {
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 200px;
                /* Adjust as needed */
            }

            th {
                cursor: pointer;
                user-select: none;
                background-color: #f2f2f2;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 200px;
                padding: 8px;
            }

            th div {
                overflow-x: auto;
                white-space: nowrap;
            }
        </style>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>



        <link href="css/style_1.css" rel="stylesheet">

    </head>
    <% 
             Boolean checkProcess = (Boolean) session.getAttribute("checkProcess");
             // Do not remove the session attribute here
    %>
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

                            <li class="icons drop-menu">
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

                        <c:if test="${role eq 'user'}">
                            <li class="nav-label">My Account</li>
                            <li>
                                <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                                    <i class="icon-note menu-icon"></i><span class="nav-text">Forms</span>
                                </a>
                                <ul aria-expanded="false">
                                    <li><a href="./UpdateProfile">Update Profile</a></li>
                                    <li><a href="naptien">Recharge Money </a></li>

                                    <li><a href="historytransaction">History Transaction</a></li>
                                        <c:if test="${role eq 'admin'}">

                                    </c:if>

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
                        </c:if>

                        <c:if test="${role eq 'admin'}">

                            <li class="nav-label">Manage</li>
                            <li>
                                <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                                    <i class="icon-menu menu-icon"></i><span class="nav-text">Manage</span>
                                </a>
                                <ul aria-expanded="false">
                                    <li><a href="ManageAccount" aria-expanded="false">Manage Account</a></li>
                                        <c:if test="${role eq 'user'}">
                                        <li><a href="ChangePassword" aria-expanded="false">Change Password</a></li>
                                        </c:if>
                                    <li><a href="manage" aria-expanded="false">Manage Product</a></li>
                                    <li><a href="manage" aria-expanded="false">Manage Inventory</a></li>
                                    <li><a href="category" aria-expanded="false">Manage Category</a></li>
                                    <li><a href="historytransaction" aria-expanded="false">Manage History Transaction</a></li>
                                    <li><a href="forum" aria-expanded="false">Manage Forum</a></li>

                                </ul>
                            </li>

                        </c:if>
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

                <div class="">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-body">
                                    <h4 class="card-title"><a href="historytransaction">History Transaction</a></h4>

                                    <!-- Buttons to filter transactions -->
                                    <form action="historytransaction" method="get">
                                        <input type="hidden" name="page" value="${1}">
                                        <button type="submit" name="period" value="3months" style="<% if ("3months".equals(request.getAttribute("selectedPeriod"))) { %>background-color: #007bff; color: #fff;<% } else { %>background-color: gray; color: #fff;<% } %>" class="filter-button">3 Months</button>
                                        <button type="submit" name="period" value="6months" style="<% if ("6months".equals(request.getAttribute("selectedPeriod"))) { %>background-color: #007bff; color: #fff;<% } else { %>background-color: gray; color: #fff;<% } %>" class="filter-button">6 Months</button>
                                        <button type="submit" name="period" value="9months" style="<% if ("9months".equals(request.getAttribute("selectedPeriod"))) { %>background-color: #007bff; color: #fff;<% } else { %>background-color: gray; color: #fff;<% } %>" class="filter-button">9 Months</button>
                                        <button type="submit" name="period" value="1year" style="<% if ("1year".equals(request.getAttribute("selectedPeriod"))) { %>background-color: #007bff; color: #fff;<% } else { %>background-color: gray; color: #fff;<% } %>" class="filter-button">1 Year</button>
                                        <c:if test="${not empty totalRecords}">
                                            <div style="color: black; margin-left: auto; margin-right: 10px; display: inline-flex">
                                                Total record: ${totalRecords}
                                            </div>
                                        </c:if>
                                    </form>

                                    <table id="transactionTable" class="table table-striped table-bordered" style="width: 100%; border-collapse: collapse;">
                                        <thead>
                                            <tr>
                                                <c:if test="${role eq 'admin'}">
                                                    <th onclick="sortTable(0, 'int')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">#</th>
                                                    <th onclick="sortTable(1, 'int')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">UserID</th>
                                                    <th onclick="sortTable(2, 'string')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Amount</th>
                                                    <th onclick="sortTable(3, 'int')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Post-transaction balance</th>
                                                    <th onclick="sortTable(4, 'string')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Description</th>
                                                    <th onclick="sortTable(5, 'date')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Transaction time</th>
                                                    <th onclick="sortTable(6, 'string')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Transaction code</th>
                                                    <th></th>
                                                    </c:if>
                                                    <c:if test="${role eq 'user'}">
                                                    <th onclick="sortTable(0, 'int')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">#</th>
                                                    <th onclick="sortTable(1, 'string')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Amount</th>
                                                    <th onclick="sortTable(2, 'int')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Post-transaction balance</th>
                                                    <th onclick="sortTable(3, 'string')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Description</th>
                                                    <th onclick="sortTable(4, 'date')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Transaction time</th>
                                                    <th onclick="sortTable(5, 'string')" style="border: 1px solid #ddd; padding: 8px; text-align: left; background-color: #f2f2f2; cursor: pointer;">Transaction code</th>
                                                    <th></th>
                                                    </c:if>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="transact" items="${transactionList}" varStatus="status">
                                                <tr>
                                                    <c:if test="${role eq 'admin'}">
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${status.index + 1}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getUserId()}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">
                                                            <c:choose>
                                                                <c:when test="${transact.transactionType == 'plus'}">
                                                                    <span style="color: green; font-weight: bold">+${transact.getAmount()}</span>
                                                                </c:when>
                                                                <c:when test="${transact.transactionType == 'minus'}">
                                                                    <span style="color: red;">-${transact.getAmount()}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${transact.amount}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getAfterTransactMoney()}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getDescription()}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getCreationDate()}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getTransactionCode()}</td>
                                                        <td>
                                                            <button type="button" class="btn btn-primary" onclick="showDetails(${transact.getUserId()}, '${transact.getAmount()}', '${transact.getAfterTransactMoney()}', '${transact.getDescription()}', '${transact.getCreationDate()}', '${transact.getTransactionCode()}', '${transact.getTransactionType()}')">Detail</button>
                                                            <button type="button" class="btn btn-primary" onclick="showCardDetails('${transact.getTransactionCode()}')">Cards</button>
                                                        </td>
                                                    </c:if>
                                                    <c:if test="${role eq 'user'}">
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${status.index + 1}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">
                                                            <c:choose>
                                                                <c:when test="${transact.transactionType == 'plus'}">
                                                                    <span style="color: green; font-weight: bold">+${transact.getAmount()}</span>
                                                                </c:when>
                                                                <c:when test="${transact.transactionType == 'minus'}">
                                                                    <span style="color: red;">-${transact.getAmount()}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${transact.amount}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getAfterTransactMoney()}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getDescription()}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getCreationDate()}</td>
                                                        <td style="border: 1px solid #ddd; padding: 8px;">${transact.getTransactionCode()}</td>
                                                        <td style="">
                                                            <button type="button" class="btn btn-primary"  onclick="showDetails(${transact.getUserId()}, '${transact.getAmount()}', '${transact.getAfterTransactMoney()}', '${transact.getDescription()}', '${transact.getCreationDate()}', '${transact.getTransactionCode()}', '${transact.getTransactionType()}')">Detail</button>
                                                            <button type="button" class="btn btn-primary"  onclick="showCardDetails('${transact.getTransactionCode()}')">Cards</button>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                    <div class="modal fade" id="transactionModal" tabindex="-1" role="dialog" aria-labelledby="transactionModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-scrollable" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="transactionModalLabel">Transaction Details</h5>
                                                    <button type="button" class="close" onclick="closeModal1()" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <form>
                                                        <div class="form-group">
                                                            <label for="modalUserId">User ID</label>
                                                            <input type="text" class="form-control" id="modalUserId" readonly>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="modalAmount">Amount</label>
                                                            <input type="text" class="form-control" id="modalAmount" readonly>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="modalTransactionType">Transaction Type</label>
                                                            <div id="modalTransactionType">
                                                                <button disabled type="button" id="plusBtn" class="dim">+</button>
                                                                <button disabled type="button" id="minusBtn" class="dim">-</button>
                                                            </div>
                                                            <input type="hidden" id="originalTransactionType">
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="modalPostBalance">Post-transaction balance</label>
                                                            <input type="text" class="form-control" id="modalPostBalance" readonly>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="modalDescription">Description</label>
                                                            <textarea class="form-control" id="modalDescription" rows="3" readonly></textarea>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="modalTime">Transaction time</label>
                                                            <input type="text" class="form-control" id="modalTime" readonly>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="modalCode">Transaction code</label>
                                                            <input type="text" class="form-control" id="modalCode" readonly>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <!-- Button to close modal using custom function -->
                                                            <button type="button" class="btn btn-secondary" onclick="closeModal1()">Close</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="modal fade" id="cardDetailsModal" tabindex="-1" role="dialog" aria-labelledby="cardDetailsModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-scrollable" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="cardDetailsModalLabel">Cart and Bill Details</h5>
                                                    <button type="button" class="close" onclick="closeModal2()" aria-label="Close">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                </div>
                                                <div class="modal-body">
                                                    <div style="text-align: center; margin-bottom: 10px; color:black"><b>Cart Details</b></div>
                                                    <div class="form-group">
                                                        <table class="table">
                                                            <thead>
                                                                <tr>
                                                                    <th>#</th>
                                                                    <th>Category</th>
                                                                    <th>Quantity</th>
                                                                    <th>Price</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="cardDetails">
                                                                <!-- Cart details will be populated here by JavaScript -->
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                   
                                                        <div style="text-align: center; margin-bottom: 10px; color:black"><b>Bill Details</b></div>
                                                        <div class="form-group">
                                                            <table class="table">
                                                                <thead>
                                                                    <tr>
                                                                        <th>#</th>
                                                                        <th>Product Name</th>
                                                                        <th>Code</th>
                                                                        <th>Seri</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody id="billDetailsModalBody">
                                                                    <!-- Bill details will be populated here by JavaScript -->
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                   

                                                    <div class="modal-footer">
                                                        <!-- Button to close modal using custom function -->
                                                        <button type="button" class="btn btn-secondary" onclick="closeModal2()">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
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
                                    <c:if test="${checkProcess != null && checkProcess}">
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
                                                title: "Your order processed successfully"
                                            });
                                        </script>
                                    </c:if>

                                    <script type="text/javascript">
                                        function showDetails(userId, amount, postBalance, description, time, code, transactionType) {
                                            document.getElementById('modalUserId').value = userId;
                                            document.getElementById('modalAmount').value = amount;
                                            document.getElementById('modalPostBalance').value = postBalance;
                                            document.getElementById('modalDescription').value = description;
                                            document.getElementById('modalTime').value = time;
                                            document.getElementById('modalCode').value = code;

                                            // Set the original transaction type
                                            document.getElementById('originalTransactionType').value = transactionType;

                                            // Highlight the correct button based on the transaction type
                                            if (transactionType === 'plus') {
                                                document.getElementById('plusBtn').classList.add('highlight');
                                                document.getElementById('plusBtn').classList.remove('dim');
                                                document.getElementById('minusBtn').classList.remove('highlight');
                                                document.getElementById('minusBtn').classList.add('dim');
                                            } else if (transactionType === 'minus') {
                                                document.getElementById('minusBtn').classList.add('highlight');
                                                document.getElementById('minusBtn').classList.remove('dim');
                                                document.getElementById('plusBtn').classList.remove('highlight');
                                                document.getElementById('plusBtn').classList.add('dim');
                                            }

                                            $('#transactionModal').modal('show');
                                        }

                                        function showCardDetails(transactionCode) {
                                            console.log('Fetching details for transactionCode:', transactionCode); // Log transaction code

                                            $.ajax({
                                                url: 'fetchCartDetails', // URL to your servlet or endpoint that fetches transaction details
                                                method: 'GET',
                                                data: {transactionCode: transactionCode},
                                                success: function (response) {
                                                    console.log('Response received:', response); // Log the response

                                                    // Check if response contains the expected data
                                                    if (response.listCard && response.listBill) {
                                                        // Populate the cart details table
                                                        var cardTbody = $('#cardDetails');
                                                        cardTbody.empty(); // Clear existing rows
                                                        response.listCard.forEach(function (card, index) {
                                                            var row = '<tr>' +
                                                                    '<td>' + (index + 1) + '</td>' +
                                                                    '<td>' + card.category + '</td>' +
                                                                    '<td>' + card.quantity + '</td>' +
                                                                    '<td>' + card.total + '</td>' +
                                                                    '</tr>';
                                                            cardTbody.append(row);
                                                        });

                                                        // Populate the bill details table
                                                        var billTbody = $('#billDetailsModalBody');
                                                        billTbody.empty(); // Clear existing rows
                                                        response.listBill.forEach(function (bill, index) {
                                                            var row = '<tr>' +
                                                                    '<td>' + (index + 1) + '</td>' +
                                                                    '<td>' + bill.productName + '</td>' +
                                                                    '<td>' + bill.code + '</td>' +
                                                                    '<td>' + bill.seriNumber + '</td>' +
                                                                    '</tr>';
                                                            billTbody.append(row);
                                                        });

                                                        // Show the card details modal
                                                        $('#cardDetailsModal').modal('show');
                                                    } else {
                                                        console.log('Invalid response format:', response);
                                                    }
                                                },
                                                error: function (error) {
                                                    console.log('Error fetching transaction details:', error);
                                                }
                                            });
                                        }

                                    </script>

                                    <!-- jQuery and Bootstrap scripts -->
                                    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                                    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
                                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
                                </div>

                            </div>
                        </div>
                    </div>
                    <script>
                                        function closeModal1() {
                                            $('#transactionModal').modal('hide');
                                        }
                                        function closeModal2() {
                                            $('#cardDetailsModal').modal('hide');
                                        }
                    </script>

                    <div class="row justify-content-center mt-3">
                        <div class="col-auto">
                            <button class="btn btn-primary" onclick="goToPreviousPage()">Previous</button>
                        </div>
                        <div class="col-auto">
                            <input type="number" id="pageInput" class="form-control" placeholder="Page number" min="1" max="${totalPages}" value="${currentPage}">
                        </div>
                        <div class="col-auto align-self-center">
                            <span>/ ${totalPages}</span>
                        </div>
                        <div class="col-auto">
                            <button class="btn btn-primary" onclick="goToPage()">Go</button>
                        </div>
                        <div class="col-auto">
                            <button class="btn btn-primary" onclick="goToNextPage()">Next</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function goToPage() {
        var page = $('#pageInput').val();
        var period = new URLSearchParams(window.location.search).get('period') || '';

        var url = 'historytransaction?page=' + page + '&period=' + period;

        if (page >= 1 && page <= ${totalPages}) {
            window.location.href = url;
        } else {
            alert('Please enter a valid page number between 1 and ${totalPages}');
        }
    }

    function goToPreviousPage() {
        var currentPage = ${currentPage};
        var period = new URLSearchParams(window.location.search).get('period') || '';

        var url = 'historytransaction?page=' + (currentPage - 1) + '&period=' + period;

        if (currentPage > 1) {
            window.location.href = url;
        }
    }

    function goToNextPage() {
        var currentPage = ${currentPage};
        var totalPages = ${totalPages};
        var period = new URLSearchParams(window.location.search).get('period') || '';

        var url = 'historytransaction?page=' + (currentPage + 1) + '&period=' + period;

        if (currentPage < totalPages) {
            window.location.href = url;
        }
    }

    function sortTable(n, type) {
        const table = document.getElementById("transactionTable");
        let rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
        switching = true;
        dir = "asc";
        while (switching) {
            switching = false;
            rows = table.rows;
            for (i = 1; i < (rows.length - 1); i++) {
                shouldSwitch = false;
                x = rows[i].getElementsByTagName("TD")[n];
                y = rows[i + 1].getElementsByTagName("TD")[n];
                if (type === 'int') {
                    if (dir === "asc") {
                        if (parseInt(x.innerHTML) > parseInt(y.innerHTML)) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir === "desc") {
                        if (parseInt(x.innerHTML) < parseInt(y.innerHTML)) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                } else if (type === 'string') {
                    if (dir === "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir === "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                } else if (type === 'date') {
                    if (dir === "asc") {
                        if (new Date(x.innerHTML) > new Date(y.innerHTML)) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir === "desc") {
                        if (new Date(x.innerHTML) < new Date(y.innerHTML)) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
            }
            if (shouldSwitch) {
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                switchcount++;
            } else {
                if (switchcount == 0 && dir == "asc") {
                    dir = "desc";
                    switching = true;
                }
            }
        }

        const headers = table.getElementsByTagName("TH");
        for (let j = 0; j < headers.length; j++) {
            headers[j].classList.remove("sorted-asc", "sorted-desc");
        }
        if (dir === "asc") {
            headers[n].classList.add("sorted-asc");
        } else {
            headers[n].classList.add("sorted-desc");
        }
    }
</script>


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

<script src="./plugins/tables/js/jquery.dataTables.min.js"></script>
<script src="./plugins/tables/js/datatable/dataTables.bootstrap4.min.js"></script>
<script src="./plugins/tables/js/datatable-init/datatable-basic.min.js"></script>

</body>

</html>
