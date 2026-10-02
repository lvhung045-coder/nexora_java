package com.nexora.servlet.admin;
import com.nexora.dao.ContactDAO;
import com.nexora.model.Contact;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/contacts")
public class AdminContactServlet extends HttpServlet {
    private ContactDAO contactDAO;
    @Override public void init() { contactDAO = new ContactDAO(); }
    
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("status".equals(action)) {
            contactDAO.updateStatus(Integer.parseInt(req.getParameter("id")), req.getParameter("st"));
            req.getSession().setAttribute("toastMsg", "Cập nhật trạng thái thành công!");
            req.getSession().setAttribute("toastType", "success");
            resp.sendRedirect(req.getContextPath() + "/admin/contacts");
            return;
        } else if ("delete".equals(action)) {
            contactDAO.delete(Integer.parseInt(req.getParameter("id")));
            req.getSession().setAttribute("toastMsg", "Xóa liên hệ thành công!");
            req.getSession().setAttribute("toastType", "success");
            resp.sendRedirect(req.getContextPath() + "/admin/contacts");
            return;
        }
        List<Contact> contacts = contactDAO.getAll();
        req.setAttribute("contacts", contacts);
        req.getRequestDispatcher("/views/admin/contacts.jsp").forward(req, resp);
    }
}
