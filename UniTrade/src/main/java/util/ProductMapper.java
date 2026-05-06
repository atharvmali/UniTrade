package util;

import java.sql.ResultSet;
import java.sql.SQLException;
import model.Product;

public class ProductMapper {

    public static Product mapRowToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setTitle(rs.getString("title"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setImage(rs.getString("image"));
        p.setOwnerName(rs.getString("owner_name"));
        p.setOwnerEmail(rs.getString("owner_email"));
        p.setContactNumber(rs.getString("contact_number"));
        return p;
    }
}
