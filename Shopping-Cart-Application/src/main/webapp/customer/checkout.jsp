<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="../includes/db_connect.jsp" %>

<%
    String role = (String) session.getAttribute("userRole");

    if (role == null || !"customer".equals(role)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    HashMap<Integer, Integer> cart =
        (HashMap<Integer, Integer>) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("shop.jsp");
        return;
    }
    
    // Calculate total items for the topbar Cart button
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

    <title>Checkout</title>

    <link rel="stylesheet" href="../assets/css/style.css">

    <style>
        .container {
            max-width: 900px;
            margin: 0 auto; /* Centers the container in the content area */
        }

        .page-title {
            margin-bottom: 25px;
            text-align: center;
            margin-top: 0;
            color: #2c3e50;
        }

        .checkout-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
            text-align: left;
        }

        .summary-box,
        .form-box {
            padding: 22px;
            background: #ffffff;
            border: 1px solid #dddddd;
            border-radius: 8px;
        }

        .summary-box {
            background: #f8f9fa;
        }

        .summary-box h3,
        .form-box h3 {
            margin-bottom: 20px;
            margin-top: 0;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            padding-bottom: 8px;
            border-bottom: 1px solid #eeeeee;
        }

        .grand-total {
            display: flex;
            justify-content: space-between;
            margin-top: 18px;
            padding-top: 12px;
            border-top: 2px solid #cccccc;
            font-size: 18px;
            font-weight: 700;
            color: #27ae60;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: 600;
        }

        .form-group input {
            margin: 0;
        }

        .pay-btn {
            margin-top: 10px;
            background: #2ecc71;
            font-size: 16px;
        }

        .pay-btn:hover {
            background: #27ae60;
        }

        .back-btn {
            margin-top: 10px;
            background: #95a5a6;
        }

        .back-btn:hover {
            background: #7f8c8d;
        }

        @media (max-width: 768px) {
            .checkout-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

</head>

<body>

    <div class="dashboard-layout">
        
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

                    <h2 class="page-title">
                        Secure Checkout
                    </h2>

                    <div class="checkout-grid">

                        <div class="summary-box">

                            <h3>Order Summary</h3>

                            <%
                                double grandTotal = 0.0;

                                if (conn != null) {
                                    try {
                                        String sql = "SELECT name, price FROM products WHERE id = ?";
                                        PreparedStatement pstmt = conn.prepareStatement(sql);

                                        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                                            pstmt.setInt(1, entry.getKey());
                                            ResultSet rs = pstmt.executeQuery();

                                            if (rs.next()) {
                                                String name = rs.getString("name");
                                                double price = rs.getDouble("price");
                                                double subtotal = price * entry.getValue();
                                                grandTotal += subtotal;
                            %>

                            <div class="summary-item">
                                <span><%= entry.getValue() %> × <%= name %></span>
                                <span>₹<%= String.format("%.2f", subtotal) %></span>
                            </div>

                            <%
                                            }
                                            rs.close();
                                        }
                                        pstmt.close();
                                    } catch (Exception e) {
                                        out.println("<div class='error'>Error loading summary: " + e.getMessage() + "</div>");
                                    }
                                }
                            %>

                            <div class="grand-total">
                                <span>Total to Pay</span>
                                <span>₹<%= String.format("%.2f", grandTotal) %></span>
                            </div>

                        </div>

                        <div class="form-box">

                            <h3>Shipping & Payment</h3>

                            <form action="checkoutAction.jsp" method="post" style="margin: 0;">

                                <div class="form-group">
                                    <label>Full Name</label>
                                    <input type="text" name="fullName" value="<%= session.getAttribute("currentUser") %>" required>
                                </div>

                                <div class="form-group">
                                    <label>Shipping Address</label>
                                    <input type="text" name="address" placeholder="123 Main St, City" required>
                                </div>

                                <div class="form-group">
                                    <label>Card Number (Dummy)</label>
                                    <input type="text" name="cardNumber" placeholder="XXXX-XXXX-XXXX-XXXX" required>
                                </div>

                                <input type="submit" class="pay-btn btn" value="Confirm & Pay ₹<%= String.format("%.2f", grandTotal) %>">

                                <a href="cart.jsp" class="btn back-btn">
                                    Return to Cart
                                </a>

                            </form>

                        </div>

                    </div>

                </div>

            </div>
            
        </div>
    </div>

</body>

</html>