package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UserProfileUpdateDTO {
    @Size(max = 100, message = "{Size.name}")
    private String name;

    @Email(message = "{Email.invalid}")
    @Size(max = 100, message = "{Size.email}")
    private String email;

    @Pattern(regexp = "^(\\+84|0)\\d{9,10}$", message = "{Pattern.phone}")
    private String phone;

    @Size(max = 255, message = "{Size.address}")
    private String address;
    private String avt;
}