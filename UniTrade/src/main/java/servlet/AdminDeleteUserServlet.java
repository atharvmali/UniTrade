package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.AdminUtility;

@WebServlet("/AdminDeleteUserServlet")
public class AdminDeleteUserServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");

        if (email == null || !AdminUtility.isAdmin(session)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String userId = request.getParameter("id");

        try {
            Connection con = DBConnection.getConnection();

            // Delete user (CASCADE will remove their products)
            PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE id=?");
            ps.setInt(1, Integer.parseInt(userId));
            ps.executeUpdate();

            response.sendRedirect("AdminUsersServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
