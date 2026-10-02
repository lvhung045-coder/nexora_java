package com.nexora.dao;

import com.nexora.db.DBUtil;
import com.nexora.model.Customer;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    /** Tim Khách hàng theo email */
    public Customer findByEmail(String email) {
        String sql = "SELECT * FROM nguoidung WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /** Tim Khách hàng theo ID */
    public Customer findById(int id) {
        String sql = "SELECT * FROM nguoidung WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /** Kiem tra email da ton tai chua */
    public boolean emailExists(String email) {
        return findByEmail(email) != null;
    }

    /**
     * Đăng ký Khách hàng moi
     * Thay password_hash($password, PASSWORD_DEFAULT) cua PHP
     */
    public boolean register(String fullname, String email, String password, String phone, String address) {
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        String sql = "INSERT INTO nguoidung (fullname, email, password, phone, address) VALUES (?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, hashedPassword);
            ps.setString(4, phone);
            ps.setString(5, address);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /**
     * Xac thuc mat khau - tuong duong password_verify() PHP
     * BCrypt tuong thich hoan toan voi $2y$ hash cua PHP
     */
    public boolean verifyPassword(String rawPassword, String hashedPassword) {
        try {
            // Chuyen $2y$ (PHP) sang $2a$ (Java jBCrypt)
            String javaHash = hashedPassword.replace("$2y$", "$2a$");
            return BCrypt.checkpw(rawPassword, javaHash);
        } catch (Exception e) {
            return false;
        }
    }

    /** Doi mat khau */
    public boolean changePassword(int userId, String newPassword) {
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        String sql = "UPDATE nguoidung SET password=? WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Lay danh sach Khách hàng (admin) */
    public List<Customer> getAll() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM nguoidung ORDER BY user_id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int count() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM nguoidung");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Customer mapRow(ResultSet rs) throws SQLException {
        Customer c = new Customer();
        c.setUserId(rs.getInt("user_id"));
        c.setFullname(rs.getString("fullname"));
        c.setEmail(rs.getString("email"));
        c.setPassword(rs.getString("password"));
        c.setPhone(rs.getString("phone"));
        c.setAddress(rs.getString("address"));
        try { c.setCreatedAt(rs.getTimestamp("created_at")); } catch (SQLException ignored) {}
        return c;
    }
}