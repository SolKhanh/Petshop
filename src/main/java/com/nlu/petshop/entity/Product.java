package com.nlu.petshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "products")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {

    @Id
    @Column(name = "product_id")
    private String productId;

    private String productName;
    private int status;
    private String image;
    private int price;

    @Column(name = "promotional_price")
    private int promotionalPrice;

    private String quantity;
    private int warranty;
    private int promotional;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(columnDefinition = "TEXT")
    private String dital;

    private String createBy;

    private LocalDateTime createDate;
    private String updateBy;
    private LocalDateTime updateDate;

    private String giong;
    private String mausac;
    private String cannang;

//    @OneToOne(cascade = CascadeType.ALL)
//    @JoinColumn(name = "sale_id", referencedColumnName = "id")
//    private ProductSale sales;

    private int quantityCart;
    private int quantityWishlist;

    private String cate_id;
    private int viewCount;
    private String size;

//    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
//    private List<ImageProduct> images;
}
