package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class CreateReviewRequestDTO {

    @NotNull(message = "Đánh giá sao không được để trống.")
    @Min(value = 1, message = "Đánh giá sao phải ít nhất là 1.")
    @Max(value = 5, message = "Đánh giá sao không được nhiều hơn 5.")
    private Integer rating;

    @Size(max = 1000, message = "Bình luận không được vượt quá 1000 ký tự.")
    private String comment;
}