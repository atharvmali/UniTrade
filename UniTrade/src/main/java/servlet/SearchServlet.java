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
import model.Product;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Product> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM products WHERE title LIKE ?"
            );
            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));

                list.add(p);
            }

            request.setAttribute("products", list);
            request.getRequestDispatcher("viewProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}