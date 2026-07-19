<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Assignment 2</title>

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

    form {
        display: flex;
        flex-direction: column;
        text-align: left;
    }

    label {
        font-size: 14px;
        font-weight: 600;
        margin-bottom: 5px;
        color: #555;
    }

    input[type="text"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    input[type="submit"] {
        background-color: #3498db;
        color: white;
        border: none;
        padding: 12px;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    input[type="submit"]:hover {
        background-color: #2980b9;
    }

    .error-msg {
        color: #e74c3c;
        background-color: #fce4e4;
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 20px;
        font-size: 14px;
    }
</style>

</head>

<body>

    <div class="container">
        <h2>User Login</h2>

        <%
            String error = request.getParameter("error");
            if (error != null) {
                out.println("<div class='error-msg'>Invalid Username or Password!</div>");
            }
        %>

        <form action="loginProcess.jsp" method="post">

            <label>Username</label>
            <input type="text" name="username" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <input type="submit" value="Login">

        </form>
    </div>

</body>
</html>