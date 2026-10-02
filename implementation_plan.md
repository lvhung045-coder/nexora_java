# 🚀 Kế Hoạch Chuyển Đổi: PHP → Java Servlet/JSP/JSTL/JDBC
## Ứng Dụng Bán Lẻ Thời Trang Đa Kênh — **Nexora Men's Boutique**

> **Mục tiêu**: Giữ nguyên 100% giao diện HTML/CSS từ source code PHP, thay thế toàn bộ phần backend và template engine bằng Java Servlet + JSP + JSTL + JDBC (MySQL).

---

## 📐 So Sánh Kiến Trúc: PHP vs Java

| Thành phần | PHP (cũ) | Java (mới) |
|---|---|---|
| Server | Apache (XAMPP) | Apache Tomcat 10 |
| Template | `.php` file | JSP (`.jsp`) + JSTL |
| DB Access | MySQLi | JDBC + Connection Pool |
| Session | `$_SESSION[]` | `HttpSession` |
| Routing | File-based URL | Servlet + `@WebServlet` |
| Includes | `include 'header.php'` | `<jsp:include page="header.jsp"/>` |
| DB Connect | `includes/connect.php` | `DBUtil.java` (Singleton) |
| Password Hash | `password_hash()` | `BCrypt` (jBCrypt library) |
| Form Data | `$_POST`, `$_GET` | `request.getParameter()` |

---

## 📁 Cấu Trúc Dự Án Java (Maven + Tomcat)

```
nexora-java/
├── pom.xml                          # Maven dependencies
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/nexora/
│   │   │       ├── db/
│   │   │       │   └── DBUtil.java              # Kết nối JDBC (thay connect.php)
│   │   │       ├── model/                       # POJOs (thay array PHP)
│   │   │       │   ├── Product.java
│   │   │       │   ├── ProductVariant.java
│   │   │       │   ├── Category.java
│   │   │       │   ├── Order.java
│   │   │       │   ├── OrderDetail.java
│   │   │       │   ├── Customer.java
│   │   │       │   └── Review.java
│   │   │       ├── dao/                         # JDBC queries (thay mysqli_query)
│   │   │       │   ├── ProductDAO.java
│   │   │       │   ├── CategoryDAO.java
│   │   │       │   ├── OrderDAO.java
│   │   │       │   ├── CustomerDAO.java
│   │   │       │   └── ReviewDAO.java
│   │   │       ├── servlet/                     # Thay file .php
│   │   │       │   ├── customer/
│   │   │       │   │   ├── HomeServlet.java     # index.php
│   │   │       │   │   ├── CategoryServlet.java # category.php
│   │   │       │   │   ├── ProductServlet.java  # product_detail.php
│   │   │       │   │   ├── CartServlet.java     # cart.php
│   │   │       │   │   ├── CheckoutServlet.java # checkout.php
│   │   │       │   │   ├── OrderHistoryServlet.java # history.php
│   │   │       │   │   ├── LoginServlet.java    # login.php
│   │   │       │   │   ├── RegisterServlet.java # register.php
│   │   │       │   │   └── LogoutServlet.java
│   │   │       │   └── admin/
│   │   │       │       ├── AdminDashboardServlet.java  # admin/index.php
│   │   │       │       ├── AdminProductServlet.java    # admin/products.php
│   │   │       │       ├── AdminOrderServlet.java      # admin/orders.php
│   │   │       │       ├── AdminCategoryServlet.java   # admin/categories.php
│   │   │       │       ├── AdminInventoryServlet.java  # admin/inventory.php
│   │   │       │       └── AdminUserServlet.java       # admin/users.php
│   │   │       └── filter/
│   │   │           ├── AuthFilter.java          # Bảo vệ trang cần đăng nhập
│   │   │           └── AdminFilter.java         # Bảo vệ trang admin
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── web.xml                      # Servlet mapping
│   │       │   └── lib/                         # jBCrypt, MySQL Connector
│   │       ├── assets/
│   │       │   ├── css/
│   │       │   │   └── nexora_luxury.css        # GIỮ NGUYÊN từ PHP project
│   │       │   └── images/                      # GIỮ NGUYÊN từ PHP project
│   │       ├── includes/                        # JSP fragments (thay includes/*.php)
│   │       │   ├── header.jsp                  # header.php → header.jsp
│   │       │   ├── footer.jsp                  # footer.php → footer.jsp
│   │       │   └── admin/
│   │       │       ├── adminHeader.jsp          # admin/includes/header.php
│   │       │       └── adminFooter.jsp
│   │       └── views/                           # JSP pages (thay .php files)
│   │           ├── customer/
│   │           │   ├── index.jsp               # index.php
│   │           │   ├── category.jsp            # category.php
│   │           │   ├── productDetail.jsp       # product_detail.php
│   │           │   ├── cart.jsp                # cart.php
│   │           │   ├── checkout.jsp            # checkout.php
│   │           │   ├── history.jsp             # history.php
│   │           │   ├── login.jsp               # login.php
│   │           │   └── register.jsp            # register.php
│   │           └── admin/
│   │               ├── dashboard.jsp           # admin/index.php
│   │               ├── products.jsp
│   │               ├── productAdd.jsp
│   │               ├── productEdit.jsp
│   │               ├── orders.jsp
│   │               ├── orderDetail.jsp
│   │               ├── categories.jsp
│   │               ├── inventory.jsp
│   │               └── users.jsp
└── SQL.sql                                     # GIỮ NGUYÊN (nexora_db)
```

