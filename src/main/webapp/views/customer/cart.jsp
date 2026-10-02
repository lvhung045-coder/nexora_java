<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/header.jsp" %>
<%
    java.util.Map<String, com.nexora.model.CartItem> cartMap =
        (java.util.Map<String, com.nexora.model.CartItem>) session.getAttribute("cart");
    long TốtalBill = 0;
    if (cartMap != null) {
        for (com.nexora.model.CartItem ci : cartMap.values()) TốtalBill += ci.getSubTốtal();
    }
    request.setAttribute("cartMap", cartMap);
    request.setAttribute("TốtalBill", TốtalBill);
%>
<div class="page-wrapper">
    <div class="container">
        <div class="nexora-card">
            <h2 class="nexora-card-title">
                <i class="fas fa-shopping-bag" style="margin-right: 10px;"></i>GIỎ HÀNG CỦA BẠN
            </h2>
            <c:choose>
                <c:when test="${not empty cartMap}">
                    <form action="${pageContext.request.contextPath}/cart" method="POST">
                        <div class="cart-table-wrapper">
                            <table class="nexora-table">
                                <thead><tr>
                                    <th>Sản phẩm</th><th>Don gia</th><th>Số lượng</th><th>Thanh tien</th>
                                    <th style="text-align:center;">Xoa</th>
                                </tr></thead>
                                <tbody>
                                    <c:forEach var="entry" items="${cartMap}">
                                    <c:set var="item" value="${entry.value}"/>
                                    <tr>
                                        <td>
                                            <div style="display:flex;align-items:center;gap:12px;">
                                                <img src="${pageContext.request.contextPath}/assets/images/${item.image}"
                                                     style="width:64px;height:64px;object-fit:contain;border:1px solid var(--border-color);padding:4px;border-radius:8px;background:#252525;flex-shrink:0;">
                                                <span style="font-weight:600;color:var(--text-white);font-size:0.9rem;">
                                                    <c:out value="${item.name}"/>
                                                </span>
                                            </div>
                                            <input type="hidden" name="cart_key" value="${entry.key}">
                                        </td>
                                        <td style="color:var(--text-gray);">
                                            <fmt:formatNumber value="${item.price}" pattern="#,###"/> &#8363;
                                        </td>
                                        <td>
                                            <input type="number" name="qty" value="${item.qty}" min="1"
                                                   style="width:65px;padding:8px;text-align:center;background:rgba(255,255,255,0.05);border:1px solid var(--border-color);border-radius:6px;color:var(--text-white);outline:none;">
                                        </td>
                                        <td style="color:var(--secondary);font-weight:bold;font-family:'Playfair Display',serif;">
                                            <fmt:formatNumber value="${item.subTốtal}" pattern="#,###"/> &#8363;
                                        </td>
                                        <td style="text-align:center;">
                                            <a href="${pageContext.request.contextPath}/cart?action=delete&id=${entry.key}"
                                               style="color:#666;font-size:1.1rem;padding:8px;display:inline-block;transition:all 0.3s;"
                                               onmouseover="this.style.color='#8B0000'" onmouseout="this.style.color='#666'"
                                               onclick="return confirm('Ban muon xoa Sản phẩm nay?')">
                                                <i class="fas fa-trash-alt"></i>
                                            </a>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div style="display:flex;justify-content:space-between;align-items:center;margin-top:22px;padding-top:18px;border-top:1px solid var(--border-color);flex-wrap:wrap;gap:12px;">
                            <a href="${pageContext.request.contextPath}/" style="color:var(--text-gray);font-size:0.9rem;display:flex;align-items:center;gap:6px;">
                                <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                            </a>
                            <button type="submit" class="btn-nexora btn-nexora-outline" style="padding:10px 22px;font-size:0.82rem;">
                                <i class="fas fa-sync-alt" style="margin-right:6px;"></i> Cap nhat gio hang
                            </button>
                        </div>
                    </form>
                    <div style="margin-top:30px;border-top:1px solid var(--border-gold);padding-top:22px;">
                        <div style="display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:16px;">
                            <div>
                                <p style="font-size:0.85rem;color:var(--text-gray);margin-bottom:4px;">Tong cong:</p>
                                <div style="font-size:clamp(1.4rem,4vw,1.8rem);color:var(--secondary);font-weight:bold;font-family:'Playfair Display',serif;">
                                    <fmt:formatNumber value="${TốtalBill}" pattern="#,###"/> &#8363;
                                </div>
                                <p style="font-size:0.72rem;color:var(--text-muted);margin-top:4px;">(Da bao gom VAT neu co)</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/checkout" class="btn-nexora btn-nexora-gold" style="padding:14px 32px;font-size:0.95rem;">
                                Tiến hành đặt hàng <i class="fas fa-arrow-right" style="margin-left:8px;"></i>
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align:center;padding:60px 20px;">
                        <i class="fas fa-shopping-bag" style="font-size:3.5rem;color:rgba(212,175,55,0.2);margin-bottom:20px;display:block;"></i>
                        <h3 style="font-size:1.05rem;font-weight:400;color:var(--text-gray);margin-bottom:22px;">GIỎ HÀNG CỦA BẠN dang trong</h3>
                        <a href="${pageContext.request.contextPath}/" class="btn-nexora btn-nexora-gold">
                            <i class="fas fa-shopping-basket" style="margin-right:8px;"></i> Tiếp tục mua sắm
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<%@ include file="/includes/footer.jsp" %>