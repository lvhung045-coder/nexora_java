<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/header.jsp" %>

<div class="page-wrapper">
    <div class="container" style="display:flex;gap:30px;flex-wrap:wrap;">
        <!-- LEFT: Thông tin Giao hàng -->
        <div style="flex:1;min-width:300px;">
            <div class="nexora-card">
                <h3 class="nexora-card-title" style="font-size:1.2rem;">
                    <i class="fas fa-shipping-fast" style="margin-right:8px;"></i>Thông tin Giao hàng
                </h3>
                <form method="POST" action="${pageContext.request.contextPath}/checkout" class="nexora-form">
                    <div class="form-group">
                        <label>Họ tên</label>
                        <input type="text" name="fullname" value="<c:out value='${customer.fullname}'/>" required>
                    </div>
                    <div class="form-group">
                        <label>So Điện thoại</label>
                        <input type="text" name="phone" value="<c:out value='${customer.phone}'/>" required>
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ Giao hàng</label>
                        <input type="text" name="address" value="<c:out value='${customer.address}'/>" required placeholder="So nha, duong, phuong/xa..." style="border-color:var(--secondary);">
                    </div>
                    <div class="form-group">
                        <label>Ghi chu <span style="color:var(--text-muted);font-weight:normal;">(neu co)</span></label>
                        <textarea name="note" placeholder="Giao gio hanh chinh..." rows="3" style="resize:none;"></textarea>
                    </div>
                    <h4 style="color:var(--secondary);font-family:'Playfair Display',serif;margin:25px 0 15px;font-size:1rem;">Phuong thuc Thanh toán</h4>
                    <div style="border:1px solid var(--border-color);border-radius:8px;overflow:hidden;">
                        <div style="padding:14px 18px;border-bottom:1px solid var(--border-color);display:flex;align-items:center;cursor:pointer;" onclick="this.querySelector('input').checked=true">
                            <input type="radio" id="cod" name="payment_method" value="Tien mat (COD)" checked style="accent-color:#D4AF37;margin-right:12px;">
                            <label for="cod" style="cursor:pointer;color:var(--text-gray);font-size:0.9rem;">
                                <i class="fas fa-money-bill-wave" style="color:#28a745;margin-right:8px;"></i> Thanh toán khi nhan hang (COD)
                            </label>
                        </div>
                        <div style="padding:14px 18px;display:flex;align-items:center;cursor:pointer;" onclick="this.querySelector('input').checked=true">
                            <input type="radio" id="banking" name="payment_method" value="Chuyển khoản" style="accent-color:#D4AF37;margin-right:12px;">
                            <label for="banking" style="cursor:pointer;color:var(--text-gray);font-size:0.9rem;">
                                <i class="fas fa-qrcode" style="color:#D4AF37;margin-right:8px;"></i> Thanh toán Chuyển khoản (QR)
                            </label>
                        </div>
                    </div>
                    <button type="submit" class="btn-nexora btn-nexora-gold" style="width:100%;margin-top:25px;padding:15px;font-size:1rem;">
                        XAC NHAN DAT HANG
                    </button>
                </form>
            </div>
        </div>
        <!-- RIGHT: Tom tat Đơn hàng -->
        <div style="width:380px;min-width:300px;">
            <div class="nexora-card" style="position:sticky;top:100px;">
                <h3 style="color:var(--secondary);font-family:'Playfair Display',serif;font-size:1.1rem;margin-bottom:20px;padding-bottom:12px;border-bottom:1px solid var(--border-gold);">
                    Đơn hàng cua ban
                </h3>
                <div style="max-height:350px;overflow-y:auto;padding-right:5px;margin-bottom:15px;">
                    <c:forEach var="entry" items="${cart}">
                    <c:set var="item" value="${entry.value}"/>
                    <div style="display:flex;gap:12px;margin-bottom:15px;border-bottom:1px solid var(--border-color);padding-bottom:12px;">
                        <img src="${pageContext.request.contextPath}/assets/images/${item.image}"
                             style="width:55px;height:55px;object-fit:contain;border:1px solid var(--border-color);border-radius:6px;background:#252525;padding:3px;">
                        <div style="flex:1;">
                            <div style="font-weight:600;font-size:0.8rem;line-height:1.4;color:var(--text-white);margin-bottom:4px;"><c:out value="${item.name}"/></div>
                            <div style="font-size:0.75rem;color:var(--text-muted);">x ${item.qty}</div>
                            <div style="font-weight:bold;color:var(--secondary);font-size:0.85rem;font-family:'Playfair Display',serif;">
                                <fmt:formatNumber value="${item.price}" pattern="#,###"/> &#8363;
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
                <div style="display:flex;justify-content:space-between;font-size:1.1rem;font-weight:bold;border-top:1px solid var(--border-gold);padding-top:15px;">
                    <span style="color:var(--text-gray);">Tổng tiền:</span>
                    <span style="color:var(--secondary);font-family:'Playfair Display',serif;font-size:1.3rem;">
                        <fmt:formatNumber value="${TốtalMoney}" pattern="#,###"/> &#8363;
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/includes/footer.jsp" %>