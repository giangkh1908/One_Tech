<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Shopping Cart - OneTech</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            .cart_section {
                padding: 80px 0;
            }
            .cart_item {
                border-bottom: 1px solid #e8e8e8;
                padding: 20px 0;
            }
            .cart_item:last-child {
                border-bottom: none;
            }
            .cart_buttons {
                margin-top: 30px;
            }
            .cart_button {
                display: inline-block;
                padding: 12px 30px;
                background-color: #0e8ce4;
                color: #ffffff;
                border: none;
                cursor: pointer;
                transition: all 0.3s;
            }
            .cart_button:hover {
                background-color: #0071c2;
            }
            .cart_button_clear {
                background-color: #f2f2f2;
                color: #0e8ce4;
            }
            .cart_button_clear:hover {
                background-color: #e6e6e6;
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
                            </div>
                        </div>
                    </div>
                </header>

                <!-- Cart -->
                <div class="cart_section">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="cart_container">
                                    <h1>Your Shopping Cart</h1>
                                <%
                                    Boolean checkProcess = (Boolean) session.getAttribute("checkProcess");
//                                    List<Cart> ProductOutOfStockList = (List<Cart>) session.getAttribute("ProductOutOfStockList");
                                %>
                                <div class="cart_items">
                                    <c:forEach var="cartItem" items="${requestScope.cartItems}">
                                        <div class="cart_item">
                                            <div class="row align-items-center">
                                                <div class="col-md-2">
                                                    <p>Product ID: ${cartItem.productID}</p>
                                                </div>
                                                <div class="col-md-2">
                                                    <p>Quantity: ${cartItem.quantity}</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <form action="RemoveCart" method="post">
                                                        <input type="hidden" name="productId" value="${cartItem.productID}">
                                                        <button type="submit" class="cart_button cart_button_clear">Remove</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
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

                                <c:if test="${checkProcess != null && !checkProcess}">
                                    <script>
                                        $(document).ready(function () {
                                            $('#outOfStockModal').modal('show'); // Show the modal
                                        });
                                    </script>
                                </c:if>

                                <!-- Hidden field to indicate if the cart is empty -->
                                <input type="hidden" id="isCartEmpty" value="${empty requestScope.cartItems}">

                                <div class="cart_buttons">
                                    <form id="checkout-form" action="CheckoutController" method="get" style="display: inline-block; margin-right: 10px;">
                                        <button type="submit" class="cart_button">Proceed to Checkout</button>
                                    </form>

                                    <a href="shop" class="cart_button cart_button_clear">Continue Shopping</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Structure -->
            <div class="modal fade" id="outOfStockModal" tabindex="-1" aria-labelledby="outOfStockModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="outOfStockModalLabel">Products Out of Stock</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Product ID</th>
                                        <th>Quantity in Stock</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${ProductOutOfStockList}">
                                        <tr>
                                            <td>${product.productID}</td> <!-- Adjust the property name based on your product object structure -->
                                            <td>${product.quantity}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="removeCartSuccessFlag()">Close</button>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Footer -->
            <footer class="footer">
                <!-- Footer content -->
            </footer>
        </div>

        <script>
            document.getElementById('checkout-form').addEventListener('submit', function (event) {
                var isCartEmpty = document.getElementById('isCartEmpty').value;

                if (isCartEmpty === 'true') {
                    event.preventDefault(); // Prevent form submission

                    Swal.fire({
                        title: "Error",
                        text: "Your cart is empty",
                        icon: "error",
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
                    return; // Exit the function to prevent further execution
                }

                // Show the processing message
//                document.getElementById('processing-message').style.display = 'block';
//
//                // Optionally, show a SweetAlert2 popup for processing
//                Swal.fire({
//                    title: 'Processing',
//                    text: 'Processing your order, please wait...',
//                    icon: 'info',
//                    allowOutsideClick: false,
//                    showConfirmButton: false,
//                    willOpen: () => {
//                        Swal.showLoading();
//                    }
//                });
            });
        </script>

        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="styles/bootstrap4/popper.js"></script>
        <script src="styles/bootstrap4/bootstrap.min.js"></script>
        <script src="plugins/greensock/TweenMax.min.js"></script>
        <script src="plugins/greensock/TimelineMax.min.js"></script>
        <script src="plugins/scrollmagic/ScrollMagic.min.js"></script>
        <script src="plugins/greensock/animation.gsap.min.js"></script>
        <script src="plugins/greensock/ScrollToPlugin.min.js"></script>
        <script src="plugins/easing/easing.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>
