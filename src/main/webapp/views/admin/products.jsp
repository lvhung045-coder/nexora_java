<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/admin/adminHeader.jsp" %>

<div class="admin-topbar">
    <h1><i class="fas fa-tshirt" style="color:#D4AF37;margin-right:10px;"></i>Quan ly Sản phẩm</h1>
    <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn-nx btn-gold">
        <i class="fas fa-plus"></i> Them Sản phẩm
    </a>
</div>

<div class="card-box">
    <div style="overflow-x:auto;">
        <table class="admin-table">
            <thead><tr>
                <th>ID</th><th>Hinh</th><th>Ten Sản phẩm</th><th>Gia</th><th>Ton kho</th><th>Hot</th><th>Hanh dong</th>
            </tr></thead>
            <tbody>
            <c:forEach var="p" items="${products}">
            <tr>
                <td style="color:#555;">#${p.productId}</td>
                <td><img src="${pageContext.request.contextPath}/assets/images/${p.image}" style="width:48px;height:48px;object-fit:contain;background:#1a1a1a;border-radius:6px;padding:4px;border:1px solid rgba(255,255,255,0.08);"></td>
                <td style="color:#F5F0E8;font-weight:600;"><c:out value="${p.productName}"/></td>
                <td style="color:#D4AF37;"><fmt:formatNumber value="${p.price}" pattern="#,###"/>&#8363;</td>
                <td>${p.stock}</td>
                <td><c:if test="${p.hot}"><span class="badge-nx badge-done">Hot</span></c:if><c:if test="${!p.hot}"><span style="color:#333;">-</span></c:if></td>
                <td>
                    <div style="display:flex;gap:6px;">
                        <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.productId}" class="btn-nx btn-outline" style="padding:6px 12px;font-size:0.75rem;"><i class="fas fa-edit"></i></a>
                        <a href="${pageContext.request.contextPath}/admin/products?action=delete&id=${p.productId}" class="btn-nx btn-red" style="padding:6px 12px;font-size:0.75rem;"
                           onclick="return confirm('Xoa Sản phẩm nay?')"><i class="fas fa-trash"></i></a>
                    </div>
                </td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
<%@ include file="/includes/admin/adminFooter.jsp" %>

