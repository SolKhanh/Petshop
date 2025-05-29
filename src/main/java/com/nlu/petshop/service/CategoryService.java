package com.nlu.petshop.service;

import com.nlu.petshop.dto.response.CategoryDTO;

import java.util.List;

public interface CategoryService {
    List<CategoryDTO> getAllCategories();
    CategoryDTO getCategoryById(Integer id);
}
