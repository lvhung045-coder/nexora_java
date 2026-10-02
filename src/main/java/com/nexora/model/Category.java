package com.nexora.model;

/** Model: categories table */
public class Category {
    private int catId;
    private String catName;
    private String catIcon;
    private int sortOrder;

    public Category() {}

    public int getCatId() { return catId; }
    public void setCatId(int catId) { this.catId = catId; }
    public String getCatName() { return catName; }
    public void setCatName(String catName) { this.catName = catName; }
    public String getCatIcon() { return catIcon; }
    public void setCatIcon(String catIcon) { this.catIcon = catIcon; }
    public int getSortOrder() { return sortOrder; }
    public void setSortOrder(int sortOrder) { this.sortOrder = sortOrder; }
}