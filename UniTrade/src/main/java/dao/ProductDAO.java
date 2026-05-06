package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Product;
import util.ProductMapper;

public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p JOIN users u ON p.seller_id = u.id";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                products.add(ProductMapper.mapRowToProduct(rs));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p JOIN users u ON p.seller_id = u.id WHERE p.title LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                products.add(ProductMapper.mapRowToProduct(rs));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getProductsByFilters(String keyword, Double minPrice, Double maxPrice, String sort) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p JOIN users u ON p.seller_id = u.id WHERE 1=1";

            if (keyword != null && !keyword.trim().isEmpty()) {
                query += " AND p.title LIKE ?";
            }

            if (minPrice != null && minPrice > 0) {
                query += " AND p.price >= ?";
            }

            if (maxPrice != null && maxPrice > 0) {
                query += " AND p.price <= ?";
            }

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

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
            }

            if (minPrice != null && minPrice > 0) {
                ps.setDouble(index++, minPrice);
            }

            if (maxPrice != null && maxPrice > 0) {
                ps.setDouble(index++, maxPrice);
            }

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                products.add(ProductMapper.mapRowToProduct(rs));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getUserProducts(int userId) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p JOIN users u ON p.seller_id = u.id WHERE p.seller_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                products.add(ProductMapper.mapRowToProduct(rs));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(int id) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p JOIN users u ON p.seller_id = u.id WHERE p.id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                Product p = ProductMapper.mapRowToProduct(rs);
                rs.close();
                ps.close();
                con.close();
                return p;
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addProduct(Product p, int userId, String imagePath) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO products(title, description, price, image, seller_id, contact_number) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, imagePath);
            ps.setInt(5, userId);
            ps.setString(6, p.getContactNumber());
            ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product p) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE products SET title=?, description=?, price=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getId());
            ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int id) {
        try {
            Connection con = DBConnection.getConnection();
            String query = "DELETE FROM products WHERE id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id);
            ps.executeUpdate();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Product> getRecentProducts(int limit) {
        List<Product> products = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT p.*, u.name AS owner_name, u.email AS owner_email FROM products p JOIN users u ON p.seller_id = u.id ORDER BY p.id DESC LIMIT ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while(rs.next()) {
                products.add(ProductMapper.mapRowToProduct(rs));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public int getTotalProductCount() {
        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT COUNT(*) as count FROM products";
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
}
