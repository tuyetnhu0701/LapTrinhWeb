package vn.iotstar.model;

import java.io.Serializable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name = "Category")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int id;

    @Column(name = "cate_name", columnDefinition = "nvarchar(255) not null")
    private String name;

    @Column(name = "icons", columnDefinition = "nvarchar(255) null")
    private String icon;

    public Category() {}

    // Getters / Setters chuẩn đang dùng trong project
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }

    // Các hàm Alias 
    public int getCateid() { return id; }
    public void setCateid(int cateid) { this.id = cateid; }
    public int getCategoryId() { return id; }
    public void setCategoryId(int categoryId) { this.id = categoryId; }
    public String getCatename() { return name; }
    public void setCatename(String catename) { this.name = catename; }
    public String getCategoryname() { return name; }
    public void setCategoryname(String categoryname) { this.name = categoryname; }
    public String getImages() { return icon; }
    public void setImages(String images) { this.icon = images; }
}