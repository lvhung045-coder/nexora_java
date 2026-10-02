# Tomcat Deployment & Project Finalization

Tôi đã tự động tải, cấu hình và khởi chạy Apache Tomcat để deploy dự án web Nexora. Dưới đây là thông tin chi tiết:

## Chi tiết triển khai
- **Phiên bản Tomcat**: Apache Tomcat 10.1.30 (Hỗ trợ Jakarta EE 10 / Servlet 6.0).
- **Thư mục cài đặt**: C:\apache-tomcat-10.1.30
- **Thư mục deploy**: C:\apache-tomcat-10.1.30\webapps\ROOT (ứng dụng Nexora được deploy trực tiếp tại trang chủ /).

## Cách truy cập
- **Trang chủ Khách hàng**: Truy cập vào [http://localhost:8080](http://localhost:8080) bằng trình duyệt web.
- **Trang Admin**: Truy cập vào [http://localhost:8080/admin/dashboard](http://localhost:8080/admin/dashboard).

## Cách quản lý Tomcat
Tomcat hiện đang được chạy ngầm bởi hệ thống. Tuy nhiên, nếu bạn muốn tự quản lý Tomcat (tắt/bật) sau này:
1. **Khởi động Server**: Chạy file C:\apache-tomcat-10.1.30\bin\startup.bat
2. **Dừng Server**: Chạy file C:\apache-tomcat-10.1.30\bin\shutdown.bat

## Cách Build và Chạy dự án (Bằng Lệnh PowerShell)
Mở Terminal / PowerShell tại thư mục gốc của dự án (C:\Users\DELL\Downloads\nexora-java) và chạy toàn bộ khối lệnh sau để tự động Build và Deploy:

`powershell
# 1. Biên dịch và đóng gói bằng Maven
mvn clean package

# 2. Triển khai bản mới vào Tomcat
Copy-Item -Path ".\target\nexora.war" -Destination "C:\apache-tomcat-10.1.30\webapps\ROOT.war" -Force

# 3. Khởi động Tomcat Server
$javaPath = (Get-Command java).Source
$env:JAVA_HOME = (Get-Item $javaPath).Directory.Parent.FullName
$env:CATALINA_HOME = "C:\apache-tomcat-10.1.30"
C:\apache-tomcat-10.1.30\bin\catalina.bat run
`

## Cách Build và Chạy dự án (Trực tiếp trên VS Code bằng tiện ích)
> [!IMPORTANT]
> **Bắt buộc:** Luôn phải bật **MySQL** trong phần mềm XAMPP trước khi chạy web.

Mỗi khi bạn mở lại phần mềm VS Code (hoặc vừa sửa code xong) và muốn chạy thử để xem kết quả, hãy làm theo quy trình 4 bước sau:

**Bước 1: Build lại Code**
1. Nhìn thanh menu ngoài cùng bên trái, bấm vào biểu tượng **M** (Maven).
2. Xổ thư mục 
exora-java > Lifecycle.
3. Bấm nút **Play (▶)** ở bên phải chữ package và chờ vài giây.

**Bước 2: Cập nhật file vào Server**
1. Mở lại thanh **Explorer** (biểu tượng 2 tờ giấy trên cùng bên trái).
2. Mở thư mục 	arget > Click chuột phải vào file **
exora.war**.
3. Chọn **Run on Server** > Chọn máy chủ **Tomcat 10.x** *(Chọn "No" nếu có bảng hỏi Edit tham số)*.

**Bước 3: Khởi động Server**
1. Mở mục **SERVERS** (dưới cùng thanh Explorer bên trái).
2. Click chuột phải vào dòng Tomcat 10.x [Stopped] > Chọn **Start Server**.

**Bước 4: Xem trang web**
- Mở trình duyệt web và truy cập: [http://localhost:8080/nexora](http://localhost:8080/nexora)
*(Lưu ý: Để tắt Server khi không dùng đến, bạn quay lại mục SERVERS, chuột phải vào Tomcat và chọn **Stop Server**).*

> [!TIP]
> Bạn có thể đăng nhập bằng tài khoản admin mặc định (như trong CSDL 
exora_db) để trải nghiệm giao diện Admin, hoặc sử dụng các tính năng Mua hàng, Giỏ hàng, Đặt hàng bên phía Khách hàng.

Dự án chuyển đổi từ PHP sang Java MVC (Servlet/JSP) giữ nguyên giao diện hiện tại đã hoàn tất 100%. Bạn có cần hỗ trợ thêm về tính năng nào khác không?
