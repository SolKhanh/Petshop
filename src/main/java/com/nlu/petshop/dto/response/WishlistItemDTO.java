package com.nlu.petshop.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WishlistItemDTO {
    private Integer productId;
    private String productName;
    private Double price;
    private String productImage;
    private String productStatus;
    private Date addedAt;
}