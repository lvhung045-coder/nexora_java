package com.nexora.model;

/** Model: product_variants table */
public class ProductVariant {
    private int variantId;
    private int productId;
    private String size;
    private String color;
    private long price;
    private int stock;

    public ProductVariant() {}

    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public long getPrice() { return price; }
    public void setPrice(long price) { this.price = price; }
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
    public String getLabel() { return "Size " + size + " - " + color; }
}