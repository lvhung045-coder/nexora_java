package com.nexora.model;

import java.sql.Timestamp;

/** Model: danhgia table */
public class Review {
    private int id;
    private int productId;
    private int userId;
    private int star;
    private String content;
    private Timestamp createdAt;
    private String fullname; // JOIN tu nguoidung

    public Review() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getStar() { return star; }
    public void setStar(int star) { this.star = star; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
}