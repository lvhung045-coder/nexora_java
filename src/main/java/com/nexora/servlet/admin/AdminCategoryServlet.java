package com.nexora.servlet.admin;

import com.nexora.dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/** AdminCategoryServlet - Quan ly Danh mục (thay admin/categories.php) */
@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO;

    @Override public void init() { categoryDAO = new CategoryDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            categoryDAO.delete(Integer.parseInt(req.getParameter("id")));
            setToast(req.getSession(), "success", "Da xoa", "Danh mục da duoc xoa.");
            resp.sendRedirect(req.getContextPath() + "/admin/categories"); return;
        }
        req.setAttribute("categories", categoryDAO.getAll());
        req.getRequestDispatcher("/views/admin/categories.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String name = req.getParameter("cat_name");
        String icon = req.getParameter("cat_icon");
        if ("insert".equals(action)) {
            categoryDAO.insert(name, icon);
            setToast(req.getSession(), "success", "Them Thành công!", "Danh mục moi da duoc them.");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("cat_id"));
            categoryDAO.update(id, name, icon);
            setToast(req.getSession(), "success", "Cap nhat Thành công!", "Danh mục da duoc cap nhat.");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }

    private void setToast(HttpSession s, String type, String title, String msg) {
        s.setAttribute("toast_type", type); s.setAttribute("toast_title", title); s.setAttribute("toast_msg", msg);
    }
}