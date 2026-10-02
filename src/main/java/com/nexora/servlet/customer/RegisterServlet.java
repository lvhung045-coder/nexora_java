package com.nexora.servlet.customer;

import com.nexora.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/** RegisterServlet - Xu ly Đăng ký Tài khoản Khách hàng */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override public void init() { customerDAO = new CustomerDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/customer/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String fullname   = req.getParameter("fullname");
        String email      = req.getParameter("email");
        String phone      = req.getParameter("phone");
        String address    = req.getParameter("address");
        String password   = req.getParameter("password");
        String rePassword = req.getParameter("re_password");

        if (!password.equals(rePassword)) {
            req.setAttribute("error", "Mat khau nhap lai khong khop!");
            req.getRequestDispatcher("/views/customer/register.jsp").forward(req, resp);
            return;
        }
        if (password.length() < 6) {
            req.setAttribute("error", "Mat khau phai co it nhat 6 ky tu!");
            req.getRequestDispatcher("/views/customer/register.jsp").forward(req, resp);
            return;
        }
        if (customerDAO.emailExists(email.trim())) {
            req.setAttribute("error", "Email nay da duoc su dung!");
            req.getRequestDispatcher("/views/customer/register.jsp").forward(req, resp);
            return;
        }

        boolean ok = customerDAO.register(fullname, email.trim(), password, phone, address);
        if (ok) {
            req.setAttribute("success", "Đăng ký Thành công! Ban co the Đăng nhập ngay.");
        } else {
            req.setAttribute("error", "Co loi xay ra, vui long thu lai!");
        }
        req.getRequestDispatcher("/views/customer/register.jsp").forward(req, resp);
    }
}