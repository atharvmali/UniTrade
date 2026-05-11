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

@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String productCondition = request.getParameter("productCondition");
        String category = request.getParameter("category");
        String campusLocation = request.getParameter("campusLocation");
        boolean sold = request.getParameter("sold") != null;

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE products SET title=?, description=?, price=?, sold=?, product_condition=?, category=?, campus_location=? WHERE id=?"
            );

            ps.setString(1, title);
            ps.setString(2, description);
            ps.setDouble(3, Double.parseDouble(price));
            ps.setBoolean(4, sold);
            ps.setString(5, productCondition);
            ps.setString(6, category);
            ps.setString(7, campusLocation);
            ps.setInt(8, Integer.parseInt(id));

            ps.executeUpdate();

            response.sendRedirect("MyProductsServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
