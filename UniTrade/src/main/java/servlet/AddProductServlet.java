package servlet;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dao.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

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

	    // 🔒 Safety check
	    if (email == null) {
	        response.sendRedirect("login.jsp");
	        return;
	    }

	    // 📸 Get image
	    Part filePart = request.getPart("image");
	    String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

	    // 📁 1. Save in LOCAL folder (permanent storage)
	    String uploadPath = "/Users/atharv/Documents/Projects_Storage/UniTradeUploads";

	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) uploadDir.mkdirs();

	    filePart.write(uploadPath + File.separator + fileName);

	    // 📁 2. Copy file into PROJECT (for browser display)
	    String projectPath = getServletContext().getRealPath("") + "uploads";
	    File projectDir = new File(projectPath);
	    if (!projectDir.exists()) projectDir.mkdirs();

	    File source = new File(uploadPath + File.separator + fileName);
	    File dest = new File(projectPath + File.separator + fileName);

	    try (InputStream in = new FileInputStream(source);
	         OutputStream out = new FileOutputStream(dest)) {

	        byte[] buffer = new byte[1024];
	        int length;

	        while ((length = in.read(buffer)) > 0) {
	            out.write(buffer, 0, length);
	        }
	    }

	    // 🗄️ Store relative path in DB
	    String imagePath = "uploads/" + fileName;

	    try {
	        Connection con = DBConnection.getConnection();

	        // 🔍 Get user ID
	        PreparedStatement psUser = con.prepareStatement(
	            "SELECT id FROM users WHERE email=?"
	        );
	        psUser.setString(1, email);
	        ResultSet rs = psUser.executeQuery();

	        int userId = 0;
	        if (rs.next()) {
	            userId = rs.getInt("id");
	        }

	        // 🛒 Insert product
	        PreparedStatement ps = con.prepareStatement(
	            "INSERT INTO products(title, description, price, image, seller_id, contact_number) VALUES (?, ?, ?, ?, ?, ?)"
	        );

	        ps.setString(1, title);
	        ps.setString(2, description);
	        ps.setDouble(3, Double.parseDouble(price));
	        ps.setString(4, imagePath);
	        ps.setInt(5, userId);
	        ps.setString(6, contactNumber);

	        ps.executeUpdate();

	        response.sendRedirect("home.jsp");

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
    
}