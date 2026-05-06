package servlet;

import java.io.IOException;

import dao.ProductDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteProductServlet")
public class DeleteProductServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String id = request.getParameter("id");

            UserDAO userDAO = new UserDAO();
            int userId = userDAO.getUserIdByEmail(email);

            ProductDAO productDAO = new ProductDAO();
            productDAO.deleteProduct(Integer.parseInt(id));

            response.sendRedirect("MyProductsServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
