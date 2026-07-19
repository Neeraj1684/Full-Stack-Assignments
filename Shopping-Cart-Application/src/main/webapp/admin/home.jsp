<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
</head>
<body>
    <div class="dashboard-layout">
        
        <div class="sidebar">
            <h2>Admin Panel</h2>
            <a href="home.jsp" class="active">Home</a>
            <a href="manageProducts.jsp">Products</a>
            <a href="viewCustomers.jsp">Customers</a>
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
                <div class="container" style="max-width: 100%; height: 60vh; display: flex; flex-direction: column; justify-content: center; align-items: center; border: 2px dashed #ccc; background: transparent; box-shadow: none;">
                    <h1 style="color: #2c3e50; margin-bottom: 10px;">Welcome to the Admin Side</h1>
                    <p style="color: #7f8c8d; font-size: 18px;">This is the central hub where you can manage products, track customer orders, and view registered users. Use the sidebar to navigate.</p>
                </div>
            </div>

        </div>
    </div>
</body>
</html>