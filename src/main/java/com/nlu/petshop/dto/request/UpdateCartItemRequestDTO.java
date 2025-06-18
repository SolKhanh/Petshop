package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class UpdateCartItemRequestDTO {
    @NotNull(message = "{NotNull.quantity}")
    @Min(value = 0, message = "{Min.quantity.zero}")
    private Integer quantity;
}