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
import model.Product;

@WebServlet("/EditProductServlet")
public class EditProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM products WHERE id=?"
            );
            ps.setInt(1, Integer.parseInt(id));

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));

                request.setAttribute("product", p);
                request.getRequestDispatcher("editProduct.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}