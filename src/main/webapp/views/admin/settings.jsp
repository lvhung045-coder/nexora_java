<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cấu hình - Admin Nexora</title>
    <link rel="stylesheet" href="/assets/css/nexora_luxury.css">
</head>
<body class="admin-body">
    <%@ include file="/includes/admin/adminHeader.jsp" %>
    
        <div class="admin-topbar">
            <h1>Cấu hình Hệ thống</h1>
        </div>
        <div class="card-box" style="max-width: 600px;">
            <form action="/admin/settings" method="post">
                <div class="admin-form-group">
                    <label>Tên Cửa Hàng</label>
                    <input type="text" name="shop_name" value="">
                </div>
                <div class="admin-form-group">
                    <label>Số điện thoại</label>
                    <input type="text" name="shop_phone" value="">
                </div>
                <div class="admin-form-group">
                    <label>Email Liên hệ</label>
                    <input type="email" name="shop_email" value="">
                </div>
                <div class="admin-form-group">
                    <label>Địa chỉ cửa hàng</label>
                    <textarea name="shop_address" rows="3"></textarea>
                </div>
                <button type="submit" class="btn-nx btn-gold">Lưu Thay Đổi</button>
            </form>
        <%@ include file="/includes/admin/adminFooter.jsp" %>




