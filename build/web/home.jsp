<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <head>
        <title>Homepage</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link rel="stylesheet" type="text/css" href="plugins/slick-1.8.0/slick.css">
        <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" />
        <style>
            #search-results {
                display: none;
            }
        </style>
        <c:if test="${sessionScope.accIsNull == true}">
            <style>
                /* The Modal (background) */
                .modal {
                    display: block; /* Hidden by default */

                    position: fixed; /* Stay in place */
                    z-index: 1; /* Sit on top */
                    left: 0;
                    top: 0;
                    width: 100%; /* Full width */
                    height: 100%; /* Full height */
                    overflow: auto; /* Enable scroll if needed */
                    background-color: rgb(0,0,0); /* Fallback color */
                    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
                    padding-top: 60px;
                }

                /* Modal Content/Box */
                .modal-content {
                    background-color: #fefefe;

                    margin: 5% auto; /* 15% from the top and centered */
                    padding: 20px;
                    border: 1px solid #888;
                    width: 35%; /* Could be more or less, depending on screen size */
                }

                /* The Close Button */
                .close {
                    color: #aaa;
                    float: right;
                    font-size: 28px;
                    font-weight: bold;
                }

                .close:hover,
                .close:focus {
                    color: black;
                    text-decoration: none;
                    cursor: pointer;
                }
            </style>
        </c:if>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


        <!-- The Modal -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <p>You must be logged in to add products to cart. <a href="login.jsp">Click here to log in</a></p>
        </div>
    </div>

    <script>
        function showModal() {
            var modal = document.getElementById("myModal");
            var span = document.getElementsByClassName("close")[0];

            modal.style.display = "block";

            span.onclick = function () {
                modal.style.display = "none";
            }

            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        }
    </script>

    <c:if test="${sessionScope.accIsNull == true}">
        <script>
            <c:if test="${sessionScope.accIsNull == true}">
            showModal();
            </c:if>
            removeCartSuccessFlag();
            function removeCartSuccessFlag() {
                fetch('removeCartSuccessFlag').then(response => {
                    if (!response.ok) {
                        console.error('Failed to remove cartSuccess flag');
                    }
                });
            }
        </script>
    </c:if>


</head>

