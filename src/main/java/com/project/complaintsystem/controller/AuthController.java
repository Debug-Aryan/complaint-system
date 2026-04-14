package com.project.complaintsystem.controller;

import com.project.complaintsystem.exception.BadRequestException;
import com.project.complaintsystem.exception.ResourceNotFoundException;
import com.project.complaintsystem.enums.UserRole;
import com.project.complaintsystem.model.User;
import com.project.complaintsystem.service.AuthService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "auth/login";
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "auth/register";
    }

    @PostMapping("/register")
    public String processRegistration(@ModelAttribute User user,
                                      @RequestParam(name = "roleName", required = false) String roleName,
                                      Model model) {
        try {
            UserRole selectedRole = UserRole.ROLE_CITIZEN;
            if (roleName != null && !roleName.isBlank()) {
                try {
                    selectedRole = UserRole.valueOf(roleName);
                } catch (IllegalArgumentException ex) {
                    throw new BadRequestException("Invalid role selected.");
                }
            }

            authService.registerUser(user, selectedRole);
            return "redirect:/login";
        } catch (BadRequestException | ResourceNotFoundException ex) {
            model.addAttribute("error", ex.getMessage());
            return "auth/register";
        }
    }
}