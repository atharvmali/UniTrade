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

@WebServlet("/MarkSoldServlet")
public class MarkSoldServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String sold = request.getParameter("sold");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE products SET sold=? WHERE id=?"
            );

            ps.setBoolean(1, "true".equals(sold));
            ps.setInt(2, Integer.parseInt(id));
            ps.executeUpdate();

            response.sendRedirect("MyProductsServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
