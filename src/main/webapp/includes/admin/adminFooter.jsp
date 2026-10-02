<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- Toast -->
<c:if test="${not empty sessionScope.toast_type}">
<script>
document.addEventListener('DOMContentLoaded', function() {
    nexoraToast('<c:out value="${sessionScope.toast_type}"/>','<c:out value="${sessionScope.toast_title}"/>','<c:out value="${sessionScope.toast_msg}"/>');
});
</script>
<c:remove var="toast_type" scope="session"/>
<c:remove var="toast_title" scope="session"/>
<c:remove var="toast_msg" scope="session"/>
</c:if>
<style>
#nexora-toast-container{position:fixed;top:24px;right:24px;z-index:99999;display:flex;flex-direction:column;gap:10px;pointer-events:none;}
.nexora-toast{pointer-events:auto;display:flex;align-items:center;gap:12px;min-width:300px;padding:14px 20px;border-radius:12px;background:rgba(15,15,15,0.95);backdrop-filter:blur(16px);border:1px solid rgba(212,175,55,0.25);box-shadow:0 12px 40px rgba(0,0,0,0.5);color:#E8E8E8;font-size:0.88rem;transform:translateX(120%);animation:nxToastIn 0.45s cubic-bezier(0.22,1,0.36,1) forwards;position:relative;}
.nexora-toast.removing{animation:nxToastOut 0.35s forwards;}
.nexora-toast .toast-icon{width:36px;height:36px;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:1rem;flex-shrink:0;}
.nexora-toast.success .toast-icon{background:rgba(76,175,80,0.15);color:#66BB6A;}
.nexora-toast.error .toast-icon{background:rgba(244,67,54,0.15);color:#EF5350;}
.nexora-toast.info .toast-icon{background:rgba(212,175,55,0.15);color:#D4AF37;}
.nexora-toast .toast-content{flex:1;}
.nexora-toast .toast-title{font-weight:600;font-size:0.82rem;color:#fff;}
.nexora-toast .toast-msg{font-size:0.8rem;color:#aaa;}
.nexora-toast .toast-progress{position:absolute;bottom:0;left:0;height:2px;border-radius:0 0 12px 12px;animation:nxToastProgress 3.5s linear forwards;}
.nexora-toast.success .toast-progress{background:linear-gradient(90deg,#66BB6A,#43A047);}
.nexora-toast.error .toast-progress{background:linear-gradient(90deg,#EF5350,#D32F2F);}
.nexora-toast.info .toast-progress{background:linear-gradient(90deg,#D4AF37,#C5A028);}
@keyframes nxToastIn{0%{transform:translateX(120%);opacity:0;}100%{transform:translateX(0);opacity:1;}}
@keyframes nxToastOut{0%{transform:translateX(0);opacity:1;}100%{transform:translateX(120%);opacity:0;}}
@keyframes nxToastProgress{0%{width:100%;}100%{width:0%;}}
</style>
<div id="nexora-toast-container"></div>
<script>
function nexoraToast(type,title,message,duration){
    duration=duration||3500;
    var c=document.getElementById('nexora-toast-container');
    var icons={success:'fa-check',error:'fa-times',info:'fa-bell',warning:'fa-exclamation-triangle'};
    var t=document.createElement('div');t.className='nexora-toast '+type;
    t.innerHTML='<div class="toast-icon"><i class="fas '+(icons[type]||'fa-info-circle')+'"></i></div><div class="toast-content"><div class="toast-title">'+title+'</div><div class="toast-msg">'+message+'</div></div><div class="toast-progress"></div>';
    t.querySelector('.toast-progress').style.animationDuration=duration+'ms';
    c.appendChild(t);
    setTimeout(function(){t.classList.add('removing');setTimeout(function(){t.remove();},400);},duration);
}
</script>
    </main>
</body>
</html>