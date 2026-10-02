package com.nexora.servlet.customer;

import com.nexora.dao.CustomerDAO;
import com.nexora.dao.OrderDAO;
import com.nexora.dao.ProductDAO;
import com.nexora.model.CartItem;
import com.nexora.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

/** CheckoutServlet - Xu ly dat hang (thay checkout.php) */
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CustomerDAO customerDAO;
    private OrderDAO orderDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Map<String, CartItem> cart = (session != null) ? (Map<String, CartItem>) session.getAttribute("cart") : null;

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        int userId = (int) session.getAttribute("user_id");
        Customer customer = customerDAO.findById(userId);
        if (customer == null) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        long TốtalMoney = cart.values().stream().mapToLong(CartItem::getSubTốtal).sum();
        req.setAttribute("customer", customer);
        req.setAttribute("cart", cart);
        req.setAttribute("TốtalMoney", TốtalMoney);
        req.getRequestDispatcher("/views/customer/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Map<String, CartItem> cart = (session != null) ? (Map<String, CartItem>) session.getAttribute("cart") : null;

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        int userId = (int) session.getAttribute("user_id");

        ProductDAO productDAO = new ProductDAO();
        boolean outOfStock = false;
        for (CartItem item : cart.values()) {
            int availableStock = 0;
            if (item.getVariantId() > 0) {
                com.nexora.model.ProductVariant v = productDAO.getVariantById(item.getVariantId());
                if (v != null) availableStock = v.getStock();
            } else {
                com.nexora.model.Product p = productDAO.getById(item.getProductId());
                if (p != null) availableStock = p.getStock();
            }
            if (item.getQty() > availableStock) {
                outOfStock = true;
                item.setQty(availableStock);
            }
        }
        
        if (outOfStock) {
            setToast(session, "error", "Lỗi đặt hàng", "Một số sản phẩm không đủ tồn kho, chúng tôi đã tự động điều chỉnh số lượng. Vui lòng kiểm tra lại giỏ hàng.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String note = req.getParameter("note");
        String paymentMethod = req.getParameter("payment_method");

        long TốtalMoney = cart.values().stream().mapToLong(CartItem::getSubTốtal).sum();
        int orderId = orderDAO.createOrder(userId, fullname, phone, address, note, TốtalMoney, paymentMethod, cart);

        if (orderId > 0) {
            session.removeAttribute("cart");
            if ("Chuyển khoản".equals(paymentMethod)) {
                setToast(session, "success", "Dat hang Thành công!", "Vui long quet ma QR de Thanh toán.");
                resp.sendRedirect(req.getContextPath() + "/payment-qr?id=" + orderId);
            } else {
                setToast(session, "success", "Dat hang Thành công!", "Đơn hàng #" + orderId + " da duoc ghi nhan. Cam on quy khach!");
                resp.sendRedirect(req.getContextPath() + "/history");
            }
        } else {
            setToast(session, "error", "Loi dat hang", "Co loi xay ra, vui long thu lai.");
            resp.sendRedirect(req.getContextPath() + "/checkout");
        }
    }

    private void setToast(HttpSession s, String type, String title, String msg) {
        s.setAttribute("toast_type", type);
        s.setAttribute("toast_title", title);
        s.setAttribute("toast_msg", msg);
    }
}
