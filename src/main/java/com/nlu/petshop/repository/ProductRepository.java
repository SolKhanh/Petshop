package com.nlu.petshop.repository;

import com.nlu.petshop.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    // Tìm sản phẩm theo ID của Category
    List<Product> findByCategoryId(Integer categoryId);
    Page<Product> findByCategoryId(Integer categoryId, Pageable pageable);

    // Tìm sản phẩm theo tên (chứa một chuỗi, không phân biệt hoa thường)
    List<Product> findByNameContainingIgnoreCase(String name);
    Page<Product> findByNameContainingIgnoreCase(String name, Pageable pageable);

    // Tìm sản phẩm theo status
    List<Product> findByStatus(String status);
    Page<Product> findByStatus(String status, Pageable pageable);
}