<body>
    <% 
        Boolean cartSuccess = (Boolean) session.getAttribute("cartSuccess");
        Boolean accIsNull = (Boolean) session.getAttribute("accIsNull");
        System.out.println("acc == null in jsp" + accIsNull);
        // Do not remove the session attribute here
    %>

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
                                    <div class="logo"style="top: 50%"><a href="home">OneTech</a></div>
                                </div>
                            </div>

                            <!-- Search -->
                            <div class="col-lg-6 col-12 order-lg-2 order-3 text-lg-left text-right">
                                <div class="header_search">
                                    <div class="header_search_content">
                                        <div class="header_search_form_container">
                                            <form action="search" method="post" class="header_search_form clearfix">
                                                <input name="txt" type="text" required="required" class="header_search_input" placeholder="Search for products...">
                                                <div class="custom_dropdown">
                                                    <div class="custom_dropdown_list">
                                                        <span class="custom_dropdown_placeholder clc">All Categories</span>
                                                        <i class="fas fa-chevron-down"></i>
                                                        <ul class="custom_list clc">
                                                        <c:forEach items="${listC}" var="o">
                                                            <li><a class="clc" href="#">${o.name}</a></li>
                                                            </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>
                                            <button type="submit" class="header_search_button trans_300" value="Submit"><img src="images/search.png" alt=""></button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Wishlist -->
                        <div class="col-lg-4 col-9 order-lg-3 order-2 text-lg-left text-right">
                            <div class="wishlist_cart d-flex flex-row align-items-center justify-content-end">
                                <%
                                String user = (String) session.getAttribute("user");

                                %>

                                <!-- Cart -->
                                <%
                                if (user != null) {
                                %>
                                <div class="cart">
                                    <div class="cart_container d-flex flex-row align-items-center justify-content-end">
                                        <div class="cart_icon">
                                            <img src="images/cart.png" alt="">
                                            <div class="cart_count"><span>${requestScope.quantity}</span></div>
                                        </div>
                                        <div class="cart_content">
                                            <div class="cart_text"><a href="GetListCartByUserId">Cart</a></div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    } else {
                                %>
                                <div class="cart">
                                    <div class="cart_container d-flex flex-row align-items-center justify-content-end">
                                        <div class="cart_icon">
                                            <a href="login.jsp"><img src="images/cart2.png" alt=""></a>
                                        </div>
                                        <div class="cart_content">
                                            <div class="cart_text"><a href="login.jsp">Cart</a></div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
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

                                <!-- Categories Menu -->

                                <div class="cat_menu_container">
                                    <div class="cat_menu_title d-flex flex-row align-items-center justify-content-start">
                                        <div class="cat_burger"><span></span><span></span><span></span></div>
                                        <div class="cat_menu_text">categories</div>
                                    </div>

                                    <ul class="cat_menu">
                                        <c:forEach items="${listC}" var="o">
                                            <li><a class="clc" href="shop?cid=${o.id}&sort_by=">${o.name}</a></li>
                                            </c:forEach>
                                    </ul>
                                </div>

                                <!-- Main Nav Menu -->

                                <div class="main_nav_menu ml-auto">
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

                                <!-- Menu Trigger -->

                                <div class="menu_trigger_container ml-auto">
                                    <div class="menu_trigger d-flex flex-row align-items-center justify-content-end">
                                        <div class="menu_burger">
                                            <div class="menu_trigger_text">menu</div>
                                            <div class="cat_burger menu_burger_inner"><span></span><span></span><span></span></div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- Menu -->


        </header>


        <!-- Banner -->

        <div class="banner">
            <div class="banner_background" style="background-image:url(images/banner_background.jpg)"></div>
            <div class="container fill_height">
                <div class="row fill_height">
                    <div class="banner_product_image"><img src="images/banner1.png" height="300" width="auto" style="vertical-align:middle;margin:40px -10px;" alt=""></div>
                    <div class="col-lg-6 offset-lg-3 fill_height">

                        <div class="logo_container">
                            <div class="logo" style="top: 100%;text-align: center;"><a href="#" style="font-size: 95px;">OneTech</a></div>
                        </div>
                        <div class="logo_container">

                        </div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Characteristics -->

        <div class="characteristics">
            <div class="container">
                <div class="row">

                    <!-- Char. Item -->
                    <div class="col-lg-3 col-md-6 char_col">

                        <div class="char_item d-flex flex-row align-items-center justify-content-start">
                            <div class="char_icon"><img src="images/char_1.png" alt=""></div>
                            <div class="char_content">
                                <div class="char_title">Instant Purchase</div>
                                <div class="char_subtitle">For Cards & Vouchers</div>
                            </div>
                        </div>
                    </div>

                    <!-- Char. Item -->
                    <div class="col-lg-3 col-md-6 char_col">

                        <div class="char_item d-flex flex-row align-items-center justify-content-start">
                            <div class="char_icon"><img src="images/char_2.png" alt=""></div>
                            <div class="char_content">
                                <div class="char_title">Quick Restock</div>
                                <div class="char_subtitle">Refreshes everyday</div>
                            </div>
                        </div>
                    </div>

                    <!-- Char. Item -->
                    <div class="col-lg-3 col-md-6 char_col">

                        <div class="char_item d-flex flex-row align-items-center justify-content-start">
                            <div class="char_icon"><img src="images/char_3.png" alt=""></div>
                            <div class="char_content">
                                <div class="char_title">Coupon Wallet</div>
                                <div class="char_subtitle">Applies to purchases</div>
                            </div>
                        </div>
                    </div>

                    <!-- Char. Item -->
                    <div class="col-lg-3 col-md-6 char_col">

                        <div class="char_item d-flex flex-row align-items-center justify-content-start">
                            <div class="char_icon"><img src="images/char_4.png" alt=""></div>
                            <div class="char_content">
                                <div class="char_title">Discounts</div>
                                <div class="char_subtitle">Site-wide</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Deals of the week -->

        <div class="viewed">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="viewed_title_container">
                            <h3 class="viewed_title">Search Results</h3>
                            <div class="viewed_nav_container">
                                <div class="viewed_nav viewed_prev"><i class="fas fa-chevron-left"></i></div>
                                <div class="viewed_nav viewed_next"><i class="fas fa-chevron-right"></i></div>
                            </div>
                        </div>

                        <div class="viewed_slider_container">

                            <!-- Recently Viewed Slider -->

                            <div class="owl-carousel owl-theme viewed_slider">

                                <!-- Recently Viewed Item -->
                                <c:forEach items="${listSearch}" var="o">
                                    <div class="owl-item">
                                        <div class="viewed_item discount d-flex flex-column align-items-center justify-content-center text-center">
                                            <div class="viewed_image d-flex flex-column align-items-center justify-content-center"><a href="detail?id=${o.id}"><img src="${o.image}" style="vertical-align:middle" alt=""></a></div>
                                            <div class="viewed_content text-center">
                                                <div class="product_price"><a href="detail?id=${o.id}">${o.getPercentDiscount()}</a></div>
                                                <div class="product_name"><div><a href="detail?id=${o.id}">${o.name}</a></div></div>
                                            </div>
                                            <ul class="item_marks">
                                                <li class="item_mark item_discount">${o.discount}%</li>
                                                <li class="item_mark item_new">new</li>
                                            </ul>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="deals_featured">
            <div class="container">
                <div class="row">
                    <div class="col d-flex flex-lg-row flex-column align-items-center justify-content-start">

                        <!-- Deals -->

                        <div class="deals">
                            <div class="deals_title">Deals of the Week</div>
                            <div class="deals_slider_container">

                                <!-- Deals Slider -->
                                <div class="owl-carousel owl-theme deals_slider">

                                    <c:forEach items="${listTop3}" var="o">
                                        <!-- Deals Item -->
                                        <div class="owl-item deals_item">
                                            <div class="deals_image"> <a href="detail?id=${o.id}"><img src="${o.image}" alt=""></a></div>
                                            <div class="deals_content">
                                                <div class="deals_info_line d-flex flex-row justify-content-start">

                                                    <div class="deals_item_price_a ml-auto">${o.getFormattedPrice()} </div>
                                                </div>

                                                <div class="deals_info_line d-flex flex-row justify-content-start">
                                                    <div class="deals_item_name"><a href="detail?id=${o.id}">${o.name}</a></div>
                                                    <div class="deals_item_price ml-auto">${o.getPercentDiscount()} </div>
                                                </div>
                                                <div class="available">
                                                    <div class="available_line d-flex flex-row justify-content-start">
                                                        <div class="available_title">Available: <span>20</span></div>
                                                        <div class="sold_title ml-auto">Already sold: <span>28</span></div>
                                                    </div>
                                                    <div class="available_bar"><span style="width:41%"></span></div>
                                                </div>
                                                <div class="deals_timer d-flex flex-row align-items-center justify-content-start">
                                                    <div class="deals_timer_title_container">
                                                        <div class="deals_timer_title">Hurry Up</div>
                                                        <div class="deals_timer_subtitle">Offer ends in:</div>
                                                    </div>
                                                    <div class="deals_timer_content ml-auto">
                                                        <div class="deals_timer_box clearfix" data-target-time="">
                                                            <div class="deals_timer_unit">
                                                                <div id="deals_timer1_hr" class="deals_timer_hr"></div>
                                                                <span>hours</span>
                                                            </div>
                                                            <div class="deals_timer_unit">
                                                                <div id="deals_timer1_min" class="deals_timer_min"></div>
                                                                <span>mins</span>
                                                            </div>
                                                            <div class="deals_timer_unit">
                                                                <div id="deals_timer1_sec" class="deals_timer_sec"></div>
                                                                <span>secs</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>


                                </div>

                            </div>

                            <div class="deals_slider_nav_container">
                                <div class="deals_slider_prev deals_slider_nav"><i class="fas fa-chevron-left ml-auto"></i></div>
                                <div class="deals_slider_next deals_slider_nav"><i class="fas fa-chevron-right ml-auto"></i></div>
                            </div>
                        </div>

                        <!-- Featured -->
                        <div class="featured">
                            <div class="tabbed_container">
                                <div class="tabs">
                                    <ul class="clearfix">
                                        <li class="active">Featured</li>
                                        <li>Best Rated</li>
                                    </ul>
                                    <div class="tabs_line"><span></span></div>
                                </div>

                                <!-- Product Panel -->

                                <div class="product_panel panel active">
                                    <div class="featured_slider slider">


                                        <!-- Slider Item -->
                                        <c:forEach items="${listP3}" var="o">
                                            <div class="featured_slider_item">

                                                <div class="border_active"></div>

                                                <div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center">
                                                    <div class="product_image d-flex flex-column align-items-center justify-content-center"><a href="detail?id=${o.id}"><img src="${o.image}" height="85" width="auto" style="vertical-align:middle" alt=""></a></div>
                                                    <div class="product_content">
                                                        <div class="product_price"><a href="detail?id=${o.id}">${o.getPercentDiscount()} </a></div>
                                                        <div class="product_name"><div><a href="detail?id=${o.id}">${o.name}</a></div></div>
                                                        <div class="product_extras">

                                                            <form action="CartControl?action=addToCart" method="post">
                                                                <input type="hidden" name="userId" value="${sessionScope.userId}">
                                                                <input type="hidden" name="productId" value="${o.id}">
                                                                <input type="hidden" name="sourcePage" value="home">
                                                                <button class="product_cart_button" type="submit">
                                                                    Add to Cart
                                                                </button>
                                                            </form>
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
                                                    <c:if test="${cartSuccess != null && cartSuccess}">
                                                        <script>
                                                            const Toast = Swal.mixin({
                                                                toast: true,
                                                                position: "top-end",
                                                                showConfirmButton: false,
                                                                timer: 1000,
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
                                                                title: "Product added to cart successfully"
                                                            });
                                                        </script>
                                                    </c:if>




                                                    <ul class="product_marks">
                                                        <c:choose>
                                                            <c:when test= "${o.discount > 0}">
                                                                <li class="product_mark product_discount">${o.discount}%</li>
                                                                <li class="product_mark product_new">new</li>
                                                                </c:when>
                                                                <c:otherwise>

                                                            </c:otherwise>
                                                        </c:choose>
                                                    </ul>

                                                </div>

                                            </div>
                                        </c:forEach>



                                    </div>
                                    <div class="featured_slider_dots_cover"></div>
                                </div>



                                <!-- Product Panel -->

                                <div class="product_panel panel">
                                    <div class="featured_slider slider">


                                        <!-- Slider Item -->
                                        <c:forEach items="${listP2}" var="o">
                                            <div class="featured_slider_item">

                                                <div class="border_active"></div>

                                                <div class="product_item discount d-flex flex-column align-items-center justify-content-center text-center">
                                                    <div class="product_image d-flex flex-column align-items-center justify-content-center"><a href="detail?id=${o.id}"><img src="${o.image}" height="85" width="auto" style="vertical-align:middle" alt=""></a></div>
                                                    <div class="product_content">
                                                        <div class="product_price"><a href="detail?id=${o.id}">${o.getPercentDiscount()} </a></div>
                                                        <div class="product_name"><div><a href="detail?id=${o.id}">${o.name}</a></div></div>
                                                        <div class="product_extras">

                                                            <form action="CartControl?action=addToCart" method="post">
                                                                <input type="hidden" name="userId" value="${sessionScope.userId}">
                                                                <input type="hidden" name="productId" value="${o.id}">
                                                                <input type="hidden" name="sourcePage" value="home">
                                                                <button class="product_cart_button" type="submit">
                                                                    Add to Cart
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </div>

                                                    <ul class="product_marks">
                                                        <c:choose>
                                                            <c:when test= "${o.discount > 0}">
                                                                <li class="product_mark product_discount">${o.discount}%</li>
                                                                <li class="product_mark product_new">new</li>
                                                                </c:when>
                                                                <c:otherwise>

                                                            </c:otherwise>
                                                        </c:choose>
                                                    </ul>

                                                </div>

                                            </div>
                                        </c:forEach>



                                    </div>
                                    <div class="featured_slider_dots_cover"></div>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>



        <!-- Banner -->



        <!-- Hot New Arrivals -->

        <div class="new_arrivals">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="tabbed_container">
                            <div class="tabs clearfix tabs-right">
                                <div class="new_arrivals_title">Top 10 Products</div>
                                <ul class="clearfix">

                                    <li>Cards</li>

                                </ul>
                                <div class="tabs_line"><span></span></div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12" style="z-index:1;">

                                    <!-- Product Panel -->
                                    <div class="product_panel panel active">
                                        <div class="arrivals_slider slider">

                                            <!-- Slider Item -->
                                            <c:forEach items="${listTop10}" var="o">
                                                <div class="arrivals_slider_item">
                                                    <div class="border_active"></div>
                                                    <div class="product_item is_new d-flex flex-column align-items-center justify-content-center text-center">
                                                        <div class="product_image d-flex flex-column align-items-center justify-content-center"><a href="detail?id=${o.id}"><img src="${o.image}" height="85" width="auto" style="vertical-align:middle" alt=""></a></div>
                                                        <div class="product_content">
                                                            <div class="product_price"><a href="detail?id=${o.id}">${o.getPercentDiscount()} </a></div>
                                                            <div class="product_name"><div><a href="detail?id=${o.id}">${o.name}</a></div></div>
                                                            <div class="product_extras">
                                                                <div class="product_color">
                                                                    <input type="radio" checked name="product_color" style="background:#b19c83">
                                                                    <input type="radio" name="product_color" style="background:#000000">
                                                                    <input type="radio" name="product_color" style="background:#999999">
                                                                </div>
                                                                <form action="CartControl?action=addToCart" method="post">
                                                                    <input type="hidden" name="userId" value="${sessionScope.userId}">
                                                                    <input type="hidden" name="productId" value="${o.id}">
                                                                    <input type="hidden" name="sourcePage" value="home">
                                                                    <button class="product_cart_button" type="submit">
                                                                        Add to Cart
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                        <div class="product_fav"><i class="fas fa-heart"></i></div>
                                                        <ul class="product_marks">
                                                            <c:choose>
                                                                <c:when test= "${o.discount > 0}">
                                                                    <li class="product_mark product_discount">${o.discount}%</li>
                                                                    <li class="product_mark product_new">new</li>
                                                                    </c:when>
                                                                    <c:otherwise>

                                                                </c:otherwise>
                                                            </c:choose>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </c:forEach>


                                        </div>
                                        <div class="arrivals_slider_dots_cover"></div>
                                    </div>




                                </div>



                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Best Sellers -->







        <!-- Recently Viewed -->

        <div class="viewed">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="viewed_title_container">
                            <h3 class="viewed_title">Suggestions Just For You ❤️</h3>
                            <div class="viewed_nav_container">
                                <div class="viewed_nav viewed_prev"><i class="fas fa-chevron-left"></i></div>
                                <div class="viewed_nav viewed_next"><i class="fas fa-chevron-right"></i></div>
                            </div>
                        </div>

                        <div class="viewed_slider_container">

                            <!-- Recently Viewed Slider -->

                            <div class="owl-carousel owl-theme viewed_slider">

                                <!-- Recently Viewed Item -->
                                <c:forEach items="${listP}" var="o">
                                    <div class="owl-item">
                                        <div class="viewed_item discount d-flex flex-column align-items-center justify-content-center text-center">
                                            <div class="viewed_image d-flex flex-column align-items-center justify-content-center"><a href="detail?id=${o.id}"><img src="${o.image}" style="vertical-align:middle" alt=""></a></div>
                                            <div class="viewed_content text-center">
                                                <div class="product_price"><a href="detail?id=${o.id}">${o.getPercentDiscount()} </a></div>
                                                <div class="product_name"><div><a href="detail?id=${o.id}">${o.name}</a></div></div>
                                            </div>
                                            <ul class="item_marks">
                                                <c:choose>
                                                    <c:when test= "${o.discount > 0}">
                                                        <li class="item_mark item_discount">${o.discount}%</li>
                                                        <li class="item_mark item_new">new</li>
                                                        </c:when>
                                                        <c:otherwise>

                                                    </c:otherwise>
                                                </c:choose>
                                            </ul>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Brands -->

        <div class="brands">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="brands_slider_container">

                            <!-- Brands Slider -->

                            <div class="owl-carousel owl-theme brands_slider">

                                <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/steam1.png" height="45" width="auto" style="vertical-align:middle" alt=""></div></div>
                                <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/vina2.png" height="180" width="auto" style="vertical-align:middle" alt=""></div></div>
                                <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/viettel2.png" height="120" width="auto" style="vertical-align:middle" alt=""></div></div>
                                <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/mobi2.png" height="180" width="auto" style="vertical-align:middle" alt=""></div></div>
                                <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/zing3.png" height="45" width="auto" style="vertical-align:middle" alt=""></div></div>
                                <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/vcoin2.png" height="30" width="auto" style="vertical-align:middle" alt=""></div></div>
                                <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/garena2.png" height="70" width="auto" style="vertical-align:middle" alt=""></div></div>
                                <div class="owl-item"><div class="brands_item d-flex flex-column justify-content-center"><img src="images/gate2.png" height="40" width="auto" style="vertical-align:middle" alt=""></div></div>

                            </div>

                            <!-- Brands Slider Navigation -->
                            <div class="brands_nav brands_prev"><i class="fas fa-chevron-left"></i></div>
                            <div class="brands_nav brands_next"><i class="fas fa-chevron-right"></i></div>

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
                                <div class="logo"><a href="#">OneTech</a></div>
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

        <!-- Copyright -->

        <div class="copyright">
            <div class="container">
                <div class="row">
                    <div class="col">

                        <!--	<div class="copyright_container d-flex flex-sm-row flex-column align-items-center justify-content-start">
                                        <div class="copyright_content">
Copyright &copy;<script data-cfasync="false" src="../../../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script><script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://templatespoint.net/" target="_blank">TemplatesPoint</a>
</div>
                                        <div class="logos ml-sm-auto">
                                                <ul class="logos_list">
                                                        <li><a href="#"><img src="images/logos_1.png" alt=""></a></li>
                                                        <li><a href="#"><img src="images/logos_2.png" alt=""></a></li>
                                                        <li><a href="#"><img src="images/logos_3.png" alt=""></a></li>
                                                        <li><a href="#"><img src="images/logos_4.png" alt=""></a></li>
                                                </ul>
                                        </div>
                                </div> -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="styles/bootstrap4/popper.js"></script>
    <script src="styles/bootstrap4/bootstrap.min.js"></script>
    <script src="plugins/greensock/TweenMax.min.js"></script>
    <script src="plugins/greensock/TimelineMax.min.js"></script>
    <script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
    <script src="plugins/greensock/animation.gsap.min.js"></script>
    <script src="plugins/greensock/ScrollToPlugin.min.js"></script>
    <script src="plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
    <script src="plugins/slick-1.8.0/slick.js"></script>
    <script src="plugins/easing/easing.js"></script>
    <script src="js/custom.js"></script>

    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
    <script>
                                                            window.dataLayer = window.dataLayer || [];
                                                            function gtag() {
                                                                dataLayer.push(arguments);
                                                            }
                                                            gtag('js', new Date());

                                                            gtag('config', 'UA-23581568-13');
    </script>

</body>


</html>
