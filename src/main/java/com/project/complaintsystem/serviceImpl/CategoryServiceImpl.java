package com.project.complaintsystem.serviceImpl;

import com.project.complaintsystem.model.Category;
import com.project.complaintsystem.repository.CategoryRepository;
import com.project.complaintsystem.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }
}

