package com.nlu.petshop.service;

import com.nlu.petshop.dto.request.ProductCreateRequestDTO;
import com.nlu.petshop.dto.request.ProductUpdateRequestDTO;
import com.nlu.petshop.dto.response.ProductDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ProductService {
    Page<ProductDTO> getAllProducts(Pageable pageable);
    Page<ProductDTO> getProductsByCategoryId(Integer categoryId, Pageable pageable);
    ProductDTO getProductById(Integer id);
    //admin
    ProductDTO createProduct(ProductCreateRequestDTO createRequest);
    ProductDTO updateProduct(Integer productId, ProductUpdateRequestDTO updateRequest);
    void deleteProduct(Integer productId);
}