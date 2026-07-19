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
    <title>Registered Customers - Admin Dashboard</title>
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
            <a href="viewCustomers.jsp" class="active">Customers</a>
            <a href="viewOrders.jsp">Orders</a>
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
                    <h2>Registered Customers</h2>

                    <table>
                        <tr>
                            <th>User ID</th>
                            <th>Username</th>
                            <th>Account Type</th>
                        </tr>
                        <%
                            if (conn != null) {
                                try {
                                    String sql = "SELECT id, username, role FROM users WHERE role = 'customer' ORDER BY id ASC";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);
                                    
                                    while(rs.next()) {
                                        int id = rs.getInt("id");
                                        String username = rs.getString("username");
                                        String accountRole = rs.getString("role");
                        %>
                                        <tr>
                                            <td><%= id %></td>
                                            <td><strong><%= username %></strong></td>
                                            <td><span style="background: #34495e; color: white; padding: 4px 10px; border-radius: 12px; font-size: 12px; text-transform: capitalize;"><%= accountRole %></span></td>
                                        </tr>
                        <%
                                    }
                                    rs.close();
                                    stmt.close();
                                } catch(Exception e) {
                                    out.println("<tr><td colspan='3' class='error'>Database Error: " + e.getMessage() + "</td></tr>");
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