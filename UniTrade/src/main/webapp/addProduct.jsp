<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<link rel="stylesheet" href="assets/css/theme.css">

</head>
<body>

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
        <h2>Add Product</h2>
        <p class="section-subtitle">List a new item with a photo and clear details.</p>

        <form action="AddProductServlet" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label>Title</label>
                <input type="text" name="title" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <input type="text" name="description" required>
            </div>

            <div class="form-group">
                <label>Price</label>
                <input type="text" name="price" required>
            </div>

            <div class="form-group">
                <label>Contact Number</label>
                <input type="text" name="contactNumber" placeholder="Enter your contact number" required>
            </div>

            <div class="form-group">
                <label>Upload Image</label>
                <input type="file" name="image" required>
            </div>

            <input type="submit" value="Add Product" class="btn">

        </form>
    </div>

</div>

</body>
</html>