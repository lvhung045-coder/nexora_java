<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/admin/adminHeader.jsp" %>
<div class="admin-topbar">
    <h1><i class="fas fa-shopping-bag" style="color:#D4AF37;margin-right:10px;"></i>Quan ly Đơn hàng</h1>
</div>
<div class="card-box">
    <div style="overflow-x:auto;">
        <table class="admin-table">
            <thead><tr>
                <th>Ma don</th><th>Khách hàng</th><th>SDD</th><th>Tổng tiền</th><th>Thanh toán</th><th>Ngay dat</th><th>Trang thai</th><th>Chi tiết</th>
            </tr></thead>
            <tbody>
            <c:forEach var="order" items="${orders}">
            <tr>
                <td style="font-weight:bold;color:#D4AF37;">#${order.orderId}</td>
                <td style="font-weight:600;color:#F5F0E8;"><c:out value="${order.fullname}"/></td>
                <td>${order.phone}</td>
                <td style="color:#D4AF37;"><fmt:formatNumber value="${order.TốtalMoney}" pattern="#,###"/>&#8363;</td>
                <td style="font-size:0.8rem;">${order.paymentMethod}</td>
                <td style="color:#666;font-size:0.8rem;"><fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy"/></td>
                <td><span class="badge-nx ${order.statusClass}">${order.statusLabel}</span></td>
                <td><a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${order.orderId}" class="btn-nx btn-outline" style="padding:5px 12px;font-size:0.75rem;"><i class="fas fa-eye"></i> Xem</a></td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
<%@ include file="/includes/admin/adminFooter.jsp" %>

