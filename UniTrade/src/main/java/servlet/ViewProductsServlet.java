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
        HttpSession session = request.getSession(false);
        String email = session == null ? null : (String) session.getAttribute("user");
        boolean isLoggedIn = email != null;

        try {
            Connection con = DBConnection.getConnection();

            // 🔥 Get parameters
            String keyword = request.getParameter("keyword");
            String minPrice = request.getParameter("minPrice");
            String maxPrice = request.getParameter("maxPrice");
            String sort = request.getParameter("sort"); // ✅ NEW
            String category = request.getParameter("category");
            String condition = request.getParameter("condition");

            // 🔥 Base query
            String query = "SELECT p.id, p.title, p.description, p.price, p.image, p.sold, p.product_condition, "
                + "p.category, p.campus_location";
            if (isLoggedIn) {
                query += ", u.name AS owner_name, u.email AS owner_email, p.contact_number";
            }
            query += " FROM products p JOIN users u ON p.seller_id = u.id WHERE 1=1";

            // 🔍 Search
            if (keyword != null && !keyword.trim().isEmpty()) {
                query += " AND (p.title LIKE ? OR p.category LIKE ? OR p.campus_location LIKE ?)";
            }

            if (category != null && !category.trim().isEmpty()) {
                query += " AND p.category=?";
            }

            if (condition != null && !condition.trim().isEmpty()) {
                query += " AND p.product_condition=?";
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
                ps.setString(index++, "%" + keyword + "%");
                ps.setString(index++, "%" + keyword + "%");
            }

            if (category != null && !category.trim().isEmpty()) {
                ps.setString(index++, category);
            }

            if (condition != null && !condition.trim().isEmpty()) {
                ps.setString(index++, condition);
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
                if (isLoggedIn) {
                    p.setOwnerName(rs.getString("owner_name"));
                    p.setOwnerEmail(rs.getString("owner_email"));
                    p.setContactNumber(rs.getString("contact_number"));
                }
                p.setSold(rs.getBoolean("sold"));
                p.setProductCondition(rs.getString("product_condition"));
                p.setCategory(rs.getString("category"));
                p.setCampusLocation(rs.getString("campus_location"));

                if (email != null) {
                    PreparedStatement psSaved = con.prepareStatement(
                        "SELECT w.id FROM wishlist w JOIN users u ON w.user_id = u.id WHERE u.email=? AND w.product_id=?"
                    );
                    psSaved.setString(1, email);
                    psSaved.setInt(2, p.getId());
                    ResultSet rsSaved = psSaved.executeQuery();
                    p.setSaved(rsSaved.next());
                }

                list.add(p);
            }

            request.setAttribute("products", list);
            request.getRequestDispatcher("viewProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
