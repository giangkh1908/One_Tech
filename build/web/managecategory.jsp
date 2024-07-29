
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Category</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
        <!-- Custom Stylesheet -->
        <link href="./plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link href="css/style_1.css" rel="stylesheet">

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
            <!--            <div class="nav-header">
                                            <div class="brand-logo">
                                                <a href="index.html">
                                                    <b class="logo-abbr"><img src="images/logo.png" alt=""> </b>
                                                    <span class="logo-compact"><img src="./images/logo-compact.png" alt=""></span>
                                                    <span class="brand-title">
                                                        <img src="images/logo-text.png" alt="">
                                                    </span>
                                                </a>
                                            </div>
                        </div>-->
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
                        <li class="nav-label">Manage</li>
                        <li>
                            <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                                <i class="icon-menu menu-icon"></i><span class="nav-text">Table</span>
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
            <head>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
                <style>
                    .manage-icon {
                        margin-right: 10px;
                        transition: transform 0.3s, color 0.3s;
                    }
                    .manage-icon:hover {
                        transform: scale(1.2);
                    }

                </style>
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
            </head>
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

                <script>

                    function searchCategory() {
                        var page = $('#pageInput').val();

                        var status = $('#cat').val();
                        var url = 'category?page=' + page;
                        var searchQuery = document.getElementById("search").value;
                        if (status) {
                            url += '&status=' + encodeURIComponent(status);
                        }

                        if (searchQuery) {
                            url += '&search=' + encodeURIComponent(searchQuery);
                        }

                        window.location.href = url;
                    }

                    document.addEventListener("DOMContentLoaded", function () {
                        var urlParams = new URLSearchParams(window.location.search);
                        var searchQuery = urlParams.get('search');
                        if (searchQuery) {
                            document.getElementById("search").value = searchQuery;
                        }
                    });

                    function goToCategory() {
                        var status = document.getElementById("cat").value;
                        window.location.href = "category?status=" + status;
                    }

                    function closeModal() {
                        var selectedCategory = document.getElementById("cat").value;
                        window.location.href = "manage?id=" + selectedCategory;
                    }
                </script>

                <body>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title"><a href="category">Manage Category</a></h4>
                                        <div class="flex-container">
                                            <div class="header-left" style="margin-right: 10px">
                                                <label class="card-title" for="category">Status:</label>
                                                <select class="form-control-sm" name="status" id="cat" onchange="goToCategory()">
                                                    <c:forEach var="c" items="${uniqueStatuses}">
                                                        <option value="${c}" ${param.status != null && param.status.equals(c) ? 'selected' : ''}>${c}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="header-right" style="display: flex; flex-direction: column; align-items: flex-end; margin-bottom: 3px;">
                                                <div class="input-group" style="margin-bottom: 10px;">
                                                    <button type="button" class="btn mb-1 btn-success" data-toggle="modal" data-target="#addCategoryModal" style="background-color: green; color: white; height: 45px; margin-right: 10px">Add Category</button>
                                                    <div class="input-group-prepend">
                                                        <button class="btn btn-primary" onclick="searchCategory()"><i class="fa fa-search"></i></button>
                                                    </div>
                                                    <input type="text" class="form-control" id="search" name="search" placeholder="Search" onkeypress="if (event.keyCode === 13)
                                                                searchCategory()">
                                                </div>

                                            </div>

                                        </div>

                                        <c:if test="${not empty totalRecords}">

                                            <div style="color: black; margin-right: 10px; margin-top: 15px;">
                                                <b>Total record: ${totalRecords}</b>
                                            </div>

                                        </c:if>
                                        <table class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Manage</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="c" items="${listC}">
                                                    <tr>
                                                        <td>${c.id}</td>
                                                        <td>${c.name}</td>
                                                        <td>
                                                            <a title="Update" data-toggle="modal" data-target="#categoryModal" 
                                                               data-id="${c.id}" data-name="${c.name}">
                                                                <i class="fas fa-edit manage-icon" style="margin-right: 10px; color: blue"></i>
                                                            </a>
                                                            <form style="display: inline-flex" id="archiveCategoryForm" action="archiveCategory" method="post">
                                                                <input type="hidden" name="csrfToken" value="${csrfToken}">
                                                                <input type="hidden" id="archiveCategoryId" name="id" value="">
                                                            </form>

                                                            <form style="display: inline-flex" id="unarchiveCategoryForm" action="unarchiveCategory" method="post">
                                                                <input type="hidden" name="csrfToken" value="${csrfToken}">
                                                                <input type="hidden" id="unarchiveCategoryId" name="id" value="">
                                                            </form>

                                                            <c:choose>
                                                                <c:when test="${c.status == 'Archived'}">
                                                                    <a href="#" title="Unarchive" onclick="confirmUnarchiveCategory('${c.id}', 'Are you sure you want to unarchive this item?');">
                                                                        <i class="fas fa-box-open manage-icon" style="color: green"></i>
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="#" title="Archive" onclick="confirmArchiveCategory('${c.id}', 'Are you sure you want to archive this item?');">
                                                                        <i class="fas fa-archive manage-icon" style="color: red"></i>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <script type="text/javascript">
                                                                function confirmArchiveCategory(id, message) {
                                                                    if (confirm(message)) {
                                                                        document.getElementById('archiveCategoryId').value = id;
                                                                        document.getElementById('archiveCategoryForm').submit();
                                                                    }
                                                                }

                                                                function confirmUnarchiveCategory(id, message) {
                                                                    if (confirm(message)) {
                                                                        document.getElementById('unarchiveCategoryId').value = id;
                                                                        document.getElementById('unarchiveCategoryForm').submit();
                                                                    }
                                                                }
                                                            </script>

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
//                                        function sortTable(n) {
//                                            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
//                                            table = document.getElementById("resultTable");
//                                            switching = true;
//                                            dir = "asc";
//                                            while (switching) {
//                                                switching = false;
//                                                rows = table.rows;
//                                                for (i = 1; i < (rows.length - 1); i++) {
//                                                    shouldSwitch = false;
//                                                    x = rows[i].getElementsByTagName("TD")[n];
//                                                    y = rows[i + 1].getElementsByTagName("TD")[n];
//                                                    if (dir == "asc") {
//                                                        if (n === 0) { // Numeric sort for the first column
//                                                            if (parseInt(x.innerHTML) > parseInt(y.innerHTML)) {
//                                                                shouldSwitch = true;
//                                                                break;
//                                                            }
//                                                        } else { // Alphabetical sort for other columns
//                                                            if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
//                                                                shouldSwitch = true;
//                                                                break;
//                                                            }
//                                                        }
//                                                    } else if (dir == "desc") {
//                                                        if (n === 0) { // Numeric sort for the first column
//                                                            if (parseInt(x.innerHTML) < parseInt(y.innerHTML)) {
//                                                                shouldSwitch = true;
//                                                                break;
//                                                            }
//                                                        } else { // Alphabetical sort for other columns
//                                                            if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
//                                                                shouldSwitch = true;
//                                                                break;
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                                if (shouldSwitch) {
//                                                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
//                                                    switching = true;
//                                                    switchcount++;
//                                                } else {
//                                                    if (switchcount == 0 && dir == "asc") {
//                                                        dir = "desc";
//                                                        switching = true;
//                                                    }
//                                                }
//                                            }
//                                        }

                                            function goToPage() {
                                                var page = $('#pageInput').val();
                                                var key = $('#search').val();
                                                var status = $('#cat').val();
                                                var url = 'category?page=' + page;
                                                if (status) {
                                                    url += '&status=' + encodeURIComponent(status);
                                                }
                                                if (key) {
                                                    url += '&search=' + encodeURIComponent(key);
                                                }

                                                if (page >= 1 && page <= ${totalPages}) {
                                                    window.location.href = url;
                                                } else {
                                                    alert('Please enter a valid page number between 1 and ${totalPages}');
                                                }
                                            }

                                            function goToPreviousPage() {
                                                var currentPage = ${currentPage};
                                                var key = $('#search').val();
                                                var url = 'category?page=' + (currentPage - 1);
                                                var status = $('#cat').val();
                                                if (status) {
                                                    url += '&status=' + encodeURIComponent(status);
                                                }
                                                if (key) {
                                                    url += '&search=' + encodeURIComponent(key);
                                                }

                                                if (currentPage > 1) {
                                                    window.location.href = url;
                                                }
                                            }

                                            function goToNextPage() {
                                                var currentPage = ${currentPage};
                                                var totalPages = ${totalPages};
                                                var key = $('#search').val();
                                                var url = 'category?page=' + (currentPage + 1);
                                                var status = $('#cat').val();
                                                if (status) {
                                                    url += '&status=' + encodeURIComponent(status);
                                                }
                                                if (key) {
                                                    url += '&search=' + encodeURIComponent(key);
                                                }

                                                if (currentPage < totalPages) {
                                                    window.location.href = url;
                                                }
                                            }
                                        </script>

                                        <!-- Bootstrap Modal For Update Category -->
                                        <div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="categoryModalLabel">Update Category</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body" style="max-height: 70vh; overflow-y: auto;">
                                                        <form id="updateCategoryForm" method="post" action="updateCategory">
                                                            <div class="form-group">
                                                                <label for="category-id" class="col-form-label">ID:</label>
                                                                <input type="text" class="form-control" id="category-id" name="id" readonly>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="category-name" class="col-form-label">Name:</label>
                                                                <input type="text" class="form-control" id="category-name" name="name">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-primary">Update</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Bootstrap Modal For Add Category -->
                                        <div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="addCategoryModalLabel">Add Category</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body" style="max-height: 70vh; overflow-y: auto;">
                                                        <form id="addCategoryForm" method="post" action="addCategory">
                                                            <div class="form-group">
                                                                <label for="new-category-name" class="col-form-label">Name:</label>
                                                                <input type="text" class="form-control" id="new-category-name" name="name">
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                <button type="submit" class="btn btn-primary">Add</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
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
                    <!--                    <p>Copyright &copy; Designed & Developed by <a href="https://themeforest.net/user/quixlab">Quixlab</a> 2018</p>-->
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
        <script>
            $('#categoryModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); // Button that triggered the modal
                var id = button.data('id'); // Extract info from data-* attributes
                var name = button.data('name');

                var modal = $(this);
                modal.find('.modal-title').text('Update Category');
                modal.find('#category-id').val(id);
                modal.find('#category-name').val(name);
            });
        </script>
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
