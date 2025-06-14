package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.request.CreateReviewRequestDTO;
import com.nlu.petshop.dto.response.ProductReviewDTO;
import com.nlu.petshop.service.AuthService;
import com.nlu.petshop.service.ProductReviewService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/products/{productId}/reviews")
public class ProductReviewController {

    @Autowired
    private ProductReviewService reviewService;

    @Autowired
    private AuthService authService;

    // public
    @GetMapping
    public ResponseEntity<Page<ProductReviewDTO>> getProductReviews(
            @PathVariable Integer productId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size,
            @RequestParam(defaultValue = "reviewDate,desc") String[] sort) {

        String sortField = sort[0];
        Sort.Direction direction = sort.length > 1 && sort[1].equalsIgnoreCase("asc") ? Sort.Direction.ASC : Sort.Direction.DESC;
        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortField));

        Page<ProductReviewDTO> reviewPage = reviewService.getReviewsByProductId(productId, pageable);
        return ResponseEntity.ok(reviewPage);
    }

    // cần xácthực
    @PostMapping
    public ResponseEntity<ProductReviewDTO> createProductReview(
            @PathVariable Integer productId,
            @Valid @RequestBody CreateReviewRequestDTO requestDTO) {

        Long userId = authService.getCurrentUser().getId();
        ProductReviewDTO createdReview = reviewService.createReview(userId, productId, requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdReview);
    }
}
