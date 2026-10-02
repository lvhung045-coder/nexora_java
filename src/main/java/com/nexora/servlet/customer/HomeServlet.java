package com.nexora.servlet.customer;

import com.nexora.dao.CategoryDAO;
import com.nexora.dao.ProductDAO;
import com.nexora.model.Category;
import com.nexora.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

/**
 * HomeServlet.java - Trang chủ Nexora
 * Thay the index.php
 */
@WebServlet({"", "/index"})
public class HomeServlet extends HttpServlet {
    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String search = req.getParameter("search");

        if (search != null && !search.trim().isEmpty()) {
            // Tìm kiếm Sản phẩm
            List<Product> results = productDAO.search(search.trim());
            req.setAttribute("searchResults", results);
            req.setAttribute("searchKeyword", search.trim());
        }

        // Tai dữ liệu cho 6 lanes - giong index.php
        Map<String, List<Product>> lanes = new LinkedHashMap<>();
        lanes.put("hot", productDAO.getHotProducts(30));
        lanes.put("1",   productDAO.getByCategory(1, 30));   // Ao Phong Nam
        lanes.put("2",   productDAO.getByCategory(2, 30));   // Ao Khoac Nam
        lanes.put("3",   productDAO.getByCategory(3, 30));   // Quan Jean Nam
        lanes.put("5",   productDAO.getByCategory(5, 30));   // Phu Kien Nam
        lanes.put("6",   productDAO.getByCategory(6, 30));   // Nuoc Hoa Nam

        Map<String, String> laneLabels = new LinkedHashMap<>();
        laneLabels.put("hot", "Hot Collection");
        laneLabels.put("1", "Ao Phong Nam");
        laneLabels.put("2", "Ao Khoac Nam");
        laneLabels.put("3", "Quan Jean Nam");
        laneLabels.put("5", "Phu Kien Nam");
        laneLabels.put("6", "Nuoc Hoa Nam");

        List<Category> categories = categoryDAO.getAll();

        req.setAttribute("lanes", lanes);
        req.setAttribute("laneLabels", laneLabels);
        req.setAttribute("categories", categories);

                // Paging for All Products Grid
        int page = 1;
        int pageSize = 12;
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try { page = Integer.parseInt(pageParam); } catch (Exception ignored) {}
        }
        List<Product> allProducts = productDAO.getPaginated(page, pageSize);
        int TốtalProducts = productDAO.count();
        int TốtalPages = (int) Math.ceil((double) TốtalProducts / pageSize);

        req.setAttribute("allProducts", allProducts);
        req.setAttribute("currentPage", page);
        req.setAttribute("TốtalPages", TốtalPages);

        req.getRequestDispatcher("/views/customer/index.jsp").forward(req, resp);
    }
}

