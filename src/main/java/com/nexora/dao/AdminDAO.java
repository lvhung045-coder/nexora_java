package com.nexora.dao;

import com.nexora.db.DBUtil;
import com.nexora.model.Admin;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class AdminDAO {

    /** Tim admin theo email hoac username */
    public Admin findByEmailOrUsername(String identifier) {
        String sql = "SELECT * FROM users WHERE email=? OR username=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, identifier);
            ps.setString(2, identifier);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public Admin findById(int id) {
        String sql = "SELECT * FROM users WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /** Xac thuc mat khau admin - tuong duong password_verify PHP */
    public boolean verifyPassword(String rawPassword, String hashedPassword) {
        try {
            String javaHash = hashedPassword.replace("$2y$", "$2a$");
            return BCrypt.checkpw(rawPassword, javaHash);
        } catch (Exception e) {
            return false;
        }
    }

    private Admin mapRow(ResultSet rs) throws SQLException {
        Admin a = new Admin();
        a.setUserId(rs.getInt("user_id"));
        a.setUsername(rs.getString("username"));
        a.setEmail(rs.getString("email"));
        a.setPassword(rs.getString("password"));
        a.setFullname(rs.getString("fullname"));
        try { a.setCreatedAt(rs.getTimestamp("created_at")); } catch (SQLException ignored) {}
        return a;
    }
}