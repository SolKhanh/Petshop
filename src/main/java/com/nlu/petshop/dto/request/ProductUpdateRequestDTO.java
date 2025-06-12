package com.nlu.petshop.dto.request;

import com.nlu.petshop.model.ProductStatus;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class ProductUpdateRequestDTO {

    @Size(min = 3, max = 255, message = "Tên sản phẩm phải từ 3 đến 255 ký tự")
    private String name;

    @Positive(message = "Giá sản phẩm phải là số dương")
    private Double price;

    @Size(max = 500, message = "Mô tả ngắn không quá 500 ký tự")
    private String description;

    private String detail;

    @Min(value = 0, message = "Số lượng không thể âm")
    private Integer quantity;

    private String image;
    private Double salePrice;
    private ProductStatus status;
    private String giong;
    private String mausac;
    private String cannang;
    private String size;
    private Integer warranty;
    private Integer categoryId;
}