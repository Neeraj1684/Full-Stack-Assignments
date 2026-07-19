<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String user = request.getParameter("username");
    String pass = request.getParameter("password");

    if (user != null && pass != null && user.equals("admin") && pass.equals("password123")) {
        session.setAttribute("loggedInUser", user);        
        response.sendRedirect("welcome.jsp");
    } else {
        response.sendRedirect("login.jsp?error=1");
    }
%>