package com.nexora.servlet.admin;

import com.nexora.dao.OrderDAO;
import com.nexora.model.Order;
import com.nexora.model.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/** AdminOrderServlet - Quan ly Đơn hàng (thay admin/orders.php + order_detail.php) */
@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override public void init() { orderDAO = new OrderDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("detail".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("id"));
            Order order = orderDAO.getById(orderId);
            List<OrderDetail> details = orderDAO.getDetails(orderId);
            req.setAttribute("order", order);
            req.setAttribute("details", details);
            req.getRequestDispatcher("/views/admin/orderDetail.jsp").forward(req, resp);
            return;
        }

        if ("update_status".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("id"));
            int status = Integer.parseInt(req.getParameter("status"));
            orderDAO.updateStatus(orderId, status);
            setToast(req.getSession(), "success", "Cap nhat Thành công!", "Trang thai Đơn hàng da duoc cap nhat.");
            resp.sendRedirect(req.getContextPath() + "/admin/orders?action=detail&id=" + orderId);
            return;
        }

        List<Order> orders = orderDAO.getAll();
        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/views/admin/orders.jsp").forward(req, resp);
    }

    private void setToast(HttpSession s, String type, String title, String msg) {
        s.setAttribute("toast_type", type); s.setAttribute("toast_title", title); s.setAttribute("toast_msg", msg);
    }
}