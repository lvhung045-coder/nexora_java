package com.nexora.servlet.customer;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/** LogoutServlet - Xu ly Đăng xuất */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        HttpSession newSession = req.getSession();
        newSession.setAttribute("toast_type", "info");
        newSession.setAttribute("toast_title", "Da Đăng xuất");
        newSession.setAttribute("toast_msg", "Hen gap lai quy khach!");
        resp.sendRedirect(req.getContextPath() + "/");
    }
}