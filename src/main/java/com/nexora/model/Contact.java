package com.nexora.model;
import java.sql.Timestamp;
public class Contact {
    private int contactId;
    private String fullname;
    private String email;
    private String message;
    private Timestamp createdAt;
    private String status;

    public Contact() {}
    public int getContactId() { return contactId; }
    public void setContactId(int contactId) { this.contactId = contactId; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
