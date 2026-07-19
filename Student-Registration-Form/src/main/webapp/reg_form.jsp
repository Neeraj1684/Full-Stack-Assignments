<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Registration Form</title>
	<style>
		body {
			background-color: cyan;
			font-family: Arial, sans-serif;
			display: flex;
			justify-content: center;
			align-items: center;
			min-height: 100vh;
			margin: 0;
		}
		
		.form-card {
			background-color: white;
			padding: 30px;
			border-radius: 8px;
			box-shadow: 0 4px 8px rgba(0,0,0,0.2);
			width: 100%;
			max-width: 450px;
			margin: 20px;
		}
		
		h2 {
			text-align: center;
			color: #333;
			margin-top: 0;
			margin-bottom: 20px;
		}
		
		.form-group{
			margin-bottom: 15px;
		}
		
		label {
			display: block;
			margin-bottom: 5px;
			font-weight: bold;
			color: #555;
		}
		
		input[type="text"], 
		input[type="email"], 
		input[type="date"], 
		select, 
		textarea {
			width: 100%;
			padding: 10px;
			border: 1px solid #ccc;
			border-radius: 4px;
			box-sizing: border-box;
		}
		
		select:invalid {
		 	color: #999999;
		}
		
		select option {
			color: #000000;
		}
		
		.radio-group, .checkbox-group {
			display: flex;
			gap: 15px;
			font-weight: normal;
			flex-wrap: wrap;
		}
		
		.radio-group label, .checkbox-group label {
			font-weight: normal;
			display: flex;
			align-items: center;
			gap: 5px;
		}
		
		.button-group {
			display: flex;
			justify-content: center;
			align-items: center;
			gap: 15px;
			margin-top: 10px;
		}
		
		.submit-btn, .reset-btn {
			flex: 1;
			padding: 12px;
			color: white;
			border: none;
			border-radius: 4px;
			cursor: pointer;
			font-size: 16px;
			font-weight: bold;
			transition: background-color 0.3s ease;
		}
		
		.submit-btn {
			background-color: #007BFF;
		}
		
		.submit-btn:hover{
			background-color: #0056b3;
		}

		.reset-btn {
			background-color: #6c757d; 
		}
		
		.reset-btn:hover {
			background-color: #5a6268;
		}
	</style>
</head>
<body>
	<div class="form-card">
		<h2>Student Registration</h2>
		
		<form action="register" method="POST">
			<div class="form-group">
				<label for="firstName">First Name:</label>
				<input type="text" id="firstName" name="firstName" placeholder="Enter First Name" required>
			</div>
			<div class="form-group">
				<label for="lastName">Last Name:</label>
				<input type="text" id="lastName" name="lastName" placeholder="Enter Last Name" required>
			</div>
			<div class="form-group">
				<label for="email">Email:</label>
				<input type="email" id="email" name="email" placeholder="Enter Email" required>
			</div>
			<div class="form-group">
				<label for="dob">Date of Birth:</label>
				<input type="date" id="dob" name="dob" required>
			</div>
			<div class="form-group">
				<label>Gender:</label>
				<div class="radio-group">
					<label> <input type="radio" name="gender" value="Male" required> Male </label>
					<label> <input type="radio" name="gender" value="Female" required> Female </label>
				</div>
			</div>
			<div class="form-group">
				<label for="address">Address:</label>
				<textarea id="address" name="address" rows="3" placeholder="Enter Full Address"></textarea>
			</div>
			<div class="form-group">
				<label for="course">Course/Major:</label>
				<select id="course" name="course" required>
					<option value="" disabled selected hidden>-- Select a Course --</option>
					<option value="Computer Science">Computer Science</option>
					<option value="MBA">MBA</option>
					<option value="Architecture">Architecture</option>
					<option value="BPharma">BPharma</option>
				</select>
			</div>
			<div class="form-group">
				<label>Interested Domains:</label>
				<div class="checkbox-group">
					<label><input type="checkbox" name="domains" value="AIML"> AIML</label>
					<label><input type="checkbox" name="domains" value="Cloud"> Cloud</label>
					<label><input type="checkbox" name="domains" value="Web Development"> Web Development</label>
					<label><input type="checkbox" name="domains" value="Cybersecurity"> Cybersecurity</label>
				</div>
			</div>
			<div class="button-group">
				<button type="submit" class="submit-btn">Submit</button>
				<button type="reset" class="reset-btn" >Reset</button>
			</div> 
		</form>
	</div>
</body>
</html>