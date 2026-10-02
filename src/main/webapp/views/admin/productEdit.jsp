<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/admin/adminHeader.jsp" %>
<div class="admin-topbar">
    <h1><i class="fas fa-edit" style="color:#D4AF37;margin-right:10px;"></i>Chinh sua Sản phẩm #${product.productId}</h1>
    <a href="${pageContext.request.contextPath}/admin/products" class="btn-nx btn-outline"><i class="fas fa-arrow-left"></i> Quay lai</a>
</div>
<div style="display:grid;grid-template-columns:2fr 1fr;gap:20px;">
<div class="card-box">
    <form action="${pageContext.request.contextPath}/admin/products" method="POST" enctype="multipart/form-data">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="product_id" value="${product.productId}">
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;">
            <div class="admin-form-group"><label>Ten Sản phẩm</label><input type="text" name="product_name" value="<c:out value='${product.productName}'/>" required></div>
            <div class="admin-form-group"><label>Danh mục</label>
                <select name="cat_id">
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat.catId}" ${cat.catId == product.catId ? 'selected' : ''}>${cat.catName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="admin-form-group"><label>Gia (VND)</label><input type="number" name="price" value="${product.price}" required></div>
            <div class="admin-form-group"><label>Ton kho</label><input type="number" name="stock" value="${product.stock}" required></div>
            <div class="admin-form-group"><label>Chat lieu</label><input type="text" name="material" value="<c:out value='${product.material}'/>"></div>
            <div class="admin-form-group"><label>Kieu dang</label><input type="text" name="style" value="<c:out value='${product.style}'/>"></div>
            <div class="admin-form-group"><label>Xuat xu</label><input type="text" name="origin" value="<c:out value='${product.origin}'/>"></div>
            <div class="admin-form-group"><label>Sản phẩm hot</label>
                <select name="is_hot">
                    <option value="0" ${!product.hot ? 'selected' : ''}>Khong</option>
                    <option value="1" ${product.hot ? 'selected' : ''}>Co - Hot!</option>
                </select>
            </div>
        </div>
        <div class="admin-form-group"><label>Mo ta</label><textarea name="product_desc" rows="4"><c:out value="${product.productDesc}"/></textarea></div>
        <div class="admin-form-group">
            <label>Hinh anh hien tai</label>
            <img src="${pageContext.request.contextPath}/assets/images/${product.image}" style="width:80px;height:80px;object-fit:contain;background:#1a1a1a;border-radius:6px;padding:4px;display:block;margin-bottom:8px;">
            <input type="file" name="image" accept="image/*">
            <small style="color:#555;font-size:0.72rem;">De trong neu khong muon thay doi anh</small>
        </div>
        <button type="submit" class="btn-nx btn-gold"><i class="fas fa-save"></i> Luu thay doi</button>
    </form>
</div>
<!-- Variants -->
<div class="card-box">
    <div class="card-box-title"><i class="fas fa-tags"></i> Bien the (Size/Mau)</div>
    <c:forEach var="v" items="${variants}">
    <div style="display:flex;justify-content:space-between;align-items:center;padding:8px 0;border-bottom:1px solid rgba(255,255,255,0.05);font-size:0.82rem;">
        <span style="color:#aaa;">Size ${v.size} - ${v.color}</span>
        <span style="color:#D4AF37;"><fmt:formatNumber value="${v.price}" pattern="#,###"/>&#8363;</span>
        <span style="color:#555;">SL: ${v.stock}</span>
        <a href="${pageContext.request.contextPath}/admin/products?action=delete_variant&id=${v.variantId}" class="btn-nx btn-red" style="padding:4px 8px;font-size:0.7rem;" onclick="return confirm('Xoa bien the nay?')"><i class="fas fa-trash"></i></a>
    </div>
    </c:forEach>
    <!-- Them bien the -->
    <form action="${pageContext.request.contextPath}/admin/products" method="POST" style="margin-top:16px;">
        <input type="hidden" name="action" value="add_variant">
        <input type="hidden" name="product_id" value="${product.productId}">
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:8px;">
            <div class="admin-form-group"><label>Size</label><input type="text" name="size" placeholder="M, L, XL..."></div>
            <div class="admin-form-group"><label>Mau</label><input type="text" name="color" placeholder="Den, Trang..."></div>
            <div class="admin-form-group"><label>Gia</label><input type="number" name="price" placeholder="150000"></div>
            <div class="admin-form-group"><label>Ton kho</label><input type="number" name="stock" placeholder="20"></div>
        </div>
        <button type="submit" class="btn-nx btn-outline" style="width:100%;justify-content:center;"><i class="fas fa-plus"></i> Them bien the</button>
    </form>
</div>
<%@ include file="/includes/admin/adminFooter.jsp" %>

