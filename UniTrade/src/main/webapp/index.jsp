<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniTrade</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #3498db, #2ecc71);
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    text-align: center;
}

.container {
    background: rgba(0,0,0,0.3);
    padding: 40px;
    border-radius: 10px;
}

h1 {
    margin-bottom: 20px;
}

a {
    display: inline-block;
    margin: 10px;
    padding: 12px 20px;
    background-color: white;
    color: #333;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
}

a:hover {
    background-color: #ddd;
}
</style>

</head>
<body>

<div class="container">
    <h1>Welcome to UniTrade 🎓</h1>
    <p>Buy & Sell within your campus</p>

    <a href="login.jsp">Login</a>
    <a href="register.jsp">Register</a>
</div>

</body>
</html>