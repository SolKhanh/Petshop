package com.nlu.petshop.dto.request;

import com.nlu.petshop.model.OrderStatus;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class OrderStatusUpdateRequestDTO {
    @NotNull(message = "{NotNull.orderStatus}")
    private OrderStatus newStatus;
}