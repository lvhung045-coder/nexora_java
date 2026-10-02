package com.nexora.model;

/** Model: chitietdonhang table */
public class OrderDetail {
    private int id;
    private int orderId;
    private int productId;
    private int variantId;
    private String productName;
    private long price;
    private int quantity;

    public OrderDetail() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public long getPrice() { return price; }
    public void setPrice(long price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public long getSubTốtal() { return price * quantity; }
}