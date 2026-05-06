package servlet;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.io.IOException;

import dao.ProductDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Product;

@WebServlet("/AddProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        String contactNumber = request.getParameter("contactNumber");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("user");

        if (email == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Part filePart = request.getPart("image");
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String projectPath = getServletContext().getRealPath("") + "uploads";
            File projectDir = new File(projectPath);
            if (!projectDir.exists()) projectDir.mkdirs();

            String imagePath = "uploads/" + fileName;
            filePart.write(projectPath + File.separator + fileName);

            Product product = new Product();
            product.setTitle(title);
            product.setDescription(description);
            product.setPrice(Double.parseDouble(price));
            product.setContactNumber(contactNumber);

            UserDAO userDAO = new UserDAO();
            int userId = userDAO.getUserIdByEmail(email);

            ProductDAO productDAO = new ProductDAO();
            productDAO.addProduct(product, userId, imagePath);

            response.sendRedirect("home.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
