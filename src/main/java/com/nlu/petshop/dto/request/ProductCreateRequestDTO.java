package com.nlu.petshop.dto.request;

import com.nlu.petshop.model.ProductStatus;
import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class ProductCreateRequestDTO {
    @NotBlank(message = "{NotBlank.productName}")
    @Size(min = 3, max = 255, message = "{Size.productName}")
    private String name;

    @NotNull(message = "{NotNull.price}")
    @Positive(message = "{Positive.price}")
    private Double price;

    @Size(max = 500, message = "{Size.description}")
    private String description;

    @NotNull(message = "{NotNull.detail}")
    private String detail;

    @NotNull(message = "{NotNull.quantity}")
    @Min(value = 0, message = "{Min.quantity.nonNegative}")
    private Integer quantity;

    @NotBlank(message = "{NotBlank.image}")
    private String image;

    private Double salePrice;

    @NotNull(message = "{NotNull.productStatus}")
    private ProductStatus status;

    private String giong;
    private String mausac;
    private String cannang;
    private String size;
    private Integer warranty;

    @NotNull(message = "{NotNull.categoryId}")
    private Integer categoryId;
}