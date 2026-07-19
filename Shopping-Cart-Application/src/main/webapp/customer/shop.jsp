<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="../includes/db_connect.jsp" %>
<%
    String role = (String) session.getAttribute("userRole");
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
    <title>Storefront</title>
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
    <style>
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 20px; }
        .product-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); border: 1px solid #eee; text-align: center; }
        .price { font-size: 18px; font-weight: bold; color: #27ae60; margin: 10px 0; }
        
        #toast {
            background-color: #2ecc71; color: #fff; text-align: center; border-radius: 5px;
            padding: 15px; min-width: 250px; font-size: 16px; font-weight: bold;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2); z-index: 1000;
            position: fixed; left: 50%; top: 25px; transform: translate(-50%, -25px);
            opacity: 0; visibility: hidden; transition: transform .35s ease, opacity .35s ease;
        }
        #toast.show { visibility: visible; opacity: 1; transform: translate(-50%, 0); }
    </style>
</head>
<body>

    <div id="toast">🛒 Product added to cart</div>

    <div class="dashboard-layout">
        
        <div class="sidebar">
            <h2>E-Shop</h2>
            <a href="shop.jsp" class="active">Shop</a>
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
                <div class="container" style="max-width: 1000px; margin: 0 auto; background: transparent; box-shadow: none; padding: 0;">
                    
                    <h2 style="text-align: left; margin-top: 0;">Available Products</h2>
                    
                    <div class="product-grid">
                        <%
                            if (conn != null) {
                                try {
                                    String sql = "SELECT * FROM products WHERE is_active = TRUE ORDER BY id DESC";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);
                                    
                                    while(rs.next()) {
                                        int id = rs.getInt("id");
                                        String name = rs.getString("name");
                                        double price = rs.getDouble("price");
                        %>
                                        <div class="product-card">
                                            <h3><%= name %></h3>
                                            <div class="price">₹<%= String.format("%.2f", price) %></div>
                                            <form action="cartAction.jsp" method="post" style="margin:0;">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="id" value="<%= id %>">
                                                <input type="submit" value="Add to Cart" style="background-color: #3498db; margin-top: 10px;">
                                            </form>
                                        </div>
                        <%
                                    }
                                    rs.close();
                                    stmt.close();
                                } catch(Exception e) {
                                    out.println("<div class='error'>Database Error: " + e.getMessage() + "</div>");
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
            
        </div>
    </div>

    <% if ("true".equals(request.getParameter("added"))) { %>
        <script>
            const toast = document.getElementById("toast");
            toast.classList.add("show");
            setTimeout(() => { toast.classList.remove("show"); }, 3000);
        </script>
    <% } %>
    
</body>
</html>