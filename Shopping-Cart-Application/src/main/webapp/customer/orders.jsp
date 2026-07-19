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
    <title>My Orders</title>
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
    <style>
        .container { max-width: 900px; margin: 0 auto; }
        h2 { text-align: left; margin-top: 0; color: #2c3e50; }
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
                    <h2>My Order History</h2>

                    <table>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        <%
                            if (conn != null) {
                                try {
                                    String sql = "SELECT * FROM orders WHERE username = ? ORDER BY order_date DESC";
                                    PreparedStatement pstmt = conn.prepareStatement(sql);
                                    pstmt.setString(1, currentUser);
                                    ResultSet rs = pstmt.executeQuery();
                                    
                                    boolean hasOrders = false;
                                    while(rs.next()) {
                                        hasOrders = true;
                                        int id = rs.getInt("id");
                                        Timestamp date = rs.getTimestamp("order_date");
                                        double total = rs.getDouble("total_amount");
                        %>
                                        <tr>
                                            <td>#<%= id %></td>
                                            <td><%= date.toString().substring(0, 16) %></td>
                                            <td style="color: #27ae60; font-weight: bold;">₹<%= String.format("%.2f", total) %></td>
                                            <td><span style="background: #2ecc71; color: white; padding: 4px 8px; border-radius: 12px; font-size: 12px;">Completed</span></td>
                                            <td><a href="orderDetails.jsp?orderId=<%= id %>" class="btn" style="background-color: #3498db; padding: 6px 12px; width: auto; font-size: 12px;">View</a></td>
                                        </tr>
                        <%
                                    }
                                    if (!hasOrders) {
                                        out.println("<tr><td colspan='5' style='text-align:center;'>You haven't placed any orders yet.</td></tr>");
                                    }
                                    rs.close();
                                    pstmt.close();
                                } catch(Exception e) {
                                    out.println("<tr><td colspan='5' class='error'>Database Error: " + e.getMessage() + "</td></tr>");
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