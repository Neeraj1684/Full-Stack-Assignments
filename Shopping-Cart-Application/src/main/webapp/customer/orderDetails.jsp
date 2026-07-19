<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="../includes/db_connect.jsp" %>
<%
    String role = (String) session.getAttribute("userRole");
    String currentUser = (String) session.getAttribute("currentUser");
    if (role == null || !"customer".equals(role)) {
        response.sendRedirect("../index.jsp");
        return; 
    }
    
    String orderId = request.getParameter("orderId");
    if (orderId == null) {
        response.sendRedirect("orders.jsp");
        return;
    }

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
    <title>Order Details</title>
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
    <style>
        .container { max-width: 800px; margin: 0 auto; }
        .header-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .header-bar h2 { margin: 0; color: #2c3e50; }
        .summary-box { background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #ddd; display: flex; justify-content: space-between; }
    </style>
</head>
<body>
    
    <div class="dashboard-layout">
        
        <div class="sidebar">
            <h2>E-Shop</h2>
            <a href="shop.jsp">Shop</a>
            <a href="orders.jsp" class="active">My Orders</a>
        </div>

        <div class="main-content">
            
            <div class="topbar">
                <a href="cart.jsp" class="btn" style="background-color: #2c3e50; width: auto; margin-right: 20px; padding: 8px 15px;">🛒 Cart (<%= cartCount %>)</a>
                
                <div class="profile-menu">
                    <span class="username"><%= currentUser %></span>
                    <div class="profile-icon">👤</div>
                    <div class="dropdown-content">
                        <a href="../logout.jsp">Logout</a>
                    </div>
                </div>
            </div>

            <div class="content-area">
                <div class="container">
                    <div class="header-bar">
                        <h2>Order Details #<%= orderId %></h2>
                        <a href="orders.jsp" class="btn" style="width: auto; background-color: #95a5a6;">← Back to Orders</a>
                    </div>

                    <%
                        if (conn != null) {
                            try {
                                // 1. Verify the order belongs to this user and get the total
                                String orderSql = "SELECT total_amount, order_date FROM orders WHERE id = ? AND username = ?";
                                PreparedStatement orderStmt = conn.prepareStatement(orderSql);
                                orderStmt.setInt(1, Integer.parseInt(orderId));
                                orderStmt.setString(2, currentUser);
                                ResultSet orderRs = orderStmt.executeQuery();
                                
                                if (orderRs.next()) {
                                    double grandTotal = orderRs.getDouble("total_amount");
                                    String date = orderRs.getTimestamp("order_date").toString().substring(0, 16);
                    %>
                                    <div class="summary-box">
                                        <div><strong>Date:</strong> <%= date %></div>
                                        <div style="color: #27ae60; font-size: 18px;"><strong>Total: ₹<%= String.format("%.2f", grandTotal) %></strong></div>
                                    </div>

                                    <table>
                                        <tr>
                                            <th>Product</th>
                                            <th>Price</th>
                                            <th>Qty</th>
                                            <th>Subtotal</th>
                                        </tr>
                    <%
                                    // 2. Fetch the items for this order using a JOIN
                                    String itemsSql = "SELECT p.name, oi.price, oi.quantity FROM order_items oi JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
                                    PreparedStatement itemsStmt = conn.prepareStatement(itemsSql);
                                    itemsStmt.setInt(1, Integer.parseInt(orderId));
                                    ResultSet itemsRs = itemsStmt.executeQuery();
                                    
                                    while(itemsRs.next()) {
                                        String name = itemsRs.getString("name");
                                        double price = itemsRs.getDouble("price");
                                        int qty = itemsRs.getInt("quantity");
                                        double subtotal = price * qty;
                    %>
                                        <tr>
                                            <td><%= name %></td>
                                            <td>₹<%= String.format("%.2f", price) %></td>
                                            <td><%= qty %></td>
                                            <td>₹<%= String.format("%.2f", subtotal) %></td>
                                        </tr>
                    <%
                                    }
                                    itemsRs.close();
                                    itemsStmt.close();
                                } else {
                                    out.println("<div class='error'>Order not found or access denied.</div>");
                                }
                                orderRs.close();
                                orderStmt.close();
                            } catch(Exception e) {
                                out.println("<div class='error'>Database Error: " + e.getMessage() + "</div>");
                            }
                        }
                    %>
                                    </table>
                </div>
            </div>
            
        </div>
    </div>
</body>
</html>