<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="../includes/db_connect.jsp" %>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("../index.jsp");
        return; 
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>All Orders - Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
    <style>
        .container { max-width: 900px; margin: 0 auto; }
        h2 { margin-top: 0; margin-bottom: 25px; color: #2c3e50; }
    </style>
</head>
<body>
    <div class="dashboard-layout">
        
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <a href="home.jsp">Home</a>
            <a href="manageProducts.jsp">Products</a>
            <a href="viewCustomers.jsp">Customers</a>
            <a href="viewOrders.jsp" class="active">Orders</a>
        </div>

        <div class="main-content">
            
            <div class="topbar">
                <div class="profile-menu">
                    <span class="username">Admin</span>
                    <div class="profile-icon">👤</div>
                    <div class="dropdown-content">
                        <a href="../logout.jsp">Logout</a>
                    </div>
                </div>
            </div>

            <div class="content-area">
                <div class="container">
                    <h2>All Customer Orders</h2>

                    <table>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Total Amount</th>
                            <th>Action</th>
                        </tr>
                        <%
                            if (conn != null) {
                                try {
                                    String sql = "SELECT * FROM orders ORDER BY order_date DESC";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);
                                    
                                    while(rs.next()) {
                                        int id = rs.getInt("id");
                                        String username = rs.getString("username");
                                        Timestamp date = rs.getTimestamp("order_date");
                                        double total = rs.getDouble("total_amount");
                        %>
                                        <tr>
                                            <td>#<%= id %></td>
                                            <td><strong><%= username %></strong></td>
                                            <td><%= date.toString().substring(0, 16) %></td>
                                            <td style="color: #27ae60; font-weight: bold;">₹<%= String.format("%.2f", total) %></td>
                                            <td><a href="orderDetails.jsp?orderId=<%= id %>" class="btn" style="background-color: #3498db; padding: 6px 12px; width: auto; font-size: 12px;">View</a></td>
                                        </tr>
                        <%
                                    }
                                    rs.close();
                                    stmt.close();
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