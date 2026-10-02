package com.nexora.dao;

import com.nexora.db.DBUtil;
import com.nexora.model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    public List<Review> getByProduct(int productId) {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT d.*, n.fullname FROM danhgia d JOIN nguoidung n ON d.user_id=n.user_id WHERE d.product_id=? ORDER BY d.id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean addReview(int productId, int userId, int star, String content) {
        String sql = "INSERT INTO danhgia (product_id, user_id, star, content) VALUES (?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, userId);
            ps.setInt(3, star);
            ps.setString(4, content);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public int count() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM danhgia");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Review mapRow(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setId(rs.getInt("id"));
        r.setProductId(rs.getInt("product_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setStar(rs.getInt("star"));
        r.setContent(rs.getString("content"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        try { r.setFullname(rs.getString("fullname")); } catch (SQLException ignored) {}
        return r;
    }
}