package com.nlu.petshop.service;

import com.nlu.petshop.dto.response.ProductDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ProductService {
    Page<ProductDTO> getAllProducts(Pageable pageable);
    Page<ProductDTO> getProductsByCategoryId(Integer categoryId, Pageable pageable);
    ProductDTO getProductById(Integer id);
}