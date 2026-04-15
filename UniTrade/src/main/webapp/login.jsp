<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="assets/css/theme.css">

</head>
<body>

<div class="auth-page">
    <div class="auth-card">
        <div class="hero-eyebrow">Welcome back</div>
        <h2>Login</h2>
        <p class="section-subtitle">Access your listings, browse products, and continue where you left off.</p>

        <form action="LoginServlet" method="post">
            <input type="text" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>

            <input type="submit" value="Login" class="btn">
        </form>

        <p class="error"><%= request.getParameter("error") != null ? "Invalid Email or Password" : "" %></p>

        <p class="section-subtitle">Don't have an account? <a href="register.jsp">Register</a></p>
    </div>
</div>

</body>
</html>