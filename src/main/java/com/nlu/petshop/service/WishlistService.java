package com.nlu.petshop.service;

import com.nlu.petshop.dto.request.AddToWishlistRequestDTO;
import com.nlu.petshop.dto.response.WishlistDTO;

public interface WishlistService {
    WishlistDTO getWishlistByUserId(Long userId);
    WishlistDTO addItemToWishlist(Long userId, AddToWishlistRequestDTO requestDTO);
    void removeItemFromWishlist(Long userId, Integer productId);
}