package com.project.complaintsystem.util;

import com.project.complaintsystem.enums.UserRole;
import com.project.complaintsystem.model.Role;
import com.project.complaintsystem.model.User;
import com.project.complaintsystem.repository.RoleRepository;
import com.project.complaintsystem.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Order(3)
public class UserSeeder implements CommandLineRunner {

    private static final Logger log = LoggerFactory.getLogger(UserSeeder.class);

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public UserSeeder(UserRepository userRepository,
                      RoleRepository roleRepository,
                      PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        if (userRepository.count() > 0) {
            log.info("User seeding skipped: users already exist.");
            return;
        }

        Role adminRole = roleRepository.findByRoleName(UserRole.ROLE_ADMIN)
                .orElseThrow(() -> new IllegalStateException("Required role not found: ROLE_ADMIN"));

        Role citizenRole = roleRepository.findByRoleName(UserRole.ROLE_CITIZEN)
                .orElseThrow(() -> new IllegalStateException("Required role not found: ROLE_CITIZEN"));

        List<SeedUser> seedUsers = List.of(
                // Admin first
                new SeedUser("System Admin", "admin@smartcomplaint.com", "admin123", "9000000001", adminRole),

                // Citizens
                new SeedUser("Aarav Sharma", "aarav@gmail.com", "password123", "9000000002", citizenRole),
                new SeedUser("Vivaan Patel", "vivaan@gmail.com", "password123", "9000000003", citizenRole),
                new SeedUser("Aditya Verma", "aditya@gmail.com", "password123", "9000000004", citizenRole),
                new SeedUser("Rohan Mehta", "rohan@gmail.com", "password123", "9000000005", citizenRole),
                new SeedUser("Kunal Gupta", "kunal@gmail.com", "password123", "9000000006", citizenRole),
                new SeedUser("Sanya Kapoor", "sanya@gmail.com", "password123", "9000000007", citizenRole),
                new SeedUser("Neha Singh", "neha@gmail.com", "password123", "9000000008", citizenRole),
                new SeedUser("Priya Nair", "priya@gmail.com", "password123", "9000000009", citizenRole),
                new SeedUser("Rahul Yadav", "rahul@gmail.com", "password123", "9000000010", citizenRole),
                new SeedUser("Ananya Das", "ananya@gmail.com", "password123", "9000000011", citizenRole)
        );

        List<User> toInsert = new ArrayList<>(seedUsers.size());
        for (SeedUser seed : seedUsers) {
            if (userRepository.existsByEmail(seed.email)) {
                continue;
            }

            User user = new User();
            user.setFullName(seed.fullName);
            user.setEmail(seed.email);
            user.setPassword(passwordEncoder.encode(seed.rawPassword));
            user.setPhoneNumber(seed.phoneNumber);
            user.setRole(seed.role);

            toInsert.add(user);
        }

        userRepository.saveAll(toInsert);
        log.info("✅ Users seeded");
    }

    private record SeedUser(String fullName, String email, String rawPassword, String phoneNumber, Role role) {
    }
}
