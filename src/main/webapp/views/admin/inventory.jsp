<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Kho - Admin Nexora</title>
    <link rel="stylesheet" href="/assets/css/nexora_luxury.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="admin-body">
    <%@ include file="/includes/admin/adminHeader.jsp" %>

    
        <div class="admin-topbar">
            <h1>Quản lý kho hàng & Hóa đơn nhập</h1>
            <a href="/admin/inventory?action=new_import" class="btn-nx btn-gold"><i class="fas fa-plus"></i> Tạo phiếu nhập kho</a>
        </div>

        <h3 class="card-box-title">Tình trạng tồn kho</h3>
        <div class="card-box" style="margin-bottom: 30px;">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Sản phẩm</th>
                        <th>Danh mục</th>
                        <th>Tồn kho</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>#${p.productId}</td>
                            <td>${p.productName}</td>
                            <td>${p.catName}</td>
                            <td>${p.stock}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${p.stock == 0}"><span style="color: #ff4d4d; font-weight: bold;">Hết hàng</span></c:when>
                                    <c:when test="${p.stock < 10}"><span style="color: #ffa502; font-weight: bold;">Sắp hết</span></c:when>
                                    <c:otherwise><span style="color: #2ed573;">Còn hàng</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <h3 class="card-box-title">Lịch sử hóa đơn nhập</h3>
        <div class="card-box">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Mã phiếu</th>
                        <th>Nhà cung cấp</th>
                        <th>Tổng tiền</th>
                        <th>Người tạo</th>
                        <th>Ngày nhập</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="inv" items="${invoices}">
                        <tr>
                            <td>#IMP-${inv.importId}</td>
                            <td>${inv.supplier}</td>
                            <td><fmt:formatNumber value="${inv.TốtalCost}" pattern="#,###"/> đ</td>
                            <td>${inv.createdBy}</td>
                            <td><fmt:formatDate value="${inv.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        <%@ include file="/includes/admin/adminFooter.jsp" %>








