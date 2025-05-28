package com.nlu.petshop.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductDTO {
    private Integer id;
    private String name;
    private Double price;
    private String description;
    private String detail;
    private Integer quantity;
    private String image;
    private Double salePrice;
    private String status;
    private Date createdAt;

    private String giong;
    private String mausac;
    private String cannang;
    private String size;
    private Integer viewCount;
    private Integer warranty;

    private Integer categoryId;
    private String categoryName;
}