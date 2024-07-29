<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">


    <head>
        <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
        <title>Shop</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/shop_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/shop_responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <style>
            .shop_sidebar {
                text-align: left;
                width: 186px;
                background: #ffffff;
            }

            .sidebar_section {
                padding: 0;

            }

            .sidebar_section .sidebar_title {
                font-weight: bold;
                font-size: 30px;
                color: #85C9DE;
                margin-bottom: 10px;

            }

            .sidebar_section .sidebar_title1 {
                font-weight: bold;
                font-size: 24px;
                color: #000;
                display: block;
                padding: 6px 0;
                border-bottom: 1px dashed #ddd;
                margin-bottom: 10px;
            }

            /* Add hover state */
            .sidebar_title1:hover {
                background-color: #85C9DE;
                color: #FFFFFF;
                text-decoration: none;
            }

            /* Add active state */
            .sidebar_title1.active {
                background-color: #85C9DE;
                color: #FFFFFF;
                text-decoration: none;
            }

            .sidebar_section .sidebar_subtitle {
                font-weight: bold; /* Set to bold */
                font-size: 24px; /* Increased font size */
                margin-bottom: 10px;
                border-bottom: 1px solid #ddd; /* Added underline */
                padding-bottom: 5px; /* Added padding for space between text and underline */
            }

            .sidebar_categories {
                list-style: none;
                margin: 0;
                padding: 0;
            }

            .sidebar_categories li {
                text-indent: 15px;
                border-bottom: 1px dashed #ddd;
                padding: 2px 0;
            }

            .sidebar_categories li a {
                border-bottom: 1px dashed #ddd;
                padding: 6px 0;
                display: block;
                font-weight: bold;
                font-size: 20px; /* Increased font size */
            }

            .sidebar_categories li a:hover {
                background-color: #85C9DE;
                color: #FFFFFF;
                text-decoration: none;
            }

            .sidebar_categories li a.active {
                background-color: #85C9DE;
                color: #FFFFFF;
                text-decoration: none;
            }

            .sidebar_categories ul {
                padding: 0px;
            }

            .sidebar_categories ul li {
                text-indent: 10px;
            }

            .sidebar_categories ul li a {
                font-weight: normal;
                font-size: 18px; /* Increased font size */
            }


            .disabled {
                pointer-events: none;
                opacity: 0.5;
            }

            .page_nav a.active {
                font-weight: bold;
                color: white;
                background-color: #007bff;
                border-radius: 4px;
                padding: 0.2em 0.5em;
            }

            .product-card {
                margin-bottom: 15px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
                transition: 0.3s;
            }

            .product-card:hover {
                box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
            }

            .product_image img {
                width: 100%;
                height: auto;
            }

            .product-info {
                padding: 15px;
            }

            .product_price {
                font-size: 16px;
                font-weight: 500;
                margin-top: 10px;
            }

            .product_name {
                margin-top: 5px;
            }

            .name_cart_container {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .name_cart_container a {
                font-size: 14px;
                color: #000;
                text-decoration: none;
            }

            .name_cart_container a:hover {
                color: #0e8ce4;
            }

            .cart_icon i {
                margin-right: 5px;
            }

            .cart_icon a {
                font-size: 14px;
                color: #000;
                text-decoration: none;
            }

            .cart_icon a:hover {
                color: #0e8ce4;
            }

            .page-link {
                padding: 8px 12px; /* Điều chỉnh padding để tạo khoảng cách xung quanh nội dung */
                margin: 0 5px; /* Khoảng cách giữa các nút phân trang */
                color: #007bff; /* Màu chữ mặc định */
                text-decoration: none; /* Bỏ gạch chân mặc định */
                border: 1px solid #007bff; /* Viền xung quanh */
                border-radius: 5px; /* Bo góc */
            }

            .sidebar_title2:hover {
                background-color: #85C9DE;
                color: #FFFFFF;
                text-decoration: none;
            }

            /* Add active state */
            .sidebar_title2.active {
                background-color: #85C9DE;
                color: #FFFFFF;
                text-decoration: none;
            }



        </style>

    </head>

    <body>

        <div class="super_container">

            <!-- Header -->

            <header class="header">

                <!-- Top Bar -->
                <jsp:include page="menu.jsp"></jsp:include>

                    <!-- Header Main -->

                    <div class="header_main">
                        <div class="container">
                            <div class="row">

                                <!-- Logo -->
                                <div class="col-lg-2 col-sm-3 col-3 order-1">
                                    <div class="logo_container">
                                        <div class="logo"><a href="home">OneTech</a></div>
                                    </div>
                                </div>

                                <!-- Search -->
                                <div class="col-lg-6 col-12 order-lg-2 order-3 text-lg-left text-right">
                                    <div class="header_search">
                                        <div class="header_search_content">
                                            <div class="header_search_form_container">
                                                <form action="#" class="header_search_form clearfix">
                                                    <input type="search" required="required" class="header_search_input" placeholder="Search for products...">
                                                    <button type="submit" class="header_search_button trans_300" value="Submit"><img src="images/search.png" alt=""></button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Wishlist -->
                                <div class="col-lg-4 col-9 order-lg-3 order-2 text-lg-left text-right">
                                    <div class="wishlist_cart d-flex flex-row align-items-center justify-content-end">
                                        <!-- Cart -->
                                        <div class="cart">
                                            <div class="cart_container d-flex flex-row align-items-center justify-content-end">
                                                <div class="cart_icon">
                                                    <img src="images/cart.png" alt="">
                                                    <div class="cart_count" id="cartItemCount"><span>0</span></div>
                                                </div>
                                                <div class="cart_content">
                                                    <div class="cart_text"><a href="GetListCartByUserId">Cart</a></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Main Navigation -->
                    <nav class="main_nav">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="main_nav_content d-flex flex-row">
                                        <div class="main_nav_menu m2-auto" style="margin-left: 300px">
                                            <ul class="standard_dropdown main_nav_dropdown">
                                                <li><a href="home">Home<i class="fas fa-chevron-down"></i></a></li>
                                                <li class="hassubs">
                                                    <a href="#">Super Deals<i class="fas fa-chevron-down"></i></a>
                                                    <ul>

                                                        <li><a href="superdeals?categoryID=3">VCoin<i class="fas fa-chevron-down"></i></a></li>
                                                        <li><a href="superdeals?categoryID=8">Vinaphone<i class="fas fa-chevron-down"></i></a></li>
                                                        <li><a href="superdeals?categoryID=5">GATE<i class="fas fa-chevron-down"></i></a></li>
                                                    </ul>
                                                </li>

                                                <li><a href="shop">Shop<i class="fas fa-chevron-down"></i></a></li>
                                                <li><a href="post">Forum<i class="fas fa-chevron-down"></i></a></li>
                                                <li><a href="ContactEmailControl">Contact<i class="fas fa-chevron-down"></i></a></li>
                                                <li class="hassubs">
                                                    <a href="#">Policy<i class="fas fa-chevron-down"></i></a>
                                                    <ul>

                                                        <li><a href="TermOfUse.html">Term of use<i class="fas fa-chevron-down"></i></a></li>
                                                        <li><a href="PrivacyPolicy.html">Privacy Policy<i class="fas fa-chevron-down"></i></a></li>
                                                        <li><a href="SalePolicy.html">Sale Policy<i class="fas fa-chevron-down"></i></a></li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </nav>

                    <!-- Menu -->


                </header>

                <!-- Home -->

                <!--                <div class="home">
                                    <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/shop_background.jpg"></div>
                                    <div class="home_overlay"></div>
                                    <div class="home_content d-flex flex-column align-items-center justify-content-center">
                                        <h2 class="home_title">Card & Vouchers</h2>
                                    </div>
                                </div>-->

                <!-- Shop -->
            <c:set var="currentCid" value="${param.cid}" />
            <c:set var="currentSort" value="${param.sort_by}" />
            <c:set var="page" value="${param.index != null ? param.index : 1}" />

            <div class="shop">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3">
                            <!-- Shop Sidebar -->
                            <div class="shop_sidebar">
                                <div class="sidebar_section">
                                    <div class="sidebar_title">BRAND</div>
                                    <div class="sidebar_title"><a class="sidebar_title1 ${empty param.cid ? 'active' : ''}" href="shop.jsp">ALL BRAND</a></div>
                                    <div class="sidebar_subtitle" >CARD</div>
                                    <ul class="sidebar_categories" id="categoryList">
                                        <c:forEach items="${requestScope.listC}" var="category">
                                            <a class="nav-link ${currentCid == category.id ? 'active' : ''}" href="shop?cid=${category.id}">${category.name}</a>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <!-- Shop Content -->
                            <div class="shop_content">
                                <div class="shop_bar clearfix">
                                    <div class="shop_product_count"><span>${productCount}</span> products found</div>
                                    <form class="shop_sorting">
                                        <span>Sort by:</span>
                                        <select name="sort_by" id="sort_by" onchange="loadPage(1, '${param.cid}', this.value)">
                                            <option value="ASC" ${param.sort_by == 'ASC' ? 'selected' : ''}>Price Ascending</option>
                                            <option value="DESC" ${param.sort_by == 'DESC' ? 'selected' : ''}>Price Descending</option>
                                            <option value="Name" ${param.sort_by == 'Name' ? 'selected' : ''}>Card Name</option>
                                        </select>
                                    </form>
                                </div>
                                <div class="row" id="productList">
                                    <c:forEach items="${requestScope.listP}" var="p">
                                        <div class="col-md-3">
                                            <!-- Product Item -->
                                            <div class="product">
                                                <div class="product-card">
                                                    <a href="detail?id=${p.id}">
                                                        <div class="product_image d-flex flex-column align-items-center justify-content-center">
                                                            <img src="${p.image}" alt="Product Image">
                                                        </div>
                                                    </a>
                                                    <div class="product-info">
                                                        <div class="product_price">



                                                            <h4>${p.formattedPrice}</h4>

                                                        </div>
                                                        <div class="product_name">
                                                            <div class="name_cart_container d-flex justify-content-between align-items-center">
                                                                <h4>Add To Cart</h4>
                                                                <p class="cart_icon">
                                                                    <a href="javascript:void(0)">
                                                                        <i class="fas fa-shopping-cart"></i>
                                                                    </a>
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="row justify-content-center mt-3">
                                    <div class="col-auto">
                                        <button class="btn btn-primary" onclick="goToPreviousPage()">Previous</button>
                                    </div>
                                    <div class="col-auto">
                                        <input type="number" id="pageInput" class="form-control" placeholder="Page number" min="1" value="1">
                                    </div>
                                    <div class="col-auto align-self-center">
                                        <span id="endPage">/ ${endPage}</span>
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








                <!-- Footer -->

                <footer class="footer">
                    <div class="container">
                        <div class="row">

                            <div class="col-lg-3 footer_col">
                                <div class="footer_column footer_contact">
                                    <div class="logo_container">
                                        <div class="logo"><a href="home">OneTech</a></div>
                                    </div>
                                    <div class="footer_title">Got Question? Call Us 24/7</div>
                                    <div class="footer_phone"></div>
                                    <div class="footer_contact_text">
                                        <p>FPT University </p>
                                        <p>Hanoi, Vietnam</p>
                                    </div>
                                    <div class="footer_social">
                                        <ul>
                                            <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                                            <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                            <li><a href="#"><i class="fab fa-youtube"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-2 offset-lg-2">


                            </div>

                            <div class="col-lg-2">

                            </div>

                            <div class="col-lg-2">
                                <div class="footer_column">
                                    <div class="footer_title">Customer Care</div>
                                    <ul class="footer_list">
                                        <li><a href="#">Customer Services</a></li>
                                        <li><a href="#">Returns / Exchange</a></li>
                                        <li><a href="#">FAQs</a></li>
                                        <li><a href="#">Product Support</a></li>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                </footer>


            </div>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

            <script>
                                            $(document).ready(function () {
                                                // Load page on initial load
                                                loadPage(${page}, '${currentCid}', '${currentSort}');
                                            });

                                            function loadPage(page, cid, sort_by) {
                                                $.ajax({
                                                    url: '/ISP392_Group1/data', // URL to DataServlet
                                                    type: 'GET',
                                                    data: {
                                                        index: page,
                                                        cid: cid,
                                                        sort_by: sort_by
                                                    },
                                                    success: function (response) {
                                                        $('#productList').empty(); // Clear existing product list

                                                        // Loop through each product in the response and construct HTML
                                                        $.each(response.listP, function (index, product) {
                                                            var productHtml =
                                                                    '<div class="col-md-3">' +
                                                                    '<div class="product">' +
                                                                    '<div class="product-card">' +
                                                                    '<a href="detail?id=' + product.id + '">' +
                                                                    '<div class="product_image d-flex flex-column align-items-center justify-content-center">' +
                                                                    '<img src="' + product.image + '" alt="Product Image">' +
                                                                    '</div>' +
                                                                    '</a>' +
                                                                    '<div class="product-info">' +
                                                                    '<div class="product_price">' +
                                                                    '<h4>' + product.formattedPrice + '</h4>' +
                                                                    '</div>' +
                                                                    '<div class="product_name">' +
                                                                    '<div class="name_cart_container d-flex justify-content-between align-items-center">' +
                                                                    '<h4>Add To Cart</h4>' +
                                                                    '<p class="cart_icon">' +
                                                                    '<a href="javascript:void(0)" class="add-to-cart-btn" data-product-id="' + product.id + '" data-quantity="' + product.quantity + '">' +
                                                                    '<i class="fas fa-shopping-cart"></i>' +
                                                                    '</a>' +
                                                                    '</p>' +
                                                                    '</div>' +
                                                                    '</div>' +
                                                                    '</div>' +
                                                                    '</div>' +
                                                                    '</div>';
                                                            $('#productList').append(productHtml); // Append each product HTML to productList
                                                        });

                                                        function updateCartItemCount() {
                                                            $.ajax({
                                                                url: '/ISP392_Group1/CartControl?action=getCartItemCount',
                                                                type: 'GET',
                                                                success: function (data) {
                                                                    $('#cartItemCount span').text(data); // Update cart item count
                                                                },
                                                                error: function () {
                                                                    console.log("Error fetching cart item count.");
                                                                }
                                                            });
                                                        }

                                                        updateCartItemCount();

                                                        $('.add-to-cart-btn').on('click', function () {
                                                            var productId = $(this).data('product-id');
                                                            var quantity = $(this).data('quantity');

                                                            $.ajax({
                                                                url: '/ISP392_Group1/CartControl?action=addToCart',
                                                                type: 'POST',
                                                                data: {
                                                                    productId: productId,
                                                                    sourcePage: 'shop',
                                                                    quantity: quantity
                                                                },
                                                                success: function (data, textStatus, jqXHR) {
                                                                    if (jqXHR.status === 200) {
                                                                        Swal.fire({
                                                                            icon: 'success',
                                                                            title: 'Success',
                                                                            text: 'Product added to cart successfully!',
                                                                            timer: 1000,
                                                                            timerProgressBar: true,
                                                                            showConfirmButton: false,
                                                                            position: 'top-end',
                                                                            toast: true,
                                                                            didOpen: (toast) => {
                                                                                toast.onmouseenter = Swal.stopTimer;
                                                                                toast.onmouseleave = Swal.resumeTimer;
                                                                            },
                                                                            didClose: () => {
                                                                                removeCartSuccessFlag(); // Remove the flag after the toast is closed
                                                                            }
                                                                        });
                                                                        updateCartItemCount();
                                                                    } else {
                                                                        Swal.fire({
                                                                            icon: 'error',
                                                                            title: 'Error',
                                                                            text: 'Error adding product to cart: ' + jqXHR.statusText,
                                                                            timer: 1000,
                                                                            timerProgressBar: true,
                                                                            showConfirmButton: false,
                                                                            position: 'top-end',
                                                                            toast: true,
                                                                            didOpen: (toast) => {
                                                                                toast.onmouseenter = Swal.stopTimer;
                                                                                toast.onmouseleave = Swal.resumeTimer;
                                                                            },
                                                                            didClose: () => {
                                                                                removeCartSuccessFlag(); // Remove the flag after the toast is closed
                                                                            }
                                                                        });
                                                                    }
                                                                },
                                                                error: function (jqXHR, textStatus, errorThrown) {
                                                                    if (jqXHR.status === 400) {
                                                                        Swal.fire({
                                                                            icon: 'warning',
                                                                            title: 'Out of Stock',
                                                                            text: 'This product is out of stock.',
                                                                            timer: 1000,
                                                                            timerProgressBar: true,
                                                                            showConfirmButton: false,
                                                                            position: 'top-end',
                                                                            toast: true,
                                                                            didOpen: (toast) => {
                                                                                toast.onmouseenter = Swal.stopTimer;
                                                                                toast.onmouseleave = Swal.resumeTimer;
                                                                            },
                                                                            didClose: () => {
                                                                                removeCartSuccessFlag(); // Remove the flag after the toast is closed
                                                                            }
                                                                        });
                                                                        var productButton = $('a[data-product-id="' + productId + '"]');
                                                                        productButton.addClass('disabled');
                                                                        productButton.find('.fa-shopping-cart').removeClass('fa-shopping-cart').addClass('fa-ban');
                                                                    }
                                                                    if (jqXHR.status === 401) {
                                                                        alert('You must be logged in to add products to cart.');
                                                                        window.location.href = 'login.jsp';
                                                                    } else {
                                                                        Swal.fire({
                                                                            icon: 'warning',
                                                                            title: 'Out of Stock',
                                                                            text: 'This product is out of stock.',
                                                                            timer: 1000,
                                                                            timerProgressBar: true,
                                                                            showConfirmButton: false,
                                                                            position: 'top-end',
                                                                            toast: true,
                                                                            didOpen: (toast) => {
                                                                                toast.onmouseenter = Swal.stopTimer;
                                                                                toast.onmouseleave = Swal.resumeTimer;
                                                                            },
                                                                            didClose: () => {
                                                                                removeCartSuccessFlag(); // Remove the flag after the toast is closed
                                                                            }
                                                                        });
                                                                    }
                                                                }
                                                            });
                                                        });

                                                        // Update product count, current page, and end page indicators
                                                        $('#productCount').text(response.productCount);
                                                        $('#endPage').text('/ ' + response.endPage);
                                                        $('#pageInput').val(response.page); // Update current page input value
                                                    },
                                                    error: function (xhr, status, error) {
                                                        console.error('Error loading products:', error);
                                                    }
                                                });
                                            }




                                            function goToPage() {
                                                var page = $('#pageInput').val();
                                                var sort_by = $('#sort_by').val();
                                                if (page >= 1) {
                                                    loadPage(page, '${param.cid}', sort_by);
                                                } else {
                                                    alert('Please enter a valid page number.');
                                                }
                                            }

                                            function goToPreviousPage() {
                                                var currentPage = parseInt($('#pageInput').val());
                                                var sort_by = $('#sort_by').val();
                                                if (currentPage > 1) {
                                                    var previousPage = currentPage - 1;
                                                    loadPage(previousPage, '${param.cid}', sort_by);
                                                }
                                            }

                                            function goToNextPage() {
                                                var currentPage = parseInt($('#pageInput').val());
                                                var endPage = parseInt($('#endPage').text().split(' ')[1]);
                                                var sort_by = $('#sort_by').val();
                                                if (currentPage < endPage) {
                                                    var nextPage = currentPage + 1;
                                                    loadPage(nextPage, '${param.cid}', sort_by);
                                                }
                                            }
            </script>
            <script>
                function removeCartSuccessFlag() {
                    fetch('removeCartSuccessFlag').then(response => {
                        if (!response.ok) {
                            console.error('Failed to remove cartSuccess flag');
                        }
                    });
                }
            </script>

            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
            <script src="js/jquery-3.3.1.min.js"></script>
            <script src="styles/bootstrap4/popper.js"></script>
            <script src="styles/bootstrap4/bootstrap.min.js"></script>
            <script src="plugins/greensock/TweenMax.min.js"></script>
            <script src="plugins/greensock/TimelineMax.min.js"></script>
            <script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
            <script src="plugins/greensock/animation.gsap.min.js"></script>
            <script src="plugins/greensock/ScrollToPlugin.min.js"></script>
            <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
            <script src="plugins/easing/easing.js"></script>
            <script src="plugins/Isotope/isotope.pkgd.min.js"></script>
            <script src="plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
            <script src="plugins/parallax-js-master/parallax.min.js"></script>
            <script src="js/shop_custom.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>

</html>
