<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="/includes/header.jsp" %>

<!-- HERO SECTION -->
<div class="hero-container" data-aos="fade-in">
    <div class="main-slider">
        <div class="slides" id="bannerSlides">
            <div class="slide">
                <img src="${pageContext.request.contextPath}/assets/images/nexora_banner1.png" alt="Nexora Collection 2026">
                <div class="banner-overlay">
                    <p>Elevating Masculine Style</p>
                    <h1 class="luxury-font">Collection 2026</h1>
                </div>
            </div>
            <div class="slide">
                <img src="${pageContext.request.contextPath}/assets/images/nexora_banner2.png" alt="Nexora The New Standard">
                <div class="banner-overlay">
                    <p>Minimalist Craftsmanship</p>
                    <h1 class="luxury-font">The New Standard</h1>
                </div>
            </div>
            <div class="slide">
                <img src="${pageContext.request.contextPath}/assets/images/nexora_banner3.png" alt="Nexora Brand">
                <div class="banner-overlay">
                    <p style="letter-spacing: 5px; color: #D4AF37;text-transform:uppercase;">DEFINING ELEGANCE</p>
                    <h1 class="luxury-font" style="font-size: 5rem; letter-spacing: 15px; text-transform: uppercase;">NEXORA</h1>
                </div>
            </div>
        </div>
        <button class="slider-btn prev" onclick="moveSlide(-1)" aria-label="Truoc">&#10094;</button>
        <button class="slider-btn next" onclick="moveSlide(1)" aria-label="Sau">&#10095;</button>
        <div style="position:absolute; bottom:12px; left:50%; transform:translateX(-50%); display:flex; gap:6px; z-index:2;">
            <span class="slider-dot active" onclick="goToSlide(0)"></span>
            <span class="slider-dot" onclick="goToSlide(1)"></span>
            <span class="slider-dot" onclick="goToSlide(2)"></span>
        </div>
    </div>
    <div class="side-banners">
        <a href="#lane-6" class="side-banner" onclick="return scrollToLane('lane-6')" data-aos="fade-left" data-aos-delay="200">
            <img src="${pageContext.request.contextPath}/assets/images/nexora_side_perfume.png" alt="Fragrance">
            <div class="banner-overlay">
                <p style="font-size:0.65rem;letter-spacing:2px;color:#D4AF37;text-transform:uppercase;">FRAGRANCE</p>
                <h3 class="luxury-font" style="font-size:1.1rem;">Nexora Parfum</h3>
            </div>
        </a>
        <a href="#lane-1" class="side-banner" onclick="return scrollToLane('lane-1')" data-aos="fade-left" data-aos-delay="400">
            <img src="${pageContext.request.contextPath}/assets/images/nexora_side_suit.png" alt="Tailoring">
            <div class="banner-overlay">
                <p style="font-size:0.65rem;letter-spacing:2px;color:#D4AF37;text-transform:uppercase;">TAILORING</p>
                <h3 class="luxury-font" style="font-size:1.1rem;">The Classic Edit</h3>
            </div>
        </a>
    </div>
</div>

<style>
.slider-dot { width:8px;height:8px;border-radius:50%;background:rgba(255,255,255,0.3);cursor:pointer;transition:all 0.3s;border:none; }
.slider-dot.active { background:var(--secondary);width:22px;border-radius:4px; }
</style>
<script>
let currentSlide = 0;
const TốtalSlides = 3;
function goToSlide(idx) {
    currentSlide = idx;
    document.getElementById('bannerSlides').style.transform = 'translateX(-' + (currentSlide*100) + '%)';
    document.querySelectorAll('.slider-dot').forEach((d,i)=>d.classList.toggle('active',i===currentSlide));
}
function moveSlide(step) { goToSlide((currentSlide+step+TốtalSlides)%TốtalSlides); }
let autoPlay = setInterval(()=>moveSlide(1),6000);
const sliderEl = document.querySelector('.main-slider');
if(sliderEl){ sliderEl.addEventListener('mouseenter',()=>clearInterval(autoPlay)); sliderEl.addEventListener('mouseleave',()=>{autoPlay=setInterval(()=>moveSlide(1),6000);}); }
</script>

