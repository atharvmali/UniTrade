<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" href="assets/css/theme.css">

</head>
<body>

<div class="auth-page">
    <div class="auth-card">
        <div class="hero-eyebrow">Join the marketplace</div>
        <h2>Create Account</h2>
        <p class="section-subtitle">Set up your profile to list products and connect with other students.</p>

        <form action="RegisterServlet" method="post">
            <input type="text" name="name" placeholder="Full Name" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>

            <input type="submit" value="Register" class="btn">
        </form>

        <p class="error"><%= request.getParameter("error") != null ? "User already exists!" : "" %></p>

        <p class="section-subtitle">Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</div>

</body>
</html>