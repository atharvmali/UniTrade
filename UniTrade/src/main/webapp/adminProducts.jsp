<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Product" %>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
    }
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("home.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Moderate Products - UniTrade Admin</title>
<link rel="stylesheet" href="assets/css/theme.css">
<style>
    .search-panel {
        background: linear-gradient(180deg, rgba(255, 255, 255, 0.16), rgba(255, 255, 255, 0.08));
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 22px;
        padding: 24px;
        margin-bottom: 24px;
        box-shadow: 0 24px 60px rgba(15, 23, 42, 0.28);
    }

    .search-form {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        gap: 12px;
        align-items: center;
    }

    .search-form input {
        padding: 12px 16px;
        background: rgba(255, 255, 255, 0.08);
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 12px;
        color: #e5eefc;
        font-size: 1em;
    }

    .search-form input::placeholder {
        color: rgba(229, 238, 252, 0.5);
    }

    .search-form button {
        padding: 12px 24px;
        background: linear-gradient(135deg, #7c3aed 0%, #2563eb 100%);
        color: white;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-weight: 600;
    }

    .search-form button:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 16px rgba(124, 58, 237, 0.3);
    }

    .admin-section {
        background: linear-gradient(180deg, rgba(255, 255, 255, 0.16), rgba(255, 255, 255, 0.08));
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 22px;
        padding: 24px;
        box-shadow: 0 24px 60px rgba(15, 23, 42, 0.28);
    }

    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 16px;
    }

    .section-title {
        font-size: 1.4em;
        font-weight: 700;
        color: #e5eefc;
    }

    .product-count {
        color: #7c3aed;
        font-weight: 600;
    }

    .admin-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 12px;
    }

    .admin-table thead {
        background: rgba(255, 255, 255, 0.08);
    }

    .admin-table th {
        padding: 12px 16px;
        text-align: left;
        font-weight: 600;
        color: #7c3aed;
        border-bottom: 1px solid rgba(255, 255, 255, 0.12);
    }

    .admin-table td {
        padding: 12px 16px;
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        color: #e5eefc;
    }

    .admin-table tbody tr:hover {
        background: rgba(255, 255, 255, 0.04);
    }

    .product-title {
        font-weight: 600;
        max-width: 200px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .price {
        color: #22c55e;
        font-weight: 600;
    }

    .delete-btn {
        padding: 6px 12px;
        background: #ef4444;
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        font-size: 0.85em;
        transition: 0.3s;
    }

    .delete-btn:hover {
        background: #dc2626;
    }

    .back-btn {
        display: inline-block;
        padding: 12px 24px;
        background: linear-gradient(135deg, #7c3aed 0%, #2563eb 100%);
        color: white;
        text-decoration: none;
        border-radius: 12px;
        font-weight: 600;
        margin-top: 24px;
    }

    .back-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(124, 58, 237, 0.3);
    }

    @media (max-width: 1024px) {
        .search-form {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 768px) {
        .admin-table {
            font-size: 0.9em;
        }

        .admin-table th, .admin-table td {
            padding: 8px;
        }

        .product-title {
            max-width: 100px;
        }
    }
</style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-brand">UniTrade</div>

    <div class="nav-links">
        <a href="AdminDashboardServlet">Dashboard</a>
        <a href="home.jsp">Home</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="page-shell top-align">
<div class="page-content">

    <!-- Page Title -->
    <div style="margin: 24px 0;">
        <h1 style="font-size: 2em; margin: 0 0 8px 0;">Moderate Products</h1>
        <p style="color: rgba(229, 238, 252, 0.72); margin: 0;">Review and remove inappropriate product listings</p>
    </div>

    <!-- Search Panel -->
    <div class="search-panel">
        <form class="search-form" action="AdminProductsServlet" method="get">
            <input type="text" name="search" placeholder="Search by product title..." value="<%= request.getAttribute("search") != null ? request.getAttribute("search") : "" %>">
            <input type="text" name="seller" placeholder="Search by seller email..." value="<%= request.getAttribute("seller") != null ? request.getAttribute("seller") : "" %>">
            <div>
                <button type="submit">🔍 Search</button>
                <a href="AdminProductsServlet" style="padding: 12px 24px; background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.12); border-radius: 12px; color: #e5eefc; text-decoration: none; font-weight: 600; display: inline-block; margin-left: 8px;">Clear</a>
            </div>
        </form>
    </div>

    <!-- Products Table -->
    <div class="admin-section">
        <div class="section-header">
            <h2 class="section-title">All Products</h2>
            <span class="product-count">Total: <%= request.getAttribute("products") != null ? ((List) request.getAttribute("products")).size() : 0 %></span>
        </div>

        <%
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
        %>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product</th>
                        <th>Seller</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Category</th>
                        <th>Condition</th>
                        <th>Location</th>
                        <th>Contact</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Product p : products) {
                    %>
                        <tr>
                            <td>#<%= p.getId() %></td>
                            <td><span class="product-title" title="<%= p.getTitle() %>"><%= p.getTitle() %></span></td>
                            <td><%= p.getOwnerName() %> (<%= p.getOwnerEmail() %>)</td>
                            <td><span class="price">₹<%= String.format("%.2f", p.getPrice()) %></span></td>
                            <td><%= p.isSold() ? "Sold" : "Available" %></td>
                            <td><%= p.getCategory() != null ? p.getCategory() : "" %></td>
                            <td><%= p.getProductCondition() != null ? p.getProductCondition() : "" %></td>
                            <td><%= p.getCampusLocation() != null ? p.getCampusLocation() : "" %></td>
                            <td><%= p.getContactNumber() %></td>
                            <td>
                                <button class="delete-btn" onclick="if(confirm('Delete this product?')) { window.location='AdminDeleteProductServlet?id=<%= p.getId() %>'; }">Delete</button>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
            } else {
        %>
            <p style="color: rgba(229, 238, 252, 0.72); padding: 24px; text-align: center;">No products found.</p>
        <%
            }
        %>
    </div>

    <a href="AdminDashboardServlet" class="back-btn">Back to Dashboard</a>

</div>
</div>

<script src="assets/js/ui.js"></script>
</body>
</html>
