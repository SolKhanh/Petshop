package com.nlu.petshop.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartItemDTO {
    private Integer productId;
    private String productName;
    private Integer quantity;
    private Double priceAtAddition;
    private Double currentPrice;
    private String productImage;
    private Double subTotal; // quantity * priceAtAddition
}