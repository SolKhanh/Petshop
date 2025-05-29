package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.AddItemToCartRequestDTO;
import com.nlu.petshop.dto.response.CartDTO;
import com.nlu.petshop.dto.request.UpdateCartItemRequestDTO;
import com.nlu.petshop.entity.UserAccount;
import com.nlu.petshop.service.AuthService;
import com.nlu.petshop.service.CartService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

    // PHƯƠNG THỨC TẠM THỜI ĐỂ LẤY USER ID - CẦN THAY THẾ BẰNG SPRING SECURITY SAU NÀY
    private Long getCurrentUserId() {
         return 1L; //id user1
    }

    @GetMapping
    public ResponseEntity<?> getMyCart() {
        try {
            Long userId = getCurrentUserId();
            CartDTO cart = cartService.getCartByUserId(userId);
            return ResponseEntity.ok(cart);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Lỗi khi lấy giỏ hàng.");
        }
    }

    @PostMapping("/items")
    public ResponseEntity<?> addItemToMyCart(@Valid @RequestBody AddItemToCartRequestDTO requestDTO) {
        try {
            Long userId = getCurrentUserId();
            CartDTO cart = cartService.addItemToCart(userId, requestDTO);
            return ResponseEntity.ok(cart);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage()); // Hoặc INTERNAL_SERVER_ERROR tùy lỗi
        }
    }

    @PutMapping("/items/{productId}")
    public ResponseEntity<?> updateMyCartItem(@PathVariable Integer productId,
                                              @Valid @RequestBody UpdateCartItemRequestDTO requestDTO) {
        try {
            Long userId = getCurrentUserId();
            CartDTO cart = cartService.updateCartItemQuantity(userId, productId, requestDTO);
            return ResponseEntity.ok(cart);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @DeleteMapping("/items/{productId}")
    public ResponseEntity<?> removeItemFromMyCart(@PathVariable Integer productId) {
        try {
            Long userId = getCurrentUserId();
            CartDTO cart = cartService.removeItemFromCart(userId, productId);
            return ResponseEntity.ok(cart);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        }
    }

    @DeleteMapping("/clear")
    public ResponseEntity<?> clearMyCart() {
        try {
            Long userId = getCurrentUserId();
            cartService.clearCart(userId);
            return ResponseEntity.ok("Giỏ hàng đã được xóa.");
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Lỗi khi xóa giỏ hàng.");
        }
    }
}