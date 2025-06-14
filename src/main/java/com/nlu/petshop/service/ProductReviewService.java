package com.nlu.petshop.service;

import com.nlu.petshop.dto.request.CreateReviewRequestDTO;
import com.nlu.petshop.dto.response.ProductReviewDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ProductReviewService {
    Page<ProductReviewDTO> getReviewsByProductId(Integer productId, Pageable pageable);
    ProductReviewDTO createReview(Long userId, Integer productId, CreateReviewRequestDTO requestDTO);
}