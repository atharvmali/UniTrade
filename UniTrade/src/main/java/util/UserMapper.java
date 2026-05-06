package util;

import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

public class UserMapper {

    public static User mapRowToUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setName(rs.getString("name"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setAdmin(rs.getBoolean("is_admin"));
        return u;
    }
}
