<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Account List</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
        <!-- Custom Stylesheet -->
        <link href="./plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link href="css/style_1.css" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <style>
            th {
            background-color: #f2f2f2;
            cursor: pointer; /* Indicate that the header is clickable for sorting */
            white-space: nowrap; /* Prevent text from wrapping */
        }
        /* Optionally, handle overflow if the text is too long */
        th {
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 200px; /* Adjust as needed */
        }

            .wrap-input-17 * {
                box-sizing: border-box;
            }

            .wrap-input-17 .search-box {
                width: fit-content;
                height: fit-content;
                position: relative;
            }

            .wrap-input-17 .input-search {
                height: 50px;
                width: 50px;
                border-style: none;
                padding: 10px;
                font-size: 18px;
                letter-spacing: 2px;
                outline: none;
                border-radius: 25px;
                transition: all .5s ease-in-out;
                background-color: #fff;
                padding-right: 40px;
                color: #000; /* Change this line to make text color black */
            }

            .wrap-input-17 .input-search::placeholder {
                color: rgba(0, 0, 0, .5); /* Change this line to make placeholder color black */
                font-size: 18px;
                letter-spacing: 2px;
                font-weight: 100;
            }

            .wrap-input-17 .btn-search {
                width: 50px;
                height: 50px;
                border-style: none;
                font-size: 20px;
                font-weight: bold;
                outline: none;
                cursor: pointer;
                border-radius: 50%;
                position: absolute;
                right: 0px;
                color: #ffffff;
                background-color: transparent;
                pointer-events: painted;
            }

            .wrap-input-17 .btn-search:focus ~ .input-search {
                width: 300px;
                border-radius: 0px;
                background-color: transparent;
                border-bottom: 1px solid rgba(0, 0, 0, .5); /* Change this line to match placeholder color */
                transition: all 500ms cubic-bezier(0, 0.110, 0.35, 2);
            }

            .wrap-input-17 .input-search:focus {
                width: 300px;
                border-radius: 0px;
                background-color: transparent;
                border-bottom: 1px solid rgba(0, 0, 0, .5); /* Change this line to match placeholder color */
                transition: all 500ms cubic-bezier(0, 0.110, 0.35, 2);
            }
        </style>
        <style>
            th.sortable:hover {
                cursor: pointer;
                text-decoration: underline;
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
                        <c:if test="${role eq 'user'}">
                            <li class="nav-label">Forms</li>
                            <li>
                                <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                                    <i class="icon-note menu-icon"></i><span class="nav-text">My Profile</span>
                                </a>
                                <ul aria-expanded="false">
                                    <li><a href="UpdateProfile">Edit Profile</a></li>
                                </ul>
                            </li>
                        </c:if>
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
                                <li><a href="inventory" aria-expanded="false">Manage Inventory</a></li>
                                <li><a href="category" aria-expanded="false">Manage Category</a></li>
                                <li><a href="historytransaction" aria-expanded="false">Manage History Transaction</a></li>

                                <li><a href="forum" aria-expanded="false">Manage Forum</a></li>

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
                            <li class="breadcrumb-item active"><a href="home.jsp">Home</a></li>
                        </ol>
                    </div>
                </div>
                <!-- row -->
                <script src="https://kit.fontawesome.com/d2d67a5ee7.js" crossorigin="anonymous">
                    function handleButtonClick() {
                        alert('Button clicked!');
                    }

                </script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

                <div class="container-fluid" style="margin-top: 1px">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">

                                <div class="card-body" >
                                    <h4 class="card-title"><a href="ManageAccount">Account List</a></h4>
                                    <form action="ManageAccount" method="get">
                                        <div class="wrap-input-17" style="display: flex; align-items: center;">
                                            <div class="search-box">
                                                <button class="btn-search">🔍</button>
                                                <input type="text" id="searchKeyInput" name="key" class="input-search" placeholder="Type to Search..." value="${param.key}" >
                                            </div>

                                            <input type="hidden" id="orderByInput" name="orderBy" value="${param.orderBy}">

                                            <div class="dropdown" style="margin-left: 10px;">
                                                <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    Order By
                                                </button>
                                                <ul class="dropdown-menu">
                                                    <li><a class="dropdown-item" href="#" onclick="document.getElementById('orderByInput').value = 'userId'; this.closest('form').submit();">User Id</a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="document.getElementById('orderByInput').value = 'username'; this.closest('form').submit();">Username</a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="document.getElementById('orderByInput').value = 'fullName'; this.closest('form').submit();">Full name</a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="document.getElementById('orderByInput').value = 'phoneNumber'; this.closest('form').submit();">Phone Number</a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="document.getElementById('orderByInput').value = 'email'; this.closest('form').submit();">Email</a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="document.getElementById('orderByInput').value = 'creationDate'; this.closest('form').submit();">Creation Date</a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="document.getElementById('orderByInput').value = 'inactive'; this.closest('form').submit();">Inactive</a></li>
                                                    <li><a class="dropdown-item" href="#" onclick="document.getElementById('orderByInput').value = 'active'; this.closest('form').submit();">Active</a></li>
                                                </ul>
                                            </div>


                                        </div>
                                        <c:if test="${not empty totalRecords}">
                                            <div style="color: black; margin-left: auto; margin-right: 10px;">
                                                Total record: ${totalRecords}
                                            </div>
                                        </c:if>
                                    </form>


                                    <table id="resultTable" class="table table-striped table-bordered">
                                        <thead>
                                            <tr>
                                                <th class="sortable" onclick="sortTable(0)">User Id</th>
                                                <th class="sortable" onclick="sortTable(1)">Username</th>
                                                <th class="sortable" onclick="sortTable(2)">Full name</th>
                                                <th class="sortable" onclick="sortTable(3)">Phone Number</th>
                                                <th class="sortable" onclick="sortTable(4)">Email</th>
                                                <th class="sortable" onclick="sortTable(5)">Creation Date</th>
                                                <th class="sortable" onclick="sortTable(6)">Last Login Date</th>
                                                <th class="sortable" onclick="sortTable(7)">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="i" items="${records}">
                                                <tr>
                                                    <td>${i.getUserId()}</td>
                                                    <td>${i.getUsername()}</td>
                                                    <td>${i.getFullname()}</td>
                                                    <td>${i.getPhoneNumber()}</td>
                                                    <td>${i.getEmail()}</td>
                                                    <td>${i.getCreationDate()}</td>
                                                    <td>${i.getLastLoginDate()}</td>
                                                    <td>
                                                        <form action="UpdateStatus" method="post" onsubmit="return confirm('Are you sure you want to ${i.getStatus() eq 'active' ? 'deactivate' : 'activate'} this account?');">
                                                            <input type="hidden" name="id" value="${i.getUserId()}" />
                                                            <input type="hidden" name="newStatus" value="${i.getStatus() eq 'Active' ? 'Inactive' : 'Active'}" />
                                                            <input type="hidden" name="token" value="secureToken123" />
                                                            <button type="submit" class="btn ${i.getStatus() eq 'Active' ? 'btn-success' : 'btn-danger'}">
                                                                ${i.getStatus() eq 'Active' ? 'Active' : 'Inactive'}
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

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

                                    <script>
                                        function sortTable(n) {
                                            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                                            table = document.getElementById("resultTable");
                                            switching = true;
                                            dir = "asc";
                                            while (switching) {
                                                switching = false;
                                                rows = table.rows;
                                                for (i = 1; i < (rows.length - 1); i++) {
                                                    shouldSwitch = false;
                                                    x = rows[i].getElementsByTagName("TD")[n];
                                                    y = rows[i + 1].getElementsByTagName("TD")[n];
                                                    if (dir == "asc") {
                                                        if (n === 0) { // Numeric sort for the first column
                                                            if (parseInt(x.innerHTML) > parseInt(y.innerHTML)) {
                                                                shouldSwitch = true;
                                                                break;
                                                            }
                                                        } else { // Alphabetical sort for other columns
                                                            if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                                                                shouldSwitch = true;
                                                                break;
                                                            }
                                                        }
                                                    } else if (dir == "desc") {
                                                        if (n === 0) { // Numeric sort for the first column
                                                            if (parseInt(x.innerHTML) < parseInt(y.innerHTML)) {
                                                                shouldSwitch = true;
                                                                break;
                                                            }
                                                        } else { // Alphabetical sort for other columns
                                                            if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
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
                                        }

                                        function goToPage() {
                                            var page = $('#pageInput').val();
                                            var key = $('#searchKeyInput').val();
                                            var order = $('#orderByInput').val();
                                            var url = 'ManageAccount?page=' + page;
                                            if (key) {
                                                url += '&key=' + encodeURIComponent(key);
                                            }
                                            if (order) {
                                                url += '&orderBy=' + encodeURIComponent(order);
                                            }
                                            if (page >= 1 && page <= ${totalPages}) {
                                                window.location.href = url;
                                            } else {
                                                alert('Please enter a valid page number between 1 and ${totalPages}');
                                            }
                                        }

                                        function goToPreviousPage() {
                                            var currentPage = ${currentPage};
                                            var key = $('#searchKeyInput').val();
                                            var url = 'ManageAccount?page=' + (currentPage - 1);
                                            var order = $('#orderByInput').val();
                                            if (key) {
                                                url += '&key=' + encodeURIComponent(key);
                                            }
                                            if (order) {
                                                url += '&orderBy=' + encodeURIComponent(order);
                                            }
                                            if (currentPage > 1) {
                                                window.location.href = url;
                                            }
                                        }

                                        function goToNextPage() {
                                            var currentPage = ${currentPage};
                                            var totalPages = ${totalPages};
                                            var key = $('#searchKeyInput').val();
                                            var url = 'ManageAccount?page=' + (currentPage + 1);
                                            var order = $('#orderByInput').val();
                                            if (key) {
                                                url += '&key=' + encodeURIComponent(key);
                                            }
                                            if (order) {
                                                url += '&orderBy=' + encodeURIComponent(order);
                                            }
                                            if (currentPage < totalPages) {
                                                window.location.href = url;
                                            }
                                        }
                                    </script>
                                </div>
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

<script src="./plugins/tables/js/jquery.dataTables.min.js"></script>
<script src="./plugins/tables/js/datatable/dataTables.bootstrap4.min.js"></script>
<script src="./plugins/tables/js/datatable-init/datatable-basic.min.js"></script>

</body>

</html>
