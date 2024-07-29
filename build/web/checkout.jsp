<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.text.NumberFormat" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Checkout - OneTech</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="OneTech shop project">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap4/bootstrap.min.css">
        <link href="plugins/fontawesome-free-5.0.1/css/fontawesome-all.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" type="text/css" href="styles/main_styles.css">
        <link rel="stylesheet" type="text/css" href="styles/responsive.css">
        <link href="css/style_1.css" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <style>
            .checkout_section {
                padding: 80px 0;
            }
            .checkout_item {
                border-bottom: 1px solid #e8e8e8;
                padding: 20px 0;
            }
            .checkout_item:last-child {
                border-bottom: none;
            }
            .total_price {
                font-size: 24px;
                font-weight: bold;
                color: #0e8ce4;
                margin-top: 30px;
            }
            .checkout_button {
                display: inline-block;
                padding: 12px 30px;
                background-color: #0e8ce4;
                color: #ffffff;
                border: none;
                cursor: pointer;
                transition: all 0.3s;
                margin-top: 20px;
            }
            .checkout_button:hover {
                background-color: #0071c2;
            }
        </style>
    </head>
    <body>
        <div class="super_container">
            <!-- Header -->
            <header style="margin-left: 0px" class="header">
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

                <!-- Checkout -->
                <div class="checkout_section">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="checkout_container">
                                    <form id="checkout-form" method="post" action="CheckoutController">
                                        <h1>Your Bill</h1>
                                        <div class="checkout_items">
                                            <table class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Product ID</th>
                                                        <th>Category</th>
                                                        <th>Product Image</th>
                                                        <th>Quantity</th>
                                                        <th>Discount</th>
                                                        <th>Total</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <c:forEach var="cartItem" items="${requestScope.cartItems}">
                                                    <tr>
                                                        <td>${cartItem.productID}</td>
                                                        <td>${cartItem.category}</td>
                                                        <td><img style="height: 25%; width: 25%" src="${cartItem.imageURL}"></td>
                                                        <td>${cartItem.quantity}</td>
                                                        <c:if test="${cartItem.discount > 0}">
                                                            <td>${cartItem.discount}%</td>
                                                        </c:if>
                                                        <c:if test="${cartItem.discount == 0}">
                                                            <td></td>
                                                        </c:if>
                                                        <td>${cartItem.total}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="total_price">
                                        Total Price: ${requestScope.totalPrice} VNĐ
                                    </div>

                                    <c:if test="${not empty requestScope.successMessage}">
                                        <div class="success_message">${requestScope.successMessage}</div>
                                    </c:if>

                                    <button type="submit" class="checkout_button">Confirm Order</button>

                                    <!-- Processing message -->
                                    <div id="processing-message" style="display: none; color: blue; margin-top: 10px;">
                                        
                                    </div>
                                </form>

                                <script>
                                    document.getElementById('checkout-form').addEventListener('submit', function (event) {
                                        // Show the processing message
                                        document.getElementById('processing-message').style.display = 'block';

                                        // Optionally, show a SweetAlert2 popup
                                        Swal.fire({
                                            title: 'Processing',
                                            text: 'Processing your order, please wait...',
                                            icon: 'info',
                                            allowOutsideClick: false,
                                            showConfirmButton: false,
                                            willOpen: () => {
                                                Swal.showLoading();
                                            }
                                        });
                                    });
                                </script>

                                <!-- JavaScript to trigger modal if errorMessage is present -->
                                <script>
                                    $(document).ready(function () {
                                    <c:if test="${not empty requestScope.errorMessage}">
                                        $('#errorModal').modal('show');
                                    </c:if>
                                    });
                                </script>
                                <script>
                                    function closeModal() {
                                        $('#errorModal').modal('hide');
                                    }
                                </script>

                                <!-- Modal HTML -->
                                <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="errorModalLabel"><b>Transaction Error</b></h5>
                                            </div>
                                            <div class="modal-body">
                                                <div style="font-family: roboto; font-weight: bold"><c:out value="${requestScope.errorMessage}" /></div>

                                                <div style="font-family: roboto"><a href="naptien" target="_blank">Click here to Recharge Money</a></div>

                                            </div>
                                            <div class="modal-footer">

                                                <!-- Button to close modal using custom function -->
                                                <button type="button" class="btn btn-secondary" onclick="closeModal()">Close</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>



                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer class="footer">
                <!-- Footer content -->
            </footer>
        </div>

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