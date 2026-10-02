<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nhập hàng - Admin Nexora</title>
    <link rel="stylesheet" href="/assets/css/nexora_luxury.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .product-row { display: flex; gap: 15px; margin-bottom: 10px; align-items: center; }
        .product-row select, .product-row input { flex: 1; padding: 10px; background: rgba(255,255,255,0.05); color: #fff; border: 1px solid rgba(255,255,255,0.1); border-radius: 6px; }
        .remove-btn { background: #ff4d4d; color: white; border: none; padding: 10px 15px; border-radius: 6px; cursor: pointer; }
    </style>
</head>
<body class="admin-body">
    <%@ include file="/includes/admin/adminHeader.jsp" %>

    
        <div class="admin-topbar">
            <h1>Tạo phiếu nhập kho</h1>
        </div>

        <div class="card-box">
            <form action="/admin/inventory" method="post">
                <div class="form-group" style="margin-bottom: 20px;">
                    <label style="display:block; margin-bottom: 5px; color:#D4AF37;">Nhà cung cấp</label>
                    <input type="text" name="supplier" required class="form-control" placeholder="Tên nhà cung cấp..." style="width: 100%; padding: 10px; background: rgba(255,255,255,0.05); color: #fff; border: 1px solid rgba(255,255,255,0.1); border-radius: 6px;">
                </div>

                <div id="product-list">
                    <div class="product-row">
                        <select name="product_id[]" required>
                            <option value="">-- Chọn sản phẩm --</option>
                            <c:forEach var="p" items="${products}">
                                <option value="${p.productId}">${p.productName} (Tồn: ${p.stock})</option>
                            </c:forEach>
                        </select>
                        <input type="number" name="quantity[]" placeholder="Số lượng" required min="1">
                        <input type="number" name="price[]" placeholder="Giá nhập (VNĐ)" required min="0">
                        <button type="button" class="remove-btn" onclick="this.parentElement.remove()"><i class="fas fa-trash"></i></button>
                    </div>
                </div>
                
                <button type="button" class="btn-nx btn-gold" onclick="addRow()" style="background: transparent; border: 1px solid #D4AF37; margin-bottom: 20px;">+ Thêm sản phẩm</button>
                <br>
                <button type="submit" class="btn-nx btn-gold">Lưu phiếu nhập</button>
                <a href="/admin/inventory" class="btn-nx btn-gold" style="background: #333;">Hủy</a>
            </form>
        </div>
    </div>

    <script>
        function addRow() {
            var row = document.querySelector('.product-row').cloneNode(true);
            row.querySelectorAll('input').forEach(input => input.value = '');
            document.getElementById('product-list').appendChild(row);
        }
    </script>
<%@ include file="/includes/admin/adminFooter.jsp" %>








