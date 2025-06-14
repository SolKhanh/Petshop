package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.AddToWishlistRequestDTO;
import com.nlu.petshop.dto.response.WishlistDTO;
import com.nlu.petshop.service.AuthService;
import com.nlu.petshop.service.WishlistService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/wishlist")
public class WishlistRestController {

    @Autowired
    private WishlistService wishlistService;

    @Autowired
    private AuthService authService;

    @GetMapping
    public ResponseEntity<WishlistDTO> getMyWishlist() {
        Long userId = authService.getCurrentUser().getId();
        WishlistDTO wishlist = wishlistService.getWishlistByUserId(userId);
        return ResponseEntity.ok(wishlist);
    }

    @PostMapping("/items")
    public ResponseEntity<WishlistDTO> addItemToMyWishlist(@Valid @RequestBody AddToWishlistRequestDTO requestDTO) {
        Long userId = authService.getCurrentUser().getId();
        WishlistDTO wishlist = wishlistService.addItemToWishlist(userId, requestDTO);
        return ResponseEntity.ok(wishlist);
    }

    @DeleteMapping("/items/{productId}")
    public ResponseEntity<Void> removeItemFromMyWishlist(@PathVariable Integer productId) {
        Long userId = authService.getCurrentUser().getId();
        wishlistService.removeItemFromWishlist(userId, productId);
        return ResponseEntity.noContent().build(); // HTTP 204 No Content
    }
}
