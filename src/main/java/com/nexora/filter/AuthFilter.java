package com.nexora.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * AuthFilter.java - Bao ve cac trang can Đăng nhập Khách hàng
 * Thay viec check $_SESSION["user_id"] thi cong trong tung file PHP
 */
@WebFilter({"/cart", "/checkout", "/history", "/change-password"})
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("user_id") != null);

        if (!loggedIn) {
            session = request.getSession();
            session.setAttribute("toast_type", "warning");
            session.setAttribute("toast_title", "Chua Đăng nhập");
            session.setAttribute("toast_msg", "Ban can Đăng nhập de thuc hien chuc nang nay!");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            chain.doFilter(req, resp);
        }
    }
}