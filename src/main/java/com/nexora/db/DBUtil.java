package com.nexora.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.util.Locale;

/**
 * DBUtil.java - Quan ly ket noi JDBC
 * Thay the includes/connect.php
 */
public class DBUtil {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL =
        "jdbc:mysql://localhost:3306/nexora_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Ho_Chi_Minh&useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASS = "";

    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Khong tim thay MySQL JDBC Driver", e);
        }
    }

    /** Lay ket noi moi den database */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    /**
     * Format tien VND - thay the ham formatCurrency() trong PHP
     * Vi du: 150000 -> "150.000 d"
     */
    public static String formatCurrency(long amount) {
        NumberFormat nf = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
        return nf.format(amount).replace(",", ".") + " \u20ab";
    }

    public static String formatCurrency(Object amount) {
        if (amount == null) return "0 \u20ab";
        if (amount instanceof Number) {
            return formatCurrency(((Number) amount).longValue());
        }
        try {
            return formatCurrency(Long.parseLong(amount.toString()));
        } catch (NumberFormatException e) {
            return "0 \u20ab";
        }
    }
}