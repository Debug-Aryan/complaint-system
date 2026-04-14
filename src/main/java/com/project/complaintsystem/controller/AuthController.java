package com.project.complaintsystem.controller;

import com.project.complaintsystem.exception.BadRequestException;
import com.project.complaintsystem.exception.ResourceNotFoundException;
import com.project.complaintsystem.model.User;
import com.project.complaintsystem.service.AuthService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String processRegistration(@ModelAttribute User user, Model model) {
        try {
            authService.registerUser(user);
            return "redirect:/login";
        } catch (BadRequestException | ResourceNotFoundException ex) {
            model.addAttribute("error", ex.getMessage());
            return "register";
        }
    }
}