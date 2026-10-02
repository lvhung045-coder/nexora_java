<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Liên hệ - Admin Nexora</title>
    <link rel="stylesheet" href="/assets/css/nexora_luxury.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <%@ include file="/includes/admin/adminHeader.jsp" %>
    
        <div class="admin-topbar">
            <h1>Quản lý Liên hệ</h1>
        </div>
        <div class="card-box">
            <table class="admin-table">
                <thead><tr><th>ID</th><th>Họ Tên</th><th>Email</th><th>Nội dung</th><th>Ngày gửi</th><th>Trạng thái</th><th>Thao tác</th></tr></thead>
                <tbody>
                    <c:forEach var="c" items="${contacts}">
                        <tr>
                            <td>#${c.id}</td>
                            <td>${c.name}</td>
                            <td>${c.email}</td>
                            <td>${c.message}</td>
                            <td><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <span class="badge-nx ${c.status == 'resolved' ? 'badge-done' : 'badge-wait'}">${c.status == 'resolved' ? 'Đã xử lý' : 'Chờ xử lý'}</span>
                            </td>
                            <td>
                                <c:if test="${c.status != 'resolved'}">
                                    <a href="?action=status&id=${c.id}&st=resolved" class="btn-nx btn-outline">Xử lý xong</a>
                                </c:if>
                                <a href="?action=delete&id=${c.id}" class="btn-nx btn-red" onclick="return confirm('Xóa liên hệ này?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        <%@ include file="/includes/admin/adminFooter.jsp" %>






