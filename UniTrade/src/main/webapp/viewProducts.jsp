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
<%
    boolean isLoggedIn = session.getAttribute("user") != null;
%>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-brand">UniTrade</div>
    <div>
        <% if(isLoggedIn) { %>
            <a href="home.jsp">Home</a>
            <a href="MyProductsServlet">My Products</a>
            <a href="WishlistServlet">Wishlist</a>
            <a href="LogoutServlet">Logout</a>
        <% } else { %>
            <a href="index.jsp">Home</a>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        <% } %>
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

            <select name="category">
                <option value="">All Categories</option>
                <option value="Books" <%= "Books".equals(request.getParameter("category")) ? "selected" : "" %>>Books</option>
                <option value="Electronics" <%= "Electronics".equals(request.getParameter("category")) ? "selected" : "" %>>Electronics</option>
                <option value="Furniture" <%= "Furniture".equals(request.getParameter("category")) ? "selected" : "" %>>Furniture</option>
                <option value="Clothing" <%= "Clothing".equals(request.getParameter("category")) ? "selected" : "" %>>Clothing</option>
                <option value="Sports" <%= "Sports".equals(request.getParameter("category")) ? "selected" : "" %>>Sports</option>
                <option value="Other" <%= "Other".equals(request.getParameter("category")) ? "selected" : "" %>>Other</option>
            </select>

            <select name="condition">
                <option value="">All Conditions</option>
                <option value="New" <%= "New".equals(request.getParameter("condition")) ? "selected" : "" %>>New</option>
                <option value="Like New" <%= "Like New".equals(request.getParameter("condition")) ? "selected" : "" %>>Like New</option>
                <option value="Used" <%= "Used".equals(request.getParameter("condition")) ? "selected" : "" %>>Used</option>
            </select>

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
            <% if(p.getCategory() != null && !p.getCategory().trim().isEmpty()) { %>
                <div class="category-badge"><span><%= p.getCategory().substring(0, 1) %></span><%= p.getCategory() %></div>
            <% } %>
            <% if(p.isSold()) { %>
                <div class="sold-badge">Sold</div>
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
            <% if(p.isSaved()) { %>
                <a class="btn saved-btn" href="RemoveWishlistServlet?id=<%= p.getId() %>">Saved</a>
            <% } else { %>
                <a class="btn save-btn" href="SaveProductServlet?id=<%= p.getId() %>">Save Product</a>
            <% } %>

            <% if(!p.isSold()) { %>
                <details class="contact-owner">
                    <summary class="btn contact-btn">Contact Owner</summary>
                    <% if(isLoggedIn) { %>
                        <div class="contact-details">
                            <p><strong>Name:</strong> <%= p.getOwnerName() %></p>
                            <p><strong>Email:</strong> <%= p.getOwnerEmail() %></p>
                            <p><strong>Phone:</strong> <%= p.getContactNumber() %></p>
                        </div>
                    <% } else { %>
                        <div class="contact-details contact-warning">
                            <p><strong>Login required:</strong> Please login or register to view seller contact details.</p>
                            <div class="contact-actions">
                                <a href="login.jsp">Login</a>
                                <a href="register.jsp">Register</a>
                            </div>
                        </div>
                    <% } %>
                </details>
            <% } %>
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

<script src="assets/js/ui.js"></script>
</body>
</html>
