<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Salary Slip</title>

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
        max-width: 500px;
        background: #ffffff;
        padding: 40px;
        border-radius: 14px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        border: 1px solid #e8edf3;
    }

    h2 {
        margin: 0;
        text-align: center;
        text-transform: uppercase;
        color: #2c3e50;
    }

    .slip-header {
        margin: 12px 0 30px;
        text-align: center;
        color: #7f8c8d;
        font-size: 14px;
    }

    .row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 0;
        border-bottom: 1px solid #ececec;
    }

    .gross {
        margin-top: 10px;
        padding: 14px 12px;
        background: #f8f9fa;
        border-radius: 8px;
        font-weight: 600;
        border: none;
    }

    .deduction {
        color: #e74c3c;
    }

    .total {
        margin-top: 18px;
        padding-top: 18px;
        border-top: 2px solid #d9d9d9;
        border-bottom: none;
        font-size: 19px;
        font-weight: 700;
        color: #27ae60;
    }

    .back-btn {
        display: block;
        margin-top: 30px;
        text-align: center;
        color: #3498db;
        text-decoration: none;
        font-weight: 600;
    }

    .back-btn:hover {
        text-decoration: underline;
    }
</style>

</head>

<body>

    <div class="container">

        <%
            String empName = (String) request.getAttribute("empName");
            String empId = (String) request.getAttribute("empId");
            double basicSalary = (Double) request.getAttribute("basicSalary");
            double hra = (Double) request.getAttribute("hra");
            double da = (Double) request.getAttribute("da");
            double pf = (Double) request.getAttribute("pf");
            double grossSalary = (Double) request.getAttribute("grossSalary");
            double tax = (Double) request.getAttribute("tax");
            double netSalary = (Double) request.getAttribute("netSalary");
        %>

        <h2>Salary Slip</h2>

        <div class="slip-header">
            Employee Name:
            <strong><%= empName %></strong>
            &nbsp;|&nbsp;
            Employee ID:
            <strong><%= empId %></strong>
        </div>

        <div class="row">
            <span>Basic Salary</span>
            <span>₹ <%= String.format("%.2f", basicSalary) %></span>
        </div>

        <div class="row">
            <span>HRA (20%)</span>
            <span>₹ <%= String.format("%.2f", hra) %></span>
        </div>

        <div class="row">
            <span>DA (10%)</span>
            <span>₹ <%= String.format("%.2f", da) %></span>
        </div>

        <div class="row gross">
            <span>Gross Salary</span>
            <span>₹ <%= String.format("%.2f", grossSalary) %></span>
        </div>

        <div class="row deduction">
            <span>PF Deduction (12%)</span>
            <span>- ₹ <%= String.format("%.2f", pf) %></span>
        </div>

        <div class="row deduction">
            <span>Tax Deduction</span>
            <span>- ₹ <%= String.format("%.2f", tax) %></span>
        </div>

        <div class="row total">
            <span>Net Salary</span>
            <span>₹ <%= String.format("%.2f", netSalary) %></span>
        </div>

        <a href="index.jsp" class="back-btn">
            ← Calculate Another Salary
        </a>

    </div>

</body>
</html>