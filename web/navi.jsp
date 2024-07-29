<%-- 
    Document   : navi
    Created on : 17 Jun 2024, 21:05:32
    Author     : MTTRBLX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
      
    </head>
    <body>
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
                                                                        <li><a class="clc" href="#">${o.name}</a></li>
                                                                    </c:forEach>
							</ul>
						</div>

						<!-- Main Nav Menu -->

						<div class="main_nav_menu ml-auto">
							<ul class="standard_dropdown main_nav_dropdown">
								<li><a href="#">Home<i class="fas fa-chevron-down"></i></a></li>
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
    </body>
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-23581568-13');
</script>

</body>


</html>
