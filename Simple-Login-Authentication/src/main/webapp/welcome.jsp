<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String currentUser = (String) session.getAttribute("loggedInUser");

    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome</title>

<style>
    * {
        box-sizing: border-box;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background-color: #f4f7f6;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
        color: #333;
    }

    .container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
        text-align: center;
    }

    h2 {
        margin-top: 0;
        margin-bottom: 20px;
        color: #2c3e50;
    }

    p {
        color: #7f8c8d;
    }

    .logout-btn {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #e74c3c;
        color: #ffffff;
        text-decoration: none;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .logout-btn:hover {
        background-color: #c0392b;
    }
</style>

</head>

<body>

    <div class="container">
        <h2>Welcome, <%= currentUser %>!</h2>

        <p>
            You have successfully logged in using JSP session management.
        </p>

        <a href="logout.jsp" class="logout-btn">Logout</a>
    </div>

</body>
</html>