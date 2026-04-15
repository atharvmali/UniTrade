<%@ page import="java.util.*, model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Products</title>
<link rel="stylesheet" href="assets/css/theme.css">

</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-brand">UniTrade</div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="MyProductsServlet">My Products</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Content -->
<div class="page-shell top-align">
<div class="page-content">

    <div class="page-header" style="text-align:center;">
        <h2>Browse Products</h2>
        <p>Explore listings with search, price filters, and sorting built into one clean view.</p>
    </div>

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

            <details class="contact-owner">
                <summary class="btn contact-btn">Contact Owner</summary>
                <div class="contact-details">
                    <p><strong>Name:</strong> <%= p.getOwnerName() %></p>
                    <p><strong>Email:</strong> <%= p.getOwnerEmail() %></p>
                    <p><strong>Phone:</strong> <%= p.getContactNumber() %></p>
                </div>
            </details>
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