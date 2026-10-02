<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"><title>500 - Nexora</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
    body{background:#0C0C0C;color:#E8E8E8;font-family:'Inter',sans-serif;display:flex;align-items:center;justify-content:center;min-height:100vh;margin:0;text-align:center;}
    .e-num{font-size:6rem;font-weight:900;color:rgba(212,175,55,0.15);line-height:1;}
    a{display:inline-block;padding:12px 28px;background:linear-gradient(135deg,#D4AF37,#C5A028);color:#0C0C0C;text-decoration:none;border-radius:8px;font-weight:700;margin-top:20px;}
    </style>
</head>
<body>
    <div>
        <div class="e-num">500</div>
        <h1>Loi may chu</h1>
        <p style="color:#555;">Da xay ra loi. Vui long thu lai sau.</p>
        <a href="${pageContext.request.contextPath}/">Ve Trang chủ</a>
    </div>
<div>Exception: <%= request.getAttribute("jakarta.servlet.error.exception") %></div></body></html>
