<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../includes/db_connect.jsp" %>
<%
    String role = (String) session.getAttribute("userRole");
    if (role == null || !"admin".equals(role)) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String action = request.getParameter("action");
    
    if (conn != null && action != null) {
        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                
                String sql = "INSERT INTO products (name, price) VALUES (?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setDouble(2, price);
                pstmt.executeUpdate();
                pstmt.close();
                
            } else if ("toggle".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean currentState = Boolean.parseBoolean(request.getParameter("currentState"));
                
                String sql = "UPDATE products SET is_active = ? WHERE id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setBoolean(1, !currentState); 
                pstmt.setInt(2, id);
                pstmt.executeUpdate();
                pstmt.close();
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                
                String sql = "UPDATE products SET name = ?, price = ? WHERE id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setDouble(2, price);
                pstmt.setInt(3, id);
                pstmt.executeUpdate();
                pstmt.close();
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        } finally {
            conn.close();
        }
    }
    
    response.sendRedirect("manageProducts.jsp");
%>