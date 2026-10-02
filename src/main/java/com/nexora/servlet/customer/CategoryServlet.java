package com.nexora.servlet.customer;

import com.nexora.dao.CategoryDAO;
import com.nexora.dao.ProductDAO;
import com.nexora.model.Category;
import com.nexora.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/** CategoryServlet - Trang Danh mục Sản phẩm (thay category.php) */
@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private static final int PAGE_SIZE = 12;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String catIdStr = req.getParameter("id");
        if (catIdStr == null) { resp.sendRedirect(req.getContextPath() + "/"); return; }

        int catId;
        try { catId = Integer.parseInt(catIdStr); } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/"); return;
        }

        int page = 1;
        try { page = Math.max(1, Integer.parseInt(req.getParameter("page"))); }
        catch (Exception ignored) {}

        int Tốtal = productDAO.countByCategory(catId);
        int TốtalPages = (int) Math.ceil((double) Tốtal / PAGE_SIZE);
        int offset = (page - 1) * PAGE_SIZE;

        List<Product> products = productDAO.getByCategoryPaged(catId, offset, PAGE_SIZE);
        Category category = categoryDAO.getById(catId);
        List<Category> allCategories = categoryDAO.getAll();

        if (category == null) { resp.sendRedirect(req.getContextPath() + "/"); return; }

        req.setAttribute("products", products);
        req.setAttribute("category", category);
        req.setAttribute("allCategories", allCategories);
        req.setAttribute("currentPage", page);
        req.setAttribute("TốtalPages", TốtalPages);
        req.setAttribute("Tốtal", Tốtal);
        req.getRequestDispatcher("/views/customer/category.jsp").forward(req, resp);
    }
}