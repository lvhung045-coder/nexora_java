<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/admin/adminHeader.jsp" %>
<div class="admin-topbar">
    <h1><i class="fas fa-users" style="color:#D4AF37;margin-right:10px;"></i>Quan ly Khách hàng</h1>
</div>
<div class="card-box">
    <div style="overflow-x:auto;">
        <table class="admin-table">
            <thead><tr><th>ID</th><th>Họ tên</th><th>Email</th><th>SDT</th><th>Địa chỉ</th><th>Ngay DK</th></tr></thead>
            <tbody>
            <c:forEach var="c" items="${customers}">
            <tr>
                <td style="color:#555;">#${c.userId}</td>
                <td style="font-weight:600;color:#F5F0E8;"><c:out value="${c.fullname}"/></td>
                <td><c:out value="${c.email}"/></td>
                <td>${c.phone}</td>
                <td style="color:#666;max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;"><c:out value="${c.address}"/></td>
                <td style="color:#555;font-size:0.8rem;"><fmt:formatDate value="${c.createdAt}" pattern="dd/MM/yyyy"/></td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
<%@ include file="/includes/admin/adminFooter.jsp" %>

