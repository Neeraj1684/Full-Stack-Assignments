<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    String role = (String) session.getAttribute("userRole");

    if (role == null || !"customer".equals(role)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String orderId = request.getParameter("orderId");

    HashMap<Integer, Integer> cart = (HashMap<Integer, Integer>) session.getAttribute("cart");
    int cartCount = 0;
    if (cart != null) {
        for (int qty : cart.values()) {
            cartCount += qty;
        }
    }
%>

<!DOCTYPE html>
<html>

<head>

    <title>Order Successful</title>

    <link rel="stylesheet" href="../assets/css/style.css">

    <style>
        .container { max-width: 600px; margin: 0 auto; }
        
        .success-box {
            padding: 40px 20px;
            text-align: center;
        }

        .check-icon {
            margin-bottom: 20px;
            font-size: 64px;
        }

        .success-box h2 {
            margin-bottom: 12px;
            margin-top: 0;
            color: #2c3e50;
        }

        .success-message {
            margin-bottom: 25px;
            color: #7f8c8d;
            font-size: 16px;
        }

        .order-number {
            margin-bottom: 30px;
            font-size: 22px;
            font-weight: 600;
            color: #2c3e50;
        }

        .home-btn {
            width: auto;
            padding: 12px 22px;
            background: #3498db;
        }

        .home-btn:hover {
            background: #2980b9;
        }
    </style>

</head>

<body>

    <div class="dashboard-layout">
        
        <!-- SIDEBAR -->
        <div class="sidebar">
            <h2>E-Shop</h2>
            <a href="shop.jsp">Shop</a>
            <a href="orders.jsp">My Orders</a>
        </div>

        <div class="main-content">
            
            <div class="topbar">
                <a href="cart.jsp" class="btn" style="background-color: #2c3e50; width: auto; margin-right: 20px; padding: 8px 15px;">🛒 Cart (<%= cartCount %>)</a>
                
                <div class="profile-menu">
                    <span class="username"><%= session.getAttribute("currentUser") %></span>
                    <div class="profile-icon">👤</div>
                    <div class="dropdown-content">
                        <a href="../logout.jsp">Logout</a>
                    </div>
                </div>
            </div>

            <div class="content-area">
                <div class="container">

                    <div class="success-box">

                        <div class="check-icon">
                            ✅
                        </div>

                        <h2>
                            Order Placed Successfully!
                        </h2>

                        <p class="success-message">
                            Thank you for your purchase,
                            <strong><%= session.getAttribute("currentUser") %></strong>.
                        </p>

                        <div class="order-number">
                            Order ID:
                            <strong>#<%= orderId %></strong>
                        </div>

                        <a href="shop.jsp" class="btn home-btn">
                            Return to Storefront
                        </a>

                    </div>

                </div>
            </div>
            
        </div>
    </div>

</body>

</html>