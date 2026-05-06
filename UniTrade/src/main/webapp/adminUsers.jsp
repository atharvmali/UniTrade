<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

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
<title>Manage Users - UniTrade Admin</title>
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
        display: flex;
        gap: 12px;
        align-items: center;
    }

    .search-form input {
        flex: 1;
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

    .user-count {
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

    .role-badge {
        display: inline-block;
        padding: 4px 12px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.85em;
    }

    .role-admin {
        background: rgba(124, 58, 237, 0.3);
        color: #a78bfa;
    }

    .role-user {
        background: rgba(34, 197, 94, 0.2);
        color: #86efac;
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

    @media (max-width: 768px) {
        .search-form {
            flex-direction: column;
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
        <a href="AdminDashboardServlet">← Dashboard</a>
        <a href="home.jsp">Home</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="page-shell top-align">
<div class="page-content">

    <!-- Page Title -->
    <div style="margin: 24px 0;">
        <h1 style="font-size: 2em; margin: 0 0 8px 0;">Manage Users</h1>
        <p style="color: rgba(229, 238, 252, 0.72); margin: 0;">View and manage all registered users</p>
    </div>

    <!-- Search Panel -->
    <div class="search-panel">
        <form class="search-form" action="AdminUsersServlet" method="get">
            <input type="text" name="search" placeholder="Search by email..." value="<%= request.getAttribute("search") != null ? request.getAttribute("search") : "" %>">
            <button type="submit">🔍 Search</button>
            <a href="AdminUsersServlet" style="padding: 12px 24px; background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.12); border-radius: 12px; color: #e5eefc; text-decoration: none; font-weight: 600;">Clear</a>
        </form>
    </div>

    <!-- Users Table -->
    <div class="admin-section">
        <div class="section-header">
            <h2 class="section-title">👥 All Users</h2>
            <span class="user-count">Total: <%= request.getAttribute("users") != null ? ((List) request.getAttribute("users")).size() : 0 %></span>
        </div>

        <%
            List<String[]> users = (List<String[]>) request.getAttribute("users");
            if (users != null && !users.isEmpty()) {
        %>
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Products</th>
                        <th>Role</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (String[] user : users) {
                            boolean isAdmin = "Admin".equals(user[4]);
                    %>
                        <tr>
                            <td>#<%= user[0] %></td>
                            <td><%= user[1] %></td>
                            <td><%= user[2] %></td>
                            <td><%= user[3] %></td>
                            <td>
                                <span class="role-badge <%= isAdmin ? "role-admin" : "role-user" %>">
                                    <%= user[4] %>
                                </span>
                            </td>
                            <td>
                                <%
                                    if (!isAdmin) {
                                %>
                                    <button class="delete-btn" onclick="if(confirm('Delete this user and all their products?')) { window.location='AdminDeleteUserServlet?id=<%= user[0] %>'; }">Delete</button>
                                <%
                                    } else {
                                %>
                                    <span style="color: rgba(229, 238, 252, 0.5);">—</span>
                                <%
                                    }
                                %>
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
            <p style="color: rgba(229, 238, 252, 0.72); padding: 24px; text-align: center;">No users found.</p>
        <%
            }
        %>
    </div>

    <a href="AdminDashboardServlet" class="back-btn">← Back to Dashboard</a>

</div>
</div>

</body>
</html>
