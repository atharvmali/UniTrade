package servlet;

import java.io.IOException;
import java.util.List;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet("/ViewProductsServlet")
public class ViewProductsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String keyword = request.getParameter("keyword");
            String minPrice = request.getParameter("minPrice");
            String maxPrice = request.getParameter("maxPrice");
            String sort = request.getParameter("sort");

            Double min = null, max = null;
            try {
                if (minPrice != null && !minPrice.trim().isEmpty()) {
                    min = Double.parseDouble(minPrice);
                }
                if (maxPrice != null && !maxPrice.trim().isEmpty()) {
                    max = Double.parseDouble(maxPrice);
                }
            } catch (NumberFormatException e) {
                // Ignore invalid prices
            }

            ProductDAO productDAO = new ProductDAO();
            List<Product> products = productDAO.getProductsByFilters(keyword, min, max, sort);

            request.setAttribute("products", products);
            request.getRequestDispatcher("viewProducts.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
