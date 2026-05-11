<%@ page import="model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product</title>
<link rel="stylesheet" href="assets/css/theme.css">

</head>
<body>

<%
    Product p = (Product) request.getAttribute("product");
%>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-brand">UniTrade</div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="MyProductsServlet">My Products</a>
        <a href="WishlistServlet">Wishlist</a>
    </div>
</div>

<!-- Form -->
<div class="page-shell top-align">

    <div class="form-card">
        <h2>Edit Product</h2>
        <p class="section-subtitle">Refine your listing details and keep your catalog up to date.</p>

        <form action="UpdateProductServlet" method="post">

            <input type="hidden" name="id" value="<%= p.getId() %>">

            <div class="form-group">
                <label>Title</label>
                <input type="text" name="title" value="<%= p.getTitle() %>" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <input type="text" name="description" value="<%= p.getDescription() %>" required>
            </div>

            <div class="form-group">
                <label>Price</label>
                <input type="text" name="price" value="<%= p.getPrice() %>" required>
            </div>

            <div class="form-group">
                <label>Condition</label>
                <select name="productCondition" required>
                    <option value="">Select Condition</option>
                    <option value="New" <%= "New".equals(p.getProductCondition()) ? "selected" : "" %>>New</option>
                    <option value="Like New" <%= "Like New".equals(p.getProductCondition()) ? "selected" : "" %>>Like New</option>
                    <option value="Used" <%= "Used".equals(p.getProductCondition()) ? "selected" : "" %>>Used</option>
                </select>
            </div>

            <div class="form-group">
                <label>Category</label>
                <select name="category" required>
                    <option value="">Select Category</option>
                    <option value="Books" <%= "Books".equals(p.getCategory()) ? "selected" : "" %>>Books</option>
                    <option value="Electronics" <%= "Electronics".equals(p.getCategory()) ? "selected" : "" %>>Electronics</option>
                    <option value="Furniture" <%= "Furniture".equals(p.getCategory()) ? "selected" : "" %>>Furniture</option>
                    <option value="Clothing" <%= "Clothing".equals(p.getCategory()) ? "selected" : "" %>>Clothing</option>
                    <option value="Sports" <%= "Sports".equals(p.getCategory()) ? "selected" : "" %>>Sports</option>
                    <option value="Other" <%= "Other".equals(p.getCategory()) ? "selected" : "" %>>Other</option>
                </select>
            </div>

            <div class="form-group">
                <label>Campus Location</label>
                <input type="text" name="campusLocation" value="<%= p.getCampusLocation() != null ? p.getCampusLocation() : "" %>" required>
            </div>

            <div class="form-group checkbox-group">
                <label>
                    <input type="checkbox" name="sold" <%= p.isSold() ? "checked" : "" %>>
                    Sold
                </label>
            </div>

            <input type="submit" value="Update Product" class="btn">

        </form>
    </div>

</div>

<script src="assets/js/ui.js"></script>
</body>
</html>
