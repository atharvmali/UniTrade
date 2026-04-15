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
import jakarta.servlet.http.*;
import model.Product;

@WebServlet("/ViewProductsServlet")
public class ViewProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            // 🔥 Get parameters
            String keyword = request.getParameter("keyword");
            String minPrice = request.getParameter("minPrice");
            String maxPrice = request.getParameter("maxPrice");
            String sort = request.getParameter("sort"); // ✅ NEW

            // 🔥 Base query
            String query = "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p JOIN users u ON p.seller_id = u.id WHERE 1=1";

            // 🔍 Search
            if (keyword != null && !keyword.trim().isEmpty()) {
                query += " AND p.title LIKE ?";
            }

            // 🎯 Filter
            if (minPrice != null && !minPrice.trim().isEmpty()) {
                query += " AND p.price >= ?";
            }

            if (maxPrice != null && !maxPrice.trim().isEmpty()) {
                query += " AND p.price <= ?";
            }

            // 🔥 SORTING LOGIC
            if (sort != null && !sort.isEmpty()) {
                switch (sort) {
                    case "price_asc":
                        query += " ORDER BY p.price ASC";
                        break;
                    case "price_desc":
                        query += " ORDER BY p.price DESC";
                        break;
                    case "name_asc":
                        query += " ORDER BY p.title ASC";
                        break;
                    case "name_desc":
                        query += " ORDER BY p.title DESC";
                        break;
                }
            }

            PreparedStatement ps = con.prepareStatement(query);

            int index = 1;

            // 🔧 Set values
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }

            if (minPrice != null && !minPrice.trim().isEmpty()) {
                ps.setDouble(index++, Double.parseDouble(minPrice));
            }

            if (maxPrice != null && !maxPrice.trim().isEmpty()) {
                ps.setDouble(index++, Double.parseDouble(maxPrice));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image"));
                p.setOwnerName(rs.getString("owner_name"));
                p.setOwnerEmail(rs.getString("owner_email"));
                p.setContactNumber(rs.getString("contact_number"));

                list.add(p);
            }

            request.setAttribute("products", list);
            request.getRequestDispatcher("viewProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}