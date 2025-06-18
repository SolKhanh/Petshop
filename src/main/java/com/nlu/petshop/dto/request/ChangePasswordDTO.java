package com.nlu.petshop.dto.request;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class ChangePasswordDTO {
    @NotBlank(message = "{NotBlank.oldPassword}")
    private String oldPassword;

    @NotBlank(message = "{NotBlank.newPassword}")
    @Size(min = 6, max = 100, message = "{Size.password}")
    private String newPassword;

    @NotBlank(message = "{NotBlank.confirmNewPassword}")
    private String confirmNewPassword;
}
