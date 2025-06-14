package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.request.CreateReviewRequestDTO;
import com.nlu.petshop.dto.response.ProductReviewDTO;
import com.nlu.petshop.entity.*;
import com.nlu.petshop.exception.ProductNotFoundException;
import com.nlu.petshop.repository.*;
import com.nlu.petshop.service.ProductReviewService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductReviewServiceImpl implements ProductReviewService {

    @Autowired private ProductReviewRepository reviewRepository;
    @Autowired private UserAccountRepository userAccountRepository;
    @Autowired private ProductRepository productRepository;
    @Autowired private OrderRepository orderRepository;

    private ProductReviewDTO convertToDTO(ProductReview review) {
        InforUser inforUser = review.getUser().getInforUser();
        String authorName = (inforUser != null && inforUser.getName() != null) ? inforUser.getName() : review.getUser().getUsername();
        String authorAvatar = (inforUser != null) ? inforUser.getAvt() : null;

        return new ProductReviewDTO(
                review.getId(),
                review.getRating(),
                review.getComment(),
                review.getReviewDate(),
                authorName,
                authorAvatar
        );
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ProductReviewDTO> getReviewsByProductId(Integer productId, Pageable pageable) {
        if (!productRepository.existsById(productId)) {
            throw new ProductNotFoundException("error.product.notFound");
        }
        Page<ProductReview> reviewPage = reviewRepository.findByProductId(productId, pageable);
        return reviewPage.map(this::convertToDTO);
    }

    @Override
    @Transactional
    public ProductReviewDTO createReview(Long userId, Integer productId, CreateReviewRequestDTO requestDTO) {
        UserAccount user = userAccountRepository.findById(userId)
                .orElseThrow(() -> new EntityNotFoundException("error.user.notFound"));

        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new ProductNotFoundException("error.product.notFound"));

        // user đã mua mới được đánh giá
        boolean hasPurchased = orderRepository.hasUserPurchasedProduct(userId, productId);
        if (!hasPurchased) {
            throw new IllegalStateException("Bạn phải mua sản phẩm này trước khi có thể đánh giá.");
        }

        ProductReview newReview = new ProductReview();
        newReview.setUser(user);
        newReview.setProduct(product);
        newReview.setRating(requestDTO.getRating());
        newReview.setComment(requestDTO.getComment());

        ProductReview savedReview = reviewRepository.save(newReview);
        return convertToDTO(savedReview);
    }
}