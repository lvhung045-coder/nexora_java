<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/includes/header.jsp" %>
<div class="page-wrapper">
    <div class="container">
        <div style="max-width:480px;margin:0 auto;">
            <div class="nexora-card">
                <h2 class="nexora-card-title"><i class="fas fa-key" style="margin-right:10px;"></i>Doi mat khau</h2>
                <c:if test="${not empty error}">
                    <div class="nexora-alert nexora-alert-error"><i class="fas fa-exclamation-triangle"></i> <c:out value="${error}"/></div>
                </c:if>
                <form action="${pageContext.request.contextPath}/change-password" method="POST" class="nexora-form">
                    <div class="form-group"><label>Mat khau hien tai</label><input type="password" name="old_password" required placeholder="Nhap mat khau hien tai"></div>
                    <div class="form-group"><label>Mat khau moi</label><input type="password" name="new_password" required placeholder="Toi thieu 6 ky tu"></div>
                    <div class="form-group"><label>Xac nhan mat khau moi</label><input type="password" name="confirm_password" required placeholder="Nhap lai mat khau moi"></div>
                    <button type="submit" class="btn-nexora btn-nexora-gold" style="width:100%;margin-top:8px;">DOI MAT KHAU</button>
                    <a href="${pageContext.request.contextPath}/" class="btn-nexora btn-nexora-outline" style="width:100%;margin-top:10px;">HUY</a>
                </form>
            </div>
        </div>
    </div>
</div>
<%@ include file="/includes/footer.jsp" %>