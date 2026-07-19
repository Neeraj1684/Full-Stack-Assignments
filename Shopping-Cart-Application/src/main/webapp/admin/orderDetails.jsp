<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../includes/db_connect.jsp" %>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("../index.jsp");
        return; 
    }
    
    String orderId = request.getParameter("orderId");
    if (orderId == null) {
        response.sendRedirect("viewOrders.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Details - Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
    <style>
        .container { max-width: 900px; margin: 0 auto; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .page-header h2 { margin: 0; color: #2c3e50; }
        .summary-box { background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #ddd; display: flex; justify-content: space-between; }
    </style>
</head>
<body>
    <div class="admin-layout">
        
        <!-- SIDEBAR -->
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <a href="home.jsp">Home</a>
            <a href="manageProducts.jsp">Products</a>
            <a href="viewCustomers.jsp">Customers</a>
            <a href="viewOrders.jsp" class="active">Orders</a>
        </div>

        <!-- MAIN CONTENT WRAPPER -->
        <div class="main-content">
            
            <!-- TOPBAR -->
            <div class="topbar">
                <div class="profile-menu">
                    <span class="username">Admin</span>
                    <div class="profile-icon">👤</div>
                    <div class="dropdown-content">
                        <a href="../logout.jsp">Logout</a>
                    </div>
                </div>
            </div>

            <!-- PAGE SPECIFIC CONTENT -->
            <div class="content-area">
                <div class="container">
                    
                    <div class="page-header">
                        <h2>Order Details #<%= orderId %></h2>
                        <a href="viewOrders.jsp" class="btn" style="width: auto; background-color: #95a5a6;">← Back to All Orders</a>
                    </div>

                    <%
                        if (conn != null) {
                            try {
                                String orderSql = "SELECT username, total_amount, order_date FROM orders WHERE id = ?";
                                PreparedStatement orderStmt = conn.prepareStatement(orderSql);
                                orderStmt.setInt(1, Integer.parseInt(orderId));
                                ResultSet orderRs = orderStmt.executeQuery();
                                
                                if (orderRs.next()) {
                                    String customerName = orderRs.getString("username");
                                    double grandTotal = orderRs.getDouble("total_amount");
                                    String date = orderRs.getTimestamp("order_date").toString().substring(0, 16);
                    %>
                                    <div class="summary-box">
                                        <div><strong>Customer:</strong> <%= customerName %> | <strong>Date:</strong> <%= date %></div>
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
                                    out.println("<div class='error'>Order not found.</div>");
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
