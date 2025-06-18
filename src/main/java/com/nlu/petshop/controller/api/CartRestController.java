package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.AddItemToCartRequestDTO;
import com.nlu.petshop.dto.response.CartDTO;
import com.nlu.petshop.dto.request.UpdateCartItemRequestDTO;
import com.nlu.petshop.service.AuthService;
import com.nlu.petshop.service.CartService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cart")
public class CartRestController {

    private final CartService cartService;
    private final AuthService authService;

    @Autowired
    public CartRestController(CartService cartService, AuthService authService) {
        this.cartService = cartService;
        this.authService = authService;
    }

    @GetMapping
    public ResponseEntity<CartDTO> getMyCart() {
        Long userId = authService.getCurrentUser().getId();
        CartDTO cart = cartService.getCartByUserId(userId);
        return ResponseEntity.ok(cart);
    }

    @PostMapping("/items")
    public ResponseEntity<CartDTO> addItemToMyCart(@Valid @RequestBody AddItemToCartRequestDTO requestDTO) {
        Long userId = authService.getCurrentUser().getId();
        CartDTO cart = cartService.addItemToCart(userId, requestDTO);
        return ResponseEntity.ok(cart);
    }

    @PutMapping("/items/{productId}")
    public ResponseEntity<CartDTO> updateMyCartItem(@PathVariable Integer productId,
                                                    @Valid @RequestBody UpdateCartItemRequestDTO requestDTO) {
        Long userId = authService.getCurrentUser().getId();
        CartDTO cart = cartService.updateCartItemQuantity(userId, productId, requestDTO);
        return ResponseEntity.ok(cart);
    }

    @DeleteMapping("/items/{productId}")
    public ResponseEntity<CartDTO> removeItemFromMyCart(@PathVariable Integer productId) {
        Long userId = authService.getCurrentUser().getId();
        CartDTO cart = cartService.removeItemFromCart(userId, productId);
        return ResponseEntity.ok(cart);
    }

    @DeleteMapping("/clear")
    public ResponseEntity<String> clearMyCart() {
        Long userId = authService.getCurrentUser().getId();
        cartService.clearCart(userId);
        return ResponseEntity.ok("Giỏ hàng đã được xóa.");
    }
}
