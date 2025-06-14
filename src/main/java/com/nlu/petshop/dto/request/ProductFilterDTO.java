package com.nlu.petshop.dto.request;

import lombok.Data;

@Data
public class ProductFilterDTO {
    private String keyword;
    private Integer categoryId;
    private Double minPrice;
    private Double maxPrice;
}
