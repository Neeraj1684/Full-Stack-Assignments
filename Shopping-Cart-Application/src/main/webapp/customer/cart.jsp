<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="../includes/db_connect.jsp" %>

<%
    String role = (String) session.getAttribute("userRole");

    if (role == null || !"customer".equals(role)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    HashMap<Integer, Integer> cart =
        (HashMap<Integer, Integer>) session.getAttribute("cart");
        
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

    <title>Your Cart</title>

    <link rel="stylesheet" href="../assets/css/style.css">

    <style>
        .container {
            max-width: 850px;
            margin: 0 auto; /* Centers the container in the content area */
        }

        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .back-btn {
            width: auto;
            background: #95a5a6;
        }

        .back-btn:hover {
            background: #7f8c8d;
        }

        .remove-btn {
            width: auto;
            padding: 8px 14px;
            background: #e74c3c;
        }

        .remove-btn:hover {
            background: #c0392b;
        }

        .total-row {
            font-size: 18px;
            font-weight: 700;
            background: #f8f9fa;
        }

        .total-row td {
            padding: 16px 12px;
        }

        .grand-total {
            color: #27ae60;
        }

        .cart-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
        }

        .clear-btn {
            width: auto;
            background: #e74c3c;
        }

        .clear-btn:hover {
            background: #c0392b;
        }

        .checkout-btn {
            width: auto;
            background: #2ecc71;
            font-size: 17px;
        }

        .checkout-btn:hover {
            background: #27ae60;
        }

        .empty-cart {
            padding: 45px;
            text-align: center;
            color: #7f8c8d;
            font-size: 17px;
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

                <div class="header-bar">
                    <h2 style="margin: 0;">Your Shopping Cart</h2>
                    <a href="shop.jsp" class="btn back-btn">
                        ← Continue Shopping
                    </a>
                </div>

                <%
                    if (cart == null || cart.isEmpty()) {

                        out.println("<div class='empty-cart'>Your cart is empty.</div>");

                    } else {
                %>

                <table>

                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Action</th>
                    </tr>

                    <%
                        double grandTotal = 0.0;

                        if (conn != null) {

                            try {

                                String sql =
                                    "SELECT name, price FROM products WHERE id = ?";

                                PreparedStatement pstmt =
                                    conn.prepareStatement(sql);

                                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {

                                    int productId = entry.getKey();
                                    int quantity = entry.getValue();

                                    pstmt.setInt(1, productId);

                                    ResultSet rs = pstmt.executeQuery();

                                    if (rs.next()) {

                                        String name = rs.getString("name");
                                        double price = rs.getDouble("price");
                                        double subtotal = price * quantity;

                                        grandTotal += subtotal;
                    %>

                    <tr>

                        <td><%= name %></td>

                        <td>
                            ₹<%= String.format("%.2f", price) %>
                        </td>

                        <td><%= quantity %></td>

                        <td>
                            ₹<%= String.format("%.2f", subtotal) %>
                        </td>

                        <td>

                            <a
                                href="cartAction.jsp?action=remove&id=<%= productId %>"
                                class="btn remove-btn">
                                Remove
                            </a>

                        </td>

                    </tr>

                    <%
                                    }

                                    rs.close();
                                }

                                pstmt.close();

                            } catch (Exception e) {

                                out.println(
                                    "<tr><td colspan='5' class='error'>Error: "
                                    + e.getMessage()
                                    + "</td></tr>"
                                );
                            }
                        }
                    %>

                    <tr class="total-row">
                        <td colspan="3" style="text-align: right;">
                            Grand Total
                        </td>
                        <td colspan="2" class="grand-total">
                            ₹<%= String.format("%.2f", grandTotal) %>
                        </td>
                    </tr>

                </table>

                <div class="cart-actions">
                    <a
                        href="cartAction.jsp?action=clear"
                        class="btn clear-btn">
                        Clear Cart
                    </a>

                    <a
                        href="checkout.jsp"
                        class="btn checkout-btn">
                        Proceed to Checkout
                    </a>
                </div>

                <%
                    }
                %>

            </div>

        </div>
    </div>
</div>

</body>

</html>