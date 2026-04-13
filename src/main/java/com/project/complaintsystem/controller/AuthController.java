package com.project.complaintsystem.controller;

import com.project.complaintsystem.model.User;
import com.project.complaintsystem.service.AuthService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private AuthService authService;

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String password,
                               HttpSession session,
                               Model model) {

        User user = authService.loginUser(email, password);

        if (user != null) {
            // Create Session
            session.setAttribute("userId", user.getId());
            session.setAttribute("role", user.getRole().getRoleName().name());

            if ("ROLE_ADMIN".equals(user.getRole().getRoleName().name())) {
                return "redirect:/admin/dashboard";
            }
            return "redirect:/user/dashboard";
        }

        model.addAttribute("error", "Invalid email or password");
        return "login";
    }

    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String processRegistration(@ModelAttribute User user, Model model) {
        User registeredUser = authService.registerUser(user);

        if (registeredUser != null) {
            return "redirect:/login";
        }

        model.addAttribute("error", "Registration failed. Email might already exist.");
        return "register";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}