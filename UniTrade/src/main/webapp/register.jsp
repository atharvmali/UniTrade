<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background: linear-gradient(135deg, #2ecc71, #3498db);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

/* Card */
.card {
    background: white;
    padding: 30px;
    border-radius: 10px;
    width: 320px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.2);
    text-align: center;
}

.card h2 {
    margin-bottom: 20px;
}

/* Inputs */
input {
    width: 100%;
    padding: 10px;
    margin: 10px 0;
    border-radius: 5px;
    border: 1px solid #ccc;
}

/* Button */
.btn {
    background-color: #2ecc71;
    color: white;
    border: none;
    cursor: pointer;
}

.btn:hover {
    background-color: #27ae60;
}

/* Error */
.error {
    color: red;
    font-size: 14px;
}
</style>

</head>
<body>

<div class="card">
    <h2>Create Account</h2>

    <form action="RegisterServlet" method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>

        <input type="submit" value="Register" class="btn">
    </form>

    <p class="error">
    <%= request.getParameter("error") != null ? "User already exists!" : "" %>
    </p>

    <p>Already have an account? <a href="login.jsp">Login</a></p>
</div>

</body>
</html>