---

## ⚙️ Công Nghệ & Dependencies (pom.xml)

```xml
<!-- MySQL JDBC Driver -->
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.3.0</version>
</dependency>

<!-- JSTL (Jakarta EE 10) -->
<dependency>
    <groupId>jakarta.servlet.jsp.jstl</groupId>
    <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
    <version>3.0.0</version>
</dependency>
<dependency>
    <groupId>org.glassfish.web</groupId>
    <artifactId>jakarta.servlet.jsp.jstl</artifactId>
    <version>3.0.1</version>
</dependency>

<!-- jBCrypt (thay password_hash của PHP) -->
<dependency>
    <groupId>org.mindrot</groupId>
    <artifactId>jbcrypt</artifactId>
    <version>0.4</version>
</dependency>
```

- **Runtime**: Apache Tomcat 10.1 (Jakarta Servlet 6.0)
- **Java**: Java 17+
- **Build**: Maven 3.9+
- **IDE**: IntelliJ IDEA / Eclipse với Tomcat plugin

---

## 🔄 Hướng Dẫn Chuyển Đổi Chi Tiết

### 1. 🔌 Kết Nối Database (connect.php → DBUtil.java)

**PHP cũ:**
```php
$conn = mysqli_connect("localhost", "root", "", "nexora_db");
mysqli_set_charset($conn, 'utf8mb4');
```

**Java mới:**
```java
// DBUtil.java - Singleton pattern
public class DBUtil {
    private static final String URL = 
        "jdbc:mysql://localhost:3306/nexora_db?useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
    
    // Utility: format tiền (thay formatCurrency PHP)
    public static String formatCurrency(long amount) {
        return String.format("%,d ₫", amount).replace(",", ".");
    }
}
```

---

### 2. 🏠 Trang Chủ (index.php → HomeServlet + index.jsp)

**PHP cũ** (mix logic + HTML):
```php
<?php
$q = "SELECT * FROM products WHERE is_hot=1 ORDER BY product_id DESC LIMIT 30";
$r = mysqli_query($conn, $q);
while ($row = mysqli_fetch_assoc($r)) { ... }
?>
<div class="hero-container">...</div>
```

**Java mới — HomeServlet.java:**
```java
@WebServlet("/")
public class HomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        ProductDAO dao = new ProductDAO();
        req.setAttribute("hotProducts", dao.getHotProducts(30));
        req.setAttribute("categories", new CategoryDAO().getAll());
        // ... các lane khác
        req.getRequestDispatcher("/views/customer/index.jsp").forward(req, resp);
    }
}
```

**index.jsp (HTML giữ nguyên, thay PHP bằng JSTL):**
```jsp
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!-- HERO SECTION - GIỮ NGUYÊN HTML từ PHP -->
<div class="hero-container" data-aos="fade-in">
    <!-- banner giống hệt -->
</div>

<!-- Lane sản phẩm - thay while PHP bằng c:forEach -->
<c:forEach var="product" items="${hotProducts}">
    <div class="product-card">
        <a href="product?id=${product.productId}">
            <img src="assets/images/${product.image}" alt="${product.productName}">
        </a>
        <div class="product-info">
            <h3>${product.productName}</h3>
            <p class="price">
                <fmt:formatNumber value="${product.price}" pattern="#,###"/> ₫
            </p>
        </div>
    </div>
</c:forEach>
```

---

### 3. 🔐 Authentication (login.php → LoginServlet + login.jsp)

