<%@ page import="model.Product" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product</title>

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
    display: flex;
    justify-content: center;
    align-items: center;
    height: 90vh;
}

/* Form Card */
.form-card {
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.2);
    width: 350px;
}

.form-card h2 {
    text-align: center;
    margin-bottom: 20px;
}

/* Inputs */
.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
}

.form-group input {
    width: 100%;
    padding: 8px;
    border-radius: 5px;
    border: 1px solid #ccc;
}

/* Button */
.btn {
    width: 100%;
    padding: 10px;
    background-color: #3498db;
    border: none;
    color: white;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
}

.btn:hover {
    background-color: #2980b9;
}
</style>

</head>
<body>

<%
    Product p = (Product) request.getAttribute("product");
%>

<!-- Navbar -->
<div class="navbar">
    <div>UniTrade 🎓</div>
    <div>
        <a href="home.jsp">Home</a>
        <a href="MyProductsServlet">My Products</a>
    </div>
</div>

<!-- Form -->
<div class="container">

    <div class="form-card">
        <h2>Edit Product</h2>

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