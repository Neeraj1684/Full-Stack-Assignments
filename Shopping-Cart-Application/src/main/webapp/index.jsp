<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Store Login</title>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css">
</head>
<body>
    <div class="container">
        <h2>E-Commerce Login</h2>
        
        <% 
            if (request.getParameter("error") != null) { 
                out.println("<div class='error'>Invalid username or password!</div>");
            }
        %>

        <form action="auth.jsp" method="post">
            <label style="float:left; font-size:14px; font-weight:bold;">Username</label>
            <input type="text" name="username" required>
            
            <label style="float:left; font-size:14px; font-weight:bold;">Password</label>
            <input type="password" name="password" required>
            
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>