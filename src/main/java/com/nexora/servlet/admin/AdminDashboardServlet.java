package com.nexora.servlet.admin;

import com.nexora.dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/** AdminDashboardServlet - Trang tong quan admin (thay admin/index.php) */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private ProductDAO productDAO;
    private OrderDAO orderDAO;
    private ReviewDAO reviewDAO;
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        orderDAO = new OrderDAO();
        reviewDAO = new ReviewDAO();
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("TốtalProducts", productDAO.count());
        req.setAttribute("TốtalOrders", orderDAO.count());
        req.setAttribute("TốtalRevenue", orderDAO.getTốtalRevenue());
        req.setAttribute("TốtalReviews", reviewDAO.count());
        req.setAttribute("TốtalCustomers", customerDAO.count());
                req.setAttribute("recentOrders", orderDAO.getRecent(7));
        req.setAttribute("topProducts", orderDAO.getTopSellingProducts(5));
        // dữ liệu bieu do Chart.js
        req.setAttribute("chartLabels", orderDAO.getLast7DaysLabels());
        req.setAttribute("chartData", orderDAO.getLast7DaysRevenue());
        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }
}
