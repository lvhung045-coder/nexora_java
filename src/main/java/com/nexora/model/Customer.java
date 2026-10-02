package com.nexora.model;

import java.sql.Timestamp;

/** Model: nguoidung table (Khách hàng) */
public class Customer {
    private int userId;
    private String fullname;
    private String email;
    private String password;
    private String phone;
    private String address;
    private Timestamp createdAt;

    public Customer() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getFirstName() {
        if (fullname == null) return "";
        String[] parts = fullname.trim().split("\\s+");
        return parts[parts.length - 1];
    }
}