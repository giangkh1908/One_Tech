<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <head>
        <title>Forum Post</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.carousel.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
        <link rel="stylesheet" type="text/css" href="plugins/OwlCarousel2-2.2.1/animate.css">
        <link rel="stylesheet" type="text/css" href="styles/blog_single_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/blog_single_responsive.css">

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
                                                    <div class="cart_count"><span>10</span></div>
                                                </div>
                                                <div class="cart_content">
                                                    <div class="cart_text"><a href="#">Cart</a></div>
                                                    <div class="cart_price">$85</div>
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

                <!-- Single Blog Post -->

                <div class="single_post">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-8 offset-lg-2">

                                <div class="single_post_title">${detail.title}</div>
                            <div class="single_post_text">
                                <p>${detail.para1}</p>
                                <div class="text-center"><img src="${detail.img1}" alt=""></div>
                                    <c:if test="${detail.quote != null}">
                                    <div class="single_post_quote text-center">
                                        <div class="quote_image"><img src="images/quote.png" alt=""></div>
                                        <div class="quote_text">${detail.quote}</div>
                                        <div class="quote_name">${detail.quote_author}</div>
                                    </div>
                                </c:if>
                                <p>${detail.para2}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Blog Posts -->

            <div class="blog">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="blog_posts d-flex flex-row align-items-start justify-content-between">

                                <!-- Blog post -->
                                <c:forEach var="p" items="${listPost}">
                                    <div class="blog_post">
                                        <div class="blog_image" style="background-image: url('${p.coverImg}');"></div>
                                        <div class="blog_text">${p.title}</div>
                                        <div class="blog_button"><a href="postdetail?id=${p.id}">Continue Reading</a></div>
                                    </div>
                                </c:forEach>

                                <!-- Blog post -->
<!--                                <div class="blog_post">
                                    <div class="blog_image" style="background-image:url(images/cover2.jpg)"></div>
                                    <div class="blog_text">Sed viverra pellentesque dictum. Aenean ligula justo, viverra in lacus porttitor</div>
                                    <div class="blog_button"><a href="blog_single.html">Continue Reading</a></div>
                                </div>

                                 Blog post 
                                <div class="blog_post">
                                    <div class="blog_image" style="background-image:url(images/cover3.jpg)"></div>
                                    <div class="blog_text">In nisl tortor, tempus nec ex vitae, bibendum rutrum mi. Integer tempus nisi</div>
                                    <div class="blog_button"><a href="blog_single.html">Continue Reading</a></div>
                                </div>-->

                            </div>
                        </div>	
                    </div>
                </div>
            </div>

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

                            <div class="copyright_container d-flex flex-sm-row flex-column align-items-center justify-content-start">
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
                            </div>
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
        <script src="plugins/parallax-js-master/parallax.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="js/blog_single_custom.js"></script>

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
