package com.nexora.servlet.customer;

import com.nexora.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/** ChangePasswordServlet - Doi mat khau (thay change_password.php) */
@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override public void init() { customerDAO = new CustomerDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/customer/changePassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        int userId = (int) session.getAttribute("user_id");

        String oldPassword  = req.getParameter("old_password");
        String newPassword  = req.getParameter("new_password");
        String confPassword = req.getParameter("confirm_password");

        if (!newPassword.equals(confPassword)) {
            req.setAttribute("error", "Mat khau xac nhan khong khop!");
            req.getRequestDispatcher("/views/customer/changePassword.jsp").forward(req, resp);
            return;
        }
        if (newPassword.length() < 6) {
            req.setAttribute("error", "Mat khau moi phai co it nhat 6 ky tu!");
            req.getRequestDispatcher("/views/customer/changePassword.jsp").forward(req, resp);
            return;
        }

        var customer = customerDAO.findById(userId);
        if (customer == null || !customerDAO.verifyPassword(oldPassword, customer.getPassword())) {
            req.setAttribute("error", "Mat khau hien tai khong dung!");
            req.getRequestDispatcher("/views/customer/changePassword.jsp").forward(req, resp);
            return;
        }

        boolean ok = customerDAO.changePassword(userId, newPassword);
        if (ok) {
            setToast(session, "success", "Doi mat khau Thành công!", "Mat khau cua ban da duoc cap nhat.");
            resp.sendRedirect(req.getContextPath() + "/");
        } else {
            req.setAttribute("error", "Co loi xay ra, vui long thu lai!");
            req.getRequestDispatcher("/views/customer/changePassword.jsp").forward(req, resp);
        }
    }

    private void setToast(HttpSession s, String type, String title, String msg) {
        s.setAttribute("toast_type", type);
        s.setAttribute("toast_title", title);
        s.setAttribute("toast_msg", msg);
    }
}