**PHP cũ:**
```php
$email = $_POST['email'];
$r = mysqli_query($conn, "SELECT * FROM nguoidung WHERE email='$email'");
if (password_verify($password, $row['password'])) {
    $_SESSION['user_id'] = $row['user_id'];
}
```

**Java mới — LoginServlet.java:**
```java
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        CustomerDAO dao = new CustomerDAO();
        Customer customer = dao.findByEmail(email);
        
        if (customer != null && BCrypt.checkpw(password, customer.getPassword())) {
            HttpSession session = req.getSession();
            session.setAttribute("user_id", customer.getUserId());
            session.setAttribute("fullname", customer.getFullname());
            session.setAttribute("role", "customer");
            resp.sendRedirect(req.getContextPath() + "/");
        } else {
            // Thử login admin
            AdminDAO adminDAO = new AdminDAO();
            Admin admin = adminDAO.findByUsername(email);
            if (admin != null && BCrypt.checkpw(password, admin.getPassword())) {
                session.setAttribute("role", "admin");
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else {
                req.setAttribute("error", "Email hoặc mật khẩu không đúng!");
                req.getRequestDispatcher("/views/customer/login.jsp").forward(req, resp);
            }
        }
    }
}
```

---

### 4. 🛒 Giỏ Hàng (cart.php → CartServlet)

**PHP**: Lưu cart vào `$_SESSION['cart']`  
**Java**: Lưu cart vào `HttpSession` — cùng logic

```java
@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) {
        HttpSession session = req.getSession();
        
        // Lấy cart từ session (HashMap thay array PHP)
        Map<String, CartItem> cart = (Map<String, CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new LinkedHashMap<>();
        
        int productId = Integer.parseInt(req.getParameter("product_id"));
        int variantId = req.getParameter("variant_id") != null ? 
                        Integer.parseInt(req.getParameter("variant_id")) : 0;
        int qty = Integer.parseInt(req.getParameter("qty"));
        
        // Key = "productId_variantId" (giống PHP: product_id + variant_id)
        String key = productId + "_" + variantId;
        
        if (cart.containsKey(key)) {
            cart.get(key).setQty(cart.get(key).getQty() + qty);
        } else {
            Product p = new ProductDAO().getById(productId);
            cart.put(key, new CartItem(p, variantId, qty));
        }
        
        session.setAttribute("cart", cart);
        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}
```

---

### 5. 👤 Header JSP với Session (thay header.php)

**PHP cũ:**
```php
<?php if (isset($_SESSION['user_id'])): ?>
    <span>Xin chào, <?= htmlspecialchars($_SESSION['fullname']) ?></span>
<?php endif; ?>
```

**header.jsp (JSTL):**
```jsp
<c:choose>
    <c:when test="${not empty sessionScope.user_id}">
        <span>Xin chào, <c:out value="${sessionScope.fullname}"/></span>
        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    </c:when>
    <c:otherwise>
        <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
    </c:otherwise>
</c:choose>

<!-- Số lượng giỏ hàng -->
<c:if test="${not empty sessionScope.cart}">
    <span class="cart-badge">${cartCount}</span>
</c:if>
```

---

### 6. 🛡️ Filter Bảo Mật (thay session check PHP)

**PHP cũ** (mỗi file admin check thủ công):
```php
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'admin') {
    header("Location: ../login.php");
    exit();
}
```

**Java — AdminFilter.java (tập trung, áp dụng cho tất cả `/admin/*`):**
```java
@WebFilter("/admin/*")
public class AdminFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) {
        HttpSession session = ((HttpServletRequest) req).getSession(false);
        boolean isAdmin = session != null && "admin".equals(session.getAttribute("role"));
        
        if (!isAdmin) {
            ((HttpServletResponse) resp).sendRedirect(contextPath + "/login");
        } else {
            chain.doFilter(req, resp);
        }
    }
}
```

---

### 7. 📊 Admin Dashboard (admin/index.php → AdminDashboardServlet)

**AdminDashboardServlet.java:**
```java
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        
        req.setAttribute("totalProducts", productDAO.count());
        req.setAttribute("totalOrders", orderDAO.count());
        req.setAttribute("totalRevenue", orderDAO.getTotalRevenue());
        req.setAttribute("totalReviews", new ReviewDAO().count());
        
        // Dữ liệu biểu đồ 7 ngày (cho Chart.js)
        req.setAttribute("chartLabels", orderDAO.getLast7DaysLabels());
        req.setAttribute("chartData",   orderDAO.getLast7DaysRevenue());
        
        req.setAttribute("recentOrders", orderDAO.getRecent(7));
        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }
}
```

