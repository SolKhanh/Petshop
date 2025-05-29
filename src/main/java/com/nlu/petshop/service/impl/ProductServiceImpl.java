package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.response.ProductDTO;
import com.nlu.petshop.entity.Product;
import com.nlu.petshop.exception.ResourceNotFoundException;
import com.nlu.petshop.repository.ProductRepository;
import com.nlu.petshop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Locale;


@Service
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final MessageSource messageSource; // Thêm MessageSource

    @Autowired
    public ProductServiceImpl(ProductRepository productRepository, MessageSource messageSource) { // Thêm vào constructor
        this.productRepository = productRepository;
        this.messageSource = messageSource;
    }

    // Helper method để chuyển Product Entity sang ProductDTO
    private ProductDTO convertToDTO(Product product) {
        return new ProductDTO(
                product.getId(),
                product.getName(),
                product.getPrice(),
                product.getDescription(),
                product.getDetail(),
                product.getQuantity(),
                product.getImage(),
                product.getSalePrice(),
                product.getStatus(),
                product.getCreatedAt(),
                product.getGiong(),
                product.getMausac(),
                product.getCannang(),
                product.getSize(),
                product.getViewCount(),
                product.getWarranty(),
                product.getCategory() != null ? product.getCategory().getId() : null,
                product.getCategory() != null ? product.getCategory().getName() : null
        );
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ProductDTO> getAllProducts(Pageable pageable) {
        Page<Product> productPage = productRepository.findAll(pageable);
        return productPage.map(this::convertToDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<ProductDTO> getProductsByCategoryId(Integer categoryId, Pageable pageable) {
        Page<Product> productPage = productRepository.findByCategoryId(categoryId, pageable);
        return productPage.map(this::convertToDTO);
    }

    @Override
    @Transactional(readOnly = true)
    public ProductDTO getProductById(Integer id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> {
                    String message = messageSource.getMessage("error.product.notfound", new Object[]{id}, Locale.getDefault());
                    return new ResourceNotFoundException(message);
                });
       return convertToDTO(product);
    }
}