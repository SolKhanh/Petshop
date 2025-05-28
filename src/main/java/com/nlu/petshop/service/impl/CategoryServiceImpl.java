package com.nlu.petshop.service.impl;

import com.nlu.petshop.dto.CategoryDTO;
import com.nlu.petshop.entity.Category;
import com.nlu.petshop.exception.ResourceNotFoundException;
import com.nlu.petshop.repository.CategoryRepository;
import com.nlu.petshop.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;
    private final MessageSource messageSource;
    @Autowired
    public CategoryServiceImpl(CategoryRepository categoryRepository, MessageSource messageSource) { // Thêm vào constructor
        this.categoryRepository = categoryRepository;
        this.messageSource = messageSource;
    }

    // Helper method để chuyển Entity sang DTO
    private CategoryDTO convertToDTO(Category category) {
        return new CategoryDTO(
                category.getId(),
                category.getName(),
                category.getDescription()
        );
    }

    @Override
    public List<CategoryDTO> getAllCategories() {
        return categoryRepository.findAll()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    @Override
    public CategoryDTO getCategoryById(Integer id) {
        Category category = categoryRepository.findById(id)
                .orElseThrow(() -> {
                    String message = messageSource.getMessage("error.category.notfound", new Object[]{id}, Locale.getDefault());
                    return new ResourceNotFoundException(message);
                });
        return convertToDTO(category);
    }
}