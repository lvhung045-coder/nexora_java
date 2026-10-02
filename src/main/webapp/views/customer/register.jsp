<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/includes/header.jsp" %>

<div class="page-wrapper">
    <div class="container">
        <div style="max-width: 520px; margin: 0 auto;">
            <div class="nexora-card">
                <h2 class="nexora-card-title">
                    <i class="fas fa-user-plus" style="margin-right: 10px;"></i>Đăng ký thanh vien
                </h2>
                <c:if test="${not empty error}">
                    <div class="nexora-alert nexora-alert-error">
                        <i class="fas fa-exclamation-triangle"></i> <c:out value="${error}"/>
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="nexora-alert nexora-alert-success">
                        <i class="fas fa-check-circle"></i> <c:out value="${success}"/>
                        <a href="${pageContext.request.contextPath}/login" style="color: var(--secondary); font-weight: bold; text-decoration: underline; margin-left: 5px;">Đăng nhập ngay</a>
                    </div>
                </c:if>
                <form action="${pageContext.request.contextPath}/register" method="POST" class="nexora-form">
                    <div class="form-group"><label>Ho va ten</label><input type="text" name="fullname" required placeholder="Nhap ho va ten"></div>
                    <div class="form-group"><label>Email</label><input type="email" name="email" required placeholder="Nhap email"></div>
                    <div class="form-group"><label>So Điện thoại</label><input type="text" name="phone" required placeholder="Nhap so Điện thoại"></div>
                    <div class="form-group"><label>Địa chỉ <span style="color: var(--text-muted); font-weight:normal;">(khong bat buoc)</span></label><input type="text" name="address" placeholder="So nha, duong, phuong/xa..."></div>
                    <div class="form-group"><label>Mat khau</label><input type="password" name="password" required placeholder="Toi thieu 6 ky tu"></div>
                    <div class="form-group"><label>Nhap lai mat khau</label><input type="password" name="re_password" required placeholder="Xac nhan mat khau"></div>
                    <button type="submit" class="btn-nexora btn-nexora-gold" style="width: 100%; margin-top: 5px;">Đăng ký</button>
                </form>
                <div style="text-align: center; margin-top: 25px; padding-top: 20px; border-top: 1px solid var(--border-color);">
                    <span style="color: var(--text-muted); font-size: 0.85rem;">Da co Tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/login" style="color: var(--secondary); font-weight: 700; margin-left: 5px;">Đăng nhập</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>