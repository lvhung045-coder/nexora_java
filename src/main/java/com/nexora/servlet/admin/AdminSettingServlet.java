package com.nexora.servlet.admin;
import com.nexora.db.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/admin/settings")
public class AdminSettingServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Map<String, String> settings = new HashMap<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM settings");
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                settings.put(rs.getString("setting_key"), rs.getString("setting_value"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        req.setAttribute("settings", settings);
        req.getRequestDispatcher("/views/admin/settings.jsp").forward(req, resp);
    }
    
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try (Connection conn = DBUtil.getConnection()) {
            Enumeration<String> params = req.getParameterNames();
            while (params.hasMoreElements()) {
                String key = params.nextElement();
                String value = req.getParameter(key);
                try (PreparedStatement ps = conn.prepareStatement("INSERT INTO settings (setting_key, setting_value) VALUES (?,?) ON DUPLICATE KEY UPDATE setting_value=?")) {
                    ps.setString(1, key);
                    ps.setString(2, value);
                    ps.setString(3, value);
                    ps.executeUpdate();
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        req.getSession().setAttribute("toastMsg", "Cập nhật cấu hình thành công!");
        req.getSession().setAttribute("toastType", "success");
        resp.sendRedirect(req.getContextPath() + "/admin/settings");
    }
}
