package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.request.ProductCreateRequestDTO;
import com.nlu.petshop.dto.request.ProductFilterDTO;
import com.nlu.petshop.dto.request.ProductUpdateRequestDTO;
import com.nlu.petshop.dto.response.ProductDTO;
import com.nlu.petshop.entity.Category;
import com.nlu.petshop.entity.Product;
import com.nlu.petshop.exception.ProductNotFoundException;
import com.nlu.petshop.exception.ResourceNotFoundException;
import com.nlu.petshop.repository.CategoryRepository;
import com.nlu.petshop.repository.ProductRepository;
import com.nlu.petshop.service.ProductService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.BeanUtils;
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
    private final MessageSource messageSource;
    private final CategoryRepository categoryRepository;
    @Autowired
    public ProductServiceImpl(ProductRepository productRepository, MessageSource messageSource, CategoryRepository categoryRepository) { // Thêm vào constructor
        this.productRepository = productRepository;
        this.messageSource = messageSource;
        this.categoryRepository = categoryRepository;
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
                product.getStatus().name(),
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

    @Override
    @Transactional(readOnly = true)
    public Page<ProductDTO> searchAndFilterProducts(ProductFilterDTO filter, Pageable pageable) {
        Page<Product> productPage = productRepository.searchAndFilterProducts(
                filter.getKeyword(),
                filter.getCategoryId(),
                filter.getMinPrice(),
                filter.getMaxPrice(),
                pageable
        );
        return productPage.map(this::convertToDTO);
    }

    @Override
    @Transactional
    public ProductDTO createProduct(ProductCreateRequestDTO createRequest) {
        Product product = new Product();

        BeanUtils.copyProperties(createRequest, product, "categoryId");

        Category category = categoryRepository.findById(createRequest.getCategoryId())
                .orElseThrow(() -> new EntityNotFoundException("error.category.notfound"));
        product.setCategory(category);
        Product savedProduct = productRepository.save(product);
        return convertToDTO(savedProduct);
    }

    @Override
    @Transactional
    public ProductDTO updateProduct(Integer productId, ProductUpdateRequestDTO updateRequest) {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new ProductNotFoundException("error.product.notFound"));
        // Cập nhật các trường từ DTO
        if (updateRequest.getName() != null) {
            existingProduct.setName(updateRequest.getName());
        }
        if (updateRequest.getPrice() != null) {
            existingProduct.setPrice(updateRequest.getPrice());
        }
        if (updateRequest.getDescription() != null) {
            existingProduct.setDescription(updateRequest.getDescription());
        }
        if (updateRequest.getDetail() != null) {
            existingProduct.setDetail(updateRequest.getDetail());
        }
        if (updateRequest.getQuantity() != null) {
            existingProduct.setQuantity(updateRequest.getQuantity());
        }
        if (updateRequest.getImage() != null) {
            existingProduct.setImage(updateRequest.getImage());
        }
        existingProduct.setSalePrice(updateRequest.getSalePrice());

        if (updateRequest.getStatus() != null) {
            existingProduct.setStatus(updateRequest.getStatus());
        }
        if (updateRequest.getGiong() != null) {
            existingProduct.setGiong(updateRequest.getGiong());
        }
        if (updateRequest.getMausac() != null) {
            existingProduct.setMausac(updateRequest.getMausac());
        }
        if (updateRequest.getCannang() != null) {
            existingProduct.setCannang(updateRequest.getCannang());
        }
        if (updateRequest.getSize() != null) {
            existingProduct.setSize(updateRequest.getSize());
        }
        if (updateRequest.getWarranty() != null) {
            existingProduct.setWarranty(updateRequest.getWarranty());
        }        if (updateRequest.getCategoryId() != null &&
                (existingProduct.getCategory() == null || !updateRequest.getCategoryId().equals(existingProduct.getCategory().getId()))) {
            Category category = categoryRepository.findById(updateRequest.getCategoryId())
                    .orElseThrow(() -> new EntityNotFoundException("error.category.notfound"));
            existingProduct.setCategory(category);
        }
        Product updatedProduct = productRepository.save(existingProduct);
        return convertToDTO(updatedProduct);
    }

    @Override
    @Transactional
    public void deleteProduct(Integer productId) {
        if (!productRepository.existsById(productId)) {
            throw new ProductNotFoundException("error.product.notFound");
        }
        // xóa trực tiếp trong db, tạm thời không sài
        productRepository.deleteById(productId);
    }
}