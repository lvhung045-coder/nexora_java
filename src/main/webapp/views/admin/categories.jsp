<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/includes/admin/adminHeader.jsp" %>
<div class="admin-topbar">
    <h1><i class="fas fa-tags" style="color:#D4AF37;margin-right:10px;"></i>Quan ly Danh mục</h1>
</div>
<div style="display:grid;grid-template-columns:2fr 1fr;gap:20px;">
<div class="card-box">
    <table class="admin-table">
        <thead><tr><th>ID</th><th>Icon</th><th>Ten Danh mục</th><th>Hanh dong</th></tr></thead>
        <tbody>
        <c:forEach var="cat" items="${categories}">
        <tr>
            <td>${cat.catId}</td>
            <td><i class="${cat.catIcon}"></i></td>
            <td style="color:#F5F0E8;font-weight:600;">${cat.catName}</td>
            <td>
                <div style="display:flex;gap:6px;">
                    <button onclick="editCat(${cat.catId},'<c:out value="${cat.catName}"/>','<c:out value="${cat.catIcon}"/>')" class="btn-nx btn-outline" style="padding:5px 10px;font-size:0.75rem;"><i class="fas fa-edit"></i></button>
                    <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${cat.catId}" class="btn-nx btn-red" style="padding:5px 10px;font-size:0.75rem;" onclick="return confirm('Xoa Danh mục nay?')"><i class="fas fa-trash"></i></a>
                </div>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div>
<div class="card-box">
    <div class="card-box-title"><i class="fas fa-plus"></i> <span id="formTitle">Them Danh mục</span></div>
    <form action="${pageContext.request.contextPath}/admin/categories" method="POST" id="catForm">
        <input type="hidden" name="action" id="catAction" value="insert">
        <input type="hidden" name="cat_id" id="catId" value="">
        <div class="admin-form-group"><label>Ten Danh mục</label><input type="text" name="cat_name" id="catName" required></div>
        <div class="admin-form-group"><label>Font Awesome Icon class (VD: fas fa-tshirt)</label><input type="text" name="cat_icon" id="catIcon" placeholder="fas fa-tshirt"></div>
        <button type="submit" class="btn-nx btn-gold" style="width:100%;justify-content:center;"><i class="fas fa-save"></i> Luu</button>
        <button type="button" onclick="resetCatForm()" class="btn-nx btn-outline" style="width:100%;justify-content:center;margin-top:8px;">Lam moi</button>
    </form>
</div>
</div>
</div>
<script>
function editCat(id, name, icon) {
    document.getElementById('catAction').value='update';
    document.getElementById('catId').value=id;
    document.getElementById('catName').value=name;
    document.getElementById('catIcon').value=icon;
    document.getElementById('formTitle').textContent='Chinh sua Danh mục #'+id;
    document.getElementById('catName').focus();
}
function resetCatForm() {
    document.getElementById('catAction').value='insert';
    document.getElementById('catId').value='';
    document.getElementById('catName').value='';
    document.getElementById('catIcon').value='';
    document.getElementById('formTitle').textContent='Them Danh mục';
}
</script>
<%@ include file="/includes/admin/adminFooter.jsp" %>
