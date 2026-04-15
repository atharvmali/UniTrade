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
<link rel="stylesheet" href="assets/css/theme.css">

</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-brand">UniTrade</div>
    
    <div class="nav-links">
        <a href="ViewProductsServlet">All Products</a>
        <a href="MyProductsServlet">My Products</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="page-shell top-align">
<div class="page-content">

    <div class="home-grid">
        <section class="hero-card home-hero">
            <div class="hero-eyebrow">Campus marketplace</div>
            <h1 class="hero-title">Welcome to <span>UniTrade</span></h1>
            <p class="hero-copy">Buy and sell items within your campus with a smooth, modern browsing experience built to help students discover and list products faster.</p>

            <div class="home-search-panel">
                <div class="search-box">
                    <form action="SearchServlet" method="get">
                        <input type="text" name="keyword" placeholder="Search products, books, gadgets, or essentials...">
                        <input type="submit" value="Search">
                    </form>
                </div>

                <div class="hero-actions home-actions">
                    <a href="addProduct.jsp">➕ Add Product</a>
                    <a href="ViewProductsServlet">🛒 Browse Products</a>
                    <a href="MyProductsServlet">📦 My Products</a>
                </div>
            </div>
        </section>

    </div>

</div>
</div>

</body>
</html>