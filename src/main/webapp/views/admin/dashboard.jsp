<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/admin/adminHeader.jsp" %>

<div class="admin-topbar">
    <h1><i class="fas fa-chart-area" style="color:#D4AF37;margin-right:10px;"></i>Dashboard</h1>
</div>

<!-- STất cảRDS - giong het PHP -->
<div class="row-stats">
    <div class="stat-card">
        <div class="stat-icon gold"><i class="fas fa-tshirt"></i></div>
        <div class="stat-info"><h3>${TốtalProducts}</h3><p>Sản phẩm</p></div>
    </div>
    <div class="stat-card">
        <div class="stat-icon blue"><i class="fas fa-star"></i></div>
        <div class="stat-info"><h3>${TốtalReviews}</h3><p>Đánh giá</p></div>
    </div>
    <div class="stat-card">
        <div class="stat-icon red"><i class="fas fa-shopping-bag"></i></div>
        <div class="stat-info"><h3>${TốtalOrders}</h3><p>Đơn hàng</p></div>
    </div>
    <div class="stat-card">
        <div class="stat-icon green"><i class="fas fa-coins"></i></div>
        <div class="stat-info"><h3 style="font-size:1rem;"><fmt:formatNumber value="${TốtalRevenue}" pattern="#,###"/> &#8363;</h3><p>Doanh thu</p></div>
    </div>
</div>

<!-- CHART + RECENT ORDERS -->
<div style="display:grid;grid-template-columns:2fr 1fr;gap:20px;">
    <div class="card-box">
        <div class="card-box-title"><i class="fas fa-chart-area"></i> Doanh thu 7 ngày qua</div>
        <div style="position:relative;height:300px;">
            <canvas id="revenueChart"></canvas>
        </div>
    </div>
    <div class="card-box">
        <div class="card-box-title"><i class="fas fa-clock"></i> Đơn hàng mới nhất</div>
        <div style="display:flex;flex-direction:column;gap:0;">
            <c:choose>
                <c:when test="${not empty recentOrders}">
                    <c:forEach var="order" items="${recentOrders}">
                    <div style="display:flex;justify-content:space-between;align-items:center;padding:11px 0;border-bottom:1px solid rgba(255,255,255,0.05);">
                        <div>
                            <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${order.orderId}"
                               style="font-weight:700;color:#D4AF37;font-size:0.88rem;">#${order.orderId}</a>
                            <div style="font-size:0.78rem;color:#666;margin-top:2px;"><c:out value="${order.fullname}"/></div>
                        </div>
                        <div style="text-align:right;">
                            <div style="font-weight:700;color:#E8E8E8;font-size:0.85rem;">
                                <fmt:formatNumber value="${order.TốtalMoney}" pattern="#,###"/>&#8363;
                            </div>
                            <span class="badge-nx ${order.statusClass}" style="margin-top:3px;">${order.statusLabel}</span>
                        </div>
                    </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="text-align:center;padding:30px;color:#444;">Chưa có Đơn hàng nao.</p>
                </c:otherwise>
            </c:choose>
        </div>
        <div style="margin-top:14px;">
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn-nx btn-outline" style="width:100%;justify-content:center;">Xem Tất cả Đơn hàng</a>
        </div>
    </div>
</div>

<!-- TOP SELLING PRODUCTS -->
<div class="card-box" style="margin-top:20px;">
    <div class="card-box-title"><i class="fas fa-fire" style="color:#ff6b6b;"></i> Top Sản phẩm bán chạy</div>
    <table class="admin-table">
        <thead>
            <tr>
                <th>Sản phẩm</th>
                <th style="text-align:right;">Đã bán</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty topProducts}">
                    <c:forEach var="tp" items="${topProducts}">
                        <tr>
                            <td>${tp.name}</td>
                            <td style="text-align:right;font-weight:700;color:#D4AF37;">${tp.qty}</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr><td colspan="2" style="text-align:center;padding:20px;color:#555;">Chưa có dữ liệu.</td></tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
new Chart(document.getElementById('revenueChart'), {
    type: 'line',
    data: {
        labels: [<c:forEach var="l" items="${chartLabels}" varStatus="s">'${l}'<c:if test="${!s.last}">,</c:if></c:forEach>],
        datasets: [{
            label: 'Doanh thu',
            data: [<c:forEach var="d" items="${chartData}" varStatus="s">${d}<c:if test="${!s.last}">,</c:if></c:forEach>],
            borderColor: '#D4AF37',
            backgroundColor: 'rgba(212,175,55,0.08)',
            borderWidth: 2, fill: true, tension: 0.4,
            pointBackgroundColor: '#D4AF37', pointRadius: 4, pointHoverRadius: 6
        }]
    },
    options: {
        responsive: true, maintainAspectRatio: false,
        plugins: { legend: { display: false } },
        scales: {
            x: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#666' } },
            y: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: '#666' }, beginAtZero: true }
        }
    }
});
</script>

<%@ include file="/includes/admin/adminFooter.jsp" %>

