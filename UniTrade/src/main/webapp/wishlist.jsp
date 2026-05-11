<%@ page import="java.util.*, model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Wishlist</title>
<link rel="stylesheet" href="assets/css/theme.css">
</head>
<body>

<div class="navbar">
    <div class="navbar-brand">UniTrade</div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="ViewProductsServlet">All Products</a>
        <a href="MyProductsServlet">My Products</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<div class="page-shell top-align">
<div class="page-content">

    <div class="page-header">
        <h2>Wishlist</h2>
        <p>Products you saved for later.</p>
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
            <% if(p.getCategory() != null && !p.getCategory().trim().isEmpty()) { %>
                <div class="category-badge"><span><%= p.getCategory().substring(0, 1) %></span><%= p.getCategory() %></div>
            <% } %>
            <% if(p.isSold()) { %>
                <div class="sold-badge">Sold</div>
            <% } else { %>
                <div class="available-badge">Available</div>
            <% } %>
            <div class="price">₹ <%= p.getPrice() %></div>
            <div class="desc"><%= p.getDescription() %></div>

            <div class="product-info">
                <% if(p.getProductCondition() != null) { %>
                    <span>Condition: <%= p.getProductCondition() %></span>
                <% } %>
                <% if(p.getCampusLocation() != null) { %>
                    <span>Location: <%= p.getCampusLocation() %></span>
                <% } %>
            </div>

            <a class="btn saved-btn" href="RemoveWishlistServlet?id=<%= p.getId() %>">Remove</a>

            <% if(!p.isSold()) { %>
                <details class="contact-owner">
                    <summary class="btn contact-btn">Contact Owner</summary>
                    <div class="contact-details">
                        <p><strong>Name:</strong> <%= p.getOwnerName() %></p>
                        <p><strong>Email:</strong> <%= p.getOwnerEmail() %></p>
                        <p><strong>Phone:</strong> <%= p.getContactNumber() %></p>
                    </div>
                </details>
            <% } %>
        </div>
    </div>

    <%
            }
        } else {
    %>

    <p class="empty-state">No saved products yet</p>

    <%
        }
    %>

    </div>

</div>
</div>

<script src="assets/js/ui.js"></script>
</body>
</html>
