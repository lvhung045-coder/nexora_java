<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/header.jsp" %>

<div class="page-wrapper">
    <div class="container">
        <h2 class="nexora-card-title" style="margin-bottom:20px;">
            <i class="${category.catIcon}" style="margin-right:8px;"></i>${category.catName}
            <span style="font-size:0.75rem;color:#555;font-weight:400;margin-left:10px;">${Tốtal} Sản phẩm</span>
        </h2>
        <!-- Danh mục ngang -->
        <div style="display:flex;gap:10px;flex-wrap:wrap;margin-bottom:30px;">
            <c:forEach var="cat" items="${allCategories}">
                <a href="${pageContext.request.contextPath}/category?id=${cat.catId}"
                   class="btn-nexora ${cat.catId == category.catId ? 'btn-nexora-gold' : 'btn-nexora-outline'}"
                   style="padding:7px 18px;font-size:0.78rem;">
                    <i class="${cat.catIcon}" style="margin-right:5px;"></i>${cat.catName}
                </a>
            </c:forEach>
        </div>
        <!-- Product Grid -->
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:20px;margin-bottom:40px;">
            <c:forEach var="p" items="${products}">
            <div class="lane-card" style="flex:unset;">
                <div class="lane-card-img-wrap">
                    <a href="${pageContext.request.contextPath}/product?id=${p.productId}">
                        <img src="${pageContext.request.contextPath}/assets/images/${p.image}" alt="${p.productName}" loading="lazy">
                    </a>
                    <c:if test="${p.hot}"><div class="product-badge">Hot</div></c:if>
                </div>
                <div class="lane-card-info">
                    <a href="${pageContext.request.contextPath}/product?id=${p.productId}">
                        <p class="lane-card-name"><c:out value="${p.productName}"/></p>
                    </a>
                    <p class="lane-card-price"><fmt:formatNumber value="${p.price}" pattern="#,###"/> &#8363;</p>
                    <div class="lane-card-actions">
                        <a href="${pageContext.request.contextPath}/product?id=${p.productId}" class="btn-primary">Mua ngay</a>
                        <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.productId}" class="btn-cart"><i class="fas fa-cart-plus"></i></a>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
        <!-- Phan trang -->
        <c:if test="${TốtalPages > 1}">
        <div style="display:flex;justify-content:center;gap:8px;margin-top:20px;">
            <c:forEach begin="1" end="${TốtalPages}" var="i">
                <a href="${pageContext.request.contextPath}/category?id=${category.catId}&page=${i}"
                   style="padding:8px 14px;border-radius:6px;text-decoration:none;font-size:0.85rem;
                   ${i == currentPage ? 'background:#D4AF37;color:#0C0C0C;font-weight:700;' : 'background:rgba(255,255,255,0.05);color:#aaa;border:1px solid rgba(255,255,255,0.1);'}">
                    ${i}
                </a>
            </c:forEach>
        </div>
        </c:if>
    </div>
</div>
<style>
.lane-card{flex:unset!important;}
.lane-card-img-wrap{aspect-ratio:3/4;}
</style>
<%@ include file="/includes/footer.jsp" %>