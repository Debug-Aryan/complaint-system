package com.project.complaintsystem.serviceImpl;

import com.project.complaintsystem.enums.UserRole;
import com.project.complaintsystem.exception.BadRequestException;
import com.project.complaintsystem.exception.ResourceNotFoundException;
import com.project.complaintsystem.exception.UnauthorizedException;
import com.project.complaintsystem.model.Role;
import com.project.complaintsystem.model.User;
import com.project.complaintsystem.repository.RoleRepository;
import com.project.complaintsystem.repository.UserRepository;
import com.project.complaintsystem.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder; // You will need to define this as a Bean in SecurityConfig

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

    @Override
    public User loginUser(String email, String rawPassword) {
        // 1. Find user by email
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found with this email."));

        // 2. Compare password (Input password vs encrypted password)
        if (!passwordEncoder.matches(rawPassword, user.getPassword())) {
            throw new UnauthorizedException("Invalid email or password.");
        }

        // 3. Return user object (The controller will handle session storage)
        return user;
    }
}