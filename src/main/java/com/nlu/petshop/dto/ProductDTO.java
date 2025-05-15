package com.nlu.petshop.dto;

import lombok.*;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductDTO {
    private String productId;
    private String productName;
    private int status;
    private String image;
    private int price;
    private int promotionalPrice;
    private String quantity;
    private int warranty;
    private int promotional;
    private String description;
    private String dital;
    private String createBy;
    private LocalDateTime createDate;
    private String updateBy;
    private LocalDateTime updateDate;
    private String giong;
    private String mausac;
    private String cannang;
//    private ProductSale sales;
    private int quantityCart;
    private int quantityWishlist;
    private String cate_id;
    private int viewCount;
    private String size;
//    private List<ImageProduct> images;
}
