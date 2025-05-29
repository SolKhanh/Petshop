package com.nlu.petshop.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailDTO {
    private Integer productId;
    private String productName;
    private Integer quantity;
    private Double price;
    private Double subTotal; // quantity * price
}