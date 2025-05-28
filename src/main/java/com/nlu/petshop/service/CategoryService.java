package com.nlu.petshop.service;

import com.nlu.petshop.dto.CategoryDTO;

import java.util.List;

public interface CategoryService {
    List<CategoryDTO> getAllCategories();
    CategoryDTO getCategoryById(Integer id);
}
