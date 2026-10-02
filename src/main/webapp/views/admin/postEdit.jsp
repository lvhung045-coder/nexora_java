<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title> Bài viết</title>
    <link rel="stylesheet" href="/assets/css/nexora_luxury.css">
</head>
<body class="admin-body">
    <%@ include file="/includes/admin/adminHeader.jsp" %>
    
        <div class="admin-topbar">
            <h1> Bài viết</h1>
        </div>
        <div class="card-box">
            <form action="/admin/posts" method="post">
                <input type="hidden" name="id" value="">
                <div class="admin-form-group">
                    <label>Tiêu đề</label>
                    <input type="text" name="title" value="" required>
                </div>
                <div class="admin-form-group">
                    <label>Nội dung</label>
                    <textarea name="content" rows="6" required></textarea>
                </div>
                <div class="admin-form-group">
                    <label>Hình ảnh (URL hoặc tên file)</label>
                    <input type="text" name="image" value="">
                </div>
                <div class="admin-form-group">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="published" >Xuất bản</option>
                        <option value="draft" >Bản nháp</option>
                    </select>
                </div>
                <button type="submit" class="btn-nx btn-gold">Lưu bài viết</button>
                <a href="/admin/posts" class="btn-nx btn-gold" style="background: #333;">Hủy</a>
            </form>
        <%@ include file="/includes/admin/adminFooter.jsp" %>




