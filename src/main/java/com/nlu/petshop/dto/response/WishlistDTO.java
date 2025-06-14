package com.nlu.petshop.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class WishlistDTO {
    private Long id; // Wishlist ID
    private Long userId;
    private List<WishlistItemDTO> items;
    private int itemCount;
}