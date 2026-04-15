

<%@ page import="java.util.*, model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Products</title>
<link rel="stylesheet" href="assets/css/theme.css">

</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-brand">UniTrade</div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="ViewProductsServlet">All Products</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Content -->
<div class="page-shell top-align">
<div class="page-content">

    <div class="page-header">
        <h2>My Products</h2>
        <p>Manage the listings you have posted and keep them updated.</p>
    </div>

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

    <p class="empty-state">No products found</p>

    <%
        }
    %>

    </div>

</div>
</div>

</body>
</html>