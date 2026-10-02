package com.nexora.model;
import java.sql.Timestamp;
public class Post {
    private int postId;
    private String title;
    private String content;
    private String image;
    private Timestamp createdAt;
    private String status;

    public Post() {}
    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
