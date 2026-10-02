package com.nexora.servlet.customer;

import com.nexora.dao.ProductDAO;
import com.nexora.model.CartItem;
import com.nexora.model.Product;
import com.nexora.model.ProductVariant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.*;

/**
 * CartServlet.java - Xu ly gio hang
 * Thay cart.php - cart luu trong HttpSession giong $_SESSION["cart"]
 * Cart key = "productId_variantId" - giong PHP
 */
@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override public void init() { productDAO = new ProductDAO(); }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        if ("add".equals(action)) {
            // Yeu cau Đăng nhập de them vao gio
            if (session.getAttribute("user_id") == null) {
                setToast(session, "warning", "Chua Đăng nhập", "Ban can Đăng nhập de them Sản phẩm vao gio hang!");
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }
            addToCart(req, resp, session);
            return;
        }

        if ("delete".equals(action)) {
            String key = req.getParameter("id");
            Map<String, CartItem> cart = getCart(session);
            cart.remove(key);
            setToast(session, "info", "Da xoa", "Sản phẩm da duoc xoa khoi gio hang.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        if ("clear".equals(action)) {
            session.removeAttribute("cart");
            setToast(session, "warning", "Da xoa Tất cả", "Toan bo gio hang da duoc xoa.");
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        // Hien thi gio hang
        req.getRequestDispatcher("/views/customer/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        String[] keys = req.getParameterValues("cart_key");
        String[] qtys = req.getParameterValues("qty");

        if (keys != null && qtys != null) {
            Map<String, CartItem> cart = getCart(session);
            boolean hasError = false;
            for (int i = 0; i < keys.length; i++) {
                try {
                    int qty = Integer.parseInt(qtys[i]);
                    if (qty <= 0) {
                        cart.remove(keys[i]);
                    } else {
                        if (cart.containsKey(keys[i])) {
                            CartItem item = cart.get(keys[i]);
                            int availableStock = 0;
                            if (item.getVariantId() > 0) {
                                ProductVariant v = productDAO.getVariantById(item.getVariantId());
                                if (v != null) availableStock = v.getStock();
                            } else {
                                Product p = productDAO.getById(item.getProductId());
                                if (p != null) availableStock = p.getStock();
                            }
                            if (qty > availableStock) {
                                hasError = true;
                                item.setQty(availableStock);
                            } else {
                                item.setQty(qty);
                            }
                        }
                    }
                } catch (NumberFormatException ignored) {}
            }
            if (hasError) {
                setToast(session, "warning", "Cảnh báo!", "Một số sản phẩm không đủ tồn kho nên đã tự điều chỉnh số lượng tối đa.");
            } else {
                setToast(session, "success", "Cập nhật thành công!", "Giỏ hàng đã được cập nhật.");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/cart");
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp, HttpSession session)
            throws IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            int variantId = 0;
            try { variantId = Integer.parseInt(req.getParameter("variant_id")); } catch (Exception ignored) {}
            String type = req.getParameter("type"); // "add" hoac "buy"

            Product product = productDAO.getById(productId);
            if (product == null) { resp.sendRedirect(req.getContextPath() + "/"); return; }

            String key = CartItem.buildKey(productId, variantId);
            String itemName = product.getProductName();
            long price = product.getPrice();

            int availableStock = product.getStock();
            if (variantId > 0) {
                ProductVariant v = productDAO.getVariantById(variantId);
                if (v != null) {
                    itemName += " - Size " + v.getSize() + " - " + v.getColor();
                    price = v.getPrice();
                    availableStock = v.getStock();
                }
            }

            Map<String, CartItem> cart = getCart(session);
            int requestedQty = 1;
            if (cart.containsKey(key)) {
                requestedQty = cart.get(key).getQty() + 1;
            }

            if (requestedQty > availableStock) {
                setToast(session, "error", "Hết hàng!", "Sản phẩm này không đủ số lượng trong kho.");
            } else {
                if (cart.containsKey(key)) {
                    cart.get(key).setQty(requestedQty);
                } else {
                    cart.put(key, new CartItem(productId, variantId, itemName, price, product.getImage(), 1));
                }
                setToast(session, "success", "Thêm thành công!", product.getProductName() + " đã được thêm vào giỏ hàng.");
            }

            if ("buy".equals(type)) {
                resp.sendRedirect(req.getContextPath() + "/checkout");
            } else {
                String referer = req.getHeader("Referer");
                resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }

    @SuppressWarnings("unchecked")
    private Map<String, CartItem> getCart(HttpSession session) {
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    private void setToast(HttpSession s, String type, String title, String msg) {
        s.setAttribute("toast_type", type);
        s.setAttribute("toast_title", title);
        s.setAttribute("toast_msg", msg);
    }
}
