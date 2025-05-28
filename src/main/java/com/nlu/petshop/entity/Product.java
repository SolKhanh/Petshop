package com.nlu.petshop.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name", nullable = false, length = 255)
    private String name;

    @Column(name = "price", nullable = false)
    private Double price;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "detail", columnDefinition = "LONGTEXT")
    private String detail;

    @Column(name = "quantity")
    private Integer quantity;

    @Column(name = "image", length = 500)
    private String image;

    @Column(name = "sale_price")
    private Double salePrice;

    @Column(name = "status", length = 50)
    private String status;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at", nullable = false, updatable = false)
    private Date createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at", nullable = false)
    private Date updatedAt;

    @Column(length = 255)
    private String giong;

    @Column(length = 255)
    private String mausac;

    @Column(length = 255)
    private String cannang;

    @Column(length = 40)
    private String size;

    @Column(name = "view_count")
    private Integer viewCount;

    @Column
    private Integer warranty;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    @PrePersist
    protected void onCreate() {
        createdAt = new Date();
        updatedAt = new Date();
        if (status == null) {
            status = "active";
        }
        if (viewCount == null) {
            viewCount = 0;
        }
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = new Date();
    }
}