**dashboard.jsp (Chart.js data inject bằng JSTL):**
```jsp
<script>
new Chart(document.getElementById('revenueChart'), {
    type: 'line',
    data: {
        labels: [<c:forEach var="l" items="${chartLabels}" varStatus="s">
                    '${l}'<c:if test="${!s.last}">,</c:if>
                 </c:forEach>],
        datasets: [{
            data: [<c:forEach var="d" items="${chartData}" varStatus="s">
                       ${d}<c:if test="${!s.last}">,</c:if>
                   </c:forEach>],
            borderColor: '#D4AF37',
            // ... giữ nguyên config từ PHP
        }]
    }
});
</script>
```

---

### 8. 🗄️ DAO Pattern (thay mysqli_query trực tiếp)

**ProductDAO.java (mẫu):**
```java
public class ProductDAO {
    public List<Product> getHotProducts(int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_hot=1 ORDER BY product_id DESC LIMIT ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Product> getByCategory(int catId) {
        // tương tự...
    }
    
    public Product getById(int id) {
        // tương tự...
    }
    
    private Product mapRow(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setProductId(rs.getInt("product_id"));
        p.setProductName(rs.getString("product_name"));
        p.setPrice(rs.getLong("price"));
        p.setImage(rs.getString("image"));
        p.setIsHot(rs.getBoolean("is_hot"));
        // ...
        return p;
    }
}
```

---

## 📋 Mapping File PHP → Java (Full)

| File PHP gốc | Java Servlet | JSP View | Ghi chú |
|---|---|---|---|
| `index.php` | `HomeServlet.java` | `index.jsp` | 6 product lanes |
| `category.php` | `CategoryServlet.java` | `category.jsp` | Phân trang |
| `product_detail.php` | `ProductServlet.java` | `productDetail.jsp` | Variants, Reviews |
| `cart.php` | `CartServlet.java` | `cart.jsp` | Session-based cart |
| `checkout.php` | `CheckoutServlet.java` | `checkout.jsp` | COD + QR |
| `payment_qr.php` | `CheckoutServlet.java` | `paymentQr.jsp` | QR code page |
| `history.php` | `OrderHistoryServlet.java` | `history.jsp` | Lịch sử đơn |
| `login.php` | `LoginServlet.java` | `login.jsp` | Dual auth |
| `register.php` | `RegisterServlet.java` | `register.jsp` | BCrypt hash |
| `change_password.php` | `ChangePasswordServlet.java` | `changePassword.jsp` | |
| `forgot_password.php` | `ForgotPasswordServlet.java` | `forgotPassword.jsp` | |
| `includes/header.php` | *(Filter)* | `header.jsp` | JSP include |
| `includes/footer.php` | *(Filter)* | `footer.jsp` | JSP include |
| `admin/index.php` | `AdminDashboardServlet.java` | `dashboard.jsp` | Chart.js |
| `admin/products.php` | `AdminProductServlet.java` | `products.jsp` | CRUD |
| `admin/product_add.php` | `AdminProductServlet.java` | `productAdd.jsp` | |
| `admin/product_edit.php` | `AdminProductServlet.java` | `productEdit.jsp` | |
| `admin/product_variants.php` | `AdminProductServlet.java` | `productVariants.jsp` | |
| `admin/orders.php` | `AdminOrderServlet.java` | `orders.jsp` | |
| `admin/order_detail.php` | `AdminOrderServlet.java` | `orderDetail.jsp` | |
| `admin/categories.php` | `AdminCategoryServlet.java` | `categories.jsp` | |
| `admin/inventory.php` | `AdminInventoryServlet.java` | `inventory.jsp` | |
| `admin/inventory_history.php` | `AdminInventoryServlet.java` | `inventoryHistory.jsp` | |
| `admin/users.php` | `AdminUserServlet.java` | `users.jsp` | |
| `chat_ajax.php` | `ChatServlet.java` | - | AJAX endpoint |
| `ai_ajax.php` | `AiChatServlet.java` | - | AI AJAX |

---

## 🎨 Giữ Nguyên Giao Diện — Checklist

> [!IMPORTANT]
> Toàn bộ file dưới đây được **COPY NGUYÊN VẸN** sang Java project, không chỉnh sửa:

- ✅ `assets/css/nexora_luxury.css` → `src/main/webapp/assets/css/nexora_luxury.css`
- ✅ `assets/images/*` → `src/main/webapp/assets/images/*`
- ✅ Tất cả HTML structure trong header/footer
- ✅ Tất cả JavaScript (slider, AOS, AJAX cart)
- ✅ Font Awesome, AOS, Chart.js CDN links

