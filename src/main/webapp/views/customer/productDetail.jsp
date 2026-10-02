<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ include file="/includes/header.jsp" %>

<div class="page-wrapper">
    <div class="container">
        <div style="display:grid;grid-template-columns:1fr 1fr;gap:40px;flex-wrap:wrap;" class="product-detail-grid">
            <!-- LEFT: Hinh anh -->
            <div>
                <div style="background:#111;border:1px solid var(--border-color);border-radius:12px;overflow:hidden;aspect-ratio:3/4;display:flex;align-items:center;justify-content:center;">
                    <img src="${pageContext.request.contextPath}/assets/images/${product.image}"
                         alt="${product.productName}"
                         style="width:100%;height:100%;object-fit:contain;padding:20px;" id="mainProductImg">
                </div>
            </div>
            <!-- RIGHT: Thông tin Sản phẩm -->
            <div>
                <div style="font-size:0.7rem;color:#555;letter-spacing:2px;text-transform:uppercase;margin-bottom:8px;">
                    Nexora Collection
                </div>
                <h1 style="font-family:'Playfair Display',serif;font-size:clamp(1.4rem,3vw,2rem);color:#F5F0E8;margin-bottom:15px;line-height:1.3;">
                    <c:out value="${product.productName}"/>
                </h1>
                <div style="font-size:1.8rem;color:#D4AF37;font-weight:bold;font-family:'Playfair Display',serif;margin-bottom:20px;">
                    <fmt:formatNumber value="${product.price}" pattern="#,###"/> &#8363;
                </div>

                <!-- Bien the size + mau -->
                <c:if test="${not empty variants}">
                <form action="${pageContext.request.contextPath}/cart" method="GET" id="add-to-cart-form">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="id" value="${product.productId}">
                    <input type="hidden" name="variant_id" id="selectedVariant" value="">

                    <!-- Chon mau sac -->
                    <div style="margin-bottom:16px;">
                        <label style="font-size:0.78rem;color:#888;letter-spacing:1.5px;text-transform:uppercase;display:block;margin-bottom:10px;">Mau sac</label>
                        <div style="display:flex;flex-wrap:wrap;gap:8px;" id="colorOptions">
                            <c:set var="lastColor" value=""/>
                            <c:forEach var="v" items="${variants}">
                            <c:if test="${v.color != lastColor}">
                                <button type="button" class="color-btn" data-color="${v.color}"
                                        onclick="selectColor('${v.color}')"
                                        style="padding:7px 16px;border:1px solid rgba(255,255,255,0.15);border-radius:6px;background:rgba(255,255,255,0.04);color:#aaa;font-size:0.82rem;cursor:pointer;transition:all 0.2s;">
                                    ${v.color}
                                </button>
                                <c:set var="lastColor" value="${v.color}"/>
                            </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Chon size -->
                    <div style="margin-bottom:20px;">
                        <label style="font-size:0.78rem;color:#888;letter-spacing:1.5px;text-transform:uppercase;display:block;margin-bottom:10px;">Kich co</label>
                        <div style="display:flex;flex-wrap:wrap;gap:8px;" id="sizeOptions"></div>
                    </div>

                    <div style="display:flex;gap:12px;flex-wrap:wrap;margin-top:24px;">
                        <button type="submit" class="btn-nexora btn-nexora-gold" style="flex:1;padding:14px;font-size:0.95rem;">
                            <i class="fas fa-shopping-bag" style="margin-right:8px;"></i>THEM VAO GIO
                        </button>
                        <button type="submit" name="type" value="buy"
                                onclick="document.querySelector('[name=action]').value='add'; document.querySelector('[name=type]')?.remove();"
                                class="btn-nexora btn-nexora-outline" style="flex:1;padding:14px;font-size:0.95rem;">
                            MUA NGAY
                        </button>
                    </div>
                </form>

                <script>
                // dữ liệu variants tu server
                var variants = [
                    <c:forEach var="v" items="${variants}" varStatus="st">
                    {id:${v.variantId},size:'${v.size}',color:'${v.color}',price:${v.price},stock:${v.stock}}<c:if test="${!st.last}">,</c:if>
                    </c:forEach>
                ];
                var selectedColor = null;
                var selectedSize = null;

                function selectColor(color) {
                    selectedColor = color;
                    selectedSize = null;
                    document.getElementById('selectedVariant').value = '';
                    document.querySelectorAll('.color-btn').forEach(function(btn) {
                        btn.style.borderColor = btn.dataset.color === color ? '#D4AF37' : 'rgba(255,255,255,0.15)';
                        btn.style.color = btn.dataset.color === color ? '#D4AF37' : '#aaa';
                    });
                    // Hien thi size tuong ung
                    var sizeDiv = document.getElementById('sizeOptions');
                    sizeDiv.innerHTML = '';
                    var sizes = variants.filter(v => v.color === color);
                    sizes.forEach(function(v) {
                        var btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = 'size-btn';
                        btn.dataset.variantId = v.id;
                        btn.textContent = v.size + (v.stock <= 0 ? ' (het)' : '');
                        btn.disabled = v.stock <= 0;
                        btn.style.cssText = 'padding:7px 16px;border:1px solid rgba(255,255,255,0.15);border-radius:6px;background:rgba(255,255,255,0.04);color:'+(v.stock>0?'#aaa':'#333')+';font-size:0.82rem;cursor:'+(v.stock>0?'pointer':'not-allowed')+';transition:all 0.2s;';
                        if (v.stock > 0) btn.onclick = function() { selectSize(v.id, this); };
                        sizeDiv.appendChild(btn);
                    });
                }

                function selectSize(variantId, btn) {
                    selectedSize = variantId;
                    document.getElementById('selectedVariant').value = variantId;
                    document.querySelectorAll('.size-btn').forEach(function(b) {
                        b.style.borderColor = 'rgba(255,255,255,0.15)';
                        b.style.color = '#aaa';
                    });
                    btn.style.borderColor = '#D4AF37';
                    btn.style.color = '#D4AF37';
                }

                // Tu dong chon mau dau tien
                if (variants.length > 0) selectColor(variants[0].color);
                </script>
                </c:if>

                <!-- Thông tin Chi tiết -->
                <div style="margin-top:30px;padding-top:20px;border-top:1px solid rgba(255,255,255,0.07);">
                    <c:if test="${not empty product.productDesc}">
                    <p style="color:#888;font-size:0.88rem;line-height:1.8;margin-bottom:16px;"><c:out value="${product.productDesc}"/></p>
                    </c:if>
                    <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;font-size:0.82rem;">
                        <c:if test="${not empty product.material}">
                        <div><span style="color:#555;">Chat lieu:</span><br><span style="color:#D4AF37;">${product.material}</span></div>
                        </c:if>
                        <c:if test="${not empty product.style}">
                        <div><span style="color:#555;">Kieu dang:</span><br><span style="color:#D4AF37;">${product.style}</span></div>
                        </c:if>
                        <c:if test="${not empty product.origin}">
                        <div><span style="color:#555;">Xuat xu:</span><br><span style="color:#D4AF37;">${product.origin}</span></div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Đánh giá -->
        <div class="nexora-card" style="margin-top:40px;">
            <h3 class="nexora-card-title"><i class="fas fa-star" style="margin-right:8px;color:#D4AF37;"></i>Đánh giá Sản phẩm</h3>

            <c:if test="${not empty sessionScope.user_id}">
            <form action="${pageContext.request.contextPath}/product" method="POST" class="nexora-form" style="margin-bottom:30px;">
                <input type="hidden" name="product_id" value="${product.productId}">
                <div style="margin-bottom:12px;">
                    <label style="font-size:0.78rem;color:#888;text-transform:uppercase;letter-spacing:1.5px;">Đánh giá cua ban</label>
                    <select name="star" style="display:block;margin-top:8px;padding:10px;background:rgba(255,255,255,0.05);border:1px solid var(--border-color);border-radius:6px;color:#E8E8E8;outline:none;">
                        <option value="5">&#9733;&#9733;&#9733;&#9733;&#9733; Tuyệt vời</option>
                        <option value="4">&#9733;&#9733;&#9733;&#9733; Tốt</option>
                        <option value="3">&#9733;&#9733;&#9733; Bình thường</option>
                        <option value="2">&#9733;&#9733; Kem</option>
                        <option value="1">&#9733; Rất kém</option>
                    </select>
                </div>
                <div class="form-group">
                    <textarea name="content" required rows="3" placeholder="Nhan xet cua ban ve Sản phẩm..." style="resize:none;"></textarea>
                </div>
                <button type="submit" class="btn-nexora btn-nexora-gold" style="padding:10px 24px;">GUI Đánh giá</button>
            </form>
            </c:if>

            <c:choose>
                <c:when test="${not empty reviews}">
                    <c:forEach var="r" items="${reviews}">
                    <div style="border-bottom:1px solid rgba(255,255,255,0.05);padding:16px 0;">
                        <div style="display:flex;align-items:center;gap:12px;margin-bottom:8px;">
                            <div style="width:36px;height:36px;border-radius:50%;background:rgba(212,175,55,0.1);border:1px solid rgba(212,175,55,0.2);display:flex;align-items:center;justify-content:center;color:#D4AF37;font-weight:bold;font-size:0.9rem;">
                                ${fn:substring(r.fullname,0,1)}
                            </div>
                            <div>
                                <div style="font-weight:600;font-size:0.88rem;color:#F5F0E8;"><c:out value="${r.fullname}"/></div>
                                <div style="color:#D4AF37;font-size:0.8rem;">
                                    <c:forEach begin="1" end="${r.star}">&#9733;</c:forEach>
                                </div>
                            </div>
                        </div>
                        <p style="color:#888;font-size:0.85rem;line-height:1.7;"><c:out value="${r.content}"/></p>
                    </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="color:#444;text-align:center;padding:30px;">Chưa có Đánh giá nao. Hay la nguoi dau tien!</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<style>
@media(max-width:768px){.product-detail-grid{grid-template-columns:1fr!important;}}
</style>
<%@ include file="/includes/footer.jsp" %>