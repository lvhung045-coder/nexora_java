<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Bài viết - Admin Nexora</title>
    <link rel="stylesheet" href="/assets/css/nexora_luxury.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <%@ include file="/includes/admin/adminHeader.jsp" %>
    
        <div class="admin-topbar">
            <h1>Quản lý Bài viết</h1>
            <a href="/admin/posts?action=edit" class="btn-nx btn-gold"><i class="fas fa-plus"></i> Thêm bài viết</a>
        </div>
        <div class="card-box">
            <table class="admin-table">
                <thead><tr><th>ID</th><th>Tiêu đề</th><th>Ngày tạo</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
                <tbody>
                    <c:forEach var="p" items="${posts}">
                        <tr>
                            <td>#${p.id}</td>
                            <td>${p.title}</td>
                            <td><fmt:formatDate value="${p.createdAt}" pattern="dd/MM/yyyy"/></td>
                            <td>${p.status == 1 ? 'Hiển thị' : 'Ẩn'}</td>
                            <td>
                                <a href="?action=edit&id=${p.id}" class="btn-nx btn-outline">Sửa</a>
                                <a href="?action=delete&id=${p.id}" class="btn-nx btn-red" onclick="return confirm('Xóa bài viết này?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        <%@ include file="/includes/admin/adminFooter.jsp" %>






