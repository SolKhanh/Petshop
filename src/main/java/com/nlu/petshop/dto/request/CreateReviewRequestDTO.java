package com.nlu.petshop.dto.request;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class CreateReviewRequestDTO {
    @NotNull(message = "{NotNull.rating}")
    @Min(value = 1, message = "{Min.rating}")
    @Max(value = 5, message = "{Max.rating}")
    private Integer rating;

    @Size(max = 1000, message = "{Size.comment}")
    private String comment;
}