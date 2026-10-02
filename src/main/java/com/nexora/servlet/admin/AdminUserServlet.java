package com.nexora.servlet.admin;

import com.nexora.dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/** AdminUserServlet - Quan ly Khách hàng (thay admin/users.php) */
@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override public void init() { customerDAO = new CustomerDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("customers", customerDAO.getAll());
        req.getRequestDispatcher("/views/admin/users.jsp").forward(req, resp);
    }
}