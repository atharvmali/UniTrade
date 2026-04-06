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

@WebServlet("/MyProductsServlet")
public class MyProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");

        // 🔒 If not logged in
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Product> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            // 🔍 Get user ID
            PreparedStatement psUser = con.prepareStatement(
                "SELECT id FROM users WHERE email=?"
            );
            psUser.setString(1, email);
            ResultSet rsUser = psUser.executeQuery();

            int userId = 0;
            if (rsUser.next()) {
                userId = rsUser.getInt("id");
            }

            // 📦 Get only user's products
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM products WHERE seller_id=?"
            );
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));

                list.add(p);
            }

            request.setAttribute("products", list);
            request.getRequestDispatcher("myProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}