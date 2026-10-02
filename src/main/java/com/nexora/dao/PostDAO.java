package com.nexora.dao;
import com.nexora.db.DBUtil;
import com.nexora.model.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    public List<Post> getAll() {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT * FROM posts ORDER BY post_id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Post p = new Post();
                p.setPostId(rs.getInt("post_id"));
                p.setTitle(rs.getString("title"));
                p.setContent(rs.getString("content"));
                p.setImage(rs.getString("image"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setStatus(rs.getString("status"));
                list.add(p);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    
    public Post getById(int id) {
        String sql = "SELECT * FROM posts WHERE post_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Post p = new Post();
                    p.setPostId(rs.getInt("post_id"));
                    p.setTitle(rs.getString("title"));
                    p.setContent(rs.getString("content"));
                    p.setImage(rs.getString("image"));
                    p.setCreatedAt(rs.getTimestamp("created_at"));
                    p.setStatus(rs.getString("status"));
                    return p;
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
    
    public boolean insert(Post p) {
        String sql = "INSERT INTO posts (title, content, image, status) VALUES (?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getContent());
            ps.setString(3, p.getImage());
            ps.setString(4, p.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
    
    public boolean update(Post p) {
        String sql = "UPDATE posts SET title=?, content=?, image=?, status=? WHERE post_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getContent());
            ps.setString(3, p.getImage());
            ps.setString(4, p.getStatus());
            ps.setInt(5, p.getPostId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
    
    public boolean delete(int id) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM posts WHERE post_id=?")) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
}
