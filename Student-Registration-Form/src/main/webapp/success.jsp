<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Registration Successful</title>
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
		.card {
			background-color: white;
			padding: 30px;
			border-radius: 8px;
			box-shadow: 0 4px 8px rgba(0,0,0,0.2);
			width: 100%;
			max-width: 500px;
		}
		h2 { 
			color: #28a745; 
			text-align: center; 
		}
		table { 
			width: 100%; 
			border-collapse: collapse; 
			margin-top: 20px; 
		}
		th, td { 
			padding: 10px; 
			border-bottom: 1px solid #ddd; 
			text-align: left; 
		}
		th { 
			color: #555; 
			width: 40%; 
		}
	</style>
</head>
<body>
	<div class="card">
		<h2>Registration Successful!</h2>
		<p>Welcome, <strong>${firstName} ${lastName}</strong>. Here is the data we received:</p>
		
		<table>
			<tr>
				<th>Email:</th>
				<td>${email}</td>
			</tr>
			<tr>
				<th>Date of Birth:</th>
				<td>${dob}</td>
			</tr>
			<tr>
				<th>Gender:</th>
				<td>${gender}</td>
			</tr>
			<tr>
				<th>Course:</th>
				<td>${course}</td>
			</tr>
			<tr>
				<th>Address:</th>
				<td>${address}</td>
			</tr>
			<tr>
				<th>Domains of Interest:</th>
				<td>${domains}</td>
			</tr>
		</table>
	</div>
</body>
</html>