package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.AdminUtility;

@WebServlet("/AdminUsersServlet")
public class AdminUsersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");

        if (email == null || !AdminUtility.isAdmin(session)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String search = request.getParameter("search");
        List<String[]> users = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT u.id, u.name, u.email, u.is_admin, COUNT(p.id) as product_count "
                    + "FROM users u LEFT JOIN products p ON u.id = p.seller_id WHERE 1=1";

            if (search != null && !search.trim().isEmpty()) {
                query += " AND u.email LIKE ?";
            }

            query += " GROUP BY u.id ORDER BY u.id DESC";

            PreparedStatement ps = con.prepareStatement(query);

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(1, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String[] user = new String[5];
                user[0] = String.valueOf(rs.getInt("id"));
                user[1] = rs.getString("name");
                user[2] = rs.getString("email");
                user[3] = String.valueOf(rs.getInt("product_count"));
                user[4] = rs.getBoolean("is_admin") ? "Admin" : "User";
                users.add(user);
            }

            request.setAttribute("users", users);
            request.setAttribute("search", search != null ? search : "");

            request.getRequestDispatcher("adminUsers.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
