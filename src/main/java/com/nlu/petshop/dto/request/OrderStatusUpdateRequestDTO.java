package com.nlu.petshop.dto.request;

import com.nlu.petshop.model.OrderStatus;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class OrderStatusUpdateRequestDTO {
    @NotBlank(message = "Trạng thái mới không được để trống.")
    private OrderStatus newStatus;
}
