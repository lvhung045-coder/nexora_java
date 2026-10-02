package com.nexora.dao;

import com.nexora.db.DBUtil;
import com.nexora.model.Order;
import com.nexora.model.OrderDetail;
import com.nexora.model.CartItem;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class OrderDAO {

    /** Tao Đơn hàng tu gio hang - thay INSERT INTO quanlydonhang PHP */
    public int createOrder(int userId, String fullname, String phone, String address,
                           String note, long TốtalMoney, String paymentMethod,
                           Map<String, CartItem> cart) {
        String sql = "INSERT INTO quanlydonhang (user_id, fullname, phone, address, note, Tốtal_money, payment_method, status) VALUES (?,?,?,?,?,?,?,0)";
        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);
            int orderId = -1;
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setString(2, fullname);
                ps.setString(3, phone);
                ps.setString(4, address);
                ps.setString(5, note);
                ps.setLong(6, TốtalMoney);
                ps.setString(7, paymentMethod);
                ps.executeUpdate();
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) orderId = keys.getInt(1);
                }
            }

            if (orderId > 0) {
                // Insert Chi tiết Đơn hàng
                String detailSql = "INSERT INTO chitietdonhang (order_id, product_id, variant_id, product_name, price, quantity) VALUES (?,?,?,?,?,?)";
                String stockSql = "UPDATE product_variants SET stock = stock - ? WHERE variant_id = ?";
                try (PreparedStatement detailPs = conn.prepareStatement(detailSql);
                     PreparedStatement stockPs = conn.prepareStatement(stockSql)) {
                    for (CartItem item : cart.values()) {
                        detailPs.setInt(1, orderId);
                        detailPs.setInt(2, item.getProductId());
                        if (item.getVariantId() > 0) detailPs.setInt(3, item.getVariantId());
                        else detailPs.setNull(3, Types.INTEGER);
                        detailPs.setString(4, item.getName());
                        detailPs.setLong(5, item.getPrice());
                        detailPs.setInt(6, item.getQty());
                        detailPs.addBatch();

                        if (item.getVariantId() > 0) {
                            stockPs.setInt(1, item.getQty());
                            stockPs.setInt(2, item.getVariantId());
                            stockPs.addBatch();
                        }
                    }
                    detailPs.executeBatch();
                    stockPs.executeBatch();
                }
            }
            conn.commit();
            return orderId;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /** Lay Đơn hàng theo user */
    public List<Order> getByUser(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM quanlydonhang WHERE user_id=? ORDER BY order_id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Lay Đơn hàng theo ID */
    public Order getById(int orderId) {
        String sql = "SELECT * FROM quanlydonhang WHERE order_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /** Lay Chi tiết Đơn hàng */
    public List<OrderDetail> getDetails(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT * FROM chitietdonhang WHERE order_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail d = new OrderDetail();
                    d.setId(rs.getInt("id"));
                    d.setOrderId(rs.getInt("order_id"));
                    d.setProductId(rs.getInt("product_id"));
                    d.setVariantId(rs.getInt("variant_id"));
                    d.setProductName(rs.getString("product_name"));
                    d.setPrice(rs.getLong("price"));
                    d.setQuantity(rs.getInt("quantity"));
                    list.add(d);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Lay Tất cả Đơn hàng (admin) */
    public List<Order> getAll() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM quanlydonhang ORDER BY order_id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Lay Đơn hàng gan nhat (admin dashboard) */
    public List<Order> getRecent(int limit) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM quanlydonhang ORDER BY order_id DESC LIMIT ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Cap nhat trang thai Đơn hàng (admin) */
    public boolean updateStatus(int orderId, int status) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("UPDATE quanlydonhang SET status=? WHERE order_id=?")) {
            ps.setInt(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Huy Đơn hàng (chi status=0) */
    public boolean cancelOrder(int orderId, int userId) {
        String sql = "UPDATE quanlydonhang SET status=4 WHERE order_id=? AND user_id=? AND status=0";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /** Dem tong Đơn hàng */
    public int count() {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM quanlydonhang");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    /** Tong doanh thu (status=3) */
    public long getTốtalRevenue() {
        String sql = "SELECT COALESCE(SUM(Tốtal_money),0) FROM quanlydonhang WHERE status=3";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getLong(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    /** Doanh thu 7 ngay gan nhat - cho Chart.js */
    public List<String> getLast7DaysLabels() {
        List<String> labels = new ArrayList<>();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM");
        for (int i = 6; i >= 0; i--) {
            labels.add(LocalDate.now().minusDays(i).format(fmt));
        }
        return labels;
    }

    public List<Long> getLast7DaysRevenue() {
        List<Long> data = new ArrayList<>();
        String sql = "SELECT COALESCE(SUM(Tốtal_money),0) FROM quanlydonhang WHERE status=3 AND DATE(created_at)=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 6; i >= 0; i--) {
                String day = LocalDate.now().minusDays(i).toString();
                ps.setString(1, day);
                try (ResultSet rs = ps.executeQuery()) {
                    data.add(rs.next() ? rs.getLong(1) : 0L);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return data;
    }
    /** Top Sản phẩm bán chạy */
    public List<java.util.Map<String, Object>> getTopSellingProducts(int limit) {
        List<java.util.Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.product_name, SUM(c.quantity) as qty " +
                     "FROM chitietdonhang c JOIN products p ON c.product_id = p.product_id " +
                     "GROUP BY p.product_id ORDER BY qty DESC LIMIT ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> map = new java.util.HashMap<>();
                    map.put("name", rs.getString("product_name"));
                    map.put("qty", rs.getInt("qty"));
                    list.add(map);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    private Order mapRow(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setOrderId(rs.getInt("order_id"));
        o.setUserId(rs.getInt("user_id"));
        o.setFullname(rs.getString("fullname"));
        o.setPhone(rs.getString("phone"));
        o.setAddress(rs.getString("address"));
        o.setTốtalMoney(rs.getLong("Tốtal_money"));
        o.setNote(rs.getString("note"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setStatus(rs.getInt("status"));
        try { o.setCreatedAt(rs.getTimestamp("created_at")); } catch (SQLException ignored) {}
        return o;
    }
}
