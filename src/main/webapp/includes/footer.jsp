<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    footer { background: linear-gradient(180deg, #0C0C0C 0%, #111111 100%); color: #A0A0A0; padding: 60px 0 20px 0; margin-top: 80px; font-size: 14px; border-top: 1px solid rgba(212, 175, 55, 0.3); position: relative; }
    footer::before { content: ''; position: absolute; top: 0; left: 50%; transform: translateX(-50%); width: 120px; height: 2px; background: linear-gradient(90deg, transparent, #D4AF37, transparent); }
    .footer-content { display: grid; grid-template-columns: repeat(4, 1fr); gap: 40px; padding-bottom: 40px; border-bottom: 1px solid rgba(255,255,255,0.07); }
    .footer-col h3 { font-family: 'Playfair Display', serif; font-size: 15px; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 22px; color: #D4AF37; font-weight: 600; position: relative; }
    .footer-col h3::after { content: ''; display: block; width: 30px; height: 1px; background: rgba(212, 175, 55, 0.5); margin-top: 8px; }
    .footer-col p { color: #777; line-height: 1.8; margin-bottom: 20px; font-size: 0.875rem; }
    .footer-col ul { list-style: none; }
    .footer-col ul li { margin-bottom: 12px; display: flex; align-items: flex-start; gap: 8px; }
    .footer-col ul li a { color: #777; transition: all 0.3s ease; text-decoration: none; font-size: 0.875rem; }
    .footer-col ul li a:hover { color: #D4AF37; padding-left: 5px; }
    .footer-col ul li i { color: #D4AF37; width: 16px; font-size: 0.85rem; margin-top: 2px; flex-shrink: 0; }
    .social-links { display: flex; gap: 12px; margin-top: 5px; }
    .social-links a { display: inline-flex; justify-content: center; align-items: center; width: 38px; height: 38px; background: rgba(255,255,255,0.04); color: #777; border: 1px solid rgba(255,255,255,0.08); border-radius: 50%; transition: all 0.3s ease; font-size: 0.9rem; }
    .social-links a:hover { background: #D4AF37; color: #0C0C0C; border-color: #D4AF37; transform: translateY(-3px); box-shadow: 0 8px 20px rgba(212, 175, 55, 0.3); }
    .footer-brand-logo { font-family: 'Playfair Display', serif; font-size: 1.6rem; color: #D4AF37; letter-spacing: 3px; text-transform: uppercase; margin-bottom: 15px; display: block; }
    .footer-tagline { font-size: 0.7rem; letter-spacing: 3px; text-transform: uppercase; color: rgba(212,175,55,0.5); margin-bottom: 18px; display: block; }
    .copyright { text-align: center; padding-top: 25px; color: #555; font-size: 12px; letter-spacing: 1px; }
    .copyright b { color: #D4AF37; font-weight: 600; }
    @media (max-width: 992px) { .footer-content { grid-template-columns: repeat(2, 1fr); } }
    @media (max-width: 576px) { .footer-content { grid-template-columns: 1fr; } }
</style>

<footer>
    <div class="container">
        <div class="footer-content">
            <div class="footer-col">
                <span class="footer-brand-logo">Nexora</span>
                <span class="footer-tagline">Defining Elegance</span>
                <p>Boutique thoi trang nam cao cap. Phong cach tinh te, chat lieu thuong hang cho quy ong hien dai.</p>
                <div class="social-links">
                    <a href="#" target="_blank"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" target="_blank"><i class="fab fa-youtube"></i></a>
                    <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="#" target="_blank"><i class="fab fa-tiktok"></i></a>
                </div>
            </div>
            <div class="footer-col">
                <h3>Ho tro Khách hàng</h3>
                <ul>
                    <li><a href="#">Huong dan mua hang</a></li>
                    <li><a href="#">Huong dan Thanh toán</a></li>
                    <li><a href="#">Tra cuu Đơn hàng</a></li>
                    <li><a href="#">Chinh sach doi tra</a></li>
                    <li><a href="#">Gop y, khieu nai</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Chinh sach</h3>
                <ul>
                    <li><a href="#">Chinh sach Bảo mật</a></li>
                    <li><a href="#">Chinh sach van chuyen</a></li>
                    <li><a href="#">Quy định bao hanh</a></li>
                    <li><a href="#">Dieu khoan su dung</a></li>
                    <li><a href="#">Chinh sach kiem hang</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Liên hệ</h3>
                <ul>
                    <li><i class="fas fa-map-marker-alt"></i><span>Ha Noi, Viet Nam</span></li>
                    <li><i class="fas fa-phone-alt"></i><span>0352 890 829 &middot; 0877 301 485</span></li>
                    <li><i class="fas fa-envelope"></i><span>nexora@gmail.com</span></li>
                    <li><i class="fas fa-clock"></i><span>08:00 &ndash; 22:00 (Hang ngay)</span></li>
                </ul>
            </div>
        </div>
        <div class="copyright">
            <p>&copy; 2026 <b>Nexora</b> &mdash; Premium Men's Boutique. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Toast notification tu session -->
<c:if test="${not empty sessionScope.toast_type}">
<script>
document.addEventListener('DOMContentLoaded', function() {
    nexoraToast(
        '<c:out value="${sessionScope.toast_type}"/>',
        '<c:out value="${sessionScope.toast_title}"/>',
        '<c:out value="${sessionScope.toast_msg}"/>'
    );
});
</script>
<c:remove var="toast_type" scope="session"/>
<c:remove var="toast_title" scope="session"/>
<c:remove var="toast_msg" scope="session"/>
</c:if>

<!-- NEXORA TOAST NOTIFICATION SYSTEM -->
<style>
#nexora-toast-container { position: fixed; top: 24px; right: 24px; z-index: 99999; display: flex; flex-direction: column; gap: 10px; pointer-events: none; }
.nexora-toast { pointer-events: auto; display: flex; align-items: center; gap: 12px; min-width: 300px; max-width: 420px; padding: 14px 20px; border-radius: 12px; background: rgba(15, 15, 15, 0.95); backdrop-filter: blur(16px); border: 1px solid rgba(212,175,55,0.25); box-shadow: 0 12px 40px rgba(0,0,0,0.5); color: #E8E8E8; font-family: 'Inter', sans-serif; font-size: 0.88rem; transform: translateX(120%); animation: nxToastIn 0.45s cubic-bezier(0.22, 1, 0.36, 1) forwards; position:relative; }
.nexora-toast.removing { animation: nxToastOut 0.35s cubic-bezier(0.55, 0, 1, 0.45) forwards; }
.nexora-toast .toast-icon { width: 36px; height: 36px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1rem; flex-shrink: 0; }
.nexora-toast.success .toast-icon { background: rgba(76,175,80,0.15); color: #66BB6A; }
.nexora-toast.error .toast-icon { background: rgba(244,67,54,0.15); color: #EF5350; }
.nexora-toast.info .toast-icon { background: rgba(212,175,55,0.15); color: #D4AF37; }
.nexora-toast.warning .toast-icon { background: rgba(255,152,0,0.15); color: #FFA726; }
.nexora-toast .toast-content { flex: 1; }
.nexora-toast .toast-title { font-weight: 600; font-size: 0.82rem; margin-bottom: 2px; color: #fff; }
.nexora-toast .toast-msg { font-size: 0.8rem; color: #aaa; line-height: 1.4; }
.nexora-toast .toast-close { background: none; border: none; color: #555; cursor: pointer; font-size: 0.9rem; padding: 4px; flex-shrink: 0; }
.nexora-toast .toast-close:hover { color: #fff; }
.nexora-toast .toast-progress { position: absolute; bottom: 0; left: 0; height: 2px; border-radius: 0 0 12px 12px; animation: nxToastProgress 3.5s linear forwards; }
.nexora-toast.success .toast-progress { background: linear-gradient(90deg, #66BB6A, #43A047); }
.nexora-toast.error .toast-progress { background: linear-gradient(90deg, #EF5350, #D32F2F); }
.nexora-toast.info .toast-progress { background: linear-gradient(90deg, #D4AF37, #C5A028); }
.nexora-toast.warning .toast-progress { background: linear-gradient(90deg, #FFA726, #FB8C00); }
@keyframes nxToastIn { 0% { transform: translateX(120%); opacity:0; } 100% { transform: translateX(0); opacity:1; } }
@keyframes nxToastOut { 0% { transform: translateX(0); opacity:1; } 100% { transform: translateX(120%); opacity:0; } }
@keyframes nxToastProgress { 0% { width: 100%; } 100% { width: 0%; } }
</style>
<div id="nexora-toast-container"></div>
<script>
function nexoraToast(type, title, message, duration) {
    duration = duration || 3500;
    var container = document.getElementById('nexora-toast-container');
    var icons = { success:'fa-check', error:'fa-times', info:'fa-bell', warning:'fa-exclamation-triangle' };
    var toast = document.createElement('div');
    toast.className = 'nexora-toast ' + type;
    toast.innerHTML = '<div class="toast-icon"><i class="fas '+(icons[type]||'fa-info-circle')+'"></i></div>' +
        '<div class="toast-content"><div class="toast-title">' + title + '</div><div class="toast-msg">' + message + '</div></div>' +
        '<button class="toast-close" onclick="this.parentElement.classList.add(\'removing\');"><i class="fas fa-times"></i></button>' +
        '<div class="toast-progress"></div>';
    toast.querySelector('.toast-progress').style.animationDuration = duration + 'ms';
    container.appendChild(toast);
    setTimeout(function() { toast.classList.add('removing'); setTimeout(function() { toast.remove(); }, 400); }, duration);
}
</script>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>AOS.init({ duration: 700, once: true });</script>
</body>
</html>