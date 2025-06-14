package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AddToWishlistRequestDTO {
    @NotNull(message = "Product ID không được để trống.")
    private Integer productId;
}