<!-- BRAND STATEMENT -->
<section class="brand-statement" data-aos="fade-up" data-aos-duration="1200">
    <div class="brand-statement-inner">
        <div class="brand-statement-ornament"></div>
        <p class="brand-statement-label">NEXORA &mdash; Our Philosophy</p>
        <h2 class="brand-statement-title luxury-font">Ban Sac Rieng Cho Quy Ong Hien Dai</h2>
        <p class="brand-statement-body">NEXORA la diem den hang dau danh cho nhung quy ong Tìm kiếm su doc ban. Tu nhung bo suit duoc cat may ti mi den dong nuoc hoa Nexora Parfum doc quyen, chung toi cham chut tung Chi tiết de tao nen mot he sinh thai phong cach toan dien.</p>
        <div class="brand-statement-ornament flip"></div>
    </div>
</section>

<!-- BOUTIQUE CATEGORIES -->
<div class="category-section" id="categoriesSection" data-aos="fade-up">
    <h2 class="luxury-font">Boutique Categories</h2>
    <div class="category-grid">
        <a href="#lane-hot" class="category-item" onclick="return scrollToLane('lane-hot')">
            <div class="category-name">&#128293; HOT COLLECTION</div>
        </a>
        <c:forEach var="cat" items="${categories}">
            <a href="#lane-${cat.catId}" class="category-item" onclick="return scrollToLane('lane-${cat.catId}')">
                <div class="category-name">${fn:toUpperCase(cat.catName)}</div>
            </a>
        </c:forEach>
    </div>
</div>

<!-- SEARCH RESULTS -->
<div id="searchResultsSection" style="display:none;">
    <div class="lane-header" style="padding:0 20px 0 max(20px,calc((100vw - 1400px)/2 + 20px));">
        <div class="lane-title-wrap">
            <i class="fas fa-search"></i>
            <span class="lane-title">Ket qua Tìm kiếm: "<span id="searchKeyword"></span>"</span>
        </div>
        <button class="lane-clear-btn" onclick="clearSearch()">x Xoa Tìm kiếm</button>
    </div>
    <div class="lane-track" id="searchResultsTrack"></div>
</div>

<!-- 6 PRODUCT LANES - thay PHP while bang JSTL c:forEach -->
<div id="allLanes">
    <%-- Lane: Hot Collection --%>
    <c:if test="${not empty lanes['hot']}">
    <section class="product-lane" id="lane-hot" data-lane="hot">
        <div class="lane-header">
            <div class="lane-title-wrap">
                <span class="lane-accent"></span>
                <span class="lane-title">&#128293; Hot Collection</span>
                <span class="lane-count">${fn:length(lanes['hot'])} Sản phẩm</span>
            </div>
            <a href="${pageContext.request.contextPath}/category?id=1" class="lane-view-all">Xem Tất cả <i class="fas fa-arrow-right"></i></a>
        </div>
        <div class="lane-scroll-wrap" id="track-lane-hot">
            <button class="lane-arrow lane-arrow-left" onclick="laneScroll('track-lane-hot',-1)">&#10094;</button>
            <div class="lane-track" id="inner-track-lane-hot">
                <c:forEach var="p" items="${lanes['hot']}">
                <div class="lane-card" data-name="${fn:toLowerCase(p.productName)}" data-cat="${p.catId}" data-hot="${p.hot}">
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
                            <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.productId}" class="btn-cart" title="Them vao gio"><i class="fas fa-cart-plus"></i></a>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
            <button class="lane-arrow lane-arrow-right" onclick="laneScroll('track-lane-hot',1)">&#10095;</button>
        </div>
    </section>
    </c:if>

    <%-- Cac Lane Danh mục --%>
    <c:set var="laneIds" value="1,2,3,5,6"/>
    <c:forTokens var="catIdStr" items="${laneIds}" delims=",">
        <c:set var="catId" value="${catIdStr}"/>
        <c:if test="${not empty lanes[catId]}">
        <section class="product-lane" id="lane-${catId}" data-lane="${catId}">
            <div class="lane-header">
                <div class="lane-title-wrap">
                    <span class="lane-accent"></span>
                    <span class="lane-title">${laneLabels[catId]}</span>
                    <span class="lane-count">${fn:length(lanes[catId])} Sản phẩm</span>
                </div>
                <a href="${pageContext.request.contextPath}/category?id=${catId}" class="lane-view-all">Xem Tất cả <i class="fas fa-arrow-right"></i></a>
            </div>
            <div class="lane-scroll-wrap" id="track-lane-${catId}">
                <button class="lane-arrow lane-arrow-left" onclick="laneScroll('track-lane-${catId}',-1)">&#10094;</button>
                <div class="lane-track" id="inner-track-lane-${catId}">
                    <c:forEach var="p" items="${lanes[catId]}">
                    <div class="lane-card" data-name="${fn:toLowerCase(p.productName)}" data-cat="${p.catId}">
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
                                <a href="${pageContext.request.contextPath}/cart?action=add&id=${p.productId}" class="btn-cart" title="Them vao gio"><i class="fas fa-cart-plus"></i></a>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                </div>
                <button class="lane-arrow lane-arrow-right" onclick="laneScroll('track-lane-${catId}',1)">&#10095;</button>
            </div>
        </section>
        </c:if>
    </c:forTokens>
