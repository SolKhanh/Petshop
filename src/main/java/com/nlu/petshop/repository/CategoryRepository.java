package com.nlu.petshop.repository;

import com.nlu.petshop.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
    // Crud cua jpa co san
}