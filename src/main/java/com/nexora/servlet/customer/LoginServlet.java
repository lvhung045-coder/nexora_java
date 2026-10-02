package com.nexora.servlet.customer;

import com.nexora.dao.AdminDAO;
import com.nexora.dao.CustomerDAO;
import com.nexora.model.Admin;
import com.nexora.model.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * LoginServlet.java - Xu ly Đăng nhập
 * Thay the login.php
 * Logic: Check nguoidung truoc, neu khong co thi check users (admin)
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private CustomerDAO customerDAO;
    private AdminDAO adminDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Neu da Đăng nhập roi thi redirect
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user_id") != null) {
            if ("admin".equals(session.getAttribute("role"))) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
            return;
        }
        req.getRequestDispatcher("/views/customer/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("error", "Vui long nhap day du email va mat khau!");
            req.getRequestDispatcher("/views/customer/login.jsp").forward(req, resp);
            return;
        }

        // CHECK 1: Tim trong bang nguoidung (Khách hàng)
        Customer customer = customerDAO.findByEmail(email.trim());
        if (customer != null) {
            if (customerDAO.verifyPassword(password, customer.getPassword())) {
                HttpSession session = req.getSession();
                session.setAttribute("user_id", customer.getUserId());
                session.setAttribute("fullname", customer.getFullname());
                session.setAttribute("email", customer.getEmail());
                session.setAttribute("role", "customer");
                setToast(session, "success", "Chao mung tro lai!", "Xin chao, " + customer.getFullname() + "!");
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            } else {
                req.setAttribute("error", "Mat khau khong dung!");
                req.getRequestDispatcher("/views/customer/login.jsp").forward(req, resp);
                return;
            }
        }

        // CHECK 2: Tim trong bang users (admin) - tim theo email hoac username
        Admin admin = adminDAO.findByEmailOrUsername(email.trim());
        if (admin != null) {
            if (adminDAO.verifyPassword(password, admin.getPassword())) {
                HttpSession session = req.getSession();
                session.setAttribute("user_id", admin.getUserId());
                session.setAttribute("fullname", admin.getFullname());
                session.setAttribute("email", admin.getEmail());
                session.setAttribute("role", "admin");
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                return;
            } else {
                req.setAttribute("error", "Mat khau quan tri khong dung!");
                req.getRequestDispatcher("/views/customer/login.jsp").forward(req, resp);
                return;
            }
        }

        req.setAttribute("error", "Email nay chua duoc Đăng ký!");
        req.getRequestDispatcher("/views/customer/login.jsp").forward(req, resp);
    }

    private void setToast(HttpSession session, String type, String title, String msg) {
        session.setAttribute("toast_type", type);
        session.setAttribute("toast_title", title);
        session.setAttribute("toast_msg", msg);
    }
}