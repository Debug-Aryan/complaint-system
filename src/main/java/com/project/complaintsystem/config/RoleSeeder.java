package com.project.complaintsystem.config;

import com.project.complaintsystem.enums.UserRole;
import com.project.complaintsystem.model.Role;
import com.project.complaintsystem.repository.RoleRepository;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RoleSeeder {

    @Bean
    public ApplicationRunner seedRoles(RoleRepository roleRepository) {
        return args -> {
            ensureRoleExists(roleRepository, UserRole.ROLE_CITIZEN);
            ensureRoleExists(roleRepository, UserRole.ROLE_ADMIN);
        };
    }

    private void ensureRoleExists(RoleRepository roleRepository, UserRole roleName) {
        if (roleRepository.findByRoleName(roleName).isPresent()) {
            return;
        }
        Role role = new Role();
        role.setRoleName(roleName);
        roleRepository.save(role);
    }
}
