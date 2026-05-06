package util;

import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import jakarta.servlet.http.HttpServletResponse;

public class AdminUtility {

    public static boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        return "admin".equals(role);
    }

    public static void requireAdminAccess(HttpSession session, HttpServletResponse response) throws IOException {
        if (!isAdmin(session)) {
            response.sendRedirect("home.jsp");
        }
    }
}
