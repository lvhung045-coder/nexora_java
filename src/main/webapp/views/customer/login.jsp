<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/includes/header.jsp" %>

<div class="page-wrapper">
    <div class="container">
        <div style="max-width: 480px; margin: 0 auto;">
            <div class="nexora-card">
                <h2 class="nexora-card-title">
                    <i class="fas fa-user-tie" style="margin-right: 10px;"></i>Đăng nhập
                </h2>

                <c:if test="${not empty error}">
                    <div class="nexora-alert nexora-alert-error">
                        <i class="fas fa-exclamation-triangle"></i> <c:out value="${error}"/>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="POST" class="nexora-form">
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" required placeholder="Nhap email cua ban">
                    </div>
                    <div class="form-group">
                        <label>Mat khau</label>
                        <input type="password" name="password" required placeholder="Nhap mat khau">
                    </div>
                    <button type="submit" class="btn-nexora btn-nexora-gold" style="width: 100%; margin-top: 10px;">
                        Đăng nhập
                    </button>
                    <div style="display: flex; justify-content: space-between; margin-top: 18px;">
                        <a href="${pageContext.request.contextPath}/" style="color: var(--text-gray); font-size: 0.85rem;">Ve Trang chủ</a>
                    </div>
                </form>

                <div style="text-align: center; margin-top: 25px; padding-top: 20px; border-top: 1px solid var(--border-color);">
                    <span style="color: var(--text-muted); font-size: 0.85rem;">Chưa có Tài khoản?</span>
                    <a href="${pageContext.request.contextPath}/register" style="color: var(--secondary); font-weight: 700; margin-left: 5px;">Đăng ký ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/includes/footer.jsp" %>