package com.nexora.servlet.customer;

import com.nexora.dao.ProductDAO;
import com.nexora.dao.ReviewDAO;
import com.nexora.model.Product;
import com.nexora.model.ProductVariant;
import com.nexora.model.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/** ProductServlet - Trang Chi tiết Sản phẩm (thay product_detail.php) */
@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;
    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) { resp.sendRedirect(req.getContextPath() + "/"); return; }

        int id;
        try { id = Integer.parseInt(idStr); } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/"); return;
        }

        Product product = productDAO.getById(id);
        if (product == null) { resp.sendRedirect(req.getContextPath() + "/"); return; }

        List<ProductVariant> variants = productDAO.getVariants(id);
        List<Review> reviews = reviewDAO.getByProduct(id);

        req.setAttribute("product", product);
        req.setAttribute("variants", variants);
        req.setAttribute("reviews", reviews);
        req.getRequestDispatcher("/views/customer/productDetail.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Gui Đánh giá
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int productId = Integer.parseInt(req.getParameter("product_id"));
        int userId = (int) session.getAttribute("user_id");
        int star = Integer.parseInt(req.getParameter("star"));
        String content = req.getParameter("content");
        reviewDAO.addReview(productId, userId, star, content);
        resp.sendRedirect(req.getContextPath() + "/product?id=" + productId);
    }
}