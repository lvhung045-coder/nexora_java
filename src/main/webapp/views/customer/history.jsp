<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/header.jsp" %>

<div class="page-wrapper">
    <div class="container">
        <div class="nexora-card">
            <h2 class="nexora-card-title"><i class="fas fa-history" style="margin-right:10px;"></i>Lich su Đơn hàng</h2>
            <c:choose>
                <c:when test="${not empty orders}">
                    <div style="overflow-x:auto;">
                        <table class="nexora-table">
                            <thead><tr>
                                <th>Ma don</th><th>Ngay dat</th><th>Tổng tiền</th>
                                <th style="text-align:center;">Thanh toán</th>
                                <th style="text-align:center;">Trang thai</th>
                                <th style="text-align:center;">Hanh dong</th>
                            </tr></thead>
                            <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td style="font-weight:bold;color:var(--secondary);">#${order.orderId}</td>
                                    <td>
                                        <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy"/><br>
                                        <small style="color:var(--text-muted);"><fmt:formatDate value="${order.createdAt}" pattern="HH:mm"/></small>
                                    </td>
                                    <td style="font-weight:bold;color:var(--secondary);font-family:'Playfair Display',serif;">
                                        <fmt:formatNumber value="${order.TốtalMoney}" pattern="#,###"/> &#8363;
                                    </td>
                                    <td style="text-align:center;">
                                        <span style="font-size:0.8rem;color:var(--text-gray);">${order.paymentMethod}</span>
                                    </td>
                                    <td style="text-align:center;">
                                        <c:choose>
                                            <c:when test="${order.status == 0}"><span style="background:rgba(255,193,7,0.15);color:#ffc107;padding:5px 12px;border-radius:20px;font-size:0.75rem;font-weight:bold;border:1px solid rgba(255,193,7,0.3);">Chờ xử lý</span></c:when>
                                            <c:when test="${order.status == 1}"><span style="background:rgba(23,162,184,0.15);color:#17a2b8;padding:5px 12px;border-radius:20px;font-size:0.75rem;font-weight:bold;border:1px solid rgba(23,162,184,0.3);">Đã gửi hàng</span></c:when>
                                            <c:when test="${order.status == 2}"><span style="background:rgba(0,123,255,0.15);color:#4dabf7;padding:5px 12px;border-radius:20px;font-size:0.75rem;font-weight:bold;border:1px solid rgba(0,123,255,0.3);">Đang giao</span></c:when>
                                            <c:when test="${order.status == 3}"><span style="background:rgba(40,167,69,0.15);color:#51cf66;padding:5px 12px;border-radius:20px;font-size:0.75rem;font-weight:bold;border:1px solid rgba(40,167,69,0.3);">Thành công</span></c:when>
                                            <c:otherwise><span style="background:rgba(220,53,69,0.15);color:#ff6b6b;padding:5px 12px;border-radius:20px;font-size:0.75rem;font-weight:bold;border:1px solid rgba(220,53,69,0.3);">Đã hủy</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="text-align:center;">
                                        <c:if test="${order.status == 0}">
                                            <a href="${pageContext.request.contextPath}/history?action=cancel&id=${order.orderId}"
                                               onclick="return confirm('Ban chac chan muon huy don nay?');"
                                               class="btn-nexora btn-nexora-red" style="padding:5px 14px;font-size:0.7rem;">Huy</a>
                                        </c:if>
                                        <c:if test="${order.status != 0}">&mdash;</c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center;padding:60px 20px;">
                        <i class="fas fa-box-open" style="font-size:4rem;color:rgba(212,175,55,0.2);margin-bottom:25px;display:block;"></i>
                        <p style="color:var(--text-gray);margin-bottom:20px;">Ban Chưa có Đơn hàng nao.</p>
                        <a href="${pageContext.request.contextPath}/" class="btn-nexora btn-nexora-gold">Mua sam ngay</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<%@ include file="/includes/footer.jsp" %>