package com.nexora.dao;

import com.nexora.db.DBUtil;
import com.nexora.model.Product;
import com.nexora.model.ProductVariant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    /** Lay Sản phẩm hot (is_hot=1) - thay SELECT * FROM products WHERE is_hot=1 */
    public List<Product> getHotProducts(int limit) {
        String sql = "SELECT * FROM products WHERE is_hot=1 ORDER BY product_id DESC LIMIT ?";
        return queryList(sql, ps -> ps.setInt(1, limit));
    }

    /** Lay Sản phẩm theo Danh mục */
    public List<Product> getByCategory(int catId, int limit) {
        String sql = "SELECT * FROM products WHERE cat_id=? ORDER BY product_id DESC LIMIT ?";
        return queryList(sql, ps -> { ps.setInt(1, catId); ps.setInt(2, limit); });
    }

    /** Lay Sản phẩm theo Danh mục co phan trang */
    public List<Product> getByCategoryPaged(int catId, int offset, int limit) {
        String sql = "SELECT * FROM products WHERE cat_id=? ORDER BY product_id DESC LIMIT ? OFFSET ?";
        return queryList(sql, ps -> { ps.setInt(1, catId); ps.setInt(2, limit); ps.setInt(3, offset); });
    }

    public int countByCategory(int catId) {
        String sql = "SELECT COUNT(*) FROM products WHERE cat_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, catId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    /** Tìm kiếm Sản phẩm */
    public List<Product> search(String keyword) {
        String sql = "SELECT * FROM products WHERE product_name LIKE ? ORDER BY product_id DESC LIMIT 40";
        return queryList(sql, ps -> ps.setString(1, "%" + keyword + "%"));
    }

    /** Lay Sản phẩm theo ID */
    public Product getById(int id) {
        String sql = "SELECT * FROM products WHERE product_id=?";
        List<Product> list = queryList(sql, ps -> ps.setInt(1, id));
        return list.isEmpty() ? null : list.get(0);
    }

    /** Dem tong so Sản phẩm */
    public int count() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM products");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    /** Lay Tất cả Sản phẩm (admin) */
    public List<Product> getAll() {
        String sql = "SELECT p.*, c.cat_name FROM products p JOIN categories c ON p.cat_id=c.cat_id ORDER BY p.product_id DESC";
        return queryList(sql, ps -> {});
    }

    /** Them Sản phẩm moi */
    public int insert(Product p) {
        String sql = "INSERT INTO products (cat_id, product_name, price, stock, image, product_desc, is_hot, material, style, origin) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, p.getCatId());
            ps.setString(2, p.getProductName());
            ps.setLong(3, p.getPrice());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getImage());
            ps.setString(6, p.getProductDesc());
            ps.setBoolean(7, p.isHot());
            ps.setString(8, p.getMaterial());
            ps.setString(9, p.getStyle());
            ps.setString(10, p.getOrigin());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    /** Cap nhat Sản phẩm */
    public boolean update(Product p) {
        String sql = "UPDATE products SET cat_id=?, product_name=?, price=?, stock=?, image=?, product_desc=?, is_hot=?, material=?, style=?, origin=? WHERE product_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getCatId());
            ps.setString(2, p.getProductName());
            ps.setLong(3, p.getPrice());
            ps.setInt(4, p.getStock());
            ps.setString(5, p.getImage());
            ps.setString(6, p.getProductDesc());
            ps.setBoolean(7, p.isHot());
            ps.setString(8, p.getMaterial());
            ps.setString(9, p.getStyle());
            ps.setString(10, p.getOrigin());
            ps.setInt(11, p.getProductId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Xoa Sản phẩm */
    public boolean delete(int id) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM products WHERE product_id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // ----- Variants -----

    public List<ProductVariant> getVariants(int productId) {
        List<ProductVariant> list = new ArrayList<>();
        String sql = "SELECT * FROM product_variants WHERE product_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapVariantRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public ProductVariant getVariantById(int variantId) {
        String sql = "SELECT * FROM product_variants WHERE variant_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, variantId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapVariantRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public boolean addVariant(ProductVariant v) {
        String sql = "INSERT INTO product_variants (product_id, size, color, price, stock) VALUES (?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, v.getProductId());
            ps.setString(2, v.getSize());
            ps.setString(3, v.getColor());
            ps.setLong(4, v.getPrice());
            ps.setInt(5, v.getStock());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean deleteVariant(int variantId) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM product_variants WHERE variant_id=?")) {
            ps.setInt(1, variantId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // ----- Helpers -----

    @FunctionalInterface
    interface StatementSetter { void set(PreparedStatement ps) throws SQLException; }

    private List<Product> queryList(String sql, StatementSetter setter) {
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            setter.set(ps);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setCatId(rs.getInt("cat_id"));
        p.setProductName(rs.getString("product_name"));
        p.setPrice(rs.getLong("price"));
        p.setStock(rs.getInt("stock"));
        p.setImage(rs.getString("image"));
        p.setProductDesc(rs.getString("product_desc"));
        p.setHot(rs.getBoolean("is_hot"));
        p.setMaterial(rs.getString("material"));
        p.setStyle(rs.getString("style"));
        p.setOrigin(rs.getString("origin"));
        try { p.setCreatedAt(rs.getTimestamp("created_at")); } catch (SQLException ignored) {}
        try { p.setCatName(rs.getString("cat_name")); } catch (SQLException ignored) {}
        return p;
    }

    private ProductVariant mapVariantRow(ResultSet rs) throws SQLException {
        ProductVariant v = new ProductVariant();
        v.setVariantId(rs.getInt("variant_id"));
        v.setProductId(rs.getInt("product_id"));
        v.setSize(rs.getString("size"));
        v.setColor(rs.getString("color"));
        v.setPrice(rs.getLong("price"));
        v.setStock(rs.getInt("stock"));
        return v;
    }

    /** Cong them Số lượng ton kho sau khi nhap hang */
    public boolean addStock(int productId, int quantity) {
        String sql = "UPDATE products SET stock = stock + ? WHERE product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Lay Sản phẩm co phan trang */
    public List<Product> getPaginated(int page, int limit) {
        int offset = (page - 1) * limit;
        String sql = "SELECT * FROM products ORDER BY product_id DESC LIMIT ? OFFSET ?";
        return queryList(sql, ps -> {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
        });
    }
}

