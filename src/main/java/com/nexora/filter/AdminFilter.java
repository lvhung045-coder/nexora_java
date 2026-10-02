package com.nexora.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * AdminFilter.java - Bao ve toan bo /admin/* 
 * Thay viec kiem tra session role thi cong trong tung file admin PHP
 */
@WebFilter("/admin/*")
public class AdminFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        HttpSession session = request.getSession(false);
        boolean isAdmin = session != null
                && session.getAttribute("user_id") != null
                && "admin".equals(session.getAttribute("role"));

        if (!isAdmin) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            chain.doFilter(req, resp);
        }
    }
}

