package com.project.complaintsystem.controller;

import com.project.complaintsystem.enums.ComplaintStatus;
import com.project.complaintsystem.security.CustomUserDetails;
import com.project.complaintsystem.service.AdminService;
import com.project.complaintsystem.service.ComplaintService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminService adminService;
    private final ComplaintService complaintService;

    public AdminController(AdminService adminService, ComplaintService complaintService) {
        this.adminService = adminService;
        this.complaintService = complaintService;
    }

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        model.addAttribute("stats", adminService.getDashboardStatistics());
        return "admin/admin-dashboard";
    }

    @GetMapping("/complaints")
    public String manageComplaints(Model model) {
        // No filter selected in UI -> fetch all
        model.addAttribute("complaints", complaintService.getAllComplaints(null));
        return "admin/manage-complaints";
    }

    @PostMapping("/complaints/{id}/update")
    public String updateComplaintStatus(@PathVariable Long id,
                                        @RequestParam ComplaintStatus status,
                                        @RequestParam String remarks,
                                        @AuthenticationPrincipal CustomUserDetails principal) {

        Long adminId = principal.getId();
        complaintService.updateComplaintStatus(id, adminId, status, remarks);

        return "redirect:/admin/complaints";
    }
}