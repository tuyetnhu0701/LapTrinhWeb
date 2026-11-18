package vn.iotstar.model;

import java.io.Serializable;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name = "[Videos]")
@NamedQuery(name = "Video.findAll", query = "SELECT v FROM Video v")
public class Video implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "videoId")
    private int videoId;

    @Column(name = "title", columnDefinition = "nvarchar(255)")
    private String title;

    @Column(name = "poster", columnDefinition = "varchar(255)")
    private String poster;

    @Column(name = "videoUrl", columnDefinition = "varchar(255)")
    private String videoUrl;

    @Column(name = "views")
    private int views = 0;

    @Column(name = "description", columnDefinition = "nvarchar(MAX)")
    private String description;

    @Column(name = "active")
    private boolean active = true;

    // ----- CỘT NGÀY ĐĂNG VỪA THÊM -----
    @Column(name = "PostDate")
    private Date postDate = new Date();

    // Thiết lập quan hệ N - 1 với bảng User
    @ManyToOne
    @JoinColumn(name = "userid", nullable = false)
    private User user;

    public Video() {
    }

    public Video(String title, String poster, String videoUrl, int views, String description, boolean active, User user) {
        this.title = title;
        this.poster = poster;
        this.videoUrl = videoUrl;
        this.views = views;
        this.description = description;
        this.active = active;
        this.user = user;
    }

    // Getter và Setter
    public int getVideoId() { return videoId; }
    public void setVideoId(int videoId) { this.videoId = videoId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }

    public String getVideoUrl() { return videoUrl; }
    public void setVideoUrl(String videoUrl) { this.videoUrl = videoUrl; }

    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    // ----- GETTER VÀ SETTER CHO NGÀY ĐĂNG -----
    public Date getPostDate() { return postDate; }
    public void setPostDate(Date postDate) { this.postDate = postDate; }
}