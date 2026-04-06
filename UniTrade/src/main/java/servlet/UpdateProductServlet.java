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

@WebServlet("/UpdateProductServlet")
public class UpdateProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String price = request.getParameter("price");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE products SET title=?, description=?, price=? WHERE id=?"
            );

            ps.setString(1, title);
            ps.setString(2, description);
            ps.setDouble(3, Double.parseDouble(price));
            ps.setInt(4, Integer.parseInt(id));

            ps.executeUpdate();

            response.sendRedirect("MyProductsServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}