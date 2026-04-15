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

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");

        // 🔒 Not logged in
        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

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

            // 🔥 Delete ONLY if owner
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM products WHERE id=? AND seller_id=?"
            );

            ps.setInt(1, Integer.parseInt(id));
            ps.setInt(2, userId);

            ps.executeUpdate();

            response.sendRedirect("MyProductsServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}