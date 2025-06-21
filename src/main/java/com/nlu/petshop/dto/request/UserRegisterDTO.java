package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRegisterDTO {
    @NotBlank(message = "{NotBlank.username}")
    @Size(min = 3, max = 50, message = "{Size.username}")
    private String username;

    @NotBlank(message = "{NotBlank.password}")
    @Size(min = 6, max = 100, message = "{Size.password}")
    private String password;

    @NotBlank(message = "{NotBlank.email}")
    @Email(message = "{Email.invalid}")
    @Size(max = 100, message = "{Size.email}")
    private String email;

    @NotBlank(message = "{NotBlank.name}")
    @Size(max = 100, message = "{Size.name}")
    private String name;

    @Pattern(regexp = "^(\\+84|0)\\d{9,10}$", message = "{Pattern.phone}")
    private String phone;
    private String address;
    private String avatar;
}
