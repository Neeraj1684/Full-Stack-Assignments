<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Result &amp; CGPA Converter</title>

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
        max-width: 500px;
        background-color: #ffffff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    h2 {
        margin-top: 0;
        margin-bottom: 20px;
        text-align: center;
        color: #2c3e50;
    }

    .tab {
        display: flex;
        margin-bottom: 20px;
        border-bottom: 2px solid #eeeeee;
    }

    .tab button {
        flex: 1;
        padding: 12px 16px;
        background-color: inherit;
        border: none;
        outline: none;
        cursor: pointer;
        font-size: 15px;
        font-weight: 600;
        color: #7f8c8d;
        transition: 0.3s;
    }

    .tab button:hover {
        background-color: #f8f9fa;
    }

    .tab button.active {
        color: #3498db;
        border-bottom: 3px solid #3498db;
    }

    .tabcontent {
        display: none;
        animation: fadeEffect 0.5s;
    }

    @keyframes fadeEffect {
        from {
            opacity: 0;
        }

        to {
            opacity: 1;
        }
    }

    form {
        display: flex;
        flex-direction: column;
    }

    label {
        margin-top: 10px;
        margin-bottom: 5px;
        font-size: 14px;
        font-weight: 600;
        color: #555;
    }

    input[type="text"],
    input[type="number"],
    select {
        width: 100%;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #cccccc;
        border-radius: 5px;
        font-size: 16px;
    }

    input[type="number"] {
        -moz-appearance: textfield;
    }

    input[type="submit"] {
        margin-top: 15px;
        padding: 12px;
        background-color: #3498db;
        color: #ffffff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
        transition: 0.3s;
    }

    input[type="submit"]:hover {
        background-color: #2980b9;
    }
</style>

<script>
    function openTab(evt, tabName) {
        let i;
        let tabcontent = document.getElementsByClassName("tabcontent");
        let tablinks = document.getElementsByClassName("tablinks");

        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }

        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className =
                tablinks[i].className.replace(" active", "");
        }

        document.getElementById(tabName).style.display = "block";
        evt.currentTarget.className += " active";
    }
</script>

</head>

<body onload="document.getElementById('defaultOpen').click();">

    <div class="container">

        <h2>Student Assessment</h2>

        <div class="tab">
            <button class="tablinks" id="defaultOpen"
                onclick="openTab(event, 'MarksTab')">
                Subject Marks
            </button>

            <button class="tablinks"
                onclick="openTab(event, 'CGPATab')">
                CGPA Converter
            </button>
        </div>

        <div id="MarksTab" class="tabcontent">

            <form action="processResult.jsp" method="post">

                <input type="hidden" name="calcType" value="marks">

                <label>Student Name</label>
                <input type="text" name="studentName" required>

                <label>Roll Number</label>
                <input type="text" name="rollNo" required>

                <label>Math Marks (out of 100)</label>
                <input type="number" name="math"
                    min="0" max="100" required>

                <label>Science Marks (out of 100)</label>
                <input type="number" name="science"
                    min="0" max="100" required>

                <label>English Marks (out of 100)</label>
                <input type="number" name="english"
                    min="0" max="100" required>

                <input type="submit" value="Calculate Result">

            </form>

        </div>

        <div id="CGPATab" class="tabcontent">

            <form action="processResult.jsp" method="post">

                <input type="hidden" name="calcType" value="gpa">

                <label>Student Name</label>
                <input type="text" name="studentName" required>

                <label>Roll Number</label>
                <input type="text" name="rollNo" required>

                <label>Grade Type</label>

                <select name="gpaType">
                    <option value="CGPA">CGPA</option>
                    <option value="SGPA">SGPA</option>
                </select>

                <label>Score (Max 10.0)</label>

                <input type="number"
                    name="gpaScore"
                    step="0.01"
                    min="0"
                    max="10"
                    required>

                <input type="submit"
                    value="Convert to Percentage">

            </form>

        </div>

    </div>

</body>
</html>