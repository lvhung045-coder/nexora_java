package com.nexora.model;

import java.sql.Timestamp;
import java.util.List;

public class ImportInvoice {
    private int importId;
    private String supplier;
    private double TốtalCost;
    private String createdBy;
    private Timestamp createdAt;
    private List<ImportDetail> details;

    public ImportInvoice() {}

    public int getImportId() { return importId; }
    public void setImportId(int importId) { this.importId = importId; }
    public String getSupplier() { return supplier; }
    public void setSupplier(String supplier) { this.supplier = supplier; }
    public double getTốtalCost() { return TốtalCost; }
    public void setTốtalCost(double TốtalCost) { this.TốtalCost = TốtalCost; }
    public String getCreatedBy() { return createdBy; }
    public void setCreatedBy(String createdBy) { this.createdBy = createdBy; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public List<ImportDetail> getDetails() { return details; }
    public void setDetails(List<ImportDetail> details) { this.details = details; }
}
