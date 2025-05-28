package com.nlu.petshop.service;

import com.nlu.petshop.dto.ProductDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface ProductService {
    Page<ProductDTO> getAllProducts(Pageable pageable);
    Page<ProductDTO> getProductsByCategoryId(Integer categoryId, Pageable pageable);
    ProductDTO getProductById(Integer id);
}