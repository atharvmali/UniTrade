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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
        	
        	
            Connection con = DBConnection.getConnection();
            
            PreparedStatement check = con.prepareStatement(
            	    "SELECT * FROM users WHERE email=?"
            	);
            	check.setString(1, email);

            	ResultSet rs = check.executeQuery();

            	if(rs.next()){
            	    response.sendRedirect("register.jsp?error=1");
            	    return;
            	}

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(name, email, password) VALUES (?, ?, ?)"
            );

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            ps.executeUpdate();

            response.getWriter().println("Registered Successfully");
            response.sendRedirect("login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}