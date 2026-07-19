<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Result Sheet</title>

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
        min-height: 100vh;
        margin: 0;
        padding: 20px;
        color: #333;
    }

    .container {
        width: 100%;
        max-width: 450px;
        background-color: #ffffff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    h2 {
        margin-top: 0;
        margin-bottom: 10px;
        text-align: center;
        color: #2c3e50;
    }

    .details {
        margin-bottom: 20px;
        padding: 15px;
        background-color: #f8f9fa;
        border: 1px solid #e9ecef;
        border-radius: 5px;
    }

    p {
        margin: 8px 0;
        font-size: 16px;
    }

    .grade-box {
        margin-top: 20px;
        padding: 15px;
        text-align: center;
        font-size: 20px;
        font-weight: bold;
        color: #ffffff;
        border-radius: 5px;
    }

    .pass {
        background-color: #2ecc71;
    }

    .fail {
        background-color: #e74c3c;
    }

    .back-btn {
        display: block;
        margin-top: 20px;
        text-align: center;
        color: #3498db;
        text-decoration: none;
        font-weight: bold;
    }

    .back-btn:hover {
        text-decoration: underline;
    }
</style>

</head>

<body>

    <div class="container">

        <%
            String calcType = request.getParameter("calcType");
            String name = request.getParameter("studentName");
            String roll = request.getParameter("rollNo");
        %>

        <h2>Result Sheet</h2>

        <div class="details">
            <p>
                <strong>Name:</strong>
                <%= name %>
            </p>

            <p>
                <strong>Roll No:</strong>
                <%= roll %>
            </p>
        </div>

        <%
            if ("marks".equals(calcType)) {

                int math = Integer.parseInt(request.getParameter("math"));
                int science = Integer.parseInt(request.getParameter("science"));
                int english = Integer.parseInt(request.getParameter("english"));

                int totalMarks = math + science + english;
                double percentage = (totalMarks / 300.0) * 100;

                String grade = "";
                String statusClass = "pass";

                if (math < 35 || science < 35 || english < 35) {
                    grade = "F (Failed in subject)";
                    statusClass = "fail";
                } else if (percentage >= 80) {
                    grade = "A (Distinction)";
                } else if (percentage >= 60) {
                    grade = "B (First Class)";
                } else if (percentage >= 40) {
                    grade = "C (Pass Class)";
                } else {
                    grade = "F (Fail)";
                    statusClass = "fail";
                }
        %>

        <p>
            <strong>Total Marks:</strong>
            <%= totalMarks %> / 300
        </p>

        <p>
            <strong>Percentage:</strong>
            <%= String.format("%.2f", percentage) %>%
        </p>

        <div class="grade-box <%= statusClass %>">
            Grade: <%= grade %>
        </div>

        <%
            } else if ("gpa".equals(calcType)) {

                String gpaType = request.getParameter("gpaType");
                double score = Double.parseDouble(request.getParameter("gpaScore"));

                double percentage = (score - 0.75) * 10.0;

                if (percentage > 100) {
                    percentage = 100.0;
                }

                if (percentage < 0) {
                    percentage = 0.0;
                }

                String classAwarded = "";
                String statusClass = "pass";

                if (score >= 7.75) {
                    classAwarded = "First Class with Distinction";
                } else if (score >= 6.75) {
                    classAwarded = "First Class";
                } else if (score >= 5.00) {
                    classAwarded = "Second Class";
                } else {
                    classAwarded = "Fail / Below Second Class";
                    statusClass = "fail";
                }
        %>

        <p>
            <strong><%= gpaType %> Score:</strong>
            <%= score %>
        </p>

        <p>
            <strong>Equivalent Percentage:</strong>
            <%= String.format("%.2f", percentage) %>%
        </p>

        <div class="grade-box <%= statusClass %>">
            Class: <%= classAwarded %>
        </div>

        <%
            }
        %>

        <a href="index.jsp" class="back-btn">
            ← New Calculation
        </a>

    </div>

</body>
</html>