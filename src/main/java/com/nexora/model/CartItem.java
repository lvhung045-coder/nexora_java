package com.nexora.model;

import java.io.Serializable;

/** Luu tru item trong gio hang (thay $_SESSION["cart"] trong PHP) */
public class CartItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private int productId;
    private int variantId;
    private String name;      // productName + variant info
    private long price;
    private String image;
    private int qty;

    public CartItem() {}

    public CartItem(int productId, int variantId, String name, long price, String image, int qty) {
        this.productId = productId;
        this.variantId = variantId;
        this.name = name;
        this.price = price;
        this.image = image;
        this.qty = qty;
    }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getVariantId() { return variantId; }
    public void setVariantId(int variantId) { this.variantId = variantId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public long getPrice() { return price; }
    public void setPrice(long price) { this.price = price; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public int getQty() { return qty; }
    public void setQty(int qty) { this.qty = qty; }
    public long getSubTốtal() { return price * qty; }
    /** Key duy nhat cho cart - giong PHP: productId_variantId */
    public static String buildKey(int productId, int variantId) {
        return productId + "_" + variantId;
    }
}