<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/shopping_cart";
        String dbUser = "root";
        String dbPass = "Luffy@0808"; 
        conn = DriverManager.getConnection(url, dbUser, dbPass);
    } catch(Exception e) {
        out.println("<div class='error'>Database connection failed: " + e.getMessage() + "</div>");
    }
%>