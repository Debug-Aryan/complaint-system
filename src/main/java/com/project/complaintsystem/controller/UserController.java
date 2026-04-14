package com.project.complaintsystem.controller;

import com.project.complaintsystem.security.CustomUserDetails;
import com.project.complaintsystem.service.ComplaintService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

    private final ComplaintService complaintService;

    public UserController(ComplaintService complaintService) {
        this.complaintService = complaintService;
    }

    @GetMapping("/dashboard")
    public String showDashboard(@AuthenticationPrincipal CustomUserDetails principal, Model model) {
        Long userId = principal.getId();
        model.addAttribute("recentComplaints", complaintService.getUserComplaints(userId));

        return "user/dashboard";
    }

    @GetMapping("/complaints")
    public String showMyComplaints(@AuthenticationPrincipal CustomUserDetails principal, Model model) {
        Long userId = principal.getId();
        model.addAttribute("complaints", complaintService.getUserComplaints(userId));

        return "user/my-complaints";
    }
}