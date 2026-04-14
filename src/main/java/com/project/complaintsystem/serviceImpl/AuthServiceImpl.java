package com.project.complaintsystem.serviceImpl;

import com.project.complaintsystem.enums.UserRole;
import com.project.complaintsystem.exception.BadRequestException;
import com.project.complaintsystem.exception.ResourceNotFoundException;
import com.project.complaintsystem.model.Role;
import com.project.complaintsystem.model.User;
import com.project.complaintsystem.repository.RoleRepository;
import com.project.complaintsystem.repository.UserRepository;
import com.project.complaintsystem.service.AuthService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final PasswordEncoder passwordEncoder;

    public AuthServiceImpl(UserRepository userRepository,
                           RoleRepository roleRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User registerUser(User user) {
        // 1. Validate input (Check if user already exists)
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new BadRequestException("Email is already registered!");
        }

        // 2. Fetch default role (ROLE_CITIZEN)
        Role citizenRole = roleRepository.findByRoleName(UserRole.ROLE_CITIZEN)
                .orElseThrow(() -> new ResourceNotFoundException("Default role not found in database."));

        // 3. Assign Role & Encrypt Password
        user.setRole(citizenRole);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        // 4. Save and return user
        return userRepository.save(user);
    }
}