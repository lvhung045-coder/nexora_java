package com.nexora.model;

import java.sql.Timestamp;

/** Model: quanlydonhang table */
public class Order {
    private int orderId;
    private int userId;
    private String fullname;
    private String phone;
    private String address;
    private long TốtalMoney;
    private String note;
    private String paymentMethod;
    private int status; // 0=Cho, 1=Gui hang, 2=Đang giao, 3=Thành công, 4=Huy
    private Timestamp createdAt;

    public Order() {}

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public long getTốtalMoney() { return TốtalMoney; }
    public void setTốtalMoney(long TốtalMoney) { this.TốtalMoney = TốtalMoney; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getStatusLabel() {
        switch (status) {
            case 0: return "Chờ xử lý";
            case 1: return "Đã gửi hàng";
            case 2: return "Đang giao";
            case 3: return "Thành công";
            case 4: return "Đã hủy";
            default: return "Không rõ";
        }
    }

    public String getStatusClass() {
        switch (status) {
            case 0: return "badge-wait";
            case 1: return "badge-sent";
            case 2: return "badge-shipping";
            case 3: return "badge-done";
            case 4: return "badge-cancel";
            default: return "badge-cancel";
        }
    }
}