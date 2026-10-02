<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/includes/admin/adminHeader.jsp" %>
<div class="admin-topbar">
    <h1><i class="fas fa-plus" style="color:#D4AF37;margin-right:10px;"></i>Them Sản phẩm moi</h1>
    <a href="${pageContext.request.contextPath}/admin/products" class="btn-nx btn-outline"><i class="fas fa-arrow-left"></i> Quay lai</a>
</div>
<div class="card-box" style="max-width:700px;">
    <form action="${pageContext.request.contextPath}/admin/products" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="action" value="insert">
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
            <div class="admin-form-group"><label>Ten Sản phẩm</label><input type="text" name="product_name" required></div>
            <div class="admin-form-group"><label>Danh mục</label>
                <select name="cat_id">
                    <c:forEach var="cat" items="${categories}"><option value="${cat.catId}">${cat.catName}</option></c:forEach>
                </select>
            </div>
            <div class="admin-form-group"><label>Gia (VND)</label><input type="number" name="price" required min="0"></div>
            <div class="admin-form-group"><label>Ton kho</label><input type="number" name="stock" required min="0"></div>
            <div class="admin-form-group"><label>Chat lieu</label><input type="text" name="material"></div>
            <div class="admin-form-group"><label>Kieu dang</label><input type="text" name="style"></div>
            <div class="admin-form-group"><label>Xuat xu</label><input type="text" name="origin"></div>
            <div class="admin-form-group"><label>Sản phẩm hot</label>
                <select name="is_hot"><option value="0">Khong</option><option value="1">Co - Hot!</option></select>
            </div>
        </div>
        <div class="admin-form-group"><label>Mo ta</label><textarea name="product_desc" rows="4"></textarea></div>
        <div class="admin-form-group"><label>Hinh anh</label><input type="file" name="image" accept="image/*"></div>
        <div style="margin-top:10px;">
            <button type="submit" class="btn-nx btn-gold"><i class="fas fa-save"></i> Luu Sản phẩm</button>
        </div>
    </form>
<%@ include file="/includes/admin/adminFooter.jsp" %>

