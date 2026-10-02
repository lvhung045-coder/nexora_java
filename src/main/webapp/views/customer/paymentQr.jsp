<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/header.jsp" %>

<div class="page-wrapper">
    <div class="container">
        <div style="max-width:500px;margin:0 auto;">
            <div class="nexora-card" style="text-align:center;">
                <h2 class="nexora-card-title" style="justify-content:center;">
                    <i class="fas fa-qrcode" style="margin-right:10px;color:#D4AF37;"></i>Thanh toán Chuyển khoản
                </h2>
                <p style="color:var(--text-gray);margin-bottom:20px;">
                    Đơn hàng <strong style="color:#D4AF37;">#${order.orderId}</strong> - 
                    Tong: <strong style="color:#D4AF37;"><fmt:formatNumber value="${order.TốtalMoney}" pattern="#,###"/> &#8363;</strong>
                </p>
                <div style="background:rgba(255,255,255,0.05);border:1px solid rgba(212,175,55,0.2);border-radius:12px;padding:24px;margin-bottom:20px;">
                    <img src="https://img.vietqr.io/image/MBBank-0352890829-qr_only.png?amount=${order.TốtalMoney}&addInfo=NEXORA%20Don%20hang%20${order.orderId}"
                         alt="QR Code Thanh toán" style="width:220px;height:220px;border-radius:8px;">
                    <p style="margin-top:15px;font-size:0.85rem;color:var(--text-gray);">Quet QR de Chuyển khoản</p>
                    <div style="margin-top:12px;font-size:0.8rem;color:#555;line-height:1.8;">
                        <div>Ngan hang: <strong style="color:#D4AF37;">MB Bank</strong></div>
                        <div>STK: <strong style="color:#D4AF37;">0352890829</strong></div>
                        <div>Noi dung: <strong style="color:#D4AF37;">NEXORA Đơn hàng ${order.orderId}</strong></div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/history" class="btn-nexora btn-nexora-gold" style="margin-top:10px;">
                    <i class="fas fa-history" style="margin-right:8px;"></i>Xem lich su Đơn hàng
                </a>
            </div>
        </div>
    </div>
</div>
<%@ include file="/includes/footer.jsp" %>