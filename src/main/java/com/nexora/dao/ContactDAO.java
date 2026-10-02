package com.nexora.dao;
import com.nexora.db.DBUtil;
import com.nexora.model.Contact;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {
    public List<Contact> getAll() {
        List<Contact> list = new ArrayList<>();
        String sql = "SELECT * FROM contacts ORDER BY contact_id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Contact c = new Contact();
                c.setContactId(rs.getInt("contact_id"));
                c.setFullname(rs.getString("fullname"));
                c.setEmail(rs.getString("email"));
                c.setMessage(rs.getString("message"));
                c.setCreatedAt(rs.getTimestamp("created_at"));
                c.setStatus(rs.getString("status"));
                list.add(c);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    
    public boolean updateStatus(int id, String status) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE contacts SET status=? WHERE contact_id=?")) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
    
    public boolean delete(int id) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM contacts WHERE contact_id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
}
