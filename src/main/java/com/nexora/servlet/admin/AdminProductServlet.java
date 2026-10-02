package com.nexora.servlet.admin;

import com.nexora.dao.CategoryDAO;
import com.nexora.dao.ProductDAO;
import com.nexora.model.Product;
import com.nexora.model.ProductVariant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.List;

@WebServlet("/admin/products")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class AdminProductServlet extends HttpServlet {
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
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            req.setAttribute("categories", categoryDAO.getAll());
            req.getRequestDispatcher("/views/admin/productAdd.jsp").forward(req, resp);
            return;
        }

        if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("product", productDAO.getById(id));
            req.setAttribute("categories", categoryDAO.getAll());
            req.setAttribute("variants", productDAO.getVariants(id));
            req.getRequestDispatcher("/views/admin/productEdit.jsp").forward(req, resp);
            return;
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            productDAO.delete(id);
            setToast(req.getSession(), "success", "Da xoa", "Sản phẩm da duoc xoa.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
            return;
        }

        if ("delete_variant".equals(action)) {
            int variantId = Integer.parseInt(req.getParameter("id"));
            productDAO.deleteVariant(variantId);
            setToast(req.getSession(), "success", "Da xoa", "Bien the da duoc xoa.");
            resp.sendRedirect(req.getHeader("Referer"));
            return;
        }

        List<Product> products = productDAO.getAll();
        req.setAttribute("products", products);
        req.getRequestDispatcher("/views/admin/products.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("insert".equals(action)) {
            Product p = buildProduct(req);
            String imageName = handleFileUpload(req);
            if (imageName != null) p.setImage(imageName);
            productDAO.insert(p);
            setToast(req.getSession(), "success", "Them Thành công!", "Sản phẩm moi da duoc them.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("product_id"));
            Product p = buildProduct(req);
            p.setProductId(id);
            String imageName = handleFileUpload(req);
            if (imageName != null) {
                p.setImage(imageName);
            } else {
                Product existing = productDAO.getById(id);
                if (existing != null) p.setImage(existing.getImage());
            }
            productDAO.update(p);
            setToast(req.getSession(), "success", "Cap nhat Thành công!", "Sản phẩm da duoc cap nhat.");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if ("add_variant".equals(action)) {
            ProductVariant v = new ProductVariant();
            v.setProductId(Integer.parseInt(req.getParameter("product_id")));
            v.setSize(req.getParameter("size"));
            v.setColor(req.getParameter("color"));
            v.setPrice(Long.parseLong(req.getParameter("price")));
            v.setStock(Integer.parseInt(req.getParameter("stock")));
            productDAO.addVariant(v);
            setToast(req.getSession(), "success", "Them bien the!", "Bien the moi da duoc them.");
            resp.sendRedirect(req.getContextPath() + "/admin/products?action=edit&id=" + v.getProductId());
        }
    }

    private Product buildProduct(HttpServletRequest req) {
        Product p = new Product();
        p.setCatId(Integer.parseInt(req.getParameter("cat_id")));
        p.setProductName(req.getParameter("product_name"));
        p.setPrice(Long.parseLong(req.getParameter("price")));
        p.setStock(Integer.parseInt(req.getParameter("stock")));
        p.setProductDesc(req.getParameter("product_desc"));
        p.setHot("1".equals(req.getParameter("is_hot")));
        p.setMaterial(req.getParameter("material"));
        p.setStyle(req.getParameter("style"));
        p.setOrigin(req.getParameter("origin"));
        return p;
    }

    private String handleFileUpload(HttpServletRequest req) {
        try {
            Part filePart = req.getPart("image");
            if (filePart == null || filePart.getSize() == 0) return null;
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            if (fileName.isEmpty()) return null;
            String uploadDir = getServletContext().getRealPath("/assets/images/");
            new File(uploadDir).mkdirs();
            filePart.write(uploadDir + File.separator + fileName);
            return fileName;
        } catch (Exception e) { e.printStackTrace(); return null; }
    }

    private void setToast(HttpSession s, String type, String title, String msg) {
        s.setAttribute("toast_type", type);
        s.setAttribute("toast_title", title);
        s.setAttribute("toast_msg", msg);
    }
}