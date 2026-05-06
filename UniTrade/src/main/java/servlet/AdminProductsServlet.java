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
import jakarta.servlet.http.HttpSession;
import model.Product;
import util.AdminUtility;

@WebServlet("/AdminProductsServlet")
public class AdminProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");

        if (email == null || !AdminUtility.isAdmin(session)) {
            response.sendRedirect("home.jsp");
            return;
        }

        String search = request.getParameter("search");
        String seller = request.getParameter("seller");
        List<Product> products = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p "
                    + "JOIN users u ON p.seller_id = u.id WHERE 1=1";

            if (search != null && !search.trim().isEmpty()) {
                query += " AND p.title LIKE ?";
            }

            if (seller != null && !seller.trim().isEmpty()) {
                query += " AND u.email LIKE ?";
            }

            query += " ORDER BY p.id DESC";

            PreparedStatement ps = con.prepareStatement(query);

            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }

            if (seller != null && !seller.trim().isEmpty()) {
                ps.setString(index++, "%" + seller + "%");
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
                products.add(p);
            }

            request.setAttribute("products", products);
            request.setAttribute("search", search != null ? search : "");
            request.setAttribute("seller", seller != null ? seller : "");

            request.getRequestDispatcher("adminProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
