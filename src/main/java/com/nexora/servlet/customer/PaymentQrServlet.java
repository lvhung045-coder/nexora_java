package com.nexora.servlet.customer;

import com.nexora.dao.OrderDAO;
import com.nexora.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/** PaymentQrServlet - Hien thi QR code Thanh toán (thay payment_qr.php) */
@WebServlet("/payment-qr")
public class PaymentQrServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override public void init() { orderDAO = new OrderDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int orderId = Integer.parseInt(req.getParameter("id"));
        Order order = orderDAO.getById(orderId);
        if (order == null) { resp.sendRedirect(req.getContextPath() + "/history"); return; }
        req.setAttribute("order", order);
        req.getRequestDispatcher("/views/customer/paymentQr.jsp").forward(req, resp);
    }
}