**Chỉ thay đổi**:
- `<?php ... ?>` → `<% ... %>` hoặc JSTL tags
- `<?= $var ?>` → `${var}` (EL Expression)
- `while ($row = mysqli_fetch_assoc($r))` → `<c:forEach var="item" items="${list}">`
- `isset($_SESSION['x'])` → `${not empty sessionScope.x}`
- URL từ `product_detail.php?id=1` → `product?id=1`

---

## 🔒 Bảo Mật — Cải Tiến so với PHP

| Vấn đề PHP | Giải pháp Java |
|---|---|
| SQL Injection (mysqli_real_escape_string) | **PreparedStatement** với `?` placeholder |
| XSS (htmlspecialchars thủ công) | JSTL `<c:out>` auto-escape + EL tự escape |
| Session Security (basic) | `HttpSession` + `AdminFilter` tập trung |
| Password (password_hash tốt) | **BCrypt** (jBCrypt) — tương đương |
| CSRF (chưa có) | Có thể thêm CSRF token filter |

---

## 🛠️ Các Bước Triển Khai

```
Bước 1: Tạo Maven Project
  └── nexora-java (Maven WAR project)
  └── Cấu hình pom.xml + Tomcat plugin

Bước 2: Thiết lập Database
  └── Chạy SQL.sql hiện tại (KHÔNG thay đổi)
  └── Tạo DBUtil.java

Bước 3: Tạo Model POJOs
  └── Product, Category, Order, Customer, Review, CartItem...

Bước 4: Tạo DAO Layer
  └── ProductDAO, CategoryDAO, OrderDAO, CustomerDAO, ReviewDAO

Bước 5: Copy Assets
  └── assets/css/ và assets/images/ → webapp/assets/

Bước 6: Tạo JSP Includes
  └── header.jsp (từ header.php), footer.jsp, adminHeader.jsp

Bước 7: Tạo Servlets + JSP (theo thứ tự)
  └── HomeServlet + index.jsp
  └── LoginServlet, RegisterServlet + JSP
  └── CategoryServlet, ProductServlet + JSP
  └── CartServlet + cart.jsp
  └── CheckoutServlet + checkout.jsp
  └── Admin Servlets + JSP

Bước 8: Cấu hình Filters
  └── AuthFilter (/cart, /checkout, /history)
  └── AdminFilter (/admin/*)

Bước 9: web.xml hoặc Annotation config
  └── Servlet mappings
  └── Filter mappings
  └── Welcome file: /

Bước 10: Test & Deploy trên Tomcat
```

---

## 🎯 Điểm Khác Biệt Kỹ Thuật Quan Trọng

### URL Mapping
```
PHP:  /index.php, /category.php?id=1, /product_detail.php?id=5
Java: /,           /category?id=1,    /product?id=5
```

### JSP Include (thay PHP include)
```jsp
<!-- Thay: include 'includes/header.php' -->
<%@ include file="/includes/header.jsp" %>
<!-- Hoặc dynamic: -->
<jsp:include page="/includes/header.jsp"/>
```

### Error Handling (tốt hơn PHP)
```java
// Tập trung trong web.xml
<error-page>
    <error-code>404</error-code>
    <location>/views/error/404.jsp</location>
</error-page>
```

### Encoding UTF-8 (quan trọng cho Tiếng Việt)
```java
// Trong mỗi Servlet hoặc Filter
req.setCharacterEncoding("UTF-8");
resp.setCharacterEncoding("UTF-8");
resp.setContentType("text/html; charset=UTF-8");
```

---

## ❓ Câu Hỏi Mở / Quyết Định Cần Xác Nhận

> [!IMPORTANT]
> **Chat System**: `chat_ajax.php` và `ai_ajax.php` dùng AJAX polling. Trong Java sẽ chuyển thành Servlet endpoint AJAX. Bạn có muốn giữ polling hay nâng lên WebSocket?

> [!NOTE]
> **AI Integration**: `ai_ajax.php` gọi Gemini API. Trong Java sẽ dùng `HttpURLConnection` hoặc thư viện HTTP client. Bạn có muốn tích hợp lại không?

> [!NOTE]
> **Password Admin**: Admin hiện dùng hash `$2y$10$...` của PHP (BCrypt). jBCrypt có thể verify hash này tương thích hoàn toàn — không cần reset mật khẩu.

---

*Tài liệu được tạo bởi Antigravity AI | Nexora Java Migration Plan v1.0*
