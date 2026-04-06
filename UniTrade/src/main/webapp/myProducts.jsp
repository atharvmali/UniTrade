

<%@ page import="java.util.*, model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Products</title>

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

.navbar a:hover {
    text-decoration: underline;
}

/* Container */
.container {
    padding: 20px;
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
    text-align: center;
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
    margin-bottom: 10px;
}

/* Buttons */
.btn {
    display: inline-block;
    padding: 6px 10px;
    margin: 5px;
    text-decoration: none;
    border-radius: 5px;
    font-size: 14px;
}

.edit {
    background-color: #3498db;
    color: white;
}

.delete {
    background-color: #e74c3c;
    color: white;
}

.btn:hover {
    opacity: 0.8;
}
</style>

</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div>UniTrade 🎓</div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="ViewProductsServlet">All Products</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Content -->
<div class="container">

    <h2>My Products</h2>

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

            <!-- Buttons -->
            <a class="btn edit" href="EditProductServlet?id=<%= p.getId() %>">Edit</a>
            
            <a class="btn delete" 
               href="DeleteProductServlet?id=<%= p.getId() %>"
               onclick="return confirm('Are you sure you want to delete?')">
               Delete
            </a>
        </div>
    </div>

    <%
            }
        } else {
    %>

    <p>No products found</p>

    <%
        }
    %>

    </div>

</div>

</body>
</html>