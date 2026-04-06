<%@ page import="java.util.*, model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Products</title>

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
}

.navbar a {
    color: white;
    margin-left: 15px;
    text-decoration: none;
    font-weight: bold;
}

/* Container */
.container {
    padding: 20px;
}

/* Filter Box */
.filter-box {
    background: white;
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 2px 6px rgba(0,0,0,0.2);
}

.filter-box input, .filter-box select {
    padding: 8px;
    margin: 5px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

/* Buttons */
.btn {
    padding: 8px 12px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.apply-btn {
    background-color: #3498db;
    color: white;
}

.clear-btn {
    background-color: #e74c3c;
    color: white;
    text-decoration: none;
    padding: 8px 12px;
}

/* Grid */
.grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
}

/* Card */
.card {
    background: white;
    width: 220px;
    margin: 15px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.2);
    overflow: hidden;
    transition: 0.3s;
}

.card:hover {
    transform: scale(1.05);
}

/* Image */
.card img {
    width: 100%;
    height: 150px;
    object-fit: cover;
}

/* Content */
.card-body {
    padding: 10px;
}

.title {
    font-weight: bold;
    margin-bottom: 5px;
}

.price {
    color: green;
    font-size: 18px;
    margin-bottom: 5px;
}

.desc {
    font-size: 14px;
    color: gray;
}
</style>

</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div>UniTrade 🎓</div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="MyProductsServlet">My Products</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Content -->
<div class="container">

    <h2 style="text-align:center;">Browse Products</h2>

    <!-- FILTER + SORT -->
    <div class="filter-box">
        <form action="ViewProductsServlet" method="get">
            
            <!-- Search -->
            <input type="text" name="keyword" placeholder="Search..."
                value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">

            <!-- Price Filter -->
            <input type="number" name="minPrice" placeholder="Min Price"
                value="<%= request.getParameter("minPrice") != null ? request.getParameter("minPrice") : "" %>">

            <input type="number" name="maxPrice" placeholder="Max Price"
                value="<%= request.getParameter("maxPrice") != null ? request.getParameter("maxPrice") : "" %>">

            <!-- SORT DROPDOWN -->
            <select name="sort">
                <option value="">Sort By</option>

                <option value="price_asc"
                    <%= "price_asc".equals(request.getParameter("sort")) ? "selected" : "" %>>
                    Price: Low to High
                </option>

                <option value="price_desc"
                    <%= "price_desc".equals(request.getParameter("sort")) ? "selected" : "" %>>
                    Price: High to Low
                </option>

                <option value="name_asc"
                    <%= "name_asc".equals(request.getParameter("sort")) ? "selected" : "" %>>
                    Name: A to Z
                </option>

                <option value="name_desc"
                    <%= "name_desc".equals(request.getParameter("sort")) ? "selected" : "" %>>
                    Name: Z to A
                </option>
            </select>

            <!-- Buttons -->
            <button type="submit" class="btn apply-btn">Apply</button>

            <a href="ViewProductsServlet" class="clear-btn">Clear</a>
        </form>
    </div>

    <!-- PRODUCTS -->
    <div class="grid">

    <%
        List<Product> products = (List<Product>) request.getAttribute("products");

        if(products != null && products.size() > 0){
            for(Product p : products){
    %>

    <div class="card">
        <img src="<%= p.getImage() %>">

        <div class="card-body">
            <div class="title"><%= p.getTitle() %></div>
            <div class="price">₹ <%= p.getPrice() %></div>
            <div class="desc"><%= p.getDescription() %></div>
        </div>
    </div>

    <%
            }
        } else {
    %>

    <p style="text-align:center;">No products found</p>

    <%
        }
    %>

    </div>

</div>

</body>
</html>