package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class CreateOrderRequestDTO {
    @NotBlank(message = "{NotBlank.customerName}")
    @Size(max = 100, message = "{Size.customerName}")
    private String customerName;

    @NotBlank(message = "{NotBlank.shippingAddress}")
    @Size(max = 255, message = "{Size.shippingAddress}")
    private String shippingAddress;

    @NotBlank(message = "{NotBlank.phone}")
    @Pattern(regexp = "^(\\+84|0)\\d{9,10}$", message = "{Pattern.phone}")
    private String phone;

    @NotBlank(message = "{NotBlank.email}")
    @Email(message = "{Email.invalid}")
    @Size(max = 100, message = "{Size.email}")
    private String email;

    @Size(max = 500, message = "{Size.note}")
    private String note;
}