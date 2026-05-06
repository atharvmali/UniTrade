package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.User;
import util.UserMapper;

public class UserDAO {

    public User getUserByEmail(String email) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                User u = UserMapper.mapRowToUser(rs);
                rs.close();
                ps.close();
                con.close();
                return u;
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getUserIdByEmail(String email) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT id FROM users WHERE email=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                int userId = rs.getInt("id");
                rs.close();
                ps.close();
                con.close();
                return userId;
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean userExists(String email) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                rs.close();
                ps.close();
                con.close();
                return true;
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void registerUser(String name, String email, String password) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO users(name, email, password, is_admin) VALUES (?, ?, ?, false)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                users.add(UserMapper.mapRowToUser(rs));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public List<User> searchUsersByEmail(String email) {
        List<User> users = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email LIKE ? ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, "%" + email + "%");
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                users.add(UserMapper.mapRowToUser(rs));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    public void deleteUser(int id) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM users WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getTotalUserCount() {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT COUNT(*) as count FROM users";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                int count = rs.getInt("count");
                rs.close();
                ps.close();
                con.close();
                return count;
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<User> getRecentUsers(int limit) {
        List<User> users = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users ORDER BY id DESC LIMIT ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                users.add(UserMapper.mapRowToUser(rs));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
}
