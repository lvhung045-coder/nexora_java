package com.nexora.servlet.customer;

import com.nexora.dao.OrderDAO;
import com.nexora.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/** OrderHistoryServlet - Lich su Đơn hàng (thay history.php) */
@WebServlet("/history")
public class OrderHistoryServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override public void init() { orderDAO = new OrderDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("user_id");

        // Xu ly huy Đơn hàng
        String action = req.getParameter("action");
        if ("cancel".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("id"));
            boolean cancelled = orderDAO.cancelOrder(orderId, userId);
            if (cancelled) {
                setToast(session, "success", "Huy don Thành công", "Đơn hàng da duoc huy.");
            } else {
                setToast(session, "error", "Khong the huy", "Khong the huy Đơn hàng nay!");
            }
            resp.sendRedirect(req.getContextPath() + "/history");
            return;
        }

        List<Order> orders = orderDAO.getByUser(userId);
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/customer/history.jsp").forward(req, resp);
    }

    private void setToast(HttpSession s, String type, String title, String msg) {
        s.setAttribute("toast_type", type);
        s.setAttribute("toast_title", title);
        s.setAttribute("toast_msg", msg);
    }
}