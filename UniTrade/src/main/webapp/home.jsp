<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UniTrade - Home</title>

<style>
body {
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
}

/* Navbar */
.navbar {
    background-color: #2c3e50;
    padding: 15px;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar h2 {
    margin: 0;
}

.nav-links a {
    color: white;
    margin-left: 15px;
    text-decoration: none;
    font-weight: bold;
}

.nav-links a:hover {
    text-decoration: underline;
}

/* Container */
.container {
    text-align: center;
    margin-top: 50px;
}

/* Search box */
.search-box input[type="text"] {
    padding: 10px;
    width: 250px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

.search-box input[type="submit"] {
    padding: 10px 15px;
    border: none;
    background-color: #3498db;
    color: white;
    border-radius: 5px;
    cursor: pointer;
}

.search-box input[type="submit"]:hover {
    background-color: #2980b9;
}

/* Buttons */
.buttons {
    margin-top: 30px;
}

.buttons a {
    display: inline-block;
    margin: 10px;
    padding: 12px 20px;
    background-color: #2ecc71;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
}

.buttons a:hover {
    background-color: #27ae60;
}
</style>

</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <h2>UniTrade 🎓</h2>
    
    <div class="nav-links">
        <a href="ViewProductsServlet">All Products</a>
        <a href="MyProductsServlet">My Products</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="container">

    <h1>Welcome to UniTrade</h1>
    <p>Buy and sell items within your campus</p>

    <!-- Search -->
    <div class="search-box">
        <form action="SearchServlet" method="get">
            <input type="text" name="keyword" placeholder="Search products...">
            <input type="submit" value="Search">
        </form>
    </div>

    <!-- Action Buttons -->
    <div class="buttons">
        <a href="addProduct.jsp">➕ Add Product</a>
        <a href="ViewProductsServlet">🛒 Browse Products</a>
        <a href="MyProductsServlet">📦 My Products</a>
    </div>

</div>

</body>
</html>