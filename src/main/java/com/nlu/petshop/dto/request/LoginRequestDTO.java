package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class LoginRequestDTO {
    @NotBlank(message = "{NotBlank.username}")
    private String username;

    @NotBlank(message = "{NotBlank.password}")
    private String password;

}