</div>

<style>
.product-lane { padding: 32px 0 24px; border-bottom: 1px solid rgba(212,175,55,0.07); position: relative; }
.product-lane:last-child { border-bottom: none; }
.lane-header { display: flex; align-items: center; justify-content: space-between; padding: 0 20px 16px max(20px, calc((100vw - 1400px)/2 + 20px)); gap: 12px; }
.lane-title-wrap { display: flex; align-items: center; gap: 12px; flex: 1; min-width: 0; }
.lane-accent { display: inline-block; width: 3px; height: 20px; background: linear-gradient(to bottom, #D4AF37, #8B0000); border-radius: 2px; flex-shrink: 0; }
.lane-title { font-family: 'Playfair Display', serif; font-size: clamp(1rem, 2.2vw, 1.3rem); color: #F5F0E8; font-weight: 600; letter-spacing: 0.5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.lane-count { font-size: 0.7rem; color: #444; letter-spacing: 2px; text-transform: uppercase; flex-shrink: 0; }
.lane-view-all { font-size: 0.75rem; color: #D4AF37; letter-spacing: 1.5px; text-transform: uppercase; text-decoration: none; border: 1px solid rgba(212,175,55,0.3); padding: 6px 14px; border-radius: 20px; white-space: nowrap; transition: all 0.2s; flex-shrink: 0; }
.lane-view-all:hover { background: rgba(212,175,55,0.1); border-color: #D4AF37; }
.lane-clear-btn { font-size: 0.75rem; color: #666; background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); padding: 6px 14px; border-radius: 20px; cursor: pointer; transition: all 0.2s; flex-shrink: 0; }
.lane-clear-btn:hover { color: #D4AF37; border-color: rgba(212,175,55,0.3); }
.lane-scroll-wrap { position: relative; display: flex; align-items: stretch; }
.lane-track { display: flex; gap: 16px; overflow-x: auto; overflow-y: visible; scroll-behavior: smooth; padding: 8px max(20px, calc((100vw - 1400px)/2 + 20px)); scrollbar-width: none; -ms-overflow-style: none; flex: 1; }
.lane-track::-webkit-scrollbar { display: none; }
.lane-arrow { position: absolute; top: 50%; transform: translateY(-50%); width: 40px; height: 40px; border-radius: 50%; background: rgba(15,15,15,0.85); border: 1px solid rgba(212,175,55,0.3); color: #D4AF37; font-size: 0.9rem; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: all 0.2s; z-index: 10; backdrop-filter: blur(6px); opacity: 0; }
.lane-scroll-wrap:hover .lane-arrow { opacity: 1; }
.lane-arrow:hover { background: rgba(212,175,55,0.15); border-color: #D4AF37; }
.lane-arrow-left { left: 4px; } .lane-arrow-right { right: 4px; }
.lane-card { flex: 0 0 200px; background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 12px; overflow: hidden; transition: all 0.3s; cursor: pointer; position: relative; }
.lane-card:hover { transform: translateY(-6px); border-color: rgba(212,175,55,0.3); box-shadow: 0 12px 30px rgba(0,0,0,0.5); }
.lane-card-img-wrap { position: relative; aspect-ratio: 3/4; overflow: hidden; background: #111; }
.lane-card-img-wrap img { width:100%; height:100%; object-fit:cover; transition:transform 0.4s; }
.lane-card:hover .lane-card-img-wrap img { transform: scale(1.06); }
.lane-card-info { padding: 12px 14px 14px; }
.lane-card-name { font-size: 0.8rem; color: #D4D4D4; margin-bottom: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; transition: color 0.2s; }
.lane-card:hover .lane-card-name { color: #D4AF37; }
.lane-card-name a { color: inherit; text-decoration: none; }
.lane-card-price { font-size: 0.85rem; color: #D4AF37; font-weight: 600; margin-bottom: 10px; }
.lane-card-actions { display: flex; gap: 7px; }
.lane-card-actions .btn-primary { flex: 1; padding: 7px 8px; font-size: 0.72rem; text-align: center; border-radius: 6px; text-decoration: none; }
.lane-card-actions .btn-cart { width: 34px; height: 34px; display: flex; align-items: center; justify-content: center; border-radius: 6px; text-decoration: none; font-size: 0.85rem; background: rgba(212,175,55,0.1); color: #D4AF37; border: 1px solid rgba(212,175,55,0.3); transition: all 0.2s; flex-shrink: 0; }
.lane-card-actions .btn-cart:hover { background: rgba(212,175,55,0.25); }
#searchResultsSection { padding: 32px 0 8px; }
#searchResultsSection .lane-track { padding-left: max(20px, calc((100vw - 1400px)/2 + 20px)); flex-wrap: wrap; height: auto; overflow-x: hidden; }
@media (max-width: 768px) { .lane-card { flex: 0 0 160px; } .lane-header { padding: 0 14px 14px; } .lane-arrow { display: none; } }
.brand-statement{background:linear-gradient(135deg,#0C0C0C 0%,#111 50%,#0C0C0C 100%);border-top:1px solid rgba(212,175,55,0.12);border-bottom:1px solid rgba(212,175,55,0.12);padding:70px 20px;position:relative;overflow:hidden;}
.brand-statement-inner{max-width:780px;margin:0 auto;text-align:center;position:relative;z-index:1;}
.brand-statement-ornament{width:60px;height:1px;background:linear-gradient(90deg,transparent,#D4AF37,transparent);margin:0 auto 20px;}
.brand-statement-ornament.flip{margin:20px auto 0;}
.brand-statement-label{font-size:0.68rem;letter-spacing:4px;text-transform:uppercase;color:#D4AF37;margin-bottom:16px;opacity:0.8;}
.brand-statement-title{font-size:clamp(1.6rem,4vw,2.4rem);color:#F5F0E8;margin-bottom:24px;line-height:1.3;letter-spacing:1px;}
.brand-statement-body{font-size:clamp(0.9rem,2vw,1.05rem);line-height:1.9;color:rgba(200,195,185,0.75);font-weight:300;letter-spacing:0.3px;}
</style>
<script>
function laneScroll(trackId, dir) {
    var el = document.querySelector('#' + trackId + ' .lane-track');
    if (!el) el = document.getElementById(trackId);
    if (el) el.scrollBy({ left: dir * 700, behavior: 'smooth' });
}
function scrollToLane(laneId) {
    var el = document.getElementById(laneId);
    if (el) {
        var top = el.getBoundingClientRect().top + window.pageYOffset - 90;
        window.scrollTo({ top: top, behavior: 'smooth' });
    }
    return false;
}
var _allCards = null;
function doClientSearch(keyword) {
    if (!_allCards) _allCards = Array.from(document.querySelectorAll('#allLanes .lane-card'));
    keyword = keyword.trim().toLowerCase();
    var searchSec = document.getElementById('searchResultsSection');
    var track = document.getElementById('searchResultsTrack');
    var kwLabel = document.getElementById('searchKeyword');
    var allLanes = document.getElementById('allLanes');
    if (!keyword) { searchSec.style.display='none'; allLanes.style.display=''; track.innerHTML=''; return; }
    var matches = _allCards.filter(c => c.dataset.name.indexOf(keyword) !== -1);
    kwLabel.textContent = keyword; track.innerHTML = '';
    if (matches.length === 0) { track.innerHTML = '<div style="padding:40px 20px;color:#444;">Khong tim thay Sản phẩm nao.</div>'; }
    else { matches.forEach(c => track.appendChild(c.cloneNode(true))); }
    searchSec.style.display=''; allLanes.style.display='none';
}
function clearSearch() {
    document.getElementById('searchResultsSection').style.display = 'none';
    document.getElementById('allLanes').style.display = '';
}
window.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('form').forEach(function(f) {
        var inp = f.querySelector('input[name="search"]');
        if (inp) {
            f.addEventListener('submit', function(e) { e.preventDefault(); doClientSearch(inp.value); });
            var deb; inp.addEventListener('input', function() { clearTimeout(deb); deb=setTimeout(function(){ doClientSearch(inp.value); },300); });
        }
    });
});
</script>

<%@ include file="/includes/footer.jsp" %>
