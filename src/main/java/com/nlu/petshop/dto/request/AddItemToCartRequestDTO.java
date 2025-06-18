package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AddItemToCartRequestDTO {
    @NotNull(message = "{NotNull.productId}")
    private Integer productId;

    @NotNull(message = "{NotNull.quantity}")
    @Min(value = 1, message = "{Min.quantity}")
    private Integer quantity;
}