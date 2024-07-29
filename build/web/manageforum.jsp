
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>Forum</title>
        <!-- Favicon icon -->
        <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
        <!-- Custom Stylesheet -->
        <link href="./plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link href="css/style_1.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="css/style.css" rel="stylesheet">
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

                    <h3 class="logo" style="color: white; text-align: center; margin-top: 10%;
                        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol';">
                        OneTech</h3>
                </a>            
            </div>

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
                                <li><a href="manage" aria-expanded="false">Manage Inventory</a></li>
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
                            <li class="breadcrumb-item active"><a href="home">Home</a></li>
                        </ol>
                    </div>
                </div>
                <!-- row -->

                <script>

                    function searchPost() {
                        var searchQuery = document.getElementById("search").value;
                        window.location.href = "forum?search=" + encodeURIComponent(searchQuery);
                    }

                    document.addEventListener("DOMContentLoaded", function () {
                        var urlParams = new URLSearchParams(window.location.search);
                        var searchQuery = urlParams.get('search');
                        if (searchQuery) {
                            document.getElementById("search").value = searchQuery;
                        }
                    });

                    function goToPost() {
                        var status = document.getElementById("post").value;
                        window.location.href = "forum?status=" + status;
                    }

                    function closeModal() {
                        var selectedCategory = document.getElementById("post").value;
                        window.location.href = "post?id=" + selectedCategory;
                    }
                </script>

                <body>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <h4 class="card-title">Manage Forum</h4>
                                        <div class="flex-container">
                                            <div class="header-left">
                                                <label class="card-title" for="post">Status:</label>
                                                <select class="form-control-sm" name="status" id="post" onchange="goToPost()">
                                                    <c:forEach var="p" items="${uniqueStatuses}">
                                                        <option value="${p}" ${param.status != null && param.status.equals(p) ? 'selected' : ''}>${p}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="header-right" style="display: flex; flex-direction: column; align-items: flex-end; margin-bottom: 3px;">
                                                <div class="input-group" style="margin-bottom: 10px;">
                                                    <button style="background-color: green; color: white; height: 45px; margin-right: 10px" type="button" class="btn mb-1 btn-success" data-toggle="modal" data-target="#addPostModal">Add New</button>

                                                    <div class="input-group-prepend">

                                                        <button class="btn btn-primary" onclick="searchPost()"><i class="fa fa-search"></i></button>
                                                    </div>
                                                    <input type="text" class="form-control" id="search" name="search" placeholder="Search" onkeypress="if (event.keyCode === 13)
                                                                searchPost()">
                                                </div>
                                            </div>

                                        </div>

                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Title</th>
                                                        <th>Manage</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="p" items="${listP}">
                                                        <tr>
                                                            <td>${p.id}</td>
                                                            <td>${p.title}</td>                                                          
                                                            <td>
                                                                <a title="Update" data-toggle="modal" data-target="#postModal" 
                                                                   data-id="${p.id}" 
                                                                   data-title="${p.title}" 
                                                                   data-coverimg="${p.coverImg}" 
                                                                   data-img1="${p.img1}" 
                                                                   data-img2="${p.img2}" 
                                                                   data-para1="${p.para1}" 
                                                                   data-para2="${p.para2}" 
                                                                   data-quote="${p.quote}" 
                                                                   data-quoteauthor="${p.quote_author}">
                                                                    <i class="fas fa-edit manage-icon" style="margin-right: 10px; color: blue"></i>
                                                                </a>

                                                                <a>
                                                                    <i class="fas fa-box-open manage-icon" style="color: red"></i>
                                                                </a>


                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>

                                            </table>

                                            <!-- Bootstrap Modal For Update Category -->
                                            <div class="modal fade" id="postModal" tabindex="-1" role="dialog" aria-labelledby="postModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-lg" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="postModalLabel">Update Category</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body" style="max-height: 70vh; overflow-y: auto;">
                                                            <form id="updatePostForm" method="post" action="updatePost">
                                                                <div class="form-group">
                                                                    <label for="post-id" class="col-form-label">ID:</label>
                                                                    <input type="text" class="form-control" id="post-id" name="id" readonly>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-title" class="col-form-label">Title:</label>
                                                                    <input type="text" class="form-control" id="post-title" name="title">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-coverImg" class="col-form-label">Cover Image:</label>
                                                                    <img id="current-coverImg" src="" alt="Current Cover Image" style="display:block; width:100px; height:auto; margin-bottom:10px;">
                                                                    <input type="file" class="form-control" id="post-coverImg" name="coverImg">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-img1" class="col-form-label">Image 1:</label>
                                                                    <img id="current-img1" src="" alt="Current Image 1" style="display:block; width:100px; height:auto; margin-bottom:10px;">
                                                                    <input type="file" class="form-control" id="post-img1" name="img1">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-img2" class="col-form-label">Image 2:</label>
                                                                    <img id="current-img2" src="" alt="Current Image 2" style="display:block; width:100px; height:auto; margin-bottom:10px;">
                                                                    <input type="file" class="form-control" id="post-img2" name="img2">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-para1" class="col-form-label">Paragraph 1:</label>
                                                                    <textarea class="form-control" id="post-para1" name="para1"></textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-para2" class="col-form-label">Paragraph 2:</label>
                                                                    <textarea class="form-control" id="post-para2" name="para2"></textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-quote" class="col-form-label">Quote:</label>
                                                                    <textarea class="form-control" id="post-quote" name="quote"></textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-quote-author" class="col-form-label">Quote Author:</label>
                                                                    <input type="text" class="form-control" id="post-quote-author" name="quote_author">
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

                                            <!-- Bootstrap Modal For Add Post -->
                                            <div class="modal fade" id="addPostModal" tabindex="-1" role="dialog" aria-labelledby="addPostModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-lg" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="addPostModalLabel">Add Post</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body" style="max-height: 70vh; overflow-y: auto;">
                                                            <form id="addPostForm" method="post" action="addPost">
                                                                <div class="form-group">
                                                                    <label for="post-title" class="col-form-label">Title:</label>
                                                                    <input type="text" class="form-control" id="post-title" name="title" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-coverImg" class="col-form-label">Cover Image:</label>
                                                                    <input type="file" class="form-control" id="post-coverImg" name="coverImg" required>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="product-status" class="col-form-label">Image 1:</label>
                                                                    <input type="file" class="form-control" id="post-img1" name="img1">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-img2" class="col-form-label">Image 2:</label>
                                                                    <input type="file" class="form-control" id="post-img2" name="img2">
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-para1" class="col-form-label">Paragraph 1:</label>
                                                                    <textarea class="form-control" id="post-para1" name="para1" required></textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-para2" class="col-form-label">Paragraph 2:</label>
                                                                    <textarea class="form-control" id="post-para2" name="para2"></textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-quote" class="col-form-label">Quote:</label>
                                                                    <textarea class="form-control" id="post-quote" name="quote"></textarea>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label for="post-quote-author" class="col-form-label">Quote Author:</label>
                                                                    <input type="text" class="form-control" id="post-quote-author" name="quote_author">
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
            $('#postModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget); // Button that triggered the modal
                var id = button.data('id'); // Extract info from data-* attributes
                var title = button.data('title');
                var coverImg = button.data('coverimg');
                var img1 = button.data('img1');
                var img2 = button.data('img2');
                var para1 = button.data('para1');
                var para2 = button.data('para2');
                var quote = button.data('quote');
                var quoteAuthor = button.data('quoteauthor');

                var modal = $(this);
                modal.find('.modal-title').text('Update Post');
                modal.find('#post-id').val(id);
                modal.find('#post-title').val(title);
                modal.find('#post-coverImg').val('');
                modal.find('#post-img1').val('');
                modal.find('#post-img2').val('');
                modal.find('#post-para1').val(para1);
                modal.find('#post-para2').val(para2);
                modal.find('#post-quote').val(quote);
                modal.find('#post-quote-author').val(quoteAuthor);

                // Hiển thị ảnh hiện tại
                modal.find('#current-coverImg').attr('src', coverImg);
                modal.find('#current-img1').attr('src', img1);
                modal.find('#current-img2').attr('src', img2);
            });

            // JavaScript để hiển thị ảnh mới khi người dùng chọn file
            document.getElementById('post-coverImg').addEventListener('change', function (event) {
                var output = document.getElementById('current-coverImg');
                output.src = URL.createObjectURL(event.target.files[0]);
                output.onload = function () {
                    URL.revokeObjectURL(output.src) // free memory
                }
            });

            document.getElementById('post-img1').addEventListener('change', function (event) {
                var output = document.getElementById('current-img1');
                output.src = URL.createObjectURL(event.target.files[0]);
                output.onload = function () {
                    URL.revokeObjectURL(output.src) // free memory
                }
            });

            document.getElementById('post-img2').addEventListener('change', function (event) {
                var output = document.getElementById('current-img2');
                output.src = URL.createObjectURL(event.target.files[0]);
                output.onload = function () {
                    URL.revokeObjectURL(output.src) // free memory
                }
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

