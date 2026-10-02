package com.nexora.model;

import java.sql.Timestamp;

/** Model: products table */
public class Product {
    private int productId;
    private int catId;
    private String catName;
    private String productName;
    private long price;
    private int stock;
    private String image;
    private String productDesc;
    private boolean isHot;
    private String material;
    private String style;
    private String origin;
    private Timestamp createdAt;

    public Product() {}

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getCatId() { return catId; }
    public void setCatId(int catId) { this.catId = catId; }
    public String getCatName() { return catName; }
    public void setCatName(String catName) { this.catName = catName; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public long getPrice() { return price; }
    public void setPrice(long price) { this.price = price; }
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public String getProductDesc() { return productDesc; }
    public void setProductDesc(String productDesc) { this.productDesc = productDesc; }
    public boolean isHot() { return isHot; }
    public void setHot(boolean hot) { isHot = hot; }
    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }
    public String getStyle() { return style; }
    public void setStyle(String style) { this.style = style; }
    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
