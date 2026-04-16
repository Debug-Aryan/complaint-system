package com.project.complaintsystem.util;

import com.project.complaintsystem.enums.UserRole;
import com.project.complaintsystem.model.Role;
import com.project.complaintsystem.repository.RoleRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@Order(1)
public class RoleSeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(RoleSeeder.class);

    private final RoleRepository roleRepository;

    public RoleSeeder(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @Override
    public void run(String... args) {
        if (roleRepository.count() > 0) {
            log.info("Role seeding skipped: roles already exist.");
            return;
        }

        Role admin = new Role();
        admin.setRoleName(UserRole.ROLE_ADMIN);

        Role citizen = new Role();
        citizen.setRoleName(UserRole.ROLE_CITIZEN);

        roleRepository.saveAll(List.of(admin, citizen));
        log.info("✅ Roles seeded");
    }
}
