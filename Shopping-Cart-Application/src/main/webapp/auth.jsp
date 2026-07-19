<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="includes/db_connect.jsp" %>
<%
    String user = request.getParameter("username");
    String pass = request.getParameter("password");
    
    if (conn != null && user != null && pass != null) {
        try {
            String sql = "SELECT role FROM users WHERE username = ? AND password = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user);
            pstmt.setString(2, pass);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String role = rs.getString("role");
                session.setAttribute("currentUser", user);
                session.setAttribute("userRole", role);
                
                if ("admin".equals(role)) {
                    response.sendRedirect("admin/home.jsp"); 
                } else {
                    response.sendRedirect("customer/shop.jsp"); 
                }
            } else {
                response.sendRedirect("index.jsp?error=1");
            }
            
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            out.println("Error verifying login: " + e.getMessage());
        } finally {
            conn.close();
        }
    }
%>