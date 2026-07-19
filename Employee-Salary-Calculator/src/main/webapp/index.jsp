<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Salary Calculator</title>

<style>
    * {
        box-sizing: border-box;
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        margin: 0;
        padding: 20px;
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        background: linear-gradient(135deg, #eef4ff, #f8fafc);
        color: #333;
    }

    .container {
        width: 100%;
        max-width: 450px;
        background: #ffffff;
        padding: 40px;
        border-radius: 14px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        border: 1px solid #e8edf3;
    }

    h2 {
        margin: 0 0 8px;
        text-align: center;
        color: #2c3e50;
    }

    .subtitle {
        text-align: center;
        color: #7f8c8d;
        font-size: 14px;
        margin-bottom: 28px;
    }

    form {
        display: flex;
        flex-direction: column;
    }

    label {
        margin: 12px 0 6px;
        font-size: 14px;
        font-weight: 600;
        color: #555;
    }

    input[type="text"],
    input[type="number"] {
        width: 100%;
        padding: 12px;
        font-size: 15px;
        border: 1px solid #d6dbe1;
        border-radius: 8px;
        outline: none;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    input[type="text"]:focus,
    input[type="number"]:focus {
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
    }

    input[type="submit"] {
        margin-top: 24px;
        padding: 12px;
        border: none;
        border-radius: 8px;
        background-color: #3498db;
        color: #ffffff;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.2s;
    }

    input[type="submit"]:hover {
        background-color: #2980b9;
        transform: translateY(-1px);
    }

    input[type="submit"]:active {
        transform: translateY(0);
    }
</style>

</head>

<body>

    <div class="container">

        <h2>Employee Salary Calculator</h2>

        <div class="subtitle">
            Generate an employee payslip by entering the details below.
        </div>

        <form action="SalaryServlet" method="post">

            <label>Employee Name</label>
            <input type="text" name="empName" required>

            <label>Employee ID</label>
            <input type="text" name="empId" required>

            <label>Basic Salary (₹)</label>
            <input type="number"
                name="basicSalary"
                min="1000"
                step="0.01"
                required>

            <input type="submit" value="Generate Payslip">

        </form>

    </div>

</body>
</html>