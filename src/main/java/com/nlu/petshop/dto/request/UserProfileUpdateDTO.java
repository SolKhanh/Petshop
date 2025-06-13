package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UserProfileUpdateDTO {
    @Size(max = 100, message = "{error.size.name}")
    private String name;

    @Email(message = "{error.email.invalid}")
    @Size(max = 100, message = "{error.size.email}")
    private String email;

    @Pattern(regexp = "^(\\+84|0)\\d{9,10}$", message = "{error.phone.invalid}")
    private String phone;

    @Size(max = 255, message = "{error.size.address}")
    private String address;
    private String avt;
}