<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nexora Admin Panel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nexora_luxury.css">
    <style>
    body { display: flex; min-height: 100vh; background: #0A0A0A; }
    .admin-sidebar { width: 240px; background: linear-gradient(180deg, #0F0F0F, #0A0A0A); border-right: 1px solid rgba(212,175,55,0.15); padding: 20px 0; position: fixed; height: 100vh; overflow-y: auto; z-index: 100; flex-shrink: 0; }
    .admin-logo { text-align: center; padding: 0 20px 20px; border-bottom: 1px solid rgba(212,175,55,0.1); margin-bottom: 10px; }
    .admin-logo span { font-family: 'Playfair Display', serif; font-size: 1.3rem; color: #D4AF37; letter-spacing: 3px; }
    .admin-logo p { font-size: 0.62rem; color: #333; letter-spacing: 2px; text-transform: uppercase; margin-top: 4px; }
    .admin-nav a { display: flex; align-items: center; gap: 12px; padding: 12px 20px; color: #555; font-size: 0.85rem; text-decoration: none; transition: all 0.2s; border-left: 3px solid transparent; }
    .admin-nav a:hover, .admin-nav a.active { color: #D4AF37; background: rgba(212,175,55,0.05); border-left-color: #D4AF37; }
    .admin-nav a i { width: 16px; text-align: center; }
    .admin-nav .nav-divider { height: 1px; background: rgba(255,255,255,0.05); margin: 10px 20px; }
    .admin-main { margin-left: 240px; padding: 24px; flex: 1; min-height: 100vh; }
    .admin-topbar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px; }
    .admin-topbar h1 { font-family: 'Playfair Display', serif; font-size: 1.4rem; color: #F5F0E8; font-weight: 600; }
    .row-stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 24px; }
    .stat-card { background: #111; border: 1px solid rgba(255,255,255,0.07); border-radius: 12px; padding: 18px; display: flex; align-items: center; gap: 16px; }
    .stat-icon { width: 44px; height: 44px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 1.1rem; flex-shrink: 0; }
    .stat-icon.gold { background: rgba(212,175,55,0.1); color: #D4AF37; }
    .stat-icon.blue { background: rgba(59,130,246,0.1); color: #60a5fa; }
    .stat-icon.red { background: rgba(239,68,68,0.1); color: #f87171; }
    .stat-icon.green { background: rgba(34,197,94,0.1); color: #4ade80; }
    .stat-info h3 { font-size: 1.3rem; color: #F5F0E8; font-weight: 700; line-height: 1.2; }
    .stat-info p { font-size: 0.75rem; color: #555; margin-top: 2px; text-transform: uppercase; letter-spacing: 1px; }
    .card-box { background: #111; border: 1px solid rgba(255,255,255,0.07); border-radius: 12px; padding: 20px; margin-bottom: 20px; }
    .card-box-title { font-size: 0.85rem; color: #D4AF37; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 16px; display: flex; align-items: center; gap: 8px; }
    .btn-nx { display: inline-flex; align-items: center; gap: 7px; padding: 9px 18px; border-radius: 6px; font-size: 0.82rem; text-decoration: none; border: none; cursor: pointer; transition: all 0.2s; font-weight: 600; letter-spacing: 0.5px; }
    .btn-gold { background: linear-gradient(135deg, #D4AF37, #C5A028); color: #0C0C0C; }
    .btn-gold:hover { opacity: 0.88; color: #0C0C0C; }
    .btn-outline { background: transparent; border: 1px solid rgba(212,175,55,0.4); color: #D4AF37; }
    .btn-outline:hover { background: rgba(212,175,55,0.1); border-color: #D4AF37; }
    .btn-red { background: rgba(239,68,68,0.1); border: 1px solid rgba(239,68,68,0.3); color: #f87171; }
    .btn-red:hover { background: rgba(239,68,68,0.2); }
    .admin-table { width: 100%; border-collapse: collapse; }
    .admin-table th { text-align: left; padding: 10px 14px; font-size: 0.72rem; color: #444; text-transform: uppercase; letter-spacing: 1.5px; border-bottom: 1px solid rgba(255,255,255,0.07); }
    .admin-table td { padding: 12px 14px; border-bottom: 1px solid rgba(255,255,255,0.04); font-size: 0.85rem; color: #C0C0C0; vertical-align: middle; }
    .admin-table tr:hover td { background: rgba(255,255,255,0.02); }
    .badge-nx { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: 0.72rem; font-weight: 600; }
    .badge-wait { background: rgba(255,193,7,0.15); color: #ffc107; border: 1px solid rgba(255,193,7,0.3); }
    .badge-sent { background: rgba(23,162,184,0.15); color: #17a2b8; border: 1px solid rgba(23,162,184,0.3); }
    .badge-shipping { background: rgba(0,123,255,0.15); color: #4dabf7; border: 1px solid rgba(0,123,255,0.3); }
    .badge-done { background: rgba(40,167,69,0.15); color: #51cf66; border: 1px solid rgba(40,167,69,0.3); }
    .badge-cancel { background: rgba(220,53,69,0.15); color: #ff6b6b; border: 1px solid rgba(220,53,69,0.3); }
    .admin-form-group { margin-bottom: 16px; }
    .admin-form-group label { display: block; font-size: 0.75rem; color: #666; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px; }
    .admin-form-group input, .admin-form-group select, .admin-form-group textarea { width: 100%; padding: 10px 14px; background: rgba(255,255,255,0.04); border: 1px solid rgba(255,255,255,0.1); border-radius: 6px; color: #E8E8E8; outline: none; font-size: 0.88rem; box-sizing: border-box; transition: border-color 0.2s; }
    .admin-form-group input:focus, .admin-form-group select:focus, .admin-form-group textarea:focus { border-color: rgba(212,175,55,0.4); }
    @media(max-width:768px) { .admin-sidebar{display:none;} .admin-main{margin-left:0;} .row-stats{grid-template-columns:repeat(2,1fr);} }
    </style>
</head>
<body>
    <!-- SIDEBAR -->
    <aside class="admin-sidebar">
        <div class="admin-logo">
            <span>NEXORA</span>
            <p>Admin Panel</p>
        </div>
        <nav class="admin-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="${pageContext.request.servletPath.contains('dashboard') ? 'active' : ''}">
                <i class="fas fa-chart-area"></i> Dashboard
            </a>
            <div class="nav-divider"></div>
            <a href="${pageContext.request.contextPath}/admin/products" class="${pageContext.request.servletPath.contains('products') ? 'active' : ''}">
                <i class="fas fa-tshirt"></i> Sản phẩm
            </a>
            <a href="${pageContext.request.contextPath}/admin/categories" class="${pageContext.request.servletPath.contains('categories') ? 'active' : ''}">
                <i class="fas fa-tags"></i> Danh mục
            </a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="${pageContext.request.servletPath.contains('orders') ? 'active' : ''}">
                <i class="fas fa-shopping-bag"></i> Đơn hàng
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="${pageContext.request.servletPath.contains('users') ? 'active' : ''}">
                <i class="fas fa-users"></i> Khách hàng
            </a>
                        <a href="${pageContext.request.contextPath}/admin/inventory" class="${pageContext.request.servletPath.contains('inventory') ? 'active' : ''}">
                <i class="fas fa-boxes"></i> Kho hàng
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/posts" class="${pageContext.request.servletPath.contains('post') ? 'active' : ''}">
                <i class="fas fa-newspaper"></i> Bài viết
            </a>
            <a href="${pageContext.request.contextPath}/admin/contacts" class="${pageContext.request.servletPath.contains('contact') ? 'active' : ''}">
                <i class="fas fa-envelope"></i> Liên hệ
            </a>
            <a href="${pageContext.request.contextPath}/admin/settings" class="${pageContext.request.servletPath.contains('setting') ? 'active' : ''}">
                <i class="fas fa-cog"></i> Cài đặt
            </a>
            <div class="nav-divider"></div>
            <a href="${pageContext.request.contextPath}/" target="_blank">
                <i class="fas fa-store"></i> Xem cửa hàng
            </a>
            <a href="${pageContext.request.contextPath}/logout" style="color:#ff6b6b!important;">
                <i class="fas fa-sign-out-alt"></i> Đăng xuất
            </a>
        </nav>
    </aside>
    <main class="admin-main">

