package com.project.complaintsystem.util;

import com.project.complaintsystem.model.Category;
import com.project.complaintsystem.repository.CategoryRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Order(2)
public class CategorySeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(CategorySeeder.class);

    private final CategoryRepository categoryRepository;

    public CategorySeeder(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public void run(String... args) {
        if (categoryRepository.count() > 0) {
            log.info("Category seeding skipped: categories already exist.");
            return;
        }

        List<String> categoryNames = List.of(
                "Infrastructure Issues",
                "Water Supply",
                "Electricity Issues",
                "Sanitation & Waste Management",
                "Public Safety",
                "Traffic & Transportation",
                "Environmental Concerns",
                "Government Services",
                "Healthcare Services",
                "Other"
        );

        List<Category> toInsert = new ArrayList<>(categoryNames.size());
        for (String name : categoryNames) {
            if (categoryRepository.findByName(name).isPresent()) {
                continue;
            }

            Category category = new Category();
            category.setName(name);
            toInsert.add(category);
        }

        categoryRepository.saveAll(toInsert);
        log.info("✅ Categories seeded");
    }
}
