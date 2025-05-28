package com.nlu.petshop.controller.api;

import com.nlu.petshop.dto.ProductDTO;
import com.nlu.petshop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/products")
public class ProductRestController {

    private final ProductService productService;

    @Autowired
    public ProductRestController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping
    public ResponseEntity<Page<ProductDTO>> getAllProducts(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "id,asc") String[] sort) {

        // Xử lý tham số sort (ví dụ: "name,desc" hoặc chỉ "name" thì mặc định là "asc")
        Sort.Direction direction = Sort.Direction.fromString(sort.length > 1 ? sort[1] : "asc");
        Sort.Order order = new Sort.Order(direction, sort[0]);
        Pageable pageable = PageRequest.of(page, size, Sort.by(order));

        Page<ProductDTO> productPage = productService.getAllProducts(pageable);
        return ResponseEntity.ok(productPage);
    }

    @GetMapping("/category/{categoryId}")
    public ResponseEntity<Page<ProductDTO>> getProductsByCategory(
            @PathVariable Integer categoryId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "id,asc") String[] sort) {

        Sort.Direction direction = Sort.Direction.fromString(sort.length > 1 ? sort[1] : "asc");
        Sort.Order order = new Sort.Order(direction, sort[0]);
        Pageable pageable = PageRequest.of(page, size, Sort.by(order));

        Page<ProductDTO> productPage = productService.getProductsByCategoryId(categoryId, pageable);
        return ResponseEntity.ok(productPage);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductDTO> getProductById(@PathVariable Integer id) {
        ProductDTO product = productService.getProductById(id);
        return ResponseEntity.ok(product);
    }
}