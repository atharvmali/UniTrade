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

            <input type="submit" value="Update Product" class="btn">

        </form>
    </div>

</div>

</body>
</html>