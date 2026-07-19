<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/db_connect.jsp" %>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("../index.jsp");
        return; 
    }
    
    String idParam = request.getParameter("id");
    if (idParam == null) {
        response.sendRedirect("manageProducts.jsp");
        return;
    }
    
    String currentName = "";
    double currentPrice = 0.0;
    
    if (conn != null) {
        try {
            String sql = "SELECT name, price FROM products WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(idParam));
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                currentName = rs.getString("name");
                currentPrice = rs.getDouble("price");
            }
            rs.close();
            pstmt.close();
        } catch(Exception e) {
            out.println("Database Error: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <link rel="stylesheet" type="text/css" href="../assets/css/style.css">
</head>
<body>
    <div class="container">
        <h2>Edit Product #<%= idParam %></h2>
        
        <form action="productAction.jsp" method="post" style="text-align: left;">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= idParam %>">
            
            <label style="font-weight: bold;">Product Name</label>
            <input type="text" name="name" value="<%= currentName %>" required>
            
            <label style="font-weight: bold;">Price (₹)</label>
            <input type="number" name="price" value="<%= currentPrice %>" step="0.01" min="0" required>
            
            <input type="submit" value="Save Changes" style="background-color: #2ecc71;">
            <a href="manageProducts.jsp" class="btn" style="background-color: #95a5a6; margin-top: 10px;">Cancel</a>
        </form>
    </div>
</body>
</html>