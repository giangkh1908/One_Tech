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
        <link rel="stylesheet" type="text/css" href="styles/product_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/product_responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    </head>
    <% 
                Boolean cartSuccess = (Boolean) session.getAttribute("cartSuccess");
                // Do not remove the session attribute here
    %>

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
                                        <div class="logo" style="top: 50%"><a href="home">OneTech</a></div>
                                    </div>
                                </div>

                                <!-- Search -->
                                <div class="col-lg-6 col-12 order-lg-2 order-3 text-lg-left text-right">
                                    <div class="header_search">
                                        <div class="header_search_content">
                                            <div class="header_search_form_container">
                                                <form action="#" class="header_search_form clearfix">
                                                    <input type="search" required="required" class="header_search_input" placeholder="Search for products...">
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




            </header>

            <!-- Banner -->

            <div class="single_product">
                <div class="container">
                    <div class="row">

                        <!-- Images -->


                        <!-- Selected Image -->
                        <div class="col-lg-5 order-lg-2 order-1">
                            <div class="image_selected"><img src="${product.image}" alt=""></div>
                        </div>
                        <c:set var="productId" value="${param.id}" />
                        <!-- Description -->
                        <div class="col-lg-5 order-3">
                            <div class="product_description">
                                <div class="product_name">${product.name}</div>
                                <div class="product_text"><p>${product.description}</p></div>

                                <div class="order_info d-flex flex-row">
                                    <form id="add-to-cart-form" action="CartControl?action=addToCart" method="POST">
                                        <!-- Hidden Inputs -->
                                        <input type="hidden" name="userId" value="${sessionScope.userId}">
                                        <input type="hidden" name="productId" value="${productId}">
                                        <input type="hidden" name="sourcePage" value="detail">
                                        <div class="clearfix" style="z-index: 1000;">
                                            <!-- Product Quantity -->
                                            <div class="product_quantity clearfix">
                                                <span>Quantity: </span>
                                                <input id="quantity_input" name="quantity1" type="text" min="0" max="${maxQuantityToAdd}" value="${maxQuantityToAdd == 0 ? 0 : 1}">
                                                <div class="quantity_buttons">
                                                    <div id="quantity_inc_button" class="quantity_inc quantity_control"><i class="fas fa-chevron-up"></i></div>
                                                    <div id="quantity_dec_button" class="quantity_dec quantity_control"><i class="fas fa-chevron-down"></i></div>
                                                </div>
                                            </div>
                                        </div>
                                        <h3>In Stock: <span id="maxQuantityToAdd">${quantityInStock}</span></h3>




                                        <script>
                                            document.addEventListener('DOMContentLoaded', function () {
                                                const stockQuantity = parseInt(document.getElementById('maxQuantityToAdd').innerText);
                                                const maxQuantityToAdd = parseInt(document.getElementById('quantity_input').max);
                                                const quantityInput = document.getElementById('quantity_input');

                                                quantityInput.addEventListener('input', function () {
                                                    let currentValue = parseInt(quantityInput.value);

                                                    if (maxQuantityToAdd > 0 && (isNaN(currentValue) || currentValue < 1)) {
                                                        quantityInput.value = 1;
                                                    } else if (currentValue > maxQuantityToAdd) {
                                                        quantityInput.value = maxQuantityToAdd;
                                                    }
                                                });

                                                document.getElementById('quantity_inc_button').addEventListener('click', function () {
                                                    let currentValue = parseInt(quantityInput.value);
                                                    if (currentValue < maxQuantityToAdd) {
                                                        quantityInput.value = currentValue + 1;
                                                    }
                                                });

                                                document.getElementById('quantity_dec_button').addEventListener('click', function () {
                                                    let currentValue = parseInt(quantityInput.value);
                                                    if (currentValue > (maxQuantityToAdd == 0 ? 0 : 1)) {
                                                        quantityInput.value = currentValue - 1;
                                                    }
                                                });
                                            });

                                            function addToCart() {
                                                const quantity = parseInt(document.getElementById('quantity_input').value);
                                                    fetch('/add-to-cart', {
                                                        method: 'POST',
                                                        headers: {
                                                            'Content-Type': 'application/x-www-form-urlencoded',
                                                        },
                                                        body: `quantity=${quantity}`
                                                    })
                                                            .then(response => {
                                                                if (!response.ok) {
                                                                    return response.text().then(text => {
                                                                        throw new Error(text)
                                                                    });
                                                                }
                                                                return response.json();
                                                            })
                                                            .then(data => {
                                                                console.log('Item added to cart:', data);
                                                            })
                                                            .catch(error => {
                                                                Swal.fire({
                                                                    icon: 'error',
                                                                    title: 'Error',
                                                                    text: error.message,
                                                                    timer: 3000,
                                                                    timerProgressBar: true,
                                                                    showConfirmButton: false,
                                                                    position: 'top-end',
                                                                    toast: true,
                                                                    didOpen: (toast) => {
                                                                        toast.onmouseenter = Swal.stopTimer;
                                                                        toast.onmouseleave = Swal.resumeTimer;
                                                                    }
                                                                });
                                                            });
                                            }
                                        </script>




                                        <div class="banner_price" style="font-size: 25px;">${product.getPercentDiscount()}  <span>${product.getFormattedPrice()}</span></div>
                                        <c:choose>
                                            <c:when test="${OutOfStock}">
                                                <div class="button_container">
                                                    <button type="button" class="button cart_button" style="background: red" disabled>Out of Stock</button>
                                                </div>
                                            </c:when>
                                            <c:when test="${maxQuantityToAdd == 0}">
                                                <div class="button_container">
                                                    <button type="submit" class="button cart_button"  id="add_to_cart_button" disabled>Add to Cart</button>
                                                </div>
                                            </c:when>

                                            <c:otherwise>
                                                <div class="button_container">
                                                    <button type="submit" class="button cart_button"  id="add_to_cart_button">Add to Cart</button>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>


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
                                    <c:forEach items="${listP2}" var="o">
                                        <div class="owl-item">
                                            <div class="viewed_item discount d-flex flex-column align-items-center justify-content-center text-center">
                                                <div class="viewed_image d-flex flex-column align-items-center justify-content-center"><a href="detail?id=${o.id}"><img src="${o.image}" style="vertical-align:middle" alt=""></a></div>
                                                <div class="viewed_content text-center">
                                                    <div class="product_price"><a href="detail?id=${o.id}">${o.getFormattedPrice()}</a></div>
                                                    <div class="product_name"><div><a href="detail?id=${o.id}">${o.name}</a></div></div>
                                                </div>
                                                <ul class="item_marks">
                                                </ul>
                                            </div>
                                        </div>
                                    </c:forEach>

                                    <c:forEach items="${listP3}" var="o">
                                        <div class="owl-item">
                                            <div class="viewed_item discount d-flex flex-column align-items-center justify-content-center text-center">
                                                <div class="viewed_image d-flex flex-column align-items-center justify-content-center"><a href="detail?id=${o.id}"><img src="${o.image}" style="vertical-align:middle" alt=""></a></div>
                                                <div class="viewed_content text-center">
                                                    <div class="product_price"><a href="detail?id=${o.id}">${o.getFormattedPrice()}</a></div>
                                                    <div class="product_name"><div><a href="detail?id=${o.id}">${o.name}</a></div></div>
                                                </div>
                                                <ul class="item_marks">
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
        <!--        <script>

            document.getElementById('quantity_inc_button').addEventListener('click', function () {
                var quantityInput = document.getElementById('quantity_input');
                var currentQuantity = parseInt(quantityInput.value);
                if (currentQuantity < stockQuantity) {
                    quantityInput.value = currentQuantity + 1;
                } else {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Limit Reached',
                        text: `You can add a maximum of ${stockQuantity} items.`,
                        timer: 3000, // Display duration in milliseconds
                        timerProgressBar: true,
                        showConfirmButton: false,
                        position: 'top-end',
                        toast: true,
                        didOpen: (toast) => {
                            toast.onmouseenter = Swal.stopTimer;
                            toast.onmouseleave = Swal.resumeTimer;
                        }
                    });
                }
            });
            document.getElementById('quantity_dec_button').addEventListener('click', function () {
                var quantityInput = document.getElementById('quantity_input');
                var currentQuantity = parseInt(quantityInput.value);
                if (currentQuantity > 1) {
                    quantityInput.value = currentQuantity - 1;
                }
            });

        </script>



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
