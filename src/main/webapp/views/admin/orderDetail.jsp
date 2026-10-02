<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/admin/adminHeader.jsp" %>
<div class="admin-topbar">
    <h1><i class="fas fa-file-invoice" style="color:#D4AF37;margin-right:10px;"></i>Đơn hàng #${order.orderId}</h1>
    <a href="${pageContext.request.contextPath}/admin/orders" class="btn-nx btn-outline"><i class="fas fa-arrow-left"></i> Quay lai</a>
</div>
<div style="display:grid;grid-template-columns:2fr 1fr;gap:20px;">
<div>
    <div class="card-box">
        <div class="card-box-title"><i class="fas fa-list"></i> Chi tiết Sản phẩm</div>
        <table class="admin-table">
            <thead><tr><th>Sản phẩm</th><th>Don gia</th><th>Số lượng</th><th>Thanh tien</th></tr></thead>
            <tbody>
            <c:forEach var="d" items="${details}">
            <tr>
                <td><c:out value="${d.productName}"/></td>
                <td style="color:#D4AF37;"><fmt:formatNumber value="${d.price}" pattern="#,###"/>&#8363;</td>
                <td>${d.quantity}</td>
                <td style="font-weight:bold;"><fmt:formatNumber value="${d.subTốtal}" pattern="#,###"/>&#8363;</td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
        <div style="text-align:right;font-size:1.1rem;font-weight:bold;padding-top:15px;border-top:1px solid rgba(255,255,255,0.07);margin-top:10px;">
            Tong: <span style="color:#D4AF37;"><fmt:formatNumber value="${order.TốtalMoney}" pattern="#,###"/>&#8363;</span>
        </div>
    </div>
</div>
<div>
    <div class="card-box">
        <div class="card-box-title"><i class="fas fa-user"></i> Thông tin Khách hàng</div>
        <div style="font-size:0.88rem;line-height:2.2;color:#aaa;">
            <div><strong style="color:#D4AF37;">Họ tên:</strong> <c:out value="${order.fullname}"/></div>
            <div><strong style="color:#D4AF37;">Điện thoại:</strong> ${order.phone}</div>
            <div><strong style="color:#D4AF37;">Địa chỉ:</strong> <c:out value="${order.address}"/></div>
            <div><strong style="color:#D4AF37;">Thanh toán:</strong> ${order.paymentMethod}</div>
            <c:if test="${not empty order.note}">
            <div><strong style="color:#D4AF37;">Ghi chu:</strong> <c:out value="${order.note}"/></div>
            </c:if>
        </div>
        <div style="margin-top:20px;padding-top:16px;border-top:1px solid rgba(255,255,255,0.07);">
            <div class="card-box-title"><i class="fas fa-clipboard-list"></i> Cap nhat trang thai</div>
            <form action="${pageContext.request.contextPath}/admin/orders" method="GET">
                <input type="hidden" name="action" value="update_status">
                <input type="hidden" name="id" value="${order.orderId}">
                <div class="admin-form-group">
                    <select name="status">
                        <option value="0" ${order.status==0?'selected':''}>Chờ xử lý</option>
                        <option value="1" ${order.status==1?'selected':''}>Đã gửi hàng</option>
                        <option value="2" ${order.status==2?'selected':''}>Đang giao</option>
                        <option value="3" ${order.status==3?'selected':''}>Thành công</option>
                        <option value="4" ${order.status==4?'selected':''}>Đã hủy</option>
                    </select>
                </div>
                <button type="submit" class="btn-nx btn-gold" style="width:100%;justify-content:center;"><i class="fas fa-save"></i> Cap nhat</button>
            </form>
        </div>
    </div>
</div>
<%@ include file="/includes/admin/adminFooter.jsp" %>

