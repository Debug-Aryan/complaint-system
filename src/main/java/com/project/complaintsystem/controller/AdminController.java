package com.project.complaintsystem.controller;

import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.service.AdminService;
import com.project.complaintsystem.service.ComplaintService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private ComplaintService complaintService;

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (isAdmin(session)) return "redirect:/login";

        model.addAttribute("stats", adminService.getDashboardStatistics());
        return "admin/admin-dashboard";
    }

    @GetMapping("/complaints")
    public String manageComplaints(HttpSession session, Model model) {
        if (isAdmin(session)) return "redirect:/login";

        // No filter selected in UI -> fetch all
        model.addAttribute("complaints", complaintService.getAllComplaints(null));
        return "admin/manage-complaints";
    }

    @PostMapping("/complaints/{id}/update")
    public String updateComplaintStatus(@PathVariable Long id,
                                        @RequestParam ComplaintStatus status,
                                        @RequestParam String remarks,
                                        HttpSession session) {

        if (isAdmin(session)) return "redirect:/login";

        Long adminId = (Long) session.getAttribute("userId");
        complaintService.updateComplaintStatus(id, adminId, status, remarks);

        return "redirect:/admin/complaints";
    }

    // Helper for role validation
    private boolean isAdmin(HttpSession session) {
        // AuthController stores role as enum name (e.g., ROLE_ADMIN)
        return session == null || !"ROLE_ADMIN".equals(session.getAttribute("role"));
    }
}