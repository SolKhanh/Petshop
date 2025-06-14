package com.nlu.petshop.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductReviewDTO {
    private Long id;
    private int rating;
    private String comment;
    private Date reviewDate;
    private String authorName;
    private String authorAvatar;
}