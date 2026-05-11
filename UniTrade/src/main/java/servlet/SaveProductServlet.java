package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SaveProductServlet")
public class SaveProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");
        String productId = request.getParameter("id");

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement psUser = con.prepareStatement("SELECT id FROM users WHERE email=?");
            psUser.setString(1, email);
            ResultSet rsUser = psUser.executeQuery();

            int userId = 0;
            if (rsUser.next()) {
                userId = rsUser.getInt("id");
            }

            if (userId != 0 && productId != null) {
                PreparedStatement ps = con.prepareStatement(
                    "INSERT IGNORE INTO wishlist(user_id, product_id) VALUES (?, ?)"
                );
                ps.setInt(1, userId);
                ps.setInt(2, Integer.parseInt(productId));
                ps.executeUpdate();
            }

            response.sendRedirect("ViewProductsServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
