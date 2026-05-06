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
import model.Product;
import util.AdminUtility;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");

        if (email == null || !AdminUtility.isAdmin(session)) {
            response.sendRedirect("home.jsp");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            int totalUsers = 0;
            int totalProducts = 0;
            List<Product> recentProducts = new ArrayList<>();
            List<String[]> recentUsers = new ArrayList<>();

            // Get total user count
            PreparedStatement psUserCount = con.prepareStatement("SELECT COUNT(*) as count FROM users");
            ResultSet rsUserCount = psUserCount.executeQuery();
            if (rsUserCount.next()) {
                totalUsers = rsUserCount.getInt("count");
            }

            // Get total product count
            PreparedStatement psProductCount = con.prepareStatement("SELECT COUNT(*) as count FROM products");
            ResultSet rsProductCount = psProductCount.executeQuery();
            if (rsProductCount.next()) {
                totalProducts = rsProductCount.getInt("count");
            }

            // Get recent 5 products
            PreparedStatement psRecentProducts = con.prepareStatement(
                "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p "
                + "JOIN users u ON p.seller_id = u.id ORDER BY p.id DESC LIMIT 5"
            );
            ResultSet rsRecentProducts = psRecentProducts.executeQuery();
            while (rsRecentProducts.next()) {
                Product p = new Product();
                p.setId(rsRecentProducts.getInt("id"));
                p.setTitle(rsRecentProducts.getString("title"));
                p.setPrice(rsRecentProducts.getDouble("price"));
                p.setOwnerName(rsRecentProducts.getString("owner_name"));
                p.setOwnerEmail(rsRecentProducts.getString("owner_email"));
                recentProducts.add(p);
            }

            // Get recent 5 users
            PreparedStatement psRecentUsers = con.prepareStatement(
                "SELECT id, name, email FROM users ORDER BY id DESC LIMIT 5"
            );
            ResultSet rsRecentUsers = psRecentUsers.executeQuery();
            while (rsRecentUsers.next()) {
                String[] user = new String[3];
                user[0] = String.valueOf(rsRecentUsers.getInt("id"));
                user[1] = rsRecentUsers.getString("name");
                user[2] = rsRecentUsers.getString("email");
                recentUsers.add(user);
            }

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("recentProducts", recentProducts);
            request.setAttribute("recentUsers", recentUsers);

            request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
