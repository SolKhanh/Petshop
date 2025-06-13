package com.nlu.petshop.dto.request;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class ChangePasswordDTO {
    @NotBlank(message = "{error.password.old.notblank}")
    private String oldPassword;

    @NotBlank(message = "{error.password.new.notblank}")
    @Size(min = 6, max = 100, message = "{error.password.new.size}")
    private String newPassword;

    @NotBlank(message = "{error.password.confirm.notblank}")
    private String confirmNewPassword;
}
