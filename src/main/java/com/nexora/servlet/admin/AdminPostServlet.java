package com.nexora.servlet.admin;
import com.nexora.dao.PostDAO;
import com.nexora.model.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/posts")
public class AdminPostServlet extends HttpServlet {
    private PostDAO postDAO;
    @Override public void init() { postDAO = new PostDAO(); }
    
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("edit".equals(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Post post = postDAO.getById(Integer.parseInt(idStr));
                req.setAttribute("post", post);
            }
            req.getRequestDispatcher("/views/admin/postEdit.jsp").forward(req, resp);
            return;
        } else if ("delete".equals(action)) {
            postDAO.delete(Integer.parseInt(req.getParameter("id")));
            req.getSession().setAttribute("toastMsg", "Xóa bài viết thành công!");
            req.getSession().setAttribute("toastType", "success");
            resp.sendRedirect(req.getContextPath() + "/admin/posts");
            return;
        }
        List<Post> posts = postDAO.getAll();
        req.setAttribute("posts", posts);
        req.getRequestDispatcher("/views/admin/posts.jsp").forward(req, resp);
    }
    
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Post p = new Post();
        p.setTitle(req.getParameter("title"));
        p.setContent(req.getParameter("content"));
        p.setImage(req.getParameter("image"));
        p.setStatus(req.getParameter("status"));
        
        if (idStr != null && !idStr.isEmpty()) {
            p.setPostId(Integer.parseInt(idStr));
            postDAO.update(p);
            req.getSession().setAttribute("toastMsg", "Cập nhật bài viết thành công!");
        } else {
            postDAO.insert(p);
            req.getSession().setAttribute("toastMsg", "Thêm bài viết thành công!");
        }
        req.getSession().setAttribute("toastType", "success");
        resp.sendRedirect(req.getContextPath() + "/admin/posts");
    }
}
