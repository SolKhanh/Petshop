package com.nlu.petshop.service;

import com.nlu.petshop.dto.request.AddItemToCartRequestDTO;
import com.nlu.petshop.dto.request.UpdateCartItemRequestDTO;
import com.nlu.petshop.dto.response.CartDTO;

public interface CartService {
    CartDTO getCartByUserId(Long userId);

    CartDTO addItemToCart(Long userId, AddItemToCartRequestDTO requestDTO);

    CartDTO updateCartItemQuantity(Long userId, Integer productId, UpdateCartItemRequestDTO requestDTO);

    CartDTO removeItemFromCart(Long userId, Integer productId);

    void clearCart(Long userId);
}
