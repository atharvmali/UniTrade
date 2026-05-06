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
<title>Admin Dashboard - UniTrade</title>
<link rel="stylesheet" href="assets/css/theme.css">
<style>
    .admin-dashboard {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 24px;
        margin-bottom: 32px;
    }

    .stat-card {
        background: linear-gradient(180deg, rgba(255, 255, 255, 0.16), rgba(255, 255, 255, 0.08));
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 22px;
        padding: 24px;
        text-align: center;
        box-shadow: 0 24px 60px rgba(15, 23, 42, 0.28);
    }

    .stat-number {
        font-size: 3em;
        font-weight: 800;
        background: linear-gradient(135deg, #7c3aed 0%, #2563eb 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .stat-label {
        font-size: 1.1em;
        color: rgba(229, 238, 252, 0.72);
        margin-top: 8px;
    }

    .admin-section {
        background: linear-gradient(180deg, rgba(255, 255, 255, 0.16), rgba(255, 255, 255, 0.08));
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 22px;
        padding: 24px;
        margin-bottom: 24px;
        box-shadow: 0 24px 60px rgba(15, 23, 42, 0.28);
    }

    .section-title {
        font-size: 1.4em;
        font-weight: 700;
        margin-bottom: 16px;
        color: #e5eefc;
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

    .admin-actions {
        display: flex;
        gap: 12px;
        justify-content: center;
        margin-top: 24px;
    }

    .action-btn {
        padding: 12px 24px;
        border-radius: 12px;
        background: linear-gradient(135deg, #7c3aed 0%, #2563eb 100%);
        color: white;
        text-decoration: none;
        font-weight: 600;
        border: none;
        cursor: pointer;
        transition: 0.3s;
    }

    .action-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(124, 58, 237, 0.3);
    }

    @media (max-width: 768px) {
        .admin-dashboard {
            grid-template-columns: 1fr;
        }

        .admin-table {
            font-size: 0.9em;
        }

        .admin-table th, .admin-table td {
            padding: 8px;
        }
    }
</style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="navbar-brand">UniTrade</div>

    <div class="nav-links">
        <a href="home.jsp">← Back to Home</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="page-shell top-align">
<div class="page-content">

    <!-- Page Title -->
    <div style="margin: 24px 0;">
        <h1 style="font-size: 2em; margin: 0 0 8px 0;">Admin Dashboard</h1>
        <p style="color: rgba(229, 238, 252, 0.72); margin: 0;">Platform statistics and recent activity</p>
    </div>

    <!-- Stats Cards -->
    <div class="admin-dashboard">
        <div class="stat-card">
            <div class="stat-number"><%= request.getAttribute("totalUsers") %></div>
            <div class="stat-label">Total Users</div>
        </div>

        <div class="stat-card">
            <div class="stat-number"><%= request.getAttribute("totalProducts") %></div>
            <div class="stat-label">Total Products</div>
        </div>
    </div>

    <!-- Recent Products -->
    <div class="admin-section">
        <h2 class="section-title">📦 Recent Products</h2>
        <%
            List<Product> recentProducts = (List<Product>) request.getAttribute("recentProducts");
            if (recentProducts != null && !recentProducts.isEmpty()) {
        %>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Seller</th>
                        <th>Price</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Product p : recentProducts) {
                    %>
                        <tr>
                            <td><%= p.getTitle() %></td>
                            <td><%= p.getOwnerName() %></td>
                            <td>₹<%= String.format("%.2f", p.getPrice()) %></td>
                            <td><%= p.getOwnerEmail() %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
            } else {
        %>
            <p style="color: rgba(229, 238, 252, 0.72);">No products yet.</p>
        <%
            }
        %>
    </div>

    <!-- Recent Users -->
    <div class="admin-section">
        <h2 class="section-title">👥 Recent Users</h2>
        <%
            List<String[]> recentUsers = (List<String[]>) request.getAttribute("recentUsers");
            if (recentUsers != null && !recentUsers.isEmpty()) {
        %>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>ID</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (String[] user : recentUsers) {
                    %>
                        <tr>
                            <td><%= user[1] %></td>
                            <td><%= user[2] %></td>
                            <td>#<%= user[0] %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <%
            } else {
        %>
            <p style="color: rgba(229, 238, 252, 0.72);">No users yet.</p>
        <%
            }
        %>
    </div>

    <!-- Quick Actions -->
    <div class="admin-section">
        <h2 class="section-title">⚙️ Management</h2>
        <div class="admin-actions">
            <a href="AdminUsersServlet" class="action-btn">Manage Users</a>
            <a href="AdminProductsServlet" class="action-btn">Moderate Products</a>
        </div>
    </div>

</div>
</div>

</body>
</html>
