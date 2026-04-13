package com.project.complaintsystem.controller;

import com.project.complaintsystem.service.ComplaintService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private ComplaintService complaintService;

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (isUserAuthenticated(session)) return "redirect:/login";

        Long userId = (Long) session.getAttribute("userId");
        model.addAttribute("recentComplaints", complaintService.getUserComplaints(userId));

        return "user/dashboard";
    }

    @GetMapping("/complaints")
    public String showMyComplaints(HttpSession session, Model model) {
        if (isUserAuthenticated(session)) return "redirect:/login";

        Long userId = (Long) session.getAttribute("userId");
        model.addAttribute("complaints", complaintService.getUserComplaints(userId));

        return "user/my-complaints";
    }

    // Helper for session validation
    private boolean isUserAuthenticated(HttpSession session) {
        return session == null || session.getAttribute("userId") == null || !"USER".equals(session.getAttribute("role